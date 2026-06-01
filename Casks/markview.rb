cask "markview" do
  version "1.5.0"
  sha256 "60af48d7f0b301ecbf0cda9546fcc7d216a7650019066009ca226457f1f71839"

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
