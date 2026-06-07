class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  version "0.0.1-alpha.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "329de738c91a7f697a16ebbe9ccbee5830f16998b887e7d3d306598adee78c04"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "edb50340bf6228e0b8e89c5702db884215fe52741d361a618942d114fe39df7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2472bc969db7516e8cf379522d6d4f0d9b11d5762dc76c76e225fc36915460b7"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "226d221ca4569b7063db0b3a3f478751e6e92e2ef5315740a1c6777a30c2e26f"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
