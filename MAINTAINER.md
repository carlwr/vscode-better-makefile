# Maintainer

## Release

```bash
pnpm version minor            # or: patch; commits + tags
git push origin main v1.2.0   # CI: check, GitHub release, publish
```

CI publishes the `.vsix` of the GitHub release to the VS Code Marketplace and open-vsx.org with trusted publishing.

To (re-)publish an existing release, e.g. after a failed publish job:
```bash
gh workflow run ci.yml -f tag=v1.2.0
```

## Version override for `vscode-textmate`

The grammar tests' `vscode-textmate` version is set with a pnpm override; otherwise, `vscode-tmgrammar-test` may resolve one far older than any editor ships.

Keep the override at a version that:
- VS Code/Cursor users plausibly run
- `vscode-tmgrammar-test` works with

## Screenshots

`arthurlobo.easy-codesnap`:

```jsonc
{
  "easy-codesnap.showLineNumbers": false,
  "easy-codesnap.roundingLevel": 3,
  "easy-codesnap.containerPadding": "0",
  "easy-codesnap.saveScale": 2,
  "easy-codesnap.transparentBackground": true,
}
```
