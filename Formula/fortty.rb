class Fortty < Formula
  desc "GPU-accelerated terminal emulator written in Fortran"
  homepage "https://github.com/FortranGoingOnForty/fortty"
  url "https://github.com/FortranGoingOnForty/fortty/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "337da567e7d7efefdd6e516e111831f3c9a0a6a91e2c16dea8fe3380831b4c82"
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
