# homebrew-markview

Homebrew tap for [MarkView](https://github.com/paulhkang94/markview) — a native macOS markdown previewer.

## Install

### Option A: Cask (recommended — full .app with Quick Look)

```bash
brew install --cask paulhkang94/markview/markview
```

Installs `MarkView.app` to `/Applications` with Quick Look extension for `.md` files.

### Option B: Formula (CLI binary, builds from source)

```bash
brew tap paulhkang94/markview
brew install markview
```

Installs `markview` CLI to your PATH.

## Usage

```bash
markview                    # Launch MarkView
markview /path/to/file.md   # Open a specific file
```
