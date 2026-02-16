# homebrew-markview

Homebrew tap for [MarkView](https://github.com/paulhkang94/markview) — a native macOS markdown previewer.

## Install

```bash
brew tap paulhkang94/markview
brew install markview
```

## Usage

```bash
markview                    # Launch MarkView
markview /path/to/file.md   # Open a specific file
```

## Full .app bundle

The Homebrew formula installs the CLI binary. For the full .app bundle with Quick Look support:

```bash
git clone https://github.com/paulhkang94/markview.git
cd markview
bash scripts/bundle.sh --install
```
