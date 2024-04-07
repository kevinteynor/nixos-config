{ 
  config,
  pkgs,
  helix,
  ...
}:

{
  home = {
    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "23.05";

    sessionVariables = {
      EDITOR = "hx";
      SUDO_EDITOR = "hx";
    };
    
    packages = with pkgs; [
      file
      which
      tree
      jq
      gh

      discord
      gimp
    ];
  };
  
  programs.home-manager = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Kevin Teynor";
    userEmail = "kevinteynor@gmail.com";
  };

  programs.fish = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    package = helix.packages."${pkgs.system}".helix;
    # package = helix.packages."x86_64-linux".default;
    # defaultEditor =;true;
    settings.theme = "nord-night";
  };
}
