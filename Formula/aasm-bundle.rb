class AasmBundle < Formula
  desc "Convenience bundle of the Agent Assembly CLI, runtime, and proxy"
  homepage "https://github.com/ai-agent-assembly/agent-assembly"
  # Homebrew requires a stable url + sha256 for every formula. This bundle ships a
  # tiny dependency-only marker artifact alongside the components (ADR-014,
  # AAASM-3951). The version is written literally (not interpolated) because the
  # url must appear before `version` in formula component order. The sha256 is a
  # placeholder resolved by the release automation and is not hand-maintained.
  url "https://github.com/ai-agent-assembly/agent-assembly/releases/download/v0.0.1-rc.2/aasm-bundle-v0.0.1-rc.2.tar.gz"
  sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
  license "MIT"

  # Meta/convenience formula: installs no binaries of its own; it pulls the
  # component formulae so `brew install aasm-bundle` sets up a local stack in one
  # step. eBPF is intentionally excluded (Linux-only, kernel-privileged) — install
  # aasm-ebpf explicitly where supported. Tap-local names are unqualified so they
  # resolve within whichever tap name this formula is installed under.
  depends_on "aasm"
  depends_on "aasm-proxy"
  depends_on "aasm-runtime"

  def install
    # Ship only a small manifest documenting what the bundle pulled in.
    (pkgshare/"COMPONENTS").write "aasm aasm-runtime aasm-proxy\n"
  end

  test do
    assert_path_exists pkgshare/"COMPONENTS"
  end
end
