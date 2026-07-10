# typed: strict
# frozen_string_literal: true

# Single source of truth for the tap's release version and artifact base URL.
#
# The formulas under Formula/*.rb do NOT require this file at load time —
# Homebrew loads formulas in a sandboxed context and parses their `url` and
# `version` fields as literals. Instead, `scripts/generate_formulas.rb` reads
# these constants and rewrites the bounded `# BEGIN GENERATED: version` /
# `# END GENERATED: version` regions of every formula.
#
# The CI drift check (`.github/workflows/formula-drift.yml`) runs the generator
# and asserts a clean `git diff`, so any hand-edit that disagrees with this
# file will fail CI.
#
# To bump the tap for a new release: change VERSION here, run
# `ruby scripts/generate_formulas.rb`, commit both this file and the
# regenerated formulas.
module AasmTapMetadata
  # Upstream release tag without the leading `v`. Formulas that build a URL
  # prepend `v` where needed (matching the release tag convention in
  # ai-agent-assembly/agent-assembly).
  VERSION = "0.0.1-rc.3"

  # GitHub Releases download base URL. All per-platform tarballs live under
  # `<RELEASE_BASE_URL>/v<VERSION>/<artifact-name>.tar.gz`.
  RELEASE_BASE_URL = "https://github.com/ai-agent-assembly/agent-assembly/releases/download"
end
