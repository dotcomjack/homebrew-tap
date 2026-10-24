cask "pusharrange" do
  version "1.0.0"
  sha256 "7623f5850f571fe70170d89fc389f0e849feb17d6434bacc233cbcb68ad28075"

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

  # One arm64 slice, built for macOS 14 or later.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PushArrange.app"

  # It registers itself as a login item on first run; take that with it.
  uninstall quit:       "com.dcj.pusharrange",
            login_item: "PushArrange"

  zap trash: "~/Library/Preferences/com.dcj.pusharrange.plist"
end
