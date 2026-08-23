cask "markview" do
  version "1.7.2"
  sha256 "0050f4416c190bf4d8773a2202ad905ae72ac7ad9ced397c08e6a507bc637706"

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
