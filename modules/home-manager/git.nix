{ ... }:

{
  # Git configuration
  programs.git = {
    enable = true;
    userName = "NAS User";
    userEmail = "nasuser@joshmangiola.com";
  };
  
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
