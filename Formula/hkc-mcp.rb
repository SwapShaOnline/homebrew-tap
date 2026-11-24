class HkcMcp < Formula
  desc "MCP server that lets Claude read and control a Hyundai/Kia (India) connected car"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "e0b69874cf0c531d2a260ce5fe860e42f7f46ee48efd106498de92b810cf6449"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "96cfd5ae536ae524eb2915472d3d6e7940ae4faa6c7e8a84f2d3f1ec97f09796"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "850d29e7970dea7384d2aa61e6c7adad17a7e81e545ffa46a70c4378371bb75d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e7bc581e9e71b421d45f2a4c8f539936df1a281f5c303953f860f218450f786e"
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
