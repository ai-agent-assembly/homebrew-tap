# homebrew-agent-assembly

[Homebrew](https://brew.sh/) tap for the [Agent Assembly](https://github.com/AI-agent-assembly/agent-assembly) `aasm` CLI.

## Install

```sh
brew tap agent-assembly/agent-assembly
brew install aasm
```

Or in one line:

```sh
brew install agent-assembly/agent-assembly/aasm
```

## Supported platforms

| OS      | Architecture             | Target triple                  |
| ------- | ------------------------ | ------------------------------ |
| macOS   | Apple Silicon (M-series) | `aarch64-apple-darwin`         |
| macOS   | Intel                    | `x86_64-apple-darwin`          |
| Linux   | x86_64                   | `x86_64-unknown-linux-gnu`     |
| Linux   | ARM64                    | `aarch64-unknown-linux-gnu`    |

The formula resolves to a pre-built binary published to the
[Agent Assembly GitHub Releases](https://github.com/AI-agent-assembly/agent-assembly/releases)
for your platform.

## Upgrade

```sh
brew update
brew upgrade aasm
```

## Uninstall

```sh
brew uninstall aasm
brew untap agent-assembly/agent-assembly
```

## Verifying installation

```sh
aasm --version
```

## How this tap is maintained

The `sha256` values in `Formula/aasm.rb` are kept in sync with each Agent
Assembly release by an automated workflow in the upstream repository
(see [AAASM-1213](https://lightning-dust-mite.atlassian.net/browse/AAASM-1213)
for the release-side automation).

Manual edits to `Formula/aasm.rb` should be limited to the formula structure
itself — the `url` and `sha256` lines are rewritten on every upstream release.

## License

[MIT](./LICENSE)
