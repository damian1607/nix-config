{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      lualine-nvim
      nvim-web-devicons
      (nvim-treesitter.withPlugins (p: [ p.nix p.lua p.kdl p.toml p.json p.bash p.fish p.markdown ]))
    ];

    initLua = ''
      -- Basics
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.relativenumber = false
      vim.opt.termguicolors = true
      vim.opt.signcolumn = "yes"
      vim.opt.scrolloff = 8
      vim.opt.clipboard = "unnamedplus"

      -- Spaces instead of tabs
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2

      -- niri configs and the alacritty import list use 4 spaces
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "kdl", "toml" },
        callback = function()
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
        end,
      })

      -- Colorscheme with transparent background
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")

      -- Status line
      require("lualine").setup({
        options = { theme = "auto", globalstatus = true },
      })

      -- Use the JSON parser for .jsonc files
      vim.treesitter.language.register("json", "jsonc")

      -- Syntax highlighting via treesitter
      vim.api.nvim_create_autocmd("FileType", {
        callback = function() pcall(vim.treesitter.start) end,
      })
    '';
  };
}
