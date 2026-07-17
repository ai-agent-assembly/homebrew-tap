class AasmEbpf < Formula
  desc "Kernel eBPF enforcement component for Agent Assembly"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # Real, resolvable source: the aa-ebpf crate published on crates.io at the
  # current release tag. This is the crate source, not a prebuilt binary — the
  # formula is disabled, so nothing is fetched or built until a real brew
  # artifact exists.
  #
  # AAASM-4678: the crate URL is now generator-managed. The crates.io filename
  # embeds the version WITHOUT a leading `v` (`aa-ebpf-0.0.1-rc.5.crate`);
  # scripts/generate_formulas.rb rewrites this bare-semver crate-style pin from
  # metadata/versions.rb, so it tracks each release instead of silently lagging.
  # The sha256 stays outside the sentinel — like every other formula, it is
  # owned by release automation and bumped from the crate's checksum on release
  # (AAASM-3951), so it must still be refreshed when the version changes.
  # BEGIN GENERATED: version
  url "https://static.crates.io/crates/aa-ebpf/aa-ebpf-0.0.1-rc.6.crate"
  # END GENERATED: version
  sha256 "d7260ad2b771d41653dbfd107af8be83e56282233337e1aa4885935005aa4cb7"
  license "MIT"

  # The eBPF component is the privileged Linux CAP_BPF loader daemon
  # `aa-ebpf-loaderd`. Unlike cli/runtime/proxy, the release pipeline
  # deliberately does NOT publish an installable brew artifact for it —
  # scripts/check-release-completeness.sh allowlists `aa-ebpf-loaderd` as
  # intentionally unreleased (AAASM-4456). Keep the formula visible so users
  # discover the component, but disabled so `brew install` gives a clear
  # message rather than a 404. Re-enable only once ebpf ships as a real brew
  # artifact (AAASM-4325).
  disable! date:    "2026-07-08",
           because: "the eBPF loader daemon aa-ebpf-loaderd is not yet shipped as a brew artifact"

  # eBPF is kernel instrumentation and ships for Linux only (ADR-014). depends_on
  # :linux makes the formula unavailable (rather than silently broken) on macOS.
  depends_on :linux

  def install
    bin.install "aa-ebpf-loaderd"
  end

  test do
    assert_path_exists bin/"aa-ebpf-loaderd"
  end
end
