class Gump < Formula
  desc "A smarter cd command - directory jumper using frecency"
  homepage "https://github.com/tenseleyFlow/gump"
  url "https://github.com/tenseleyFlow/gump/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2d505f50ab334a6e8dff255a5c627f44fd0b9fc7602b2c812076e11a7e8ebb89"
  license "MIT"
  head "https://github.com/tenseleyFlow/gump.git", branch: "trunk"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Add to your shell config:

      Bash (~/.bashrc):
        eval "$(gump init bash)"

      Zsh (~/.zshrc):
        eval "$(gump init zsh)"

      Fish (~/.config/fish/config.fish):
        gump init fish | source

      Usage:
        g foo        # jump to best match
        gi foo       # interactive with fzf
        foo          # no prefix needed
    EOS
  end

  test do
    assert_match "gump", shell_output("#{bin}/gump --help")
  end
end
