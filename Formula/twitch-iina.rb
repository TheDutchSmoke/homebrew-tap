class TwitchIina < Formula
  desc "Twitch in IINA via Streamlink Twitch GUI, with 2K (H.265) and back-to-live"
  homepage "https://github.com/TheDutchSmoke/twitch-iina"
  url "https://github.com/TheDutchSmoke/twitch-iina/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "6d523e18553af514cbd5508709d5164e5d6ea1848aa261175282c0e3239048c5"
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos
  depends_on "streamlink"

  def install
    bin.install "bin/iina-twitch", "bin/twitch-2k-login"
    pkgshare.install "share/twitch-iina/live.lua"
  end

  def caveats
    <<~EOS
      Needs IINA: brew install --cask iina
      Once per Mac, for 2K: twitch-2k-login
      Streamlink Twitch GUI → Settings → Streaming:
        Player preset: No preset
        Video player:  #{HOMEBREW_PREFIX}/bin/iina-twitch
        Parameters:    (empty)
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/iina-twitch --version")
    assert_match version.to_s, shell_output("#{bin}/twitch-2k-login --version")
    assert_path_exists pkgshare/"live.lua"
  end
end
