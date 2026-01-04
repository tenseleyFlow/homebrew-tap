class Hyprkvm < Formula
  desc "Hyprland-native software KVM switch"
  homepage "https://github.com/tenseleyFlow/hyprKVM"
  url "https://github.com/tenseleyFlow/hyprKVM/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "09d420a468b23c259df0a4a3335d5912c2687c9d7f5979eeb7e3d5475ee8f229"
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
