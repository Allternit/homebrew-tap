class Fw < Formula
  include Language::Python::Virtualenv

  desc "Download, verify and search open AI model weights from Allternit Freeweights"
  homepage "https://freeweights.allternit.com"
  url "https://github.com/Allternit/freeweights/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "c7cae6c5d876bc7a4dbae721da92eaa4cda7dd4eee30e9e291b601bc9ebe1d05"
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
