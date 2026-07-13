class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # BEGIN GENERATED: version
  version "0.0.1-rc.4"
  # END GENERATED: version
  license "MIT"

  on_macos do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "5c1d9ca4f79dd0834ea177169b3e7b71a846044abc6af8f6cb4918d579b48e2e"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "3641a11f464a24cd54eb105396cd7afb2a8d6ee4140a7bb7d2238b54198b9e69"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "8b87b5f9c088acf08477af817f0bb3a3e3aa4498c3c88c8b236bf96e87faaa3a"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "715af386f40aef2df9f02c21953e9ae769f5922d7f73bda1bf11911e9403a6ba"
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
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-api-v#{version}-darwin-arm64.tar.gz"
        # END GENERATED: version
        sha256 "f63d08c0606d01d4e4b6fab67134e071df3a1116131e159f34d01f3ad1b939ae"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-api-v#{version}-darwin-amd64.tar.gz"
        # END GENERATED: version
        sha256 "92785b5d80bd58cda6cfa7f91ceb35bf0c9d15ad6e521510aa575c64bd96a607"
      end
    end
    on_linux do
      on_arm do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-api-v#{version}-linux-arm64.tar.gz"
        # END GENERATED: version
        sha256 "2bb5ec3f367d53c4232258627a6de88fc6c648e95120f9dcc3a50dbb6e60f93f"
      end
      on_intel do
        # BEGIN GENERATED: version
        url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-api-v#{version}-linux-amd64.tar.gz"
        # END GENERATED: version
        sha256 "b86e5dc0a5c1354117988321a434df68791219a03520ffc6ae01f57f56fe1a0c"
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
