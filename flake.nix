{
  description = "Seastar C++ framework flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = {
      default = self.packages.x86_64-linux.seastar;
      seastar = nixpkgs.legacyPackages.x86_64-linux.callPackage ./seastar.nix {};
    };
    
    overlays.default = final: prev: {
      seastar = if prev.stdenv.isLinux && prev.stdenv.isx86_64
        then prev.callPackage ./seastar.nix {}
        else throw "Seastar is only supported on x86_64-linux";
    };
  };
}
