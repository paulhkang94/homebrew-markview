class Markview < Formula
  desc "Native macOS markdown previewer with live reload, GFM, and syntax highlighting"
  homepage "https://paulkang.dev"
  url "https://github.com/paulhkang94/markview/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "401214f9baee8a407def78d55e8756617ebbe207c8d6d0ebf3a9f8b5f3f30361"
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
