class Gitswitch < Formula
  desc "Secure Git identity and SSH/GPG key management for seamless account switching"
  homepage "https://github.com/tenseleyFlow/gitswitchC"
  url "https://github.com/tenseleyFlow/gitswitchC/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "3628317c6dd2470707e4fcc141ab38b089892661030ccbf246fad9c2d5506d9b"
  license "GPL-3.0-or-later"
  head "https://github.com/tenseleyFlow/gitswitchC.git", branch: "trunk"

  depends_on "gnupg"
  depends_on "readline"
  uses_from_macos "git"

  on_linux do
    depends_on "openssh"
  end

  def install
    # GitHub tag archives omit .git; embed the package provenance explicitly.
    system "make", "BUILD_TYPE=release", "READLINE=1",
                   "VERSION=#{version}", "COMMIT=homebrew"
    system "make", "install", "BUILD_TYPE=release", "READLINE=1",
                   "VERSION=#{version}", "COMMIT=homebrew", "PREFIX=#{prefix}"

    doc.install "README.md"
  end

  def caveats
    <<~EOS
      To integrate with your shell, add to your shell config:

      For bash:
        eval "$(gitswitch init bash)"

      For zsh:
        eval "$(gitswitch init zsh)"

      For fish:
        gitswitch init fish | source

      (The legacy `gitswitch --ssh-agent-info` invocation is still accepted
      as a compat alias and auto-detects your shell from $SHELL.)
    EOS
  end

  test do
    assert_equal "gitswitch-c #{version} (homebrew)\n",
                 shell_output("#{bin}/gitswitch --version")
  end
end
