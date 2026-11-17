## Maintainer

### Release

```bash
pnpm version minor            # or: patch; commits + tags
git push origin main v1.2.0   # CI: check, GitHub release, Marketplace publish
```

CI publishes the `.vsix` of the GitHub release to the VS Code Marketplace with [trusted publishing](https://github.com/microsoft/vscode-vsce#trusted-publishing) (`vsce publish --oidc`; no token stored). The trust policy is configured on the Marketplace side: publisher `carlwr`, repository `carlwr/vscode-better-makefile`, workflow `ci.yml`, environment `marketplace`.

To (re-)publish an existing release, e.g. after a failed publish job:
```bash
gh workflow run ci.yml -f tag=v1.2.0
```

Publishing to open-vsx.org is manual: `pnpm run ovsx:publish`.
