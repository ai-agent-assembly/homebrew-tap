class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  version "0.0.1-alpha.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "1e08c94bb3bbb1c1a179684953f033c2d8cf8da96adc63a7d1a070948e8bfdd1"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "047e0cb58d7bd7e440c7826649e107b7af048a01c0a07f3480049a7426ff02c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "95b7f7cac29bbcee59a0636f2ac3a19805276a61c2fcdac4ed0b5a682124b462"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "311be632ca2c3b17dab1cecf7c9c97ecaf09f23b6a3ce2843d34ee1a055ac8e9"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
