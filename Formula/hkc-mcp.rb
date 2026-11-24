class HkcMcp < Formula
  desc "MCP server that lets Claude read and control a Hyundai/Kia (India) connected car"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "d8b49294b5540508fdab8b7cbb6268a48a16c78fcf03c40405865722bdcda9e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "94e4312d8d1081ee01cebdad977ae2663c650fbcbb392cc8b7cdb58e39d17717"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91ee2999b6fce538bddc4c2bbdf59458b5a128f466b50956017b58b5dc2cdbfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2da5a6c63693ec08750a0b80deb8e539fd75d788edd380d5bc9563ef7869bcb"
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
      bin.install "hkc-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hkc-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hkc-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hkc-mcp"
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
