{
  description = "Devshell to load all dependencies to compile the latex document";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Das in TeX Live gebündelte latexminted (0.6.0) stürzt unter Python 3.14 ab
      # (argparse-Inkompatibilität). Das latexminted-Paket aus nixpkgs ist zu neu für
      # minted.sty 3.7.0, daher wird das gebündelte Skript mit Python 3.13 ausgeführt.
      mintedScript = "${pkgs.texlivePackages.minted.out}/bin/latexminted";
      texlive = pkgs.texliveFull.overrideAttrs (old: {
        postBuild = (old.postBuild or "") + ''
          rm -f $out/bin/latexminted
          cat > $out/bin/latexminted <<EOF
          #!${pkgs.runtimeShell}
          exec ${pkgs.python313}/bin/python3 ${mintedScript} "\$@"
          EOF
          chmod +x $out/bin/latexminted
        '';
      });
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ texlive ];
      };
    };
}
