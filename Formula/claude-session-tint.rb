class ClaudeSessionTint < Formula
  desc "Know which parallel Claude Code session is waiting on you"
  homepage "https://github.com/dotcomjack/claude-session-tint"
  url "https://github.com/dotcomjack/claude-session-tint/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "1d18c9d8159498be8ac36323b9b0d1c0ebbb28f2cbf27db3c7b6f0108141be30"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    libexec.install "tabtint.sh", "prompt-hook.sh", "palette.conf", "commands", "hooks"

    # tabtint.sh resolves its palette and its sibling scripts relative to its
    # own directory, so both scripts have to stay together in libexec. The
    # shipped bin/tabtint resolves a Claude Code plugin cache instead, which a
    # Homebrew install does not have, so point straight at libexec here.
    (bin/"tabtint").write <<~SHELL
      #!/bin/bash
      exec "#{libexec}/tabtint.sh" tab "$@"
    SHELL
  end

  def caveats
    <<~EOS
      The tabtint command is ready to use:

        tabtint list          show the palette
        tabtint <project>     tag this window
        tabtint off           untag it

      To make windows light up on their own, register the hooks with Claude Code:

        claude plugin marketplace add dotcomjack/claude-session-tint
        claude plugin install claude-session-tint@dotcomjack

      Copy the starter palette to make it yours (it survives upgrades there):

        cp #{libexec}/palette.conf ~/.claude/tabtint-palette.conf

      Window colouring drives Terminal.app through AppleScript and no-ops in
      other terminals. The zero-turn ,project command works in any of them.
    EOS
  end

  test do
    # Exercises the palette reader, the hex parser and the formatter without
    # touching Terminal.app, which is not available in the sandbox.
    output = shell_output("#{bin}/tabtint list")
    assert_match "#A3D8E1", output
  end
end
