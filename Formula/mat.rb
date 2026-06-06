class Mat < Formula
  desc "A fast cat/bat alternative with syntax highlighting and a built-in pager"
  homepage "https://github.com/tenseleyFlow/mat"
  url "https://github.com/tenseleyFlow/mat.git",
      tag: "v0.7.3",
      revision: "64f804a6c0a4187a242dd8ec65388376fbbc0a9e"
  license "MIT"
  head "https://github.com/tenseleyFlow/mat.git", branch: "trunk"

  def install
    system "./configure"
    system "make"
    bin.install "mat"
    man1.install "man/mat.1" if File.exist?("man/mat.1")
    bash_completion.install "completions/mat.bash" => "mat"
    zsh_completion.install "completions/mat.zsh" => "_mat"
    fish_completion.install "completions/mat.fish"
  end

  test do
    assert_match "mat 0.7.3", shell_output("#{bin}/mat --version")
    assert_match "usage:", shell_output("#{bin}/mat --help")

    (testpath/"hello.txt").write("hello world\n")
    assert_equal "hello world\n", shell_output("#{bin}/mat hello.txt")
  end
end
