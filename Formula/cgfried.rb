class Cgfried < Formula
  desc "Standards-first C17 compiler for x86-64 and ARM64"
  homepage "https://github.com/tenseleyFlow/Cgfried"
  url "https://github.com/tenseleyFlow/Cgfried/releases/download/v0.1.0/cgfried-0.1.0.tar.gz"
  sha256 "7f3b6e70b3276171e8cee878e92b433d8f3d365452b69a33c8848f5e4f12a548"
  license "GPL-3.0-only"
  head "https://github.com/tenseleyFlow/Cgfried.git", branch: "trunk"

  depends_on "rust" => :build

  on_macos do
    depends_on arch: :arm64
  end

  def install
    system "cargo", "install", *std_cargo_args(path: "afs-as")
    system "make", "install", "PREFIX=#{prefix}"

    man1.install "doc/cgfried.1"
    doc.install "README.md", "CHANGELOG.md"
  end

  test do
    version_banner = "cgfried (Cgfried) #{version}"
    assert_match version_banner, shell_output("#{bin}/cgfried --version")
    assert_match version_banner, shell_output("#{bin}/cgf --version")

    (testpath/"hello.c").write <<~C
      #include <stdio.h>
      int main(void) {
          puts("cgfried-homebrew");
          return 0;
      }
    C
    system bin/"cgfried", "-Wall", "-Wextra", testpath/"hello.c",
           "-o", testpath/"hello"
    assert_equal "cgfried-homebrew\n", shell_output(testpath/"hello")
  end
end
