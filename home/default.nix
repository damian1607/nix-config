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
      ];

      programs.git = {
        enable = true;
        settings = {
          user.name = "damian1607";
          user.email = "damianchw@proton.me";
          pull.rebase = true;
        };
      };

      home.stateVersion = "26.05";
    };
  };
}
