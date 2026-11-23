class HkcMcp < Formula
  desc "MCP server that lets Claude read and control a Hyundai/Kia (India) connected car"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "0c6da6f87a35aaf98161956b75a15cda97cc5bbedbfe3d5aab24a35b87a2d632"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "b66d7bb6ee9a53516e32befa8a8a5d5a492ce51be30a8eab5ad67ca54b831735"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6fea86f86c559bc36b3cc48ec25d69f5c744bb9bb194ccf7e37ee8f526556ffa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.1/hkc-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "00a8d005da50634e99601beaa4e3e18d6f6069c015cb3d417ae0a0d33d6b0dd1"
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
