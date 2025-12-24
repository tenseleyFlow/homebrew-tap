class Fortty < Formula
  desc "GPU-accelerated terminal emulator written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/fortty"
  url "https://github.com/FortranGoingOnForty/fortty/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "20b39136cb6dd954e2aae48cafc3fd8d05aa068779d14dfdbb5f84c71ee388d9"
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
