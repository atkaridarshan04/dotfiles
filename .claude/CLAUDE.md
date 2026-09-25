# Global instructions

Applies to every Claude Code session on this machine, in any directory.
A repo's own `CLAUDE.md` adds to this — it does not replace it.

## Working conventions

- **No manual hard-wrapping.** Write prose in files, docs, and commit messages (subject and body) as one continuous line per statement — don't break a sentence across multiple lines with a line break plus indentation. Let the reader's editor soft-wrap it for display.
- **Verify before asserting as fact.** When stating how a spec, tool, API, or library actually behaves, check a current source (docs, code, `--help`) rather than asserting from memory — flag it as unverified if you can't check.

## Git conventions

- **No Claude attribution.** Commit messages and PR descriptions carry no mention of Claude/Anthropic — no `Co-Authored-By` trailer, no signing as Claude. The user is the sole author of record.
- **Clean text.** Match the surrounding file's existing formatting exactly — no trailing whitespace, no stray blank lines, no unnecessary leading blank line before the content starts.
- **Confirm before `git push` or opening a PR.** Every time, even after a prior one was approved in the same session — approval doesn't carry forward.
- **Never merge a PR.** Merging is the user's action alone, with no exceptions.
- **Small, focused commits.** Split unrelated changes into separate commits rather than bundling them into one.
- **Conventional Commits format.** Subject line: `type(scope): description` (scope optional), lowercase, imperative mood, no trailing period. Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `perf`, `style`, `build`, `ci`. Mark breaking changes with `!` before the colon (e.g. `feat!:`) and explain in the body, or a `BREAKING CHANGE:` footer.
