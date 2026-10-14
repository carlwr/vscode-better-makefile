_This file is `AGENTS.md`. `CLAUDE.md` is a symlink pointing to this file._


## README.md files

Any `README.md` files within the repo are the voice of the human maintainer.

Agents _may not_:
- edit the prose
- suggest changes to the prose
- suggest prose to put into such files
- inform about grammatic errors or non-idiomatic phrasing

Agents _may_:
- correct typos
- adjust markdown punctuation used for styling
- adjust html code, badges and links
- inform about missing information, things that might be unclear or wrong
- (essentially: anything except providing or suggesting changes to the language/phrasing)


## Style guide

- code must be concise
- avoid code comments
  - instead: refactor the code so the code itself reads better
- code comments, if used, must be maximally concise
- text added to .md files, if added at all, must be maximally concise
- IMPORTANT: add text to .md files ONLY when really warranted
  - what can be read from code/config files generally should not be re-stated as text (whether as code comments or text i .md files)
- make .md text and code comments as stale-proof as possible:
  - avoid referencing specific file names or identifier names
  - avoid claims about things in other files


## Commits

For commits by agents:
- no commit body - only a subject line
- subject line:
  - max. 55 chars, preferably a bit shorter
  - phrased in imperative
  - follow patterns used in the existing commit history


## Commit history re-writing

recipe:
- commit on top of branch tip so desired end state, or close to it, becomes the branch tip
- attach a backup tag to the (possibly new) branch tip
- re-write commit history
- compare new branch tip to the backup tag; assert byte-equality or inspect the diff is as expected
- consider
  - reading new intermediate commit diffs so they are as expected
  - running a suitable `rebase -x ..` command to verify source<->generated align + all tests pass
- verify not compromised, unless necessary:
  - previous pure file moves (similarity=100%, or high)
  - previous intact move of line chunks
- remove the backup tag

Never re-write pushed commits unless the user explicitly asks for that.

## Other rules

Agents and subagents are not allowed to list files, read files or write to anything under `.non-vcs/`, unless explicitly asked to by the user; e.g. by the user mentioning that dir or files in it.
