# Global instructions

Applies to every Claude Code session on this machine, in any directory.
A repo's own `CLAUDE.md` adds to this — it does not replace it.

## Git conventions

- **No Claude attribution.** Commit messages and PR descriptions carry no
  mention of Claude/Anthropic — no `Co-Authored-By` trailer, no signing as
  Claude. The user is the sole author of record.
- **Clean text.** Match the surrounding file's existing formatting exactly —
  no trailing whitespace, no stray blank lines, no unnecessary leading
  blank line before the content starts.
- **Confirm before `git push` or opening a PR.** Every time, even after a
  prior one was approved in the same session — approval doesn't carry
  forward.
- **Never merge a PR.** Merging is the user's action alone, with no
  exceptions.
- **Small, focused commits.** Split unrelated changes into separate commits
  rather than bundling them into one.
