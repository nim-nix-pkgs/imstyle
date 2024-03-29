{
  description = ''A nice way to manage your ImGui application's style'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-imstyle-0_3_4.flake = false;
  inputs.src-imstyle-0_3_4.ref   = "refs/tags/0.3.4";
  inputs.src-imstyle-0_3_4.owner = "Patitotective";
  inputs.src-imstyle-0_3_4.repo  = "ImStyle";
  inputs.src-imstyle-0_3_4.type  = "github";
  
  inputs."nimgl".owner = "nim-nix-pkgs";
  inputs."nimgl".ref   = "master";
  inputs."nimgl".repo  = "nimgl";
  inputs."nimgl".dir   = "1_3_2";
  inputs."nimgl".type  = "github";
  inputs."nimgl".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimgl".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."chroma".owner = "nim-nix-pkgs";
  inputs."chroma".ref   = "master";
  inputs."chroma".repo  = "chroma";
  inputs."chroma".dir   = "0_2_7";
  inputs."chroma".type  = "github";
  inputs."chroma".inputs.nixpkgs.follows = "nixpkgs";
  inputs."chroma".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."niprefs".owner = "nim-nix-pkgs";
  inputs."niprefs".ref   = "master";
  inputs."niprefs".repo  = "niprefs";
  inputs."niprefs".dir   = "0_3_4";
  inputs."niprefs".type  = "github";
  inputs."niprefs".inputs.nixpkgs.follows = "nixpkgs";
  inputs."niprefs".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-imstyle-0_3_4"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-imstyle-0_3_4";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}