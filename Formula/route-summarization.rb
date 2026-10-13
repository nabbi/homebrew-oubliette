class RouteSummarization < Formula
  desc "Aggregate IPv4/IPv6 CIDR prefixes into their minimal covering set"
  homepage "https://github.com/nabbi/route-summarization-rs"
  url "https://github.com/nabbi/route-summarization-rs/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3c3d07e21af1dac28ef2c04b8ae92c9eb70761ab5bf3ae1f94509cf71a197b88"
  license "GPL-3.0-or-later"
  head "https://github.com/nabbi/route-summarization-rs.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    doc.install "CHANGELOG.md", "NOTICE", "README.md", Dir["docs/*.md"]
  end

  test do
    input = "10.0.0.0/25\n10.0.0.128/25\n2001:db8::/33\n2001:db8:8000::/33\n"
    assert_equal "10.0.0.0/24\n2001:db8::/32\n", pipe_output(bin/"aggregate-cidr", input, 0)

    spf = "ip4:10.0.0.0/25\nip4:10.0.0.128/25\n"
    assert_equal "ip4:10.0.0.0/24\n", pipe_output("#{bin}/aggregate-cidr --quiet --spf", spf, 0)

    assert_match version.to_s, shell_output("#{bin}/aggregate-cidr --version")
  end
end
