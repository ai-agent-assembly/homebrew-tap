class AasmRuntime < Formula
  BINARY_NAME = "aa-runtime".freeze

  desc "Local runtime daemon for the Agent Assembly governance stack"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # Component-aware artifacts (ADR-014) — the url/sha256 pairs below are
  # placeholders that AAASM-3951's release automation will fill in when the
  # first aasm-runtime component artifact is published. Until then the formula
  # can't produce a working install, so it is disabled with a clear message
  # rather than a checksum error. AAASM-3951 removes this disable! line.
  disable! date: "2026-07-08",
           because: "aasm-runtime component artifacts are not yet published; pending release automation (AAASM-3951)"


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
    bin.install BINARY_NAME
  end

  # Runtime is NOT started on install (ADR-014). Users opt in with
  # `brew services start aasm-runtime`.
  service do
    run [opt_bin/BINARY_NAME]
    keep_alive false
    log_path var/"log/aasm-runtime.log"
    error_log_path var/"log/aasm-runtime.log"
  end

  test do
    assert_match BINARY_NAME, shell_output("#{bin}/#{BINARY_NAME} --version").downcase
  end
end
