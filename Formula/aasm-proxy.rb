class AasmProxy < Formula
  desc "Sidecar proxy enforcement layer for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  version "0.0.1-rc.2"
  license "MIT"

  # Component-aware artifacts (ADR-014). The sha256 values below are placeholders
  # resolved by the release automation when the first aasm-proxy component
  # artifact is published (AAASM-3951); they are not hand-maintained.
  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-proxy-v#{version}-darwin-arm64.tar.gz"
      sha256 "5555555555555555555555555555555555555555555555555555555555555555"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-proxy-v#{version}-darwin-amd64.tar.gz"
      sha256 "6666666666666666666666666666666666666666666666666666666666666666"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-proxy-v#{version}-linux-arm64.tar.gz"
      sha256 "7777777777777777777777777777777777777777777777777777777777777777"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-proxy-v#{version}-linux-amd64.tar.gz"
      sha256 "8888888888888888888888888888888888888888888888888888888888888888"
    end
  end

  def install
    bin.install "aasm-proxy"
  end

  test do
    assert_match(/aasm-proxy/i, shell_output("#{bin}/aasm-proxy --version"))
  end
end
