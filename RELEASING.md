# How to Release a New Version of BoogieWoogie

Follow these steps to update the Homebrew formula and publish a new release:

## 1. Update the Formula

Edit `boogiewoogie.rb`:
- Change the `version` field to the new version (e.g., `1.0.11`).
- Update the `url` field to:
  ```ruby
  url "https://github.com/malhotra-rishabh/boogiewoogie/archive/refs/tags/v1.0.11.tar.gz"
  ```
- Download the new tarball:
  ```sh
  curl -L -o boogiewoogie-v1.0.11.tar.gz https://github.com/malhotra-rishabh/boogiewoogie/archive/refs/tags/v1.0.11.tar.gz
  ```
- Calculate the sha256:
  ```sh
  shasum -a 256 boogiewoogie-v1.0.11.tar.gz
  ```
- Copy the resulting hash and update the `sha256` field in the formula.

## 2. Commit the Changes

```sh
git add boogiewoogie.rb
git commit -m "Update formula for v1.0.11"
git push origin main
```

## 3. Tag and Push

If you haven't already, create and push the new tag:
```sh
git tag v1.0.11
git push origin v1.0.11
```

## 4. GitHub Actions Workflow

The workflow will automatically run when a new tag is pushed. It will:
- Build the release tarball
- Create or update the GitHub release for the tag
- Upload the tarball and Homebrew formula as release assets

## Notes
- Always update the version, url, and sha256 in `boogiewoogie.rb` before tagging a new release.
- If you push a tag without updating the formula, the workflow may fail or publish incorrect assets.
- You can repeat these steps for every new release.
