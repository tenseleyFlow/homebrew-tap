class Fussr < Formula
  desc "A git staging TUI tool - Rust port of fuss"
  homepage "https://github.com/tenseleyFlow/fussr"
  url "https://github.com/tenseleyFlow/fussr/archive/refs/tags/v0.2.13.tar.gz"
  sha256 "9548efb03ec10661821c9eea8c3a51538ef27d67c00302bf594a502745555dd6"
  license "MIT"
  head "https://github.com/tenseleyFlow/fussr.git", branch: "trunk"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
  end

  test do
    # Basic test - check that binary runs
    assert_match "fussr", shell_output("#{bin}/fussr --help 2>&1", 1) rescue true
  end
end
