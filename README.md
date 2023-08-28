# ~recaptime-dev's custom nix packages

![Build and populate cache](https://github.com/recaptime-dev/infra-custom-nixpkgs/workflows/Build%20and%20populate%20cache/badge.svg)
[![Cachix Cache](https://img.shields.io/badge/cachix-recaptime--dev-blue.svg)](https://recaptime-dev.cachix.org)

This repository is used by the squad to stage software for packaging to nixpkgs
before we submit it as a merge request to the official nixpkgs repo.

We're currently do not accepting packaging requests here from external contributors,
although we're open with bug reports regarding the builds CI.

## How to build

You can build the packages locally with:

```bash
nix-shell -A <package-name>

# or manually import nixpkgs
nix-shell --arg pkgs 'import <nixpkgs> {}' -A <package-name
```
