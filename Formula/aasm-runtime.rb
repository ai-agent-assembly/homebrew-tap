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
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.4/aasm-runtime-v0.0.1-rc.4-darwin-arm64.tar.gz"
      # END GENERATED: version
      sha256 "e3d7951fdf57d95076351b1eccf32b64d064d0067d016e9a7b66488ed556e79f"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.4/aasm-runtime-v0.0.1-rc.4-darwin-amd64.tar.gz"
      # END GENERATED: version
      sha256 "5a7d38359dc90f09c9364e9979dec5b9d947f277fa9ec60d3fc2b26716eb0ad8"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.4/aasm-runtime-v0.0.1-rc.4-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "b5ab00eba62daf37040d57e7a22e3cdd882bce93700e7c9e1e810728c3890e2f"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.4/aasm-runtime-v0.0.1-rc.4-linux-amd64.tar.gz"
      # END GENERATED: version
      sha256 "65ed254a69b46240dccb9c4cb4069b1e5d4a4a1c146c893143505be566e8698e"
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
