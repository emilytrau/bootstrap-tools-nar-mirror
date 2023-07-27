# Archived. This set of tools is no longer needed as of https://github.com/NixOS/nixpkgs/pull/238357.

# bootstrap-tools-nar-mirror

NAR archive mirror for bootstrap source packages.


## Motivation

As part of the `nixpkgs` minimal bootstrapping process we need to fetch source
code for projects such as [stage0-posix](https://github.com/oriansj/stage0-posix).
At the bottom-most level of bootstrapping we don't have access to utilities such
as `fetchgit` since they would introduce a circular dependency. The only tool we have
to fetch source trees hermetically is `import <nix/fetchurl.nix>` with the `unpack`
option, taking a NAR (Nix ARchive) file as input. This project aims to repackage
dependency tarballs in a compatible format as such.

## Build release

```sh
nix build ".#mirror"
```
