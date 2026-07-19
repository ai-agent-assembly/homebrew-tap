class AasmBundle < Formula
  desc "Convenience bundle of the Agent Assembly CLI, runtime, and proxy"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # Homebrew requires a stable url + sha256 for every formula. This bundle ships a
  # tiny dependency-only marker artifact alongside the components (ADR-014,
  # AAASM-3951). The version is written literally (not interpolated) because the
  # url must appear before `version` in formula component order. The sha256 is a
  # placeholder resolved by the release automation and is not hand-maintained.
  # BEGIN GENERATED: version
  url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.6/aasm-bundle-v0.0.1-rc.6.tar.gz"
  # END GENERATED: version
  sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
  license "MIT"

  # No `aasm-bundle-*.tar.gz` release artifact has ever been published (rc.1
  # through rc.6 all 404), so the url above 404s and the sha256 is still the
  # release-automation placeholder. Mirror the aasm-ebpf.rb pattern: keep the
  # formula visible so users discover the bundle, but disable it so `brew
  # install aasm-bundle` gives a clear message instead of failing on a 404 /
  # checksum mismatch. Re-enable once the release pipeline publishes a real
  # aasm-bundle-<version>.tar.gz asset and its real sha256 is set here
  # (AAASM-4879).
  disable! date:    "2026-07-19",
           because: "no aasm-bundle release artifact has been published yet; re-enable once a real aasm-bundle-<version>.tar.gz asset and sha256 exist"

  # Meta/convenience formula: installs no binaries of its own; it pulls the
  # component formulae so `brew install aasm-bundle` sets up a local stack in one
  # step. eBPF is intentionally excluded (Linux-only, kernel-privileged) — install
  # aasm-ebpf explicitly where supported. Dependencies are tap-qualified so `brew
  # audit` resolves them unambiguously to this tap's formulae.
  depends_on "ai-agent-assembly/tap/aasm"
  depends_on "ai-agent-assembly/tap/aasm-proxy"
  depends_on "ai-agent-assembly/tap/aasm-runtime"

  def install
    # Ship only a small manifest documenting what the bundle pulled in.
    (pkgshare/"COMPONENTS").write "aasm aa-runtime aa-proxy\n"
  end

  test do
    assert_path_exists pkgshare/"COMPONENTS"
  end
end
