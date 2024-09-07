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
    aliases = {
      l = "log --oneline --graph";
    };
  };

  programs.fish = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    package = helix.packages."${pkgs.system}".helix;
    settings = {
      theme = "nord-night";
      
      # TODO: enable in new Helix version >24.07
      #       https://github.com/helix-editor/helix/pull/6417
      # editor.inline-diagnostics = {
      #   cursor-line = "hint";
      #   other-lines = "error";
      # };
    };
  };
}
