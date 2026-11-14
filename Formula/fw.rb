class Fw < Formula
  include Language::Python::Virtualenv

  desc "Download, verify and search open AI model weights from Allternit Freeweights"
  homepage "https://freeweights.allternit.com"
  url "https://github.com/Allternit/freeweights/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "6e9a53d59b71c86a0f609429ebc653ff07f79d7e59bc3acbc3c224de7494160d"
  license "Apache-2.0"

  depends_on "minisign"
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage: fw", shell_output("#{bin}/fw --help")
    assert_match "download and verify", shell_output("#{bin}/fw --help")
  end
end
