cask "nocturne" do
  version "1.3.0"
  sha256 "e1503466bac86066fde4002cbcd794d56c3cd21793799e2bc1ca017df45bb46b"

  url "https://github.com/dotcomjack/nocturne/releases/download/v#{version}/Nocturne-#{version}.dmg"
  name "Nocturne"
  desc "Puts the menu bar clock away when you go on Do Not Disturb"
  homepage "https://github.com/dotcomjack/nocturne"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Nocturne.app"

  # Quit through the app rather than letting Homebrew delete it out from
  # under a running copy. Nocturne restores the real clock on termination,
  # so removing the bundle first would uninstall it and leave the user with
  # a hidden clock and nothing left to put it back.
  uninstall quit: "com.dcj.nocturne"

  # Only Nocturne's own domain. The clock settings it edits live in Apple's
  # com.apple.menuextra.clock, which is the user's, not ours to trash.
  zap trash: "~/Library/Preferences/com.dcj.nocturne.plist"
end
