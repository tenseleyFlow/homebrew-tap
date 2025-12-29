class Fackr < Formula
  desc "Terminal text editor written in Rust - facsimile reimplementation"
  homepage "https://github.com/TenseleyFlow/fackr"
  url "https://github.com/TenseleyFlow/fackr/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "37be16e8fbdd5e7fb03c8abc90a74167d749a0de4d27225f81a449407f53a32e"
  license "MIT"
  head "https://github.com/TenseleyFlow/fackr.git", branch: "trunk"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "fackr", shell_output("#{bin}/fackr --version")
  end
end
