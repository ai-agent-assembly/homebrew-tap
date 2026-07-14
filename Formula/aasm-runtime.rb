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
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-runtime-v0.0.1-rc.5-darwin-arm64.tar.gz"
      # END GENERATED: version
      sha256 "96fb95d7ca48d9d664ec9acf321bbaff808fea0a0f485758885b0d9143b7546f"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-runtime-v0.0.1-rc.5-darwin-amd64.tar.gz"
      # END GENERATED: version
      sha256 "22ea03068a9b4d17648cbb98159c04517a98928cafb246a3fb6ceac92d7b2272"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-runtime-v0.0.1-rc.5-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "7ecec985cb44d5e1d05025b9b7579bed3db3118101b9c5aa36b03fade097d977"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-runtime-v0.0.1-rc.5-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "aa532e3cf354d879c6af56f2aa88651692c70ae18faaf6d89f831174a0030bd7"
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
