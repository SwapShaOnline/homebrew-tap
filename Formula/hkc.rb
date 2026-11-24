class Hkc < Formula
  desc "Command-line control for Hyundai/Kia connected cars in India"
  homepage "https://github.com/SwapShaOnline/hkconnect"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.5/hkc-aarch64-apple-darwin.tar.xz"
      sha256 "bfd5f8b870da02d453b0fa8f34cebd8bfcba8942077697e117501f2ff46a1119"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.5/hkc-x86_64-apple-darwin.tar.xz"
      sha256 "8ab2225d23471553f879a1384aa7f1924d4552406668c06ed0390b7fa9d89d23"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.5/hkc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eddc5912420e58282dea4574f91e285b94276585fdb3bdba4bcbe62afabec0b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SwapShaOnline/hkconnect/releases/download/v0.1.5/hkc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4ebb0193cf81ada7453bf55787ee04d648734c8bd6c16ee5e60ff6857d28e191"
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
