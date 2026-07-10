#!/usr/bin/env ruby
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
#   * URL rewriting preserves the artifact filename (the last URL path segment)
#     and only replaces the version segment `/v<OLD_VERSION>/`. Formulas that
#     add or rename artifacts do so by editing the url line's artifact name
#     between the sentinels — the generator will keep the edit and only fix
#     the version segment on the next run.
#   * The script is idempotent: running it twice against a clean tree produces
#     no diff. CI (`.github/workflows/formula-drift.yml`) enforces this by
#     asserting `git diff --exit-code` after a fresh run.

require "pathname"

REPO_ROOT = Pathname.new(__dir__).parent.expand_path
FORMULA_DIR = REPO_ROOT.join("Formula")
METADATA_FILE = REPO_ROOT.join("metadata", "versions.rb")

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
def rewrite_region(inner_lines, formula_path)
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
    # Match `url "<base>/v<anything>/<artifact-filename>"`.
    m = line.match(/\Aurl\s+"(?<base>.+?)\/v[^\/"]+\/(?<artifact>[^"\/]+)"\s*\z/)
    unless m
      raise "#{formula_path}: url line does not match expected shape " \
            "'url \"<base>/v<VERSION>/<artifact>\"': #{line.inspect}"
    end
    ["#{indent}url \"#{m[:base]}/v#{VERSION}/#{m[:artifact]}\"\n"]
  else
    raise "#{formula_path}: unrecognized managed line inside sentinels: " \
          "#{line.inspect} (expected `version` or `url`)"
  end
end

# Walk one formula file, rewriting each sentinel region in place. Returns true
# if the file was modified (used only for reporting; the drift check gates CI).
def process_formula(path)
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

def main
  formulas = FORMULA_DIR.children.select { |p| p.extname == ".rb" }.sort
  if formulas.empty?
    warn "No formulas found under #{FORMULA_DIR}"
    exit 1
  end

  changed = []
  formulas.each do |formula|
    changed << formula.relative_path_from(REPO_ROOT).to_s if process_formula(formula)
  end

  if changed.empty?
    puts "generate_formulas.rb: no changes (VERSION=#{VERSION})"
  else
    puts "generate_formulas.rb: regenerated #{changed.length} formula(s) at VERSION=#{VERSION}:"
    changed.each { |c| puts "  #{c}" }
  end
end

main if $PROGRAM_NAME == __FILE__
