class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/AI-agent-assembly/agent-assembly"
  version "0.0.1-alpha.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "72797101248d3f21aee9b755f4945ca593e05ec767753083451157e0fe122b44"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "95eeb7aa13fe4a187e5664364088c00f120e3aa0660cba2a740a360fcf8f60af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "297deb95eeed2e495644310d76ae41178352e3fb8023a252572220eb24e1557c"
    end
    on_intel do
      url "https://github.com/AI-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5461865e74f3e125b469ad6e370062ff739c44bdf1417ca4622c68b999540e57"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
