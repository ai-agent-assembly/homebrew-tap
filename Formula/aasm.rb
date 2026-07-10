class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # BEGIN GENERATED: version
  version "0.0.1-rc.3"
  # END GENERATED: version
  license "MIT"

  on_macos do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "f2610b39905fd90204d8c9adc624de3ef8531eeab51f2a80afea9175a3a9d216"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      # END GENERATED: version
      sha256 "e5054f1e3d271f3d5a501278c75ae7fe46a0ce0fb6f3a61969dc65d53f752e01"
    end
  end

  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "b1e6a4ee40c87548c8c2fca8749a8624f3c80b38cc5e185aad8132da6fdec9ff"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      # END GENERATED: version
      sha256 "051e5f24dc8056bc59fbf0a843ba5c9c108926e18b594be1a1dfd7d2ff9771f1"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
