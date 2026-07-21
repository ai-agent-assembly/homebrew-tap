# CLAUDE.md — homebrew-agent-assembly

Repo-specific guidance for Claude Code (and humans) in this repository.

Org-wide baseline: https://github.com/ai-agent-assembly/.github/blob/main/CLAUDE.md
(org-universal conventions this file doesn't repeat). When a fact here duplicates
`README.md` or the formula, treat those as the source of truth and update them.

## What this repo is

The **Homebrew tap** (Ruby formulae) for the `aasm` CLI — the operator front-end
for the Agent Assembly governance runtime. It exposes a single formula,
[`Formula/aasm.rb`](Formula/aasm.rb), that downloads a **pre-built** `aasm` binary
from the upstream [`agent-assembly` GitHub Releases](https://github.com/ai-agent-assembly/agent-assembly/releases)
and installs it onto your `PATH`. Nothing is compiled at install time.

- **Layout:** formulae under `Formula/*.rb` (the file `aasm.rb` maps to formula `aasm`).
- **Tap shorthand:** `ai-agent-assembly/tap` (repo `homebrew-tap`; Homebrew strips `homebrew-`).
- **License:** MIT (the core runtime is Apache-2.0).

## How version bumps / `sha256` / bottles land — release-driven

The formula's `version`, `url`, and `sha256` lines stay in lock-step with upstream
`agent-assembly` releases. Bumps are **not authored here by hand** — they are driven
by the release skills that live in the **monorepo's** `agent-assembly/.claude/skills/`:

- `release-tag-cut` — cuts the coordinated upstream release tag.
- `homebrew-tap-merge` — verifies the bot PR's `sha256` against the upstream
  `SHA256SUMS` and merges the bump onto this tap.
- `release-validate-channels` — confirms the tap (and other channels) went live.

On a new release the automation rewrites each `url` + copies the matching `sha256`
from `SHA256SUMS`, then opens a bot PR. Limit manual edits to `version`/`url`/`sha256`.

### Local formula checks

```sh
brew style ./Formula/                                       # lint style
brew audit --strict --tap ai-agent-assembly/tap          # strict audit (matches CI)
brew install ai-agent-assembly/tap/aasm                   # real install
brew test  ai-agent-assembly/tap/aasm                    # runs the formula's test block
```

CI (`.github/workflows/tests.yml`) runs `brew style` + `brew audit --strict` on
`Formula/**`, plus a macOS install/test. Org GitHub Actions billing is currently
suspended, so **validate locally** rather than waiting on CI.

## Repo-specific gotchas

- **Push remote is `remote`** (→ canonical `ai-agent-assembly/homebrew-agent-assembly`),
  not `origin` (a personal fork). Scope changes against `remote/main`.
- **Default branch is `main`**; PR base is always `main`. Never `--no-verify`,
  never force-push.

## Project policy

- **JIRA:** project AAASM; set **Component** to `AI-agent-assembly/homebrew-agent-assembly`;
  Team = **Pioneer**. PR title `[<ticket>] <emoji> (<scope>): <summary>`; fill the
  repo PR template.

## Documentation conventions

Keep formula comments **minimal and why-only** — capture intent the Ruby can't
(why a `sha256` is pinned, why a platform block exists), never restate what the
formula already says. Most lines are mechanical and need no comment.
