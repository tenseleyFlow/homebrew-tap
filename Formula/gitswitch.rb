class Gitswitch < Formula
  desc "Secure Git identity and SSH/GPG key management for seamless account switching"
  homepage "https://github.com/tenseleyFlow/gitswitchC"
  url "https://github.com/tenseleyFlow/gitswitchC/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "f2e1c5681bfc89b0605616e8a0d3140a19f9261f8a429abb7273db3170e51aa2"
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

      For bash/zsh:
        eval "$(gitswitch --ssh-agent-info)"

      For fish:
        gitswitch --ssh-agent-info | source
    EOS
  end

  test do
    assert_match "gitswitch", shell_output("#{bin}/gitswitch --version 2>&1", 1)
  end
end
