# Spotline — Homebrew tap

Audio library, local transcription, and Pro Tools spotting for audio post.

## Install

```sh
brew install --cask grumpaphone/spotline/spotline
```

Then clear the first-launch block once (see below).

## The first launch

Spotline is **code signed but not notarized by Apple**. Notarization requires a
paid Apple Developer Program membership; not having it means Apple has not
scanned the app. It does **not** mean the app is unsigned or was modified in
transit — every release is cryptographically signed.

macOS quarantines the download and blocks the first launch. Clear it once,
whichever you prefer:

```sh
xattr -dr com.apple.quarantine /Applications/Spotline.app
```

or launch Spotline, let macOS refuse, then open **System Settings › Privacy &
Security** and click **Open Anyway**. On macOS 15+ the old Control-click → Open
shortcut no longer works.

Installing via Homebrew does *not* skip this. Homebrew removed its
`--no-quarantine` flag, and a cask cannot waive quarantine on your behalf —
that is deliberate on Homebrew's part, and this tap does not work around it.

You only do this once. Updates that Spotline installs for itself are not
quarantined, so they do not repeat it.

## Updates

Spotline updates itself using [Sparkle](https://sparkle-project.org), verifying
an EdDSA signature on every update before installing it. That check does not
depend on Apple notarization.

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
