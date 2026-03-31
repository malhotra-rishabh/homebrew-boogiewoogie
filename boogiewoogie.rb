class Boogiewoogie < Formula
  desc "Git profile manager for switching between multiple Git identities"
  homepage "https://github.com/malhotra-rishabh/boogiewoogie"
  url "https://github.com/malhotra-rishabh/homebrew-boogiewoogie/archive/refs/tags/v1.0.20.tar.gz"
  sha256 "f927cf450ab2eaa04b755569a2bf9c35175166298ebb5fec89742c05cae144a8"
  license "MIT"
  head "https://github.com/malhotra-rishabh/boogiewoogie.git", branch: "main"
  version "1.0.20"

  livecheck do
    url "https://github.com/malhotra-rishabh/homebrew-boogiewoogie/archive/refs/tags/v1.0.20.tar.gz"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "git"
  depends_on "openssh"
  depends_on "libunistring"
  depends_on "gettext"
  depends_on "pcre2"
  depends_on "ca-certificates"
  depends_on "openssl@3"
  depends_on "readline"
  depends_on "sqlite"
  depends_on "xz"
  depends_on "zstd"
  depends_on "python@3.14"
  depends_on "ldns"

  def install
    bin.install "boogiewoogie"
    
    # Install shell completions
    generate_completions_from_executable(bin/"boogiewoogie", "completion")
    
    # Install manual page
    man1.install "docs/boogiewoogie.1"
  end

  def post_install
    (var/"boogiewoogie").mkpath
  end

  test do
    system "#{bin}/boogiewoogie", "--version 1.0.20"
    
    # Test profile creation
    ENV["HOME"] = testpath
    system "#{bin}/boogiewoogie", "help"
    
    # Check if config directory is created
    assert_predicate testpath/".boogiewoogie", :exist?
  end
end 