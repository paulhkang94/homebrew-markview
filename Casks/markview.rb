cask "markview" do
  version "1.2.4"
  sha256 "41e4b95c259ee6b203e3878c38aecf8a743eb62f8754737bf0e05d8ccf38f634"

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
