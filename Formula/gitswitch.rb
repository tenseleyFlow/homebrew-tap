class Gitswitch < Formula
  desc "Secure Git identity and SSH/GPG key management for seamless account switching"
  homepage "https://github.com/tenseleyFlow/gitswitchC"
  url "https://github.com/tenseleyFlow/gitswitchC/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "c644056ce5d21227e3168af918e95ae20547465fb226f4104182a95979dd50d7"
  license "GPL-3.0-or-later"
  head "https://github.com/tenseleyFlow/gitswitchC.git", branch: "trunk"

  depends_on "openssl"

  def install
    # Build release version
    system "make", "BUILD_TYPE=release"

    # Install binary
    bin.install "build/bin/gitswitch"

    # Install documentation
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
