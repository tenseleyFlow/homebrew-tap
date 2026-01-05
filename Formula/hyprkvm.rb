class Hyprkvm < Formula
  desc "Hyprland-native software KVM switch"
  homepage "https://github.com/tenseleyFlow/hyprKVM"
  url "https://github.com/tenseleyFlow/hyprKVM/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "18a510ea78fcd9b5c15d309364e8109d6cc6af0c4136aa0fa8e900f24e45352e"
  license "MIT"
  head "https://github.com/tenseleyFlow/hyprKVM.git", branch: "trunk"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"
  depends_on :linux

  def install
    system "cargo", "build", "--release", "-p", "hyprkvm-daemon", "-p", "hyprkvm-cli"
    bin.install "target/release/hyprkvm"
    bin.install "target/release/hyprkvm-ctl"
  end

  test do
    assert_match "hyprkvm", shell_output("#{bin}/hyprkvm --version")
  end
end
