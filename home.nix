{ 
  config,
  pkgs,
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
      helix
      file
      which
      tree
      jq
      gh
      ripgrep

      discord
      gimp
      firefox
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
    settings = {
      theme = "nord-night";
      editor = {
        file-picker.hidden = false;
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
      };
    };
  };
}
