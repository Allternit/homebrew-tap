cask "allternit" do
  arch arm: "arm64", intel: "x64"

  version "1.1.10"
  sha256 arm:   "6100503c0cf0b5566694420cea874869cc23853dd6b8ed1176de9ea18ad9594d",
         intel: "9281f704953c678c423f1fdf2758861235254a3e25fc07082ee9ffab8a9ac3ad"

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
