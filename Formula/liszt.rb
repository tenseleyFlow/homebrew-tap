class Liszt < Formula
  desc "GNU ls reimplementation: byte-identical output, radix sorts, parallel stat"
  homepage "https://github.com/tenseleyFlow/liszt"
  url "https://github.com/tenseleyFlow/liszt/releases/download/v0.2.0/liszt-0.2.0.tar.gz"
  sha256 "c045e8827f1efdae466a7d83cc32cd96b911a3fa27394aa76a2fa028490b1e30"
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
    # v0.2 extensions: icons emit a glyph, tree emits a branch.
    icons = shell_output("#{bin}/liszt --icons=always -1 #{testpath}")
    refute_equal "a\nb", icons.strip
    tree = shell_output("#{bin}/liszt --tree --tree-glyphs=ascii #{testpath}")
    assert_match "`-- ", tree
  end
end
