cask "grux" do
  version "1.2.1"
  sha256 "a711dfe417f1bac640eebf5f2032bcb456c47fd8bc9cce10601006eac8efc84c"

  url "https://github.com/dotcomjack/grux/releases/download/v#{version}/Grux-#{version}-macOS-arm64.zip"
  name "Grux"
  desc "Local-first Mac agent: terminals it can undo, agent swarms, mail, meetings"
  homepage "https://gruxai.com"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple silicon only, and this is a hard floor rather than a preference.
  # The release ships one arm64 slice, so an Intel Mac would download 23 MB
  # and then fail to launch with a message about the wrong architecture.
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Grux.app"

  # The command line is not a second download. It is a binary inside the app
  # bundle, which is deliberate: it speaks a versioned socket protocol to the
  # app, and two copies of that client is how you get a mismatch that reports
  # itself as a connection failure. Linking it here means `brew install` gives
  # you the whole product, app and CLI, in one step.
  binary "#{appdir}/Grux.app/Contents/MacOS/grux-cli", target: "grux"

  # Grux keeps no server-side anything, so uninstalling really is local. The
  # audit log lives under Application Support and is plain text, which is the
  # one thing worth knowing before it goes.
  zap trash: [
    "~/Library/Application Support/Grux",
    "~/Library/Caches/com.gruxai.grux",
    "~/Library/Preferences/com.gruxai.grux.plist",
    "~/Library/Saved Application State/com.gruxai.grux.savedState",
  ]

  # DELIBERATELY NOT ZAPPED: the Keychain items under the service
  # `com.gruxai.grux`. Those are the user's own provider API keys, put there by
  # the user, and usable by anything else they own. A cask that deletes a live
  # Anthropic key because somebody ran `brew uninstall --zap` has destroyed
  # something it did not create. `security delete-generic-password -s
  # com.gruxai.grux` removes them, when that is actually what you want.
end
