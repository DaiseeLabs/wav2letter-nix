# Nix expression to build wav2letter++

Tested on x86_64-linux, the nix expression in default.nix should build
wav2letter++.

The nixpkgs version is pinned in nixpkgs.nix and is overridable. 

# Prerequisites

* nix (`curl https://nixos.org/nix/install | sh`)
* probably linux

# Building

```
nix-build default.nix
```

# Installing

```
nix-env -f default.nix -i
```
