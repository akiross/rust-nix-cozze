{
  description = "Let's build with cozze";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    cargo2nix = {
      url = "github:cargo2nix/cargo2nix/release-0.11.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, cargo2nix, ... }: {
    packages.x86_64-linux =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ cargo2nix.overlays.default ];
        };

        toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;

        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = toolchain;
          packageFun = import ./Cargo.nix;
        };
      in
      {
        rust-nix-cozze = (rustPkgs.workspace.rust-nix-cozze { });
      };
  };
}
