class AasmRuntime < Formula
  desc "Local runtime daemon for the Agent Assembly governance stack"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # Component-aware artifacts (ADR-014). The sha256 values below are placeholders
  # resolved by the release automation when the first aasm-runtime component
  # artifact is published (AAASM-3951); they are not hand-maintained.
  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-runtime-v0.0.1-rc.2-darwin-arm64.tar.gz"
      sha256 "1111111111111111111111111111111111111111111111111111111111111111"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-runtime-v0.0.1-rc.2-darwin-amd64.tar.gz"
      sha256 "2222222222222222222222222222222222222222222222222222222222222222"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-runtime-v0.0.1-rc.2-linux-arm64.tar.gz"
      sha256 "3333333333333333333333333333333333333333333333333333333333333333"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-runtime-v0.0.1-rc.2-linux-amd64.tar.gz"
      sha256 "4444444444444444444444444444444444444444444444444444444444444444"
    end
  end

  def install
    bin.install "aa-runtime"
  end

  # Runtime is NOT started on install (ADR-014). Users opt in with
  # `brew services start aasm-runtime`.
  service do
    run [opt_bin/"aa-runtime"]
    keep_alive false
    log_path var/"log/aasm-runtime.log"
    error_log_path var/"log/aasm-runtime.log"
  end

  test do
    assert_match(/aa-runtime/i, shell_output("#{bin}/aa-runtime --version"))
  end
end
