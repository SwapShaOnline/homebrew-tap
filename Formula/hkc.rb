class Hkc < Formula
  desc "Command-line control for Hyundai/Kia connected cars in India"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-aarch64-apple-darwin.tar.xz"
      sha256 "ef0000b64dba3dd0113fd2441d625bf200097261193a713490cacbbed7f0c08f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-x86_64-apple-darwin.tar.xz"
      sha256 "eefa4f84de74a104ec112ad71327eb9bb1a3f3acce75171717c3425c27da4be1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff214ce97eaab60d24383be8e7fa600eae49fb60e7ece4c0cb1a42561f8c112f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0bcabae2d02df338b9a51ed0b0ca4b3f5de4ee5b9767c40a0c4004ac82ef1fca"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hkc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hkc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hkc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hkc"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
