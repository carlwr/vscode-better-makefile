import * as readPkg from 'read-pkg';
import { z } from 'zod';

const schema = z.object({
  name: z.string(),
  contributes: z.object({
    grammars: z.array(z.object({
      path: z.string(),
      scopeName: z.string(),
    })),
  }),
  devDependencies: z.object({
    'vscode-oniguruma': z.string(),
  }),
});

function parse(): PackageJson {
  try {
    const pkg = readPkg.readPackageSync();
    return schema.parse(pkg);
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
}

export type PackageJson = z.infer<typeof schema>;

export const pkgJson = parse();
