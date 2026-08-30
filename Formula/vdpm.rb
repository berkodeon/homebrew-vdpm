class Vdpm < Formula
  desc "CLI for managing VisiData plugins"
  homepage "https://github.com/berkodeon/vdpm"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/berkodeon/vdpm/releases/download/v0.2.0/vdpm-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "8844e5f40bdf31910b93afda19842118c3b711189a835baeaf29d86406eddb97"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/berkodeon/vdpm/releases/download/v0.2.0/vdpm-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "35030b263edf7bcd20e351822dbfca95dd9c5ba7edcddbe7c70e411e7fc83072"
    end
  end

  def install
    bin.install "vdpm"
  end

  def caveats
    <<~EOS
      vdpm requires VisiData ("vd") on your PATH at runtime.
      Install it separately, e.g. `brew install saulpw/vd/visidata`
      or `pip install visidata`.
    EOS
  end

  test do
    (testpath/"bin/vd").write "#!/bin/sh\necho '3.1.1'\n"
    chmod 0755, testpath/"bin/vd"
    ENV.prepend_path "PATH", testpath/"bin"
    ENV["VDPM_HOME"] = testpath

    assert_match "name", shell_output("#{bin}/vdpm list")
  end
end
