# Maintainer

## Release

```bash
pnpm version minor            # or: patch; commits + tags
git push origin main v1.2.0   # CI: check, GitHub release, Marketplace publish
```

CI publishes the `.vsix` of the GitHub release to the VS Code Marketplace with [trusted publishing](https://github.com/microsoft/vscode-vsce#trusted-publishing).

To (re-)publish an existing release, e.g. after a failed publish job:
```bash
gh workflow run ci.yml -f tag=v1.2.0
```

Publishing to open-vsx.org is manual: `pnpm run ovsx:publish`.

## Version override for `vscode-textmate`

The grammar tests' `vscode-textmate` version is set with a pnpm override; otherwise, `vscode-tmgrammar-test` may resolve one far older than any editor ships.

Keep the override at a version that:
- VS Code/Cursor users plausibly run
- `vscode-tmgrammar-test` works with
