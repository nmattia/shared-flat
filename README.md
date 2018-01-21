# Shared flat template

This is a shared flat agreement template. You can set
variables in `variables`.  To build, you need [gpp][1] and
[pandoc][2]. Run the following command:

``` shell
$ gpp --include src/variables -H src/contract.md | pandoc -o contract.pdf
```

## Building with Nix

Once you have [nix](https://nixos.org/nix/) installed, you can either run the
above command inside a nix-shell:

``` shell
$ nix-shell --command 'gpp --include src/variables -H src/contract.md | pandoc -o contract.pdf'
```

or build the contract directly with

``` shell
$ nix-build
```

which will produce `result/contract.pdf`.

[1]: https://logological.org/gpp
[2]: https://pandoc.org/

## Updating the nixpkgs

You can update the nixpkgs commit by running:

``` shell
$ ./nix/update
```

in the top-level directory.
