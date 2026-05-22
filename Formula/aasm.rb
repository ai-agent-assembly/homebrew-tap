class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/AI-agent-assembly/agent-assembly"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
