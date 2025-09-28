class Boogiewoogie < Formula
  desc "Git profile manager for switching between multiple Git identities"
  homepage "https://github.com/malhotra-rishabh/boogiewoogie"
  url "https://github.com/malhotra-rishabh/homebrew-boogiewoogie/archive/refs/tags/v1.0.17.tar.gz"
  sha256 "9aae95f8287a5e24a53ec91dbd75d0293e1f3b58742383b5f9e636a25f2730a1"
  license "MIT"
  head "https://github.com/malhotra-rishabh/boogiewoogie.git", branch: "main"
  version "1.0.17"

  livecheck do
    url "https://github.com/malhotra-rishabh/homebrew-boogiewoogie/archive/refs/tags/v1.0.17.tar.gz"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "git"
  depends_on "openssh"

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
    system "#{bin}/boogiewoogie", "--version "1.0.17"
    
    # Test profile creation
    ENV["HOME"] = testpath
    system "#{bin}/boogiewoogie", "help"
    
    # Check if config directory is created
    assert_predicate testpath/".boogiewoogie", :exist?
  end
end 