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
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-proxy-v0.0.1-rc.6-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "6fc8d1f3c58db844e77f23032bbb1132b8c80d9e3ff803a4d76adf6339df9ae8"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-proxy-v0.0.1-rc.6-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "07b62ca34ba630dec2bf173dc50a7db52aaa3ac868b5fbc87b31f9c0e3518ef5"
    end
  end

  def install
    bin.install "aa-proxy"
  end

  test do
    assert_match(/aa-proxy/i, shell_output("#{bin}/aa-proxy --version"))
  end
end
