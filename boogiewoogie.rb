class Boogiewoogie < Formula
  desc "Git profile manager for switching between multiple Git identities"
  homepage "https://github.com/malhotra-rishabh/boogiewoogie"
  url "https://github.com/malhotra-rishabh/boogiewoogie/archive/refs/tags/v1.0.6.tar.gz" # always remember to change this while updating version
  sha256 "5b56c88f94c0ebf5704ae13ad8db4d86c674380a7335db525be01adb18df10dd"
  license "MIT"
  head "https://github.com/malhotra-rishabh/boogiewoogie.git", branch: "main"
  version "1.0.6"

  livecheck do
    url :stable
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
    system "#{bin}/boogiewoogie", "--version"
    
    # Test profile creation
    ENV["HOME"] = testpath
    system "#{bin}/boogiewoogie", "help"
    
    # Check if config directory is created
    assert_predicate testpath/".boogiewoogie", :exist?
  end
end 