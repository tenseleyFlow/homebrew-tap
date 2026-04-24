class Rcal < Formula
  desc "Responsive terminal calendar with local events and Microsoft Graph sync"
  homepage "https://github.com/tenseleyFlow/rcal"
  url "https://github.com/tenseleyFlow/rcal/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "5abfdb8412ee8a7e794aa4e62d3d0dbd10931b0a0f2f3899a6cd91ab76d6ba20"
  license "GPL-3.0-only"
  head "https://github.com/tenseleyFlow/rcal.git", branch: "trunk"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      To configure Microsoft calendars:
        rcal providers microsoft setup --account <account> --browser

      To install the reminder daemon:
        rcal reminders install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rcal --version")
    assert_match "Usage:", shell_output("#{bin}/rcal --help")
  end
end
