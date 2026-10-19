cask "allternit" do
  arch arm: "arm64", intel: "x64"

  version "1.1.7"
  sha256 arm:   "642676521376da925205f84357b30d3ca301869b2720d6a86af0ae07751990c2",
         intel: "48c2d118146e5c6618c28efdc567207be11a7b7ebbca15edd41a5a271d582447"

  url "https://github.com/Allternit/desktop/releases/download/v#{version}/Allternit-Desktop-#{version}-#{arch}.dmg"
  name "Allternit Desktop"
  desc "AI-powered autonomous coding platform with local execution"
  homepage "https://allternit.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "Allternit Desktop.app"

  zap trash: [
    "~/Library/Application Support/@allternit/desktop",
    "~/Library/Caches/com.allternit.desktop",
    "~/Library/Caches/com.allternit.desktop.ShipIt",
    "~/Library/Preferences/com.allternit.desktop.plist",
    "~/Library/Saved Application State/com.allternit.desktop.savedState",
  ]

  caveats <<~EOS
    Allternit Desktop is not signed with an Apple Developer ID yet. On first
    launch, if Gatekeeper blocks the app, right-click Allternit Desktop in
    Applications and select "Open".

    The app updates itself after installation.
  EOS
end
