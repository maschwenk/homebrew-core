class ApacheOpennlp < Formula
  desc "Machine learning toolkit for processing natural language text"
  homepage "https://opennlp.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=opennlp/opennlp-2.5.2/apache-opennlp-2.5.2-bin.tar.gz"
  mirror "https://archive.apache.org/dist/opennlp/opennlp-2.5.2/apache-opennlp-2.5.2-bin.tar.gz"
  sha256 "d515781b1444038dad6433ee8414f535bac3b244f126b3b5479a5b021bf22246"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "0b2ff41d83c0c8195c3dd5fb365911a94b0ae5f8333f541502cff01a857202b2"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    (bin/"opennlp").write_env_script libexec/"bin/opennlp", JAVA_HOME:    Formula["openjdk"].opt_prefix,
                                                            OPENNLP_HOME: libexec
  end

  test do
    assert_equal "Hello , friends", pipe_output("#{bin}/opennlp SimpleTokenizer", "Hello, friends").lines.first.chomp
  end
end
