class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # BEGIN GENERATED: version
  version "0.0.1-rc.6"
  # END GENERATED: version
  license "MIT"

  on_macos do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "613a381beb0a5157bacf6bb4150d46407704058efffdc635c1131849fbe1fd2a"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "937914cbf86359db8a329c8abdcadd1615e889745f44c317d359cfc7e62f2591"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "bc2bc53b8755f3045ca532e32c167ff0685f5bba6bd8ddca70d081c66c3d042e"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "9500ca1568ff5b303735116febea61297f5c8d1a0078120bc4b15c108f30aa97"
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
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-api-v0.0.1-rc.6-darwin-arm64.tar.gz"
        # END GENERATED: version
        sha256 "5052ee6202edb335149d63c87b13e11d9c4db960d8d8ee9b3f5a515d693fc4cd"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-api-v0.0.1-rc.6-darwin-amd64.tar.gz"
        # END GENERATED: version
        sha256 "a3ae926b2b1044758aa6ee132c6bb43a344b85732ae5c46d7084ae2823157f98"
      end
    end
    on_linux do
      on_arm do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-api-v0.0.1-rc.6-linux-arm64.tar.gz"
        # END GENERATED: version
        sha256 "674f5d3e95521fc00424123713b9777747f42eb1b395f191b4e14d4a65f9d2ec"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-api-v0.0.1-rc.6-linux-amd64.tar.gz"
        # END GENERATED: version
        sha256 "a0a93a6ecf619b379fd5e0cc60a3fa1f73dbaa84886274e1004a4ed5848d4955"
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
