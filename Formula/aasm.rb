class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # BEGIN GENERATED: version
  version "0.0.1-rc.5"
  # END GENERATED: version
  license "MIT"

  on_macos do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "0086b570a9d3dfe726c96ced0fa5340a186650553df6517b13c0cdcf8b294116"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "a3ff2258fe72812d1241c353c5267e7eab9b7a2730ef2493e4d65dec8b6bbc26"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "b4ebb96b4373370c133fd0d65466d20a0192655e37d3d5ba2a9b42448b9d6b80"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "45b32cbc16e7db70aa860836e043e44ad3972f0cd1d4f1954916ff1303317fa5"
    end
  end

  # aa-api-server ships in a separate `aasm-api` release tarball; the main
  # `aasm-*` tarball carries only aasm + aa-gateway. Installing the API server
  # here is what lets `aasm start --mode local` — which spawns aa-api-server —
  # work from a plain `brew install`. See AAASM-4448 / AAASM-4455.
  resource "api" do
    on_macos do
      on_arm do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-api-v0.0.1-rc.5-darwin-arm64.tar.gz"
        # END GENERATED: version
        sha256 "83f68a6bafc1c62fcb8de391766ba6eb80b790c03eb61333d77b8f416ab88df9"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-api-v0.0.1-rc.5-darwin-amd64.tar.gz"
        # END GENERATED: version
        sha256 "9f38af4479c17c4e3b77461046fdf844d150979c72a843de208b02e48361300c"
      end
    end
    on_linux do
      on_arm do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-api-v0.0.1-rc.5-linux-arm64.tar.gz"
        # END GENERATED: version
        sha256 "5afbe801735b2ea4bb21c8ff1895088055b64016155e17773df29a6c40368914"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.5/aasm-api-v0.0.1-rc.5-linux-amd64.tar.gz"
        # END GENERATED: version
        sha256 "c1c86a3222c193cb5e2ab28dd54679bbe203bae19406de3e26f468ee07566cf6"
      end
    end
  end

  def install
    bin.install "aasm", "aa-gateway"
    resource("api").stage do
      bin.install "aa-api-server"
    end
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
    assert_path_exists bin/"aa-gateway"
    assert_path_exists bin/"aa-api-server"
  end
end
