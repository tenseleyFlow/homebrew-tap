class Liszt < Formula
  desc "GNU ls reimplementation: byte-identical output, radix sorts, parallel stat"
  homepage "https://github.com/tenseleyFlow/liszt"
  url "https://github.com/tenseleyFlow/liszt/releases/download/v0.3.0/liszt-0.3.0.tar.gz"
  sha256 "fd3924a74174f8086ebb0141d6e3b039629cb0c8579dc304ce0d6206a219e8c4"
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
    # v0.3: themes emit 24-bit SGR.
    themed = shell_output("#{bin}/liszt --theme=dracula -l #{testpath}")
    assert_match "38;2;", themed
  end
end
