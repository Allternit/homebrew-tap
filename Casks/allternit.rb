cask "allternit" do
  arch arm: "arm64", intel: "x64"

  version "1.1.9"
  sha256 arm:   "0043f71d82e59b1af1bf413f405ffc2185802c186f76b7854ddc41c87c0e0010",
         intel: "85b081aed3dacf7d5cd62fa90a9f841f67a523fa34899ee6c3d8a8cb4a7c8ec2"

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
