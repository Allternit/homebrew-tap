class GizziCode < Formula
  desc "AI-powered terminal interface for the Allternit ecosystem"
  homepage "https://docs.gizziio.com"
  version "2.2.14"
  license "Apache-2.0"

  # gizzi-code doesn't statically link ripgrep; Glob/Grep use `rg` on PATH.
  depends_on "ripgrep"

  # Release tags look like "gizzi-code/v2.0.5"; assets are version-named:
  # gizzi-code-v2.0.5-<target>.tar.gz
  base_url = "https://github.com/Allternit/allternit-platform/releases/download/gizzi-code/v#{version}"

  # macOS ARM64 (Apple Silicon)
  if OS.mac? && Hardware::CPU.arm?
    url "#{base_url}/gizzi-code-v#{version}-darwin-arm64.tar.gz"
    sha256 "f8baf72f1a348eec1b8a01357be07bd10c2f9a7e8c3904c5ce4af64a60961296"
  end

  # macOS Intel
  if OS.mac? && Hardware::CPU.intel?
    url "#{base_url}/gizzi-code-v#{version}-darwin-x64.tar.gz"
    sha256 "a8fa3db001a143ef1ba423ce04441f76c9ddda6cedf1577807dd953923b9b654"
  end

  # Linux ARM64
  if OS.linux? && Hardware::CPU.arm?
    url "#{base_url}/gizzi-code-v#{version}-linux-arm64.tar.gz"
    sha256 "185698a7af6d3f0862c4150258d67fa8abfb3936f5b2ac10f8969418db8bb094"
  end

  # Linux x64
  if OS.linux? && Hardware::CPU.intel?
    url "#{base_url}/gizzi-code-v#{version}-linux-x64.tar.gz"
    sha256 "9191af9cfccd8213d5c650dd0ae0c191575a2382af89144ac18dc153639300e2"
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
