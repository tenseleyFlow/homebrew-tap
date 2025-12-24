class Fortty < Formula
  desc "GPU-accelerated terminal emulator written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/fortty"
  url "https://github.com/FortranGoingOnForty/fortty/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "5c8b2d9e331ad1f0985606ce9252f2fcceb94586d62f949d138048c28cea0749"
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
