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
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-runtime-v0.0.1-rc.6-darwin-arm64.tar.gz"
      # END GENERATED: version
      sha256 "27a59068adf94d010119545b11c1d6fd8dbbadd7266dfabb4f697bb2d13f748e"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-runtime-v0.0.1-rc.6-darwin-amd64.tar.gz"
      # END GENERATED: version
      sha256 "679e85c0965a5c6945a0e0a1d8f0f5b2ae044894e13daa96ac5699aeaaa62789"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-runtime-v0.0.1-rc.6-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "c6c252c36094888377647a0b4f09d38f3efab13f6e26f870f261fcca458586a1"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-runtime-v0.0.1-rc.6-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "91bdfa6a01ee214752b7213c53962551df12252869a65a12c4ae1700adeb9ff9"
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
