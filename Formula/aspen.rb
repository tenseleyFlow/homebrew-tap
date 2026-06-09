class Aspen < Formula
  desc "Fast, byte-compatible reimplementation of tree(1) in C"
  homepage "https://github.com/tenseleyFlow/aspen"
  url "https://github.com/tenseleyFlow/aspen/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ad10113502aa0f764b6d5ac91b58a5be92e1b3f125800f08d2224bad4997fb1e"
  license "MIT"
  head "https://github.com/tenseleyFlow/aspen.git", branch: "trunk"

  def install
    system "./configure"
    system "make", "release"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "aspen v#{version}", shell_output("#{bin}/aspen --version")
    (testpath/"sub").mkpath
    (testpath/"file").write("")
    assert_match "sub", shell_output("#{bin}/aspen #{testpath}")
  end
end
