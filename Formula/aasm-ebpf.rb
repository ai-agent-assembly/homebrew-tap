class AasmEbpf < Formula
  desc "Kernel eBPF enforcement component for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # eBPF is kernel instrumentation and ships for Linux only (ADR-014). depends_on
  # :linux makes the formula unavailable (rather than silently broken) on macOS.
  disable! date:    "2026-07-08",
           because: "aasm-ebpf component artifacts are not yet published; pending release automation (AAASM-3951)"

  depends_on :linux

  # Component-aware artifacts (ADR-014) — the url/sha256 pairs below are
  # placeholders that AAASM-3951's release automation will fill in when the
  # first aasm-ebpf component artifact is published. Until then the formula
  # can't produce a working install, so it is disabled with a clear message
  # rather than a checksum error. AAASM-3951 removes this disable! line.

  on_linux do
    on_arm do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-ebpf-v0.0.1-rc.2-linux-arm64.tar.gz"
      sha256 "9999999999999999999999999999999999999999999999999999999999999999"
    end
    on_intel do
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-ebpf-v0.0.1-rc.2-linux-amd64.tar.gz"
      sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    end
  end

  def install
    bin.install "aa-ebpf"
  end

  test do
    assert_match(/aa-ebpf/i, shell_output("#{bin}/aa-ebpf --version"))
  end
end
