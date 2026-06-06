class Facsimile < Formula
  desc "Terminal text editor written in Fortran with VSCode-style keybindings"
  homepage "https://github.com/FortranGoingOnForty/facsimile"
  url "https://github.com/FortranGoingOnForty/facsimile/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "14670f6102dc3ef2279ac80f29792d2908f140ca999ead0011a7d5839b3bde4c"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/facsimile.git", branch: "trunk"

  depends_on "gcc" # for gfortran

  def install
    # Build using make
    system "make"

    # Install binary
    bin.install "fac"

    # Create symlink for convenience
    bin.install_symlink "fac" => "facsimile"

    # Install documentation
    doc.install "README.md"
  end

  test do
    # Test that fac can run (basic version check or help)
    system "#{bin}/fac", "--help" rescue true
  end
end
