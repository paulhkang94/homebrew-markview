class Markview < Formula
  desc "Native macOS markdown previewer with live reload, GFM, and syntax highlighting"
  homepage "https://paulkang.dev"
  url "https://github.com/paulhkang94/markview/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "509a6755e2833c5a0ab5036d21f0842f66c290a36d305081238b791cbfdecde4"
  license "MIT"

  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/MarkView" => "markview"
  end

  def caveats
    <<~EOS
      To run MarkView as a GUI app:
        markview

      To preview a specific file:
        markview /path/to/file.md

      For the full .app bundle with Quick Look support, build from source:
        git clone https://github.com/paulhkang94/markview.git
        cd markview
        bash scripts/bundle.sh --install
    EOS
  end

  test do
    assert_path_exists bin/"markview"
    assert_predicate bin/"markview", :executable?
  end
end
