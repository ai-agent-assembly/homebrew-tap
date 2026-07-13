class AasmProxy < Formula
  desc "Sidecar proxy enforcement layer for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # aasm-proxy ships as a Linux-only enforcement sidecar for now (AAASM-3951
  # publishes proxy tarballs only for linux-{arm64,amd64}). depends_on :linux
  # keeps macOS installs producing a clean "unavailable on this platform"
  # message rather than a 404 on a non-existent darwin artifact.
  depends_on :linux

  # Component-aware artifacts (ADR-014 / AAASM-3951). sha256 values are copied
  # from the release's SHA256SUMS by the release automation; do not hand-edit
  # them without a matching upstream release.
  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.4/aasm-proxy-v0.0.1-rc.4-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "56165f17bdb31c73bdb43524568075b5b1bfcb93dd5c2bdaa7784e526a84c106"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.4/aasm-proxy-v0.0.1-rc.4-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "f9746430c49be4a4c04605ca25afa2f5b1a1a082be80b4677ae2790be12e3ed3"
    end
  end

  def install
    bin.install "aa-proxy"
  end

  test do
    assert_match(/aa-proxy/i, shell_output("#{bin}/aa-proxy --version"))
  end
end
