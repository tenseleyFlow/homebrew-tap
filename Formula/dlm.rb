class Dlm < Formula
  desc "Text file becomes your personal, locally-trained LLM"
  homepage "https://github.com/tenseleyFlow/DocumentLanguageModel"
  # Fat tarball built by release.yml — bundles vendor/llama.cpp/ (source
  # only, no binaries) so the convert_hf_to_gguf.py / convert_lora_to_gguf.py
  # scripts `dlm export` invokes are available under libexec.
  url "https://github.com/tenseleyFlow/DocumentLanguageModel/releases/download/v0.9.0/dlm-v0.9.0.tar.gz"
  sha256 "887e89d5651861c5f9c55bb3fcf3c238a133b74469c51227401a0c1b6b7ee9a9"
  license "MIT"

  depends_on "python@3.11"
  # `llama-quantize` + `llama-imatrix` live here; DLM's vendoring resolver
  # falls back to PATH when the in-tree `vendor/llama.cpp/build/` isn't
  # present (brew installs don't ship the compiled binaries).
  depends_on "llama.cpp"

  def install
    venv_root = libexec/"venv"
    system Formula["python@3.11"].opt_bin/"python3.11", "-m", "venv", venv_root
    system venv_root/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"

    # Install DLM + its runtime deps. pip resolves torch, transformers,
    # peft, trl, datasets, huggingface-hub, safetensors, packaging from
    # PyPI (we depend on those indirectly; we don't publish dlm itself).
    system venv_root/"bin/pip", "install", buildpath

    # Stash the vendored llama.cpp Python helpers (convert scripts +
    # gguf-py/) under libexec so the `dlm` shim can point at them.
    # We never rely on the vendored `build/` here — `depends_on
    # "llama.cpp"` handles the binary side.
    if (buildpath/"vendor/llama.cpp").directory?
      libexec.install "vendor"
    end

    # `DLM_LLAMA_CPP_ROOT` tells `dlm.export.vendoring` where to find
    # the Python convert scripts; unset → module falls back to $PATH
    # for binaries and raises VendoringError with a clear pointer if
    # the scripts are missing.
    (bin/"dlm").write_env_script venv_root/"bin/dlm",
                                 DLM_LLAMA_CPP_ROOT: (libexec/"vendor/llama.cpp").to_s,
                                 PATH: "#{venv_root}/bin:$PATH"
  end

  def caveats
    <<~EOS
      🧠 DLM installed. To get the full export pipeline working:

      • Ollama (required for `dlm export` smoke runs):
          brew install ollama
          ollama serve    # or start it via the menu-bar app on macOS

      • CUDA / QLoRA 4-bit (NVIDIA only):
          "#{opt_libexec}/venv/bin/pip" install 'dlm[cuda]'

      First-run sanity check:
          dlm doctor
          dlm --help

      Docs: https://github.com/tenseleyFlow/DocumentLanguageModel/tree/v0.9.0/docs
    EOS
  end

  test do
    # `dlm --help` must render without the Python env complaining.
    assert_match "DocumentLanguageModel", shell_output("#{bin}/dlm --help")
    # `dlm doctor --json` must emit parseable JSON with at least the
    # `capabilities` block — a smoke test that the venv Python can import
    # all the core deps (torch, psutil, pydantic).
    output = shell_output("#{bin}/dlm doctor --json")
    assert_match(/"capabilities"/, output)
    # Parse to confirm it's valid JSON, not just a substring match.
    require "json"
    JSON.parse(output)
  end
end
