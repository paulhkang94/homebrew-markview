cask "markview" do
  version "1.2.3"
  sha256 "ee094b5dee2aea7697141a8a75ed2b7d97d59208bc9bef6b0658befad54146b1"

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
