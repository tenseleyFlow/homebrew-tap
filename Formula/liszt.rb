class Liszt < Formula
  desc "GNU ls reimplementation: byte-identical output, radix sorts, parallel stat"
  homepage "https://github.com/tenseleyFlow/liszt"
  url "https://github.com/tenseleyFlow/liszt/releases/download/v0.1.0/liszt-0.1.0.tar.gz"
  sha256 "62be1698a0a8c767056be3e4fbc03812d97adc152643f2a559cad241ef825eb8"
  license "GPL-3.0-or-later"
  head "https://github.com/tenseleyFlow/liszt.git", branch: "trunk"

  def install
    system "./configure"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "liszt #{version}", shell_output("#{bin}/liszt --version")
    (testpath/"b").write ""
    (testpath/"a").write ""
    assert_equal "a\nb", shell_output("#{bin}/liszt -1 #{testpath}").strip
    # lz is the same binary under a shorter name.
    assert_match "liszt #{version}", shell_output("#{bin}/lz --version")
    assert_equal "b\na", shell_output("#{bin}/lz -1r #{testpath}").strip
  end
end
