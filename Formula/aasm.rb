class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/AI-agent-assembly/agent-assembly"
  version "0.0.1-alpha.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "5167aa13783621d1778fd877c411d8d5874ef1657cc4d60b03e49b6b321236d7"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "ed7e585067687935c74e6e35e7d6f78fedf389d7f417e3fd9e29fe1eb834f249"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ea8e724f917bf5eb2f46e849f4b8147a54428954562bbd37f73a233c62e81917"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a36e3eae93efb71505f438eb4349cf50b62d5f409a53f2c3a08e51eb7ca530b"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
