{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      lualine-nvim
      nvim-web-devicons
      catppuccin-nvim
      nvim-cmp
      cmp-nvim-lsp
      luasnip
    ];

    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.termguicolors = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.updatetime = 50

      -- Map leader
      vim.g.mapleader = " "

      -- Theme
      vim.cmd.colorscheme "catppuccin"

      -- Lualine
      require('lualine').setup {
        options = { theme = 'catppuccin' }
      }

      -- Telescope keymaps (fuzzy finder)
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      -- LSP Config
      local lspconfig = require('lspconfig')
      lspconfig.nixd.setup{} -- Nix
      lspconfig.pyright.setup{} -- Python
      lspconfig.rust_analyzer.setup{} -- Rust
      lspconfig.ts_ls.setup{} -- JS/TS
      lspconfig.clangd.setup{} -- C/C++

      -- Completion setup
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    '';
  };
}