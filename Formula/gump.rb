class Gump < Formula
  desc "A smarter cd command - directory jumper using frecency"
  homepage "https://github.com/tenseleyFlow/gump"
  url "https://github.com/tenseleyFlow/gump/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "c87841918270da04db8e75bd3e651ec57dfe1b22d042d9fba834582798a44725"
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
