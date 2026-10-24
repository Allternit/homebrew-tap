cask "allternit" do
  arch arm: "arm64", intel: "x64"

  version "1.1.12"
  sha256 arm:   "0565008cd341cee0441603b22bf314691d40108eadcf668003aba65f1c1e045f",
         intel: "bca1692c5b8ac10c606a8857916397f1d6970b264597eaea0cc5d3149d0653cd"

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
