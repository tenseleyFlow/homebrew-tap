class Gump < Formula
  desc "A smarter cd command - directory jumper using frecency"
  homepage "https://github.com/tenseleyFlow/gump"
  url "https://github.com/tenseleyFlow/gump/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "0c53d3a8f0a12a97901fb7bdddf8fe3dc2ab67425b2460455f9c44c947b8f223"
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

      Then restart your shell or source the config file.

      Usage:
        g foo        # jump to best match
        gi foo       # interactive with fzf
        foo          # no prefix needed
        g            # go home
        g -          # go back

      Import existing data:
        gump import  # imports from zoxide/autojump/z/fasd
    EOS
  end

  test do
    assert_match "gump", shell_output("#{bin}/gump --help")
  end
end
