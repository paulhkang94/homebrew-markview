cask "markview" do
  version "1.0.0"
  sha256 "35f3843bfb6a28ac9411d017833775ef22b50af1bb7dea7d63439a28d1f12f57"

  url "https://github.com/paulhkang94/markview/releases/download/v#{version}/MarkView-#{version}.tar.gz"
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
