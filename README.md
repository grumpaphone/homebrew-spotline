# Spotline — Homebrew tap

Audio library, local transcription, and Pro Tools spotting for audio post.

## Install

```sh
brew install --cask --no-quarantine grumpaphone/spotline/spotline
```

Homebrew will warn you that `--no-quarantine` bypasses Gatekeeper. That is
expected, and the reason is below — it is also why this tap exists rather than
just a download link.

## Why `--no-quarantine`

Spotline is **code signed but not notarized by Apple**. Notarization requires a
paid Apple Developer Program membership; not having it means Apple has not
scanned the app. It does **not** mean the app is unsigned or has been modified
in transit.

Without the flag, macOS quarantines the download and blocks the first launch,
and since macOS 15 the old Control-click → Open shortcut no longer works — you
would have to go to System Settings › Privacy & Security › Open Anyway and
enter an admin password. Passing `--no-quarantine` skips that, because Homebrew
never applies the attribute in the first place.

Homebrew has no way for a cask to make that choice on your behalf, by design.
It is yours to make.

## Updates

Spotline updates itself using [Sparkle](https://sparkle-project.org), verifying
an EdDSA signature on every update before installing it. That check does not
depend on Apple notarization, and updates Spotline installs are not
quarantined — so the first-launch step above is needed once, not per update.

The cask is marked `auto_updates true`, so `brew upgrade` leaves Spotline alone
and lets the app manage its own versions.

## Uninstall

```sh
brew uninstall --zap --cask spotline
```

`--zap` also removes the library database, caches, WhisperKit models, Pro Tools
proxies, preferences, and saved window state.

**It does not remove your API keys.** Those live in your login Keychain under
`com.spotline.apikeys` — delete them in Keychain Access if you want them gone.

Uninstalling never touches your audio files. Spotline indexes folders in place
and only ever writes inside its own Application Support directory.

## Requirements

macOS 15 (Sequoia) or later. Apple's on-device transcription needs macOS 26+;
WhisperKit works on 15+.
