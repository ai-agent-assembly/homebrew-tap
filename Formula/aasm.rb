class Aasm < Formula
  desc "Agent Assembly CLI for the aasm runtime and dashboard"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  version "0.0.1-beta.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-apple-darwin.tar.gz"
      sha256 "2180f689ceea698767350f76b2de93425b91d5be18bf8a3b948adf028c459380"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-apple-darwin.tar.gz"
      sha256 "0cbdc67b51b087080707f4193a0310335deadf7aae8241eb857d644fa9f313a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f776fb338a3dcfa6bfd3e844918bf8f92e9991e0e5e7cc68a12c9beeb7d10bc4"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22ec72c2308a058fec72b2b4c91c80fd3301545e51012726efef23fdeb0d38da"
    end
  end

  def install
    bin.install "aasm"
  end

  test do
    assert_match(/aasm/i, shell_output("#{bin}/aasm --version"))
  end
end
