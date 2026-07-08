class AasmRuntime < Formula
  BINARY_NAME = "aa-runtime".freeze

  desc "Local runtime daemon for the Agent Assembly governance stack"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # Component-aware artifacts (ADR-014 / AAASM-3951). sha256 values are copied
  # from the release's SHA256SUMS by the release automation; do not hand-edit
  # them without a matching upstream release.
  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.3/aasm-runtime-v0.0.1-rc.3-darwin-arm64.tar.gz"
      sha256 "bcd2fd3c4aa6884d551b2671e2423bee7bc0336c6d5dc2f0449121cd7b1b784c"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.3/aasm-runtime-v0.0.1-rc.3-darwin-amd64.tar.gz"
      sha256 "3e6a2371756cb41dcfdc71e9f0dafca2e44b8c0a6c558e2209edc5e7fc2ae24d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.3/aasm-runtime-v0.0.1-rc.3-linux-arm64.tar.gz"
      sha256 "68f8459fd114e8a22ea23c4c919da185695d9aa72421f31bbca1149b652bfdcf"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.3/aasm-runtime-v0.0.1-rc.3-linux-amd64.tar.gz"
      sha256 "2e2c0d33786dd12b7179cc9fa4b0f0ee937b19e3bcaab0cbe94b9d0134abd2b5"
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
