class Xfig < Formula
  desc "Facility for interactive generation of figures"
  homepage "https://mcj.sourceforge.net/"
  url "https://downloads.sourceforge.net/mcj/xfig-3.2.9.tar.xz"
  sha256 "13ed9d04d1bbc2dec09da7ef49ceec278382d290f6cd926474c2f2d016fec2f7"
  license "MIT"

  livecheck do
    url :stable
    regex(%r{url=.*?/xfig[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end

  bottle do
    sha256 arm64_ventura:  "941c7128195ecda9f0a5bb082a2c97e68d5fedf24bc12dfb026a576e3d081475"
    sha256 arm64_monterey: "4b0a5046a49eb1a199b0e510026b3fe7535595b689c9ab6b55b5d745e835f064"
    sha256 arm64_big_sur:  "27a8617539bd153050335ea7ccdff58f017a3530b7df277dcb135d708c0d95e7"
    sha256 ventura:        "ba40317eabb65806ee84ce46b434b64d240b578efd2a479ffbee6b48905b1b99"
    sha256 monterey:       "884daf8e46154273f9ae6c2cb8f9d0a6d0ecf96f31f9b8690efa571fb52f2e53"
    sha256 big_sur:        "7173fb6938b4050bc4abbdccb644baeed38b88e3cceaba3e90c3867e415ba1c5"
    sha256 x86_64_linux:   "eb8139430792390d9fb6e0657d3a45081fe11f1aa74092a431fef71f614daf1b"
  end

  depends_on "fig2dev"
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libx11"
  depends_on "libxaw3d"
  depends_on "libxft"
  depends_on "libxi"
  depends_on "libxpm"
  depends_on "libxt"

  on_macos do
    depends_on "gnu-sed" => :build
  end

  def install
    # Use GNU sed on macOS to avoid this build failure:
    # `sed: 1: " /^[ \t]*\(!\|$\)/ d; s ...": bad flag in substitute command: '}'`
    ENV.prepend_path "PATH", Formula["gnu-sed"].libexec/"gnubin" if OS.mac?

    # Xft #includes <ft2build.h>, not <freetype2/ft2build.h>, hence freetype2
    # must be put into the search path.
    ENV.append "CFLAGS", "-I#{Formula["freetype"].opt_include}/freetype2"

    system "./configure", "--with-appdefaultdir=#{etc}/X11/app-defaults",
                          "--disable-silent-rules",
                          *std_configure_args
    system "make", "install-strip"
  end

  test do
    assert_equal "Xfig #{version}", shell_output("#{bin}/xfig -V 2>&1").strip
  end
end
