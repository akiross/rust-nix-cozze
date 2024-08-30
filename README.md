Building fails successfully:

```
$ nix build .#rust-nix-cozze

error:
       … while calling the 'derivationStrict' builtin

         at /builtin/derivation.nix:9:12: (source not available)

       … while evaluating derivation 'crate-rust-nix-cozze-0.1.0'
         whose name attribute is located at /nix/store/ddvrdcjgkdc9i2510hx1czhzbg3fflna-source/pkgs/stdenv/generic/make-derivation.nix:336:7

       … while evaluating attribute 'nativeBuildInputs' of derivation 'crate-rust-nix-cozze-0.1.0'

         at /nix/store/ddvrdcjgkdc9i2510hx1czhzbg3fflna-source/pkgs/stdenv/generic/make-derivation.nix:380:7:

          379|       depsBuildBuild              = elemAt (elemAt dependencies 0) 0;
          380|       nativeBuildInputs           = elemAt (elemAt dependencies 0) 1;
             |       ^
          381|       depsBuildTarget             = elemAt (elemAt dependencies 0) 2;

       error: value is a set while a string was expected
```

Unclear why, though.
