class AasmProxy < Formula
  desc "Sidecar proxy enforcement layer for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # Component-aware artifacts (ADR-014). The sha256 values below are placeholders
  # resolved by the release automation when the first aasm-proxy component
  # artifact is published (AAASM-3951); they are not hand-maintained.
  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-proxy-v0.0.1-rc.2-darwin-arm64.tar.gz"
      sha256 "5555555555555555555555555555555555555555555555555555555555555555"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-proxy-v0.0.1-rc.2-darwin-amd64.tar.gz"
      sha256 "6666666666666666666666666666666666666666666666666666666666666666"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-proxy-v0.0.1-rc.2-linux-arm64.tar.gz"
      sha256 "7777777777777777777777777777777777777777777777777777777777777777"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-proxy-v0.0.1-rc.2-linux-amd64.tar.gz"
      sha256 "8888888888888888888888888888888888888888888888888888888888888888"
    end
  end

  def install
    bin.install "aa-proxy"
  end

  test do
    assert_match(/aa-proxy/i, shell_output("#{bin}/aa-proxy --version"))
  end
end
