class Rcal < Formula
  desc "Responsive terminal calendar with local events and Microsoft Graph sync"
  homepage "https://github.com/tenseleyFlow/rcal"
  url "https://github.com/tenseleyFlow/rcal/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "f5406444738d6e62f27de368987b8d41b38b1bc1a672ab3932a9d30f65bdfc16"
  license "GPL-3.0-only"
  head "https://github.com/tenseleyFlow/rcal.git", branch: "trunk"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      To create a starter config:
        rcal config init

      To configure Microsoft calendars, edit your config.toml with provider
      account settings, then run:
        rcal providers microsoft auth login --account <account> --browser
        rcal providers microsoft calendars list --account <account>
        rcal providers microsoft sync --account <account>

      To install the reminder daemon:
        rcal reminders install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rcal --version")
    assert_match "Usage:", shell_output("#{bin}/rcal --help")
  end
end
