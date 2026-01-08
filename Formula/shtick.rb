class Shtick < Formula
  desc "Shell configuration manager with multi-shell support"
  homepage "https://github.com/tenseleyFlow/shtickC"
  url "https://github.com/tenseleyFlow/shtickC/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7ca94481ac775acd2cf7e1fef76e747502d659ed98fdc50254cbac43e8e0ce03"
  license "MIT"
  head "https://github.com/tenseleyFlow/shtickC.git", branch: "trunk"

  def install
    system "make"
    bin.install "shtick"

    # Install setup script
    (share/"shtick").install "setup.sh"

    # Install documentation
    doc.install "README.md"
    doc.install "CLAUDE.md"
  end

  def caveats
    <<~EOS
      Quick Setup (Recommended):
        Run the interactive setup script to enable auto-sourcing:

        #{share}/shtick/setup.sh

      Alternative Setup:
        Add to your shell config (~/.bashrc, ~/.zshrc, etc.):

        source ~/.config/shtick/load_active.<shell>

      Or generate wrapper function:
        shtick wrapper bash    # for bash
        shtick wrapper zsh     # for zsh
        shtick wrapper fish    # for fish

      Getting Started:
        shtick init           # Show setup instructions
        shtick status         # Show current status
        shtick alias ll='ls -la'   # Create an alias
    EOS
  end

  test do
    assert_match "shtick", shell_output("#{bin}/shtick --version 2>&1")
  end
end
