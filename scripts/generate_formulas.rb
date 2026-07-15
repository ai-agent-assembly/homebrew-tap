#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

# Rewrites the bounded `# BEGIN GENERATED: version` / `# END GENERATED: version`
# regions of every formula under Formula/*.rb so that the version literal and
# every release-artifact URL agree with `metadata/versions.rb` — the tap's
# single source of truth for the current release version and base URL.
#
# Design notes:
#   * The generator is intentionally line-oriented and dependency-free (Ruby
#     stdlib only). Formulas are Ruby source files but Homebrew requires that
#     `url` and `version` appear as literals, so we do not `eval` them; we
#     rewrite the specific literal lines inside the sentinel regions.
#   * A sentinel region wraps exactly ONE managed line — either `version "..."`
#     or `url "..."`. Everything outside the sentinels (including every
#     `sha256` line) is preserved verbatim, because release automation owns the
#     sha256 values and this generator must not touch them (AAASM-3951).
#   * URL rewriting is version-shaped: every `v<semver>` token in the URL is
#     rewritten to `v<VERSION>`. This covers both the release-path segment
#     (`.../releases/download/v<OLD>/...`) and the version embedded in
#     component artifact filenames (`aasm-proxy-v<OLD>-darwin-arm64.tar.gz`).
#     Non-version parts of the artifact name — the component prefix, the
#     platform triple — are preserved, so a formula that renames an artifact
#     inside its sentinel region will keep the rename on the next run.
#   * The script is idempotent: running it twice against a clean tree produces
#     no diff. CI (`.github/workflows/formula-drift.yml`) enforces this by
#     asserting `git diff --exit-code` after a fresh run.

# Pathname must be required explicitly when this script runs standalone
# (RuboCop 1.85+ still flags this as `Lint/RedundantRequireStatement` on the
# assumption of a Bundler-loaded environment; the disable comment below scopes
# the exception to this line only).
require "pathname" # rubocop:disable Lint/RedundantRequireStatement

# Wrapping the top-level constants and methods in a module keeps
# `Style/TopLevelMethodDefinition` happy without changing the entrypoint
# semantics — the `main if $PROGRAM_NAME == __FILE__` guard at the bottom of
# the file still runs when this script is executed directly.
module FormulaGenerator
  REPO_ROOT = Pathname.new(__dir__).parent.expand_path.freeze
  FORMULA_DIR = REPO_ROOT.join("Formula").freeze
  METADATA_FILE = REPO_ROOT.join("metadata", "versions.rb").freeze

  BEGIN_MARKER = "# BEGIN GENERATED: version"
  END_MARKER = "# END GENERATED: version"

  # Load the SoT constants (VERSION, RELEASE_BASE_URL) from metadata/versions.rb.
  # We require the file rather than parsing it so that a syntax error in the SoT
  # surfaces here, before we touch any formula.
  require METADATA_FILE.to_s
  VERSION = AasmTapMetadata::VERSION
  RELEASE_BASE_URL = AasmTapMetadata::RELEASE_BASE_URL

  # Rewrite the single managed line inside a sentinel region.
  #
  # The region is expected to contain exactly one non-blank, non-comment line —
  # either `version "..."` or `url "..."`. Any other shape is a hand-edit that
  # the generator refuses to guess at; we raise so CI fails loudly instead of
  # silently producing a bad formula.
  def self.rewrite_region(inner_lines, formula_path)
    managed = inner_lines.reject { |l| l.strip.empty? || l.strip.start_with?("#") }
    if managed.length != 1
      raise "#{formula_path}: expected exactly 1 managed line between " \
            "sentinels, found #{managed.length}: #{managed.inspect}"
    end

    line = managed.first
    indent = line[/\A\s*/]

    if line.strip.start_with?("version ")
      ["#{indent}version \"#{VERSION}\"\n"]
    elsif line.strip.start_with?("url ")
      # Extract the quoted URL literal, then rewrite the version token inside it.
      # Two artifact URL shapes exist across the tap's formulae:
      #
      #   * GitHub-release shape — the version appears with a leading `v`
      #     (`.../download/v0.0.1-rc.5/aasm-proxy-v0.0.1-rc.5-linux-arm64.tar.gz`).
      #     Every `v<semver>` token is rewritten to `v<VERSION>`.
      #   * crates.io shape — the version appears WITHOUT a leading `v`, because
      #     the crate filename embeds the bare version
      #     (`https://static.crates.io/crates/aa-ebpf/aa-ebpf-0.0.1-rc.5.crate`,
      #     AAASM-4649/AAASM-4678). The bare `<semver>` token is rewritten to
      #     `<VERSION>`. Without this branch the crate pin sits outside generator
      #     management and silently lags each release.
      #
      # Semver here is intentionally strict — `<major>.<minor>.<patch>` optionally
      # followed by a single dashed pre-release identifier of the shape
      # `<alpha-word>` or `<alpha-word>.<digits>` (e.g. `rc`, `rc.2`, `beta.1`).
      # This is deliberately tighter than the semver spec: it does NOT match
      # `v#{version}` Ruby interpolations (kept intact for aasm.rb's URL style),
      # and it will not greedily swallow file extensions like `.tar.gz`/`.crate`
      # in artifact filenames such as `aasm-proxy-v0.0.1-rc.2.tar.gz`.
      m = line.strip.match(/\Aurl\s+"(?<url>[^"]+)"\z/)
      unless m
        raise "#{formula_path}: url line does not match expected shape " \
              "'url \"<url>\"': #{line.inspect}"
      end
      bare_semver = "\\d+\\.\\d+\\.\\d+(?:-[a-zA-Z]+(?:\\.\\d+)?)?"
      v_semver_token = /v#{bare_semver}/
      bare_semver_token = /#{bare_semver}/
      original_url = m[:url]
      # `String#exclude?` (Homebrew/NegateInclude's suggested replacement) is
      # an ActiveSupport addition loaded at brew-style time; this generator
      # runs under vanilla Ruby (see CI: `ruby scripts/...`) so we can only
      # rely on stdlib `.include?`. Disabling the cop here keeps the code
      # portable across the two runtimes.
      new_url =
        if v_semver_token.match?(original_url)
          # GitHub-release shape. Checked first so a `v`-prefixed URL is never
          # matched by the bare-semver token (which would drop the `v`).
          original_url.gsub(v_semver_token, "v#{VERSION}")
        elsif original_url.include?("v\#{version}") # rubocop:disable Homebrew/NegateInclude
          # aasm.rb interpolates `v#{version}`; the literal has no version digits
          # to rewrite, so it is preserved verbatim.
          original_url
        elsif bare_semver_token.match?(original_url)
          # crates.io shape (no leading `v`).
          original_url.gsub(bare_semver_token, VERSION)
        else
          raise "#{formula_path}: url contains no rewritable <semver> segment " \
                "and no `v\#{version}` interpolation: #{original_url.inspect}"
        end
      ["#{indent}url \"#{new_url}\"\n"]
    else
      raise "#{formula_path}: unrecognized managed line inside sentinels: " \
            "#{line.inspect} (expected `version` or `url`)"
    end
  end

  # Walk one formula file, rewriting each sentinel region in place. Returns true
  # if the file was modified (used only for reporting; the drift check gates CI).
  def self.process_formula?(path)
    original = path.read
    lines = original.lines

    out = []
    i = 0
    in_region = false
    region_buf = []
    region_start_line = nil

    while i < lines.length
      line = lines[i]
      stripped = line.strip

      if !in_region && stripped == BEGIN_MARKER
        out << line
        in_region = true
        region_start_line = i + 1
        region_buf = []
      elsif in_region && stripped == END_MARKER
        # Preserve the indentation of the original managed line by regenerating
        # from the buffered inner lines. rewrite_region handles the leading
        # whitespace.
        out.concat(rewrite_region(region_buf, path))
        out << line
        in_region = false
        region_buf = []
      elsif in_region
        region_buf << line
      else
        out << line
      end
      i += 1
    end

    if in_region
      raise "#{path}: unterminated `#{BEGIN_MARKER}` region " \
            "starting at line #{region_start_line}"
    end

    new_content = out.join
    return false if new_content == original

    path.write(new_content)
    true
  end

  def self.main
    formulas = FORMULA_DIR.children.select { |p| p.extname == ".rb" }.sort
    if formulas.empty?
      warn "No formulas found under #{FORMULA_DIR}"
      exit 1
    end

    changed = []
    formulas.each do |formula|
      changed << formula.relative_path_from(REPO_ROOT).to_s if process_formula?(formula)
    end

    if changed.empty?
      puts "generate_formulas.rb: no changes (VERSION=#{VERSION})"
    else
      puts "generate_formulas.rb: regenerated #{changed.length} formula(s) at VERSION=#{VERSION}:"
      changed.each { |c| puts "  #{c}" }
    end
  end
end

FormulaGenerator.main if $PROGRAM_NAME == __FILE__
