class AasmEbpf < Formula
  desc "Kernel eBPF enforcement component for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  version "0.0.1-rc.2"
  license "MIT"

  # eBPF is kernel instrumentation and ships for Linux only (ADR-014). depends_on
  # :linux makes the formula unavailable (rather than silently broken) on macOS.
  depends_on :linux

  # Component-aware artifacts (ADR-014). The sha256 values below are placeholders
  # resolved by the release automation when the first aasm-ebpf component artifact
  # is published (AAASM-3951); they are not hand-maintained.
  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-ebpf-v#{version}-linux-arm64.tar.gz"
      sha256 "9999999999999999999999999999999999999999999999999999999999999999"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v#{version}/aasm-ebpf-v#{version}-linux-amd64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end
  end

  def install
    bin.install "aasm-ebpf"
  end

  test do
    assert_match(/aasm-ebpf/i, shell_output("#{bin}/aasm-ebpf --version"))
  end
end
