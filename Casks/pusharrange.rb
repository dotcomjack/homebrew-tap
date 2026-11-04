cask "pusharrange" do
  version "1.2.3"
  sha256 "41054205c3aa3e1042b2b56013e31a4a4aac6d6485caed983de06b1c352fa225"

  url "https://dotcomjack.com/downloads/pusharrange/PushArrange-#{version}.dmg"
  name "PushArrange"
  desc "Push the pointer toward your monitor and the display arrangement follows"
  homepage "https://dotcomjack.com/pusharrange"

  # The app reads the same file to tell its users an update is out, so brew and
  # the app can never disagree about what the latest version is.
  livecheck do
    url "https://dotcomjack.com/downloads/pusharrange/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # Universal (arm64 and x86_64), built for macOS 14 or later.
  depends_on macos: :sonoma

  app "PushArrange.app"

  # It registers itself as a login item on first run; take that with it.
  uninstall quit:       "com.dcj.pusharrange",
            login_item: "PushArrange"

  zap trash: "~/Library/Preferences/com.dcj.pusharrange.plist"
end
