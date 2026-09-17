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
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-runtime-v0.0.1-rc.7-darwin-arm64.tar.gz"
      # END GENERATED: version
      sha256 "5fc709f7d79e40122fc1487b37bdf25eccd69dbb791c462232d5679d1154c547"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-runtime-v0.0.1-rc.7-darwin-amd64.tar.gz"
      # END GENERATED: version
      sha256 "56e5f332b0322ef5d5d2688d99bf853d4f85cb23826464dac56d3a847bdf39a1"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-runtime-v0.0.1-rc.7-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "f539f288e389ee6513463b1947ccb21aa4331ad88bc0d6af674a500ea8409bb7"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-runtime-v0.0.1-rc.7-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "4c1e118d0cc71d9a78a5894fe1050e175cc0debad5404c2a127d430b01287308"
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
