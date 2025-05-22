class Boogiewoogie < Formula
  desc "Git profile manager for switching between multiple Git identities"
  homepage "https://github.com/YOUR_USERNAME/boogiewoogie"
  url "https://github.com/YOUR_USERNAME/boogiewoogie/archive/v1.0.0.tar.gz"
  sha256 "REPLACE_WITH_ACTUAL_SHA256" # You'll need to replace this with the actual SHA256 of your release
  license "MIT"

  def install
    bin.install "boogiewoogie"
  end

  test do
    system "#{bin}/boogiewoogie", "--version"
  end
end 