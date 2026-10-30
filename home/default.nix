{ inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.damian = {
      imports = [
        inputs.zen-browser.homeModules.default
        ./desktop.nix
        ./neovim.nix
        ./zen.nix
      ];

      programs.git = {
        enable = true;
        settings = {
          user.name = "damian1607";
          user.email = "damianchw@proton.me";
          pull.rebase = true;
        };
      };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings.homelab = {
          hostname = "192.168.2.24";
          port = 2222;
          user = "damian";
        };
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };

      home.stateVersion = "26.05";
    };
  };
}
