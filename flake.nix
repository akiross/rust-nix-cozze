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

        toolchain = pkgs.fenix.stable;

        naersk' = pkgs.callPackage
          naersk
          {
            cargo = toolchain.cargo;
            rustc = toolchain.rustc;
          };
      in
      {
        rust-nix-cozze = naersk'.buildPackage {
          src = ./.;
        };
      };
  };
}
