cask "markview" do
  version "1.2.5"
  sha256 "fd9026799d4de710f00015b9385e62cf5f6b8d33dc16b931b57ccf5d7a67889f"

  url "https://github.com/paulhkang94/markview/releases/download/v#{version}/MarkView-#{version}.zip"
  name "MarkView"
  desc "Native macOS markdown previewer with live reload, GFM, and syntax highlighting"
  homepage "https://github.com/paulhkang94/markview"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "MarkView.app"

  zap trash: [
    "~/Library/Preferences/com.markview.app.plist",
    "~/Library/Caches/com.markview.app",
  ]
end
