class Gitswitch < Formula
  desc "Secure Git identity and SSH/GPG key management for seamless account switching"
  homepage "https://github.com/tenseleyFlow/gitswitchC"
  url "https://github.com/tenseleyFlow/gitswitchC/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "f13f6e0674bb02d599a4b0862a50995eea41f591c6bfd436967c6ad3149da80a"
  license "GPL-3.0-or-later"
  head "https://github.com/tenseleyFlow/gitswitchC.git", branch: "trunk"

  depends_on "openssl"

  def install
    # Pass VERSION/COMMIT explicitly: GitHub tarballs strip .git, which would
    # otherwise leave the binary reporting "(unknown)" even though the upstream
    # Makefile has a VERSION file fallback. This just makes it belt-and-suspenders.
    system "make", "BUILD_TYPE=release", "VERSION=#{version}", "COMMIT=homebrew"

    bin.install "build/bin/gitswitch"
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
    assert_match "gitswitch", shell_output("#{bin}/gitswitch --version 2>&1", 1)
  end
end
