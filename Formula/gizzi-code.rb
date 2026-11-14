class GizziCode < Formula
  desc "AI-powered terminal interface for the Allternit ecosystem"
  homepage "https://docs.gizziio.com"
  version "2.11.0"
  license "Apache-2.0"

  # gizzi-code doesn't statically link ripgrep; Glob/Grep use `rg` on PATH.
  depends_on "ripgrep"

  # Release tags look like "gizzi-code/v2.0.5"; assets are version-named:
  # gizzi-code-v2.0.5-<target>.tar.gz
  base_url = "https://github.com/Allternit/allternit-platform/releases/download/gizzi-code/v#{version}"

  # macOS ARM64 (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "#{base_url}/gizzi-code-v#{version}-darwin-arm64.tar.gz"
    sha256 "58e2a6efa0d56ed0f2bc492af621ed706ca9399d576138488374bf19a5c2d9fe"
  end

  # macOS Intel
  if OS.mac? && Hardware::CPU.intel?
    url "#{base_url}/gizzi-code-v#{version}-darwin-x64.tar.gz"
    sha256 "2b5fb5c781f6013367d1d7564808aa1c33505189943d6b64145744f13c7dc34d"
  end

  # Linux ARM64
  if OS.linux? && Hardware::CPU.arm?
    url "#{base_url}/gizzi-code-v#{version}-linux-arm64.tar.gz"
    sha256 "aead8fc4f1a00cd948a1d352b51408d35f380e240355c6f33dac3a7dc45dd51d"
  end

  # Linux x64
  if OS.linux? && Hardware::CPU.intel?
    url "#{base_url}/gizzi-code-v#{version}-linux-x64.tar.gz"
    sha256 "f96e20d3c9ecc0d7c6e74a64733c79659c845a00bb38a4706145df0c43f6eca0"
  end

  def install
    # gizzi-code and the Allternit Factory engine live side by side in
    # libexec: gizzi finds allternit-factory next to its own (resolved)
    # binary, and only `gizzi` / `gizzi-code` go on PATH.
    libexec.install "gizzi-code"
    libexec.install "allternit-factory" if File.exist?("allternit-factory")
    bin.install_symlink libexec/"gizzi-code"
    bin.install_symlink libexec/"gizzi-code" => "gizzi"

    # Install shell completions
    bash_completion.install "completions/gizzi-code.bash" if File.exist?("completions/gizzi-code.bash")
    zsh_completion.install "completions/_gizzi-code" if File.exist?("completions/_gizzi-code")
    fish_completion.install "completions/gizzi-code.fish" if File.exist?("completions/gizzi-code.fish")
  end

  test do
    system "#{bin}/gizzi-code", "--version"
  end
end
