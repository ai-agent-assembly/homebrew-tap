class AasmProxy < Formula
  desc "Sidecar proxy enforcement layer for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  version "0.0.1-rc.3"
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
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-proxy-v#{version}-linux-arm64.tar.gz"
      sha256 "1f7b95c71f05a3bb16baf398f66dcf2e7208efc783ff31c625634ad7b2ddecce"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-proxy-v#{version}-linux-amd64.tar.gz"
      sha256 "60457171eaa499bcbfa0ce869aaf19865686851bcae5edf5fda62f7d335084c8"
    end
  end

  def install
    bin.install "aa-proxy"
  end

  test do
    assert_match(/aa-proxy/i, shell_output("#{bin}/aa-proxy --version"))
  end
end
