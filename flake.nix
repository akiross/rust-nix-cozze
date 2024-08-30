{
  description = "Let's build with cozze";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, naersk, fenix, ... }: {
    packages.x86_64-linux =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ fenix.overlays.default ];
        };

        toolchain = with fenix.packages.x86_64-linux; combine [
          minimal.cargo
          minimal.rustc
          targets.x86_64-unknown-linux-musl.latest.rust-std
        ];

        naersk' = pkgs.callPackage
          naersk
          {
            cargo = toolchain;
            rustc = toolchain;
          };
      in
      {
        rust-nix-cozze = naersk'.buildPackage {
          src = ./.;
          # This is necessary or it wil build for glibc
          CARGO_BUILD_TARGET = "x86_64-unknown-linux-musl";
        };
      };
  };
}
