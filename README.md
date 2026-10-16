# Oubliette Homebrew Tap

Personal, unofficial Homebrew formulae. The Gentoo counterpart is
[oubliette-overlay](https://github.com/nabbi/oubliette-overlay).

## Install

```shell
brew tap nabbi/oubliette
brew install route-summarization spf-flatten
```

Or in one step: `brew install nabbi/oubliette/<formula>`.

## Formulae

| Formula | Description |
|---|---|
| [route-summarization](Formula/route-summarization.rb) | `aggregate-cidr`: aggregate IPv4/IPv6 CIDR prefixes into their minimal covering set ([source](https://github.com/nabbi/route-summarization-rs)) |
| [spf-flatten](Formula/spf-flatten.rb) | `spf-flatten`: flatten SPF records to stay within the RFC 7208 DNS lookup and size limits ([source](https://github.com/nabbi/spf-flatten)) |

## License

The formulae in this tap are [BSD-2-Clause](LICENSE). Each packaged project
keeps its own license, listed in its formula.
