class Fackr < Formula
  desc "Terminal text editor written in Rust - facsimile reimplementation"
  homepage "https://github.com/TenseleyFlow/fackr"
  url "https://github.com/TenseleyFlow/fackr/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "6a3212fb434554e148df0eb8abe34191dd7c413a2c25420e34103f014c03becf"
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
