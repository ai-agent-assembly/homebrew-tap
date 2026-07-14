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
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-proxy-v0.0.1-rc.5-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "4e2edf8bd690c848a926267cf3a7cea2de8ae1e190aaf81d9e93bfacf64da5a5"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-proxy-v0.0.1-rc.5-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "16a0a84d0ed8356ac03d00d817022f6c32b3d6e41f0db6f1a1d3f40620cc4307"
    end
  end

  def install
    bin.install "aa-proxy"
  end

  test do
    assert_match(/aa-proxy/i, shell_output("#{bin}/aa-proxy --version"))
  end
end
