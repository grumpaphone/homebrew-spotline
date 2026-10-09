cask "spotline" do
  version "0.3.2"
  sha256 "83b7bc94f6d179f83a3775642933eda91cf2a85a5ce7b7f00b368edbc3ccfe22"

  url "https://pub-b6b0f0b9be184a8ba1bd3ee72524b767.r2.dev/Spotline-#{version}.dmg"
  name "Spotline"
  desc "Audio library, local transcription, and Pro Tools spotting for audio post"

  livecheck do
    url "https://pub-b6b0f0b9be184a8ba1bd3ee72524b767.r2.dev/appcast.xml"
    # Bare `strategy :sparkle` yields "shortVersion,buildVersion" (e.g.
    # "0.1.0,1"), which never equals this cask's "0.1.0" — so `brew livecheck`
    # reports an update on every run, forever. Take the short version alone;
    # the release pipeline requires CURRENT_PROJECT_VERSION to increase
    # whenever MARKETING_VERSION does, so the short version is sufficient to
    # detect a genuinely new release.
    strategy :sparkle, &:short_version
  end

  # Spotline updates itself through Sparkle. Without this, `brew upgrade`
  # would reinstall over an app that had already updated in place.
  auto_updates true
  # Bare `macos:` is Homebrew's spelling for a MINIMUM version (its own
  # OSDependsOn cop rewrites ">= :sequoia" to this); `maximum_macos:` is the
  # separate stanza for an upper bound. Sequoia is macOS 15, matching the
  # app's LSMinimumSystemVersion.
  depends_on macos: :sequoia

  app "Spotline.app"

  zap trash: [
    "~/Library/Application Support/Spotline",
    "~/Library/Caches/com.spotline.Spotline",
    "~/Library/HTTPStorages/com.spotline.Spotline",
    "~/Library/Preferences/com.spotline.Spotline.plist",
    "~/Library/Saved Application State/com.spotline.Spotline.savedState",
  ]

  caveats <<~EOS
    API keys are stored in your login Keychain under "com.spotline.apikeys"
    and are NOT removed by `brew uninstall --zap`. Remove them in Keychain
    Access if you want them gone.
  EOS
end
