class SpfFlatten < Formula
  desc "Flatten SPF records to stay within the RFC 7208 DNS lookup and size limits"
  homepage "https://github.com/nabbi/spf-flatten"
  url "https://github.com/nabbi/spf-flatten/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2c2a8d179c434d2677071ec8e50783f58816fe93f1bb071ef8eb80e36063b98c"
  license "GPL-3.0-or-later"
  head "https://github.com/nabbi/spf-flatten.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    doc.install "README.md", Dir["docs/*.md"]
    pkgshare.install "examples"
  end

  test do
    (testpath/"zone.txt").write <<~EOS
      example.com TXT "v=spf1 include:a.test include:b.test -all"
      a.test TXT "v=spf1 ip4:192.0.2.0/25 -all"
      b.test TXT "v=spf1 ip4:192.0.2.128/25 -all"
    EOS

    assert_match "lookups:      2 of 10", shell_output("#{bin}/spf-flatten check example.com --dns-file zone.txt")

    system bin/"spf-flatten", "import", "example.com", "--dns-file", "zone.txt", "-o", "spf.toml"
    assert_equal "example.com\tv=spf1 ip4:192.0.2.0/24 -all\n",
                 shell_output("#{bin}/spf-flatten flatten -i spf.toml --dns-file zone.txt -f plain 2>/dev/null")

    assert_match version.to_s, shell_output("#{bin}/spf-flatten --version")
  end
end
