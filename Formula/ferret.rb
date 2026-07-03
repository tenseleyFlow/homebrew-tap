class Ferret < Formula
  desc "Fast, byte-for-byte reimplementation of GNU find(1) in C"
  homepage "https://github.com/tenseleyFlow/ferret"
  # Release asset (bundles the frtdate submodule); the generated tag archive omits it.
  url "https://github.com/tenseleyFlow/ferret/releases/download/v0.1.0/ferret-0.1.0.tar.gz"
  sha256 "95c5cad610c362c1b679dc41169a1e44f86a4ad8bb287295f8f4f792a5b47c3f"
  license "MIT"
  head "https://github.com/tenseleyFlow/ferret.git", branch: "trunk"

  def install
    system "./configure"
    system "make", "release"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "ferret #{version}", shell_output("#{bin}/ferret --version")
    (testpath/"a.txt").write("")
    assert_match "a.txt", shell_output("#{bin}/ferret #{testpath} -name a.txt")
    # frt is the same binary under a second name.
    assert_match "a.txt", shell_output("#{bin}/frt #{testpath} -name a.txt")
  end
end
