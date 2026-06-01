class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/AI-agent-assembly/agent-assembly"
  version "0.0.1-alpha.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "e8089ba79ad8b7f780b197f31be8a2dbe1c44a682d35fffe98cb6eb9d3d5b701"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "d82d604d2bd43de3cb6e7d9bf2b3a214a43806263356a9ddf9269e4e51bc7c29"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "530f9a542d9b6be2312cc09eb0591023edd7926e53cb92f98c36a0706e2a7613"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cff9dae8c4235f5d35d09a85b627f8e61c7d507d5fe011a49f7b33aaf8c9e169"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
