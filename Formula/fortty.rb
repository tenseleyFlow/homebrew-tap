class Fortty < Formula
  desc "GPU-accelerated terminal emulator written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/fortty"
  url "https://github.com/FortranGoingOnForty/fortty/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "d8620f932e286679e0cc09af28fa6d395311ee8da7230a2f2c588127331233f3"
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
