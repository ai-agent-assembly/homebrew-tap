class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # BEGIN GENERATED: version
  version "0.0.1-rc.7"
  # END GENERATED: version
  license "MIT"

  on_macos do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "c4c5c21d84c366b41a1a712c1b199cee53b9f7b543c6c1cd7e81187e37cf54c8"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "c26dbb2f9361f13f218358b1a08ce6c5a27473092820cc2b1cda2ca70441f874"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "3bd1b67a964d4edcf73c1229202b8a9f0b59c347e7b1022471b31214604bd9ef"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "91f6d0655e4f4d6e2e65652548fb84b929acca0318c9b46818d1a55fa0117cd6"
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
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-api-v0.0.1-rc.7-darwin-arm64.tar.gz"
        # END GENERATED: version
        sha256 "1f615bedead45dd3550907be10917bad3d03ffbd41ae801c76e658098c5bfa12"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-api-v0.0.1-rc.7-darwin-amd64.tar.gz"
        # END GENERATED: version
        sha256 "578a3c677a8ee1df4e82c4f4f3a660c35971a0da21b6598262e341a98278f85c"
      end
    end
    on_linux do
      on_arm do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-api-v0.0.1-rc.7-linux-arm64.tar.gz"
        # END GENERATED: version
        sha256 "c5ab94539d2ff21aaea84675e8a76ed55a5a5521003983b044bf0225a88f3d70"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.7/aasm-api-v0.0.1-rc.7-linux-amd64.tar.gz"
        # END GENERATED: version
        sha256 "b8a0ee8b95a94c92ae13e3bed761e3fd4ca1c5d80bd654dac0dec54aa37fdea6"
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
