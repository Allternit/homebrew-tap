cask "allternit" do
  arch arm: "arm64", intel: "x64"

  version "1.1.15"
  sha256 arm:   "7c82d91f642aaca5ce89b066a8eef79ac582683704d3656d6cebcb9659985e1b",
         intel: "727fb3cb6892595c6c62bc92ed3e919fa6a67497b56b615ff6a77e67d491e69d"

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
    Allternit Desktop is not notarized by Apple yet. The first time you open
    it, macOS says it could not verify the app: press Done, then open
    System Settings > Privacy & Security and press Open Anyway.

    To update, run: brew upgrade --cask allternit
  EOS
end
