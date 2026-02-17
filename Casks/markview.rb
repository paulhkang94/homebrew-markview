cask "markview" do
  version "1.1.1"
  sha256 "6d3bf9a630f3c66837d68fb322f9e94059c70552edd37f8b3c7eabea5a5666e3"

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
