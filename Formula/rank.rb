class Rank < Formula
  desc "GNU sort reimplementation: byte-identical output, MSD radix sorting"
  homepage "https://github.com/tenseleyFlow/rank"
  url "https://github.com/tenseleyFlow/rank/releases/download/v0.1.1/rank-0.1.1.tar.gz"
  sha256 "6cffe28390ed82e5a188e524c81e6789ccf8bf0c4a9e9f9b464e2c680392aed0"
  license "MIT"
  head "https://github.com/tenseleyFlow/rank.git", branch: "trunk"

  def install
    system "./configure"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "rank #{version}", shell_output("#{bin}/rank --version")
    assert_equal "a\nb\n", pipe_output("#{bin}/rank", "b\na\n")
    assert_equal "b\na\n", pipe_output("#{bin}/rank -r", "a\nb\n")
  end
end
