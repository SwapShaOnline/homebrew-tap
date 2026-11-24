class Hkc < Formula
  desc "Command-line control for Hyundai/Kia connected cars in India"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-aarch64-apple-darwin.tar.xz"
      sha256 "da5b1d197faed0a982a13c95b1daa408a92479d834a99fd462e09a2a231dcc61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-x86_64-apple-darwin.tar.xz"
      sha256 "8fe2f9ddde99e5ad71c7d8f87209abdd4d7c7e6fd2e6dc0375b27ed7f6edc0cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1df2e1a720c0f3e39918cca1fe3ced0bc429f861971aad8bd701b6f6d185d183"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.4/hkc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8229dbeacdc39df6d9e40aa1bd46b676a119bfbb85505759d7e7ced0b9346f80"
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
