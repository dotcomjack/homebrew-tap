<!-- █ dcj · dotcomjack.com · MIT -->
# Security

This repository is a Homebrew tap. It ships no compiled code of its own. What
it ships is **instructions telling your machine what to download and run**,
which makes it the highest leverage thing in this account to get right. A
compromised tap is worse than a compromised app, because it can hand you a bad
binary for an app whose source is perfectly clean.

Treat that as the threat model below.

## Reporting a vulnerability

**Do not open a public issue for a security problem.** Two private channels:

1. [Open a private advisory](https://github.com/dotcomjack/homebrew-tap/security/advisories/new)
   on this repository. Preferred.
2. Email **jack@dotcomjack.com** with `homebrew-tap security` in the subject.

Report immediately, ahead of everything else, if you find any of these:

* A `url` in a cask or formula that does not point at a
  `github.com/dotcomjack/...` release asset.
* A `sha256` that does not match the artifact currently published at that URL.
* A cask or formula for a project that is not one of Jack's.
* Any `postflight`, `preflight`, `installer script`, or arbitrary shell in a
  cask. There is currently none, and there should not be.

**Response:** maintained by one person. Acknowledgement within 3 business days,
first assessment within 7. Anything in the list above gets same day treatment,
because the blast radius is every install.

## What is in this tap

| Kind | Name | Points at |
| --- | --- | --- |
| Cask | `nocturne` | [dotcomjack/nocturne](https://github.com/dotcomjack/nocturne) releases |
| Formula | `claude-session-tint` | [dotcomjack/claude-session-tint](https://github.com/dotcomjack/claude-session-tint) |

If `brew` offers you anything from this tap other than the rows above, stop and
report it.

## How installs are pinned

Every cask pins an exact version and an exact `sha256` of the artifact. Homebrew
verifies that hash after download and refuses to install on a mismatch. That is
the control that matters: even if someone replaced the file at the URL, the
install fails rather than proceeding.

You can check what you are about to run before running it:

```sh
# Print the actual cask definition Homebrew will execute
brew cat dotcomjack/tap/nocturne

# Confirm the pinned hash matches what is published right now
brew fetch --cask dotcomjack/tap/nocturne
```

For Nocturne specifically, the downloaded app is also signed with a Developer ID
certificate and notarized by Apple, so there is a second independent check. Its
verification commands are in
[nocturne/SECURITY.md](https://github.com/dotcomjack/nocturne/blob/main/SECURITY.md).

## In scope

* Any cask or formula in this repository.
* The pinning, hashes, and URLs above.
* Anything that causes `brew install` from this tap to fetch or execute
  something other than the named, hash pinned artifact.

## Out of scope

* Homebrew itself. Report those to
  [Homebrew/brew](https://github.com/Homebrew/brew/security).
* Vulnerabilities inside a tapped project. Report those on that project's own
  repository, which has its own security policy.
* The absence of a hash on `url :url` style formulae that build from a git ref.

## Supported versions

Only the current `main` of this tap is supported. Taps are not versioned. Run
`brew update` before reporting that a hash is stale.
