class Hkc < Formula
  desc "Command-line control for Hyundai/Kia connected cars in India"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-aarch64-apple-darwin.tar.xz"
      sha256 "9d2cd977a06bb5a71a2be67b3e3c70011ff98629ab96ea0a337dfde185e293ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-x86_64-apple-darwin.tar.xz"
      sha256 "23c24d2582d4cdafd17398ef360a4330a00b582fb440f4c5d32d077987fa9587"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a749b3098fd36bcbf97a80b4de1ef8c5877508b2fd83d86531d5c8e4a68c2da7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.2/hkc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6f6c925b2fff7931a5103e4532d21ea80f294f87261c0850cd59e811a64d140"
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
