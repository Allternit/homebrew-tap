class GizziCode < Formula
  desc "AI-powered terminal interface for the Allternit ecosystem"
  homepage "https://docs.gizziio.com"
  version "2.20.0"
  license "Apache-2.0"

  # gizzi-code doesn't statically link ripgrep; Glob/Grep use `rg` on PATH.
  depends_on "ripgrep"

  # Release tags look like "gizzi-code/v2.0.5"; assets are version-named:
  # gizzi-code-v2.0.5-<target>.tar.gz
  base_url = "https://github.com/Allternit/allternit-platform/releases/download/gizzi-code/v#{version}"

  # macOS ARM64 (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "#{base_url}/gizzi-code-v#{version}-darwin-arm64.tar.gz"
    sha256 "92d74a66434c6bd34731dddc716f7c1658c5022642f431bd1743fbf8e877c3cb"
  end

  # macOS Intel
  if OS.mac? && Hardware::CPU.intel?
    url "#{base_url}/gizzi-code-v#{version}-darwin-x64.tar.gz"
    sha256 "5c4bb386ae8c1d8ebfbf97bbcb998d21c2abe805e45b4da1026a3b028e56328a"
  end

  # Linux ARM64
  if OS.linux? && Hardware::CPU.arm?
    url "#{base_url}/gizzi-code-v#{version}-linux-arm64.tar.gz"
    sha256 "1a4aeb9e0de79621590e66509fbf8b45e33e63bef1da2c5fc23750daa974de7b"
  end

  # Linux x64
  if OS.linux? && Hardware::CPU.intel?
    url "#{base_url}/gizzi-code-v#{version}-linux-x64.tar.gz"
    sha256 "5d438abfd434198a5e30ad863b5df44853bacf65d1a05c66b35e74d2037e50e9"
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
