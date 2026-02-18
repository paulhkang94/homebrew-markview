cask "markview" do
  version "1.1.3"
  sha256 "fe746f76ab06ad3deff2add1c03e7b2eba478e26f64d6aa94733e579789bea8a"

  url "https://github.com/paulhkang94/markview/releases/download/v#{version}/MarkView-#{version}.tar.gz"
  name "MarkView"
  desc "Native macOS markdown previewer with live reload, GFM, and syntax highlighting"
  homepage "https://github.com/paulhkang94/markview"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "MarkView.app"

  postflight do
    # Strip quarantine until app is notarized with Apple
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MarkView.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.markview.app.plist",
    "~/Library/Caches/com.markview.app",
  ]
end
