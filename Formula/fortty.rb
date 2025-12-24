class Fortty < Formula
  desc "GPU-accelerated terminal emulator written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/fortty"
  url "https://github.com/FortranGoingOnForty/fortty/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "f4ad65d740fe6bf6495224b053f87f4f5eea64a2f63f98f6dc343b27619a0df5"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "freetype"
  depends_on "glfw"
  depends_on "fontconfig"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/fortty"
  end

  test do
    assert_predicate bin/"fortty", :executable?
  end
end
