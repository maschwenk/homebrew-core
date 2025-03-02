class FernApi < Formula
  desc "Stripe-level SDKs and Docs for your API"
  homepage "https://buildwithfern.com/"
  url "https://registry.npmjs.org/fern-api/-/fern-api-0.46.14.tgz"
  sha256 "492ae032a5266174602f89fe50bcb81e25eee291392f81685ac44320bc35121d"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "110300a9b001c499f00d5254fcb90d2b0dfb01276ee6e474d329e0bc36b4a41e"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/fern init 2>&1", 1)
    assert_match "Login required", output

    system bin/"fern", "--version"
  end
end
