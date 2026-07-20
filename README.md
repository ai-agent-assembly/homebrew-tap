# homebrew-tap

> [Homebrew](https://brew.sh/) tap for the [Agent Assembly](https://github.com/ai-agent-assembly/agent-assembly) `aasm` CLI.

[![Tests](https://github.com/ai-agent-assembly/homebrew-tap/actions/workflows/tests.yml/badge.svg)](https://github.com/ai-agent-assembly/homebrew-tap/actions/workflows/tests.yml)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

This repository is the official Homebrew tap for installing the `aasm`
command-line tool — the operator front-end for the
[Agent Assembly](https://github.com/ai-agent-assembly/agent-assembly)
governance runtime. The tap's default formula, `Formula/aasm.rb`, downloads a
pre-built `aasm` binary from the upstream
[GitHub Releases](https://github.com/ai-agent-assembly/agent-assembly/releases)
and installs it onto your `PATH`. Additional components — runtime, proxy, and
eBPF — are separate formulae (see [Components](#components)).

> [!NOTE]
> **Current state — pre-release (release candidate).**
> The tap tracks **pre-release (release-candidate) builds** of `aasm`. Every
> formula is pinned to **`v0.0.1-rc.6`** via the shared version source of truth
> ([`metadata/versions.rb`](metadata/versions.rb)), and each `sha256` is verified
> against the real release artifacts (see [Checksum readiness](#checksum-readiness)).
> The `aasm` CLI, `aasm-runtime`, and `aasm-proxy` all install from published
> `v0.0.1-rc.6` artifacts today; `aasm-bundle` and `aasm-ebpf` are intentionally
> disabled until their artifacts ship (see [Components](#components)).
> There is **no stable (`vX.Y.0`) release yet**, so installs pull a pre-release
> binary. Expect breaking changes until the first stable tag is cut.

## Install

```sh
brew install ai-agent-assembly/tap/aasm
```

Or tap once, then install by short name:

```sh
brew tap ai-agent-assembly/tap
brew install aasm
```

> [!IMPORTANT]
> The canonical tap is **`ai-agent-assembly/tap`** — the repository is named
> `homebrew-tap`, and Homebrew strips the `homebrew-` prefix. `aasm` installs the
> **CLI only**; it never installs or starts a background runtime. The org id is
> lowercase **`ai-agent-assembly`** everywhere.

> [!NOTE]
> **Migrating from the old tap name?** Earlier docs used
> `brew install ai-agent-assembly/agent-assembly/aasm` (repo
> `homebrew-agent-assembly`). That command still works — GitHub redirects the
> renamed repository — but it is **deprecated**. Switch to
> `ai-agent-assembly/tap/aasm`. To move an existing checkout:
> ```sh
> brew untap ai-agent-assembly/agent-assembly   # optional; old tap
> brew install ai-agent-assembly/tap/aasm
> ```

Prefer a tap-less, dependency-free install? The upstream project also ships a
`curl | sh` one-line installer. See the core repo's
[Install the CLI](https://github.com/ai-agent-assembly/agent-assembly#install-the-cli)
section for the installer command, the install endpoint, and version pinning.
(That installer endpoint is provisioned alongside the tap bootstrap under
[AAASM-1201](https://lightning-dust-mite.atlassian.net/browse/AAASM-1201) and may
not be live yet during the pre-release window.)

## Components

`aasm` installs the **CLI only**. Every other component is a separate formula, so
you install exactly what you want and nothing starts automatically.

| Formula | Installs | Platforms | Service |
| --- | --- | --- | --- |
| `aasm` | `aasm` CLI | macOS · Linux | — |
| `aasm-runtime` | local runtime daemon | macOS · Linux | `brew services` (opt-in) |
| `aasm-proxy` | sidecar proxy enforcement | macOS · Linux | — |
| `aasm-ebpf` | eBPF kernel enforcement | **Linux only** | — |
| `aasm-bundle` | CLI + runtime + proxy (meta) | macOS · Linux | — |

```sh
brew install ai-agent-assembly/tap/aasm-runtime
brew install ai-agent-assembly/tap/aasm-proxy
brew install ai-agent-assembly/tap/aasm-ebpf       # Linux only
brew install ai-agent-assembly/tap/aasm-bundle     # convenience bundle
```

Installing `aasm-runtime` does **not** start it. Manage it explicitly with
Homebrew services:

```sh
brew services start aasm-runtime
brew services stop  aasm-runtime
```

> [!NOTE]
> `aasm-runtime` and `aasm-proxy` install from the component-aware release
> artifacts tracked under
> [AAASM-3951](https://lightning-dust-mite.atlassian.net/browse/AAASM-3951), with
> `sha256` values verified against the published `v0.0.1-rc.6` assets. The
> `aasm-bundle` and `aasm-ebpf` formulae stay **disabled** until their artifacts
> ship — `brew install` reports a clear "disabled" message rather than a 404
> (bundle: [AAASM-4879](https://lightning-dust-mite.atlassian.net/browse/AAASM-4879);
> eBPF: [AAASM-4325](https://lightning-dust-mite.atlassian.net/browse/AAASM-4325)).

## Supported platforms

| OS    | Architecture             | Target triple                |
| ----- | ------------------------ | ---------------------------- |
| macOS | Apple Silicon (M-series) | `aarch64-apple-darwin`       |
| macOS | Intel                    | `x86_64-apple-darwin`        |
| Linux | ARM64                    | `aarch64-unknown-linux-gnu`  |
| Linux | x86_64                   | `x86_64-unknown-linux-gnu`   |

The formula selects the correct artifact for your platform using Homebrew's
`on_macos` / `on_linux` and `on_arm` / `on_intel` blocks. Each artifact is a
pre-built binary published to the upstream
[GitHub Releases](https://github.com/ai-agent-assembly/agent-assembly/releases);
nothing is compiled from source at install time.

## Verifying the install

```sh
aasm --version
```

This should print the installed `aasm` version. From there, common entry points are:

```sh
aasm topology     # inspect the agent topology
aasm policy       # manage policy
aasm dashboard    # launch the operator TUI
```

Full CLI documentation lives on the canonical docs site:
<https://docs.agent-assembly.com/>.

## Upgrade

```sh
brew update
brew upgrade aasm
```

`brew update` refreshes this tap; `brew upgrade aasm` installs the newest
formula version. While the tap tracks pre-releases, each upgrade may pull a new
release-candidate build.

## Uninstall

```sh
brew uninstall aasm
brew untap ai-agent-assembly/tap   # optional — removes the tap itself
```

`brew uninstall` removes the `aasm` binary. The optional `brew untap` removes
the tap from your Homebrew installation.

## Troubleshooting

| Symptom | Likely cause and fix |
| --- | --- |
| `Error: No available formula with the name "aasm"` | The tap is not added. Run `brew tap ai-agent-assembly/tap` first, or use the fully-qualified `brew install ai-agent-assembly/tap/aasm`. |
| `Error: aasm: ... SHA256 mismatch` | The local formula is stale or the release asset changed. Run `brew update`, then retry. If it persists, [open an issue](https://github.com/ai-agent-assembly/homebrew-tap/issues). |
| `curl: ... 404` while downloading the bottle | The pinned release asset is missing or the tag was deleted upstream. Verify the formula's `version` against the [releases page](https://github.com/ai-agent-assembly/agent-assembly/releases). |
| `aasm: command not found` after install | `brew --prefix`/bin is not on your `PATH`. Add it (e.g. `eval "$(brew shellenv)"`) and restart your shell. |
| Install hangs or fails behind a proxy | GitHub Releases must be reachable. Set `HOMEBREW_GITHUB_API_TOKEN` and/or your proxy env vars (`HTTPS_PROXY`) and retry. |

Still stuck? Collect `brew config` and `brew install --verbose aasm` output and
[file an issue](https://github.com/ai-agent-assembly/homebrew-tap/issues).

## Formula details

- **Formula path:** [`Formula/aasm.rb`](Formula/aasm.rb)
- **Formula version:** `0.0.1-rc.6` (pre-release / release candidate)
- **Class:** `Aasm` (Homebrew maps the file `aasm.rb` to `aasm`)
- **License:** MIT (matches this tap; the core runtime is Apache-2.0)
- **Install:** drops the `aasm` binary into Homebrew's `bin`
- **Test:** `brew test` runs `aasm --version` and asserts the output

### Checksum readiness

The `sha256` value for each platform artifact in `Formula/aasm.rb` is verified
against the `SHA256SUMS` manifest published with the upstream
[`v0.0.1-rc.6` release](https://github.com/ai-agent-assembly/agent-assembly/releases/tag/v0.0.1-rc.6).
All four platform checksums are present and match the published assets, so the
formula is installable today. The `aasm-runtime` and `aasm-proxy` formulae carry
the same verified, release-matched checksums for their published `v0.0.1-rc.6`
artifacts.

### Latest vs stable

| Channel | State |
| --- | --- |
| **Pre-release (release candidate)** | **Active.** Every formula pinned to `v0.0.1-rc.6`. This is what installs today. |
| **Stable (`vX.Y.0`)** | **Not yet cut.** No stable tag exists. When the first stable release ships, the formulae will be re-pointed to it and this section updated. |

## Release & checksum update workflow

The formula's `url` and `sha256` lines must stay in lock-step with the upstream
`agent-assembly` releases. The intended flow:

1. Upstream `agent-assembly` cuts a release and publishes the per-platform
   `aasm-<target>.tar.gz` artifacts plus a `SHA256SUMS` manifest.
2. The release-side automation bumps `version`, rewrites each `url`, and copies
   the matching `sha256` from `SHA256SUMS` into `Formula/aasm.rb`, then opens a
   PR against this tap.
3. CI (`brew style` + `brew audit` + a macOS install/test) gates the bump.
4. On merge, `brew upgrade aasm` picks up the new version.

> [!NOTE]
> The **automated** checksum-sync workflow is still being finished under
> [AAASM-1201](https://lightning-dust-mite.atlassian.net/browse/AAASM-1201).
> Until it lands, formula bumps for new releases are applied manually using the
> same procedure. Manual edits should be limited to the `version`, `url`, and
> `sha256` lines — the formula structure itself is stable.

### Shared version SoT (AAASM-4354)

The `version` field and `github.com/ai-agent-assembly/agent-assembly/releases/download/v<X>/…`
URL fragments across every formula in this tap are generated from a single
source of truth at [`metadata/versions.rb`](metadata/versions.rb). To bump the
tap version:

1. Edit `VERSION` in `metadata/versions.rb`.
2. Run `ruby scripts/generate_formulas.rb` — this rewrites the bounded
   `# BEGIN GENERATED: version` / `# END GENERATED: version` blocks in every
   `Formula/*.rb`.
3. Commit both the SoT change and the regenerated formulae together.
4. The CI job [`.github/workflows/formula-drift.yml`](.github/workflows/formula-drift.yml)
   re-runs the generator on every PR that touches `Formula/**` or the SoT and
   fails if the tree is out of sync. This is what caught the `aasm-bundle` /
   `aasm-proxy` / `aasm-ebpf` staying pinned at `v0.0.1-rc.2` while `aasm.rb`
   moved to `v0.0.1-rc.3` — the exact drift class this generator prevents.

Do **not** hand-edit the `version` line or `url` version fragment in any
formula. Do hand-edit `sha256` values — those are release-artifact fingerprints
that the release automation resolves and are intentionally outside the
generator's scope.

## Formula validation

Contributors and CI run the standard Homebrew checks. To validate locally:

```sh
# Lint formula style
brew style ./Formula/

# Strict audit (matches CI)
brew audit --strict --tap ai-agent-assembly/tap

# Install + run the formula's own test block
brew install ai-agent-assembly/tap/aasm
brew test  ai-agent-assembly/tap/aasm
```

CI ([`.github/workflows/tests.yml`](.github/workflows/tests.yml)) runs
`brew style` and `brew audit --strict` on every change to `Formula/**`, plus a
real `brew install` + `brew test` on macOS. Link checks: keep all cross-links in
this README pointing at the lowercase `ai-agent-assembly` org and verify they
resolve before merging.

> [!NOTE]
> Organisation GitHub Actions billing is currently suspended, so CI runs may be
> queued or skipped until billing is restored. Run the validation commands above
> locally in the meantime.

## Contributing

PRs are welcome — most changes here are formula bumps (usually automated) or
documentation. Please follow the
[pull request template](.github/PULL_REQUEST_TEMPLATE.md) and ensure
`brew style` / `brew audit` pass locally. Reviews are routed via
[`CODEOWNERS`](.github/CODEOWNERS).

## Links

- **Core runtime & releases:** <https://github.com/ai-agent-assembly/agent-assembly>
  · [Releases](https://github.com/ai-agent-assembly/agent-assembly/releases)
- **Organization profile:** <https://github.com/ai-agent-assembly>
- **Documentation site:** <https://docs.agent-assembly.com/>
- **Release process:** [`agent-assembly` releases](https://github.com/ai-agent-assembly/agent-assembly/releases)
  and the upstream release workflow
- **Issues / support:** <https://github.com/ai-agent-assembly/homebrew-tap/issues>
- **Security:** report vulnerabilities to **security@agent-assembly.dev**
  (see the org [security policy](https://github.com/ai-agent-assembly/.github/blob/master/SECURITY.md))

## License

[MIT](./LICENSE) © Agent Assembly contributors
