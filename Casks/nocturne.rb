cask "nocturne" do
  version "1.2.0"
  sha256 "3700bd9e3934b63ec2cee51b7b5726ec2a6bfeff9ecaa896a8c285967350b4f4"

  url "https://github.com/dotcomjack/nocturne/releases/download/v#{version}/Nocturne-#{version}.dmg"
  name "Nocturne"
  desc "Hides the menu bar clock, and gives it back in one click"
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
