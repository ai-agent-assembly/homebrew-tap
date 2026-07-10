class AasmEbpf < Formula
  desc "Kernel eBPF enforcement component for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  license "MIT"

  # AAASM-3951 shipped component-aware release artifacts for `cli`, `runtime`
  # and `proxy`, but the ebpf variant is not yet packaged as an installable
  # tar.gz — the release only publishes raw probe binaries (see the tag's
  # EBPF_SHA256SUMS). Keep this formula visible in the tap as a scaffold so
  # users discover the component exists, but disabled with a clear message
  # instead of a 404 / checksum error. A follow-up will remove this block
  # once ebpf tar.gz artifacts start shipping alongside runtime/proxy.
  disable! date:    "2026-07-08",
           because: "aasm-ebpf tar.gz artifacts are not yet published (only raw probe binaries ship today)"

  # eBPF is kernel instrumentation and ships for Linux only (ADR-014). depends_on
  # :linux makes the formula unavailable (rather than silently broken) on macOS.
  depends_on :linux

  # url/sha256 pairs kept as placeholders — they will be filled in once the
  # ebpf tar.gz artifacts start publishing and the disable! block above is
  # removed. Do not attempt to hand-maintain the sha values.
  on_linux do
    on_arm do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.3/aasm-ebpf-v0.0.1-rc.3-linux-arm64.tar.gz"
      # END GENERATED: version
      sha256 "9999999999999999999999999999999999999999999999999999999999999999"
    end
    on_intel do
      # BEGIN GENERATED: version
      url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.3/aasm-ebpf-v0.0.1-rc.3-linux-amd64.tar.gz"
      # END GENERATED: version
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
