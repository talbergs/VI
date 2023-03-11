local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "https://github.com/neo4j-contrib/cypher-vim-syntax", commit = "386abb72a5113dfd3aa88ab59bb1e99d3ff33c8e" }
  use { "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used by lots of plugins
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
  use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" }
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }
  use { "lukas-reineke/indent-blankline.nvim", ft = {'yaml'}, commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" }

  -- Colorschemes
  use { "savq/melange", commit = "78af754ad22828ea3558e2990326b8aa39730918" }
  use { "rktjmp/lush.nvim", commit = "6b9f399245de7bea8dac2c3bf91096ffdedfcbb7" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
  -- use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "https://github.com/dcampos/cmp-snippy", commit = "9af1635fe40385ffa3dabf322039cb5ae1fd7d35" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- snippets
  -- use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" } --snippet engine
  -- use { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" } -- a bunch of snippets to use
  use { "https://github.com/dcampos/nvim-snippy", commit = "1860215584d4835d87f75896f07007b3b3c06df4" }

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP
  use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "https://github.com/arkav/lualine-lsp-progress", commit = "56842d097245a08d77912edf5f2a69ba29f275d7" }
  use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters

  use {"simnalamburt/vim-mundo", commit = "3c7e008a9922702be979dbfe3c5280313f53618b"} -- https://github.com/simnalamburt/vim-mundo
  use {"windwp/nvim-spectre", commit = "c553eb47ad9d82f8452119ceb6eb209c930640ec"} -- https://github.com/windwp/nvim-spectre
  use {"itchyny/vim-qfedit", commit = "f03f0c2ce03ec60c4c296be39c9558f8cc9dbd63"} -- https://github.com/itchyny/vim-qfedit
  use {"tpope/vim-fugitive", commit = "66a921bbe38bea19f6b581c8a56d5a8a41209e35"} -- https://github.com/tpope/vim-fugitive
  use {"tpope/vim-surround", commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea" } -- https://github.com/tpope/vim-surround
  use {"tpope/vim-commentary", commit = "3654775824337f466109f00eaf6759760f65be34" } -- https://github.com/tpope/vim-commentary
  use {"tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" } -- https://github.com/tpope/vim-repeat
  use {"https://github.com/gcmt/taboo.vim", commit = "caf948187694d3f1374913d36f947b3f9fa1c22f" }

  use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        tag = "1.*",
        config = function()
          require"window-picker".setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal" },
              },
            },
            other_win_hl_color = "#e35e4f",
          })
        end,
      }
    },
    config = function ()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint",
        {text = "", texthl = "DiagnosticSignHint"})

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end
  }

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "518e27589c0463af15463c9d675c65e464efc2fe" }
  use { "lewis6991/spellsitter.nvim", commit = "c1b318f8b959e015f5cc7941624d1ca0f84705dd" }
  use { "lukas-reineke/virt-column.nvim", commit = "29db24c5e94243df1f34f47bbcb4e7803204cae4" }
  use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" }
  use { "andymass/vim-matchup", commit = "976ebfe61b407d0a75d87b4a507bf9ae4ffffbaa",
    config = function ()
      vim.g.matchup_matchparen_offscreen = {}
    end
  }
  use { "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", commit = "4234c446d14370b3cd7604bd8e2e51ae2680f5ee" }
  use { "nvim-treesitter/nvim-treesitter-context", commit = "8e88b67d0dc386d6ba1b3d09c206f19a50bc0625",
    config = function()
      require"treesitter-context".setup{
        enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
            "foreach",
            "if",
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
          },
          -- Example for a specific filetype.
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          --   rust = {
          --       'impl_item',
          --   },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        },

        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20, -- The Z-index of the context window
        mode = "topline",  -- Line used to calculate context. Choices: 'cursor', 'topline'
        separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
      }
    end
  }

  use { "https://github.com/kwkarlwang/bufjump.nvim", commit = "a020f81bb82f758da51594a07bfcb9635a6b0f73", config = function()
        require("bufjump").setup({
            forward = "<a-i>",
            backward = "<a-o>",
            on_success = nil
        })
    end }

  use { "https://github.com/nvim-treesitter/playground", commit = "bcfab84f98a33f2ad34dda6c842046dca70aabf6" }

  -- use {
  --     'stevearc/aerial.nvim',
  --     config = function() require('aerial').setup() end
  --   }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  use {"https://github.com/LukasPietzschmann/telescope-tabs", commit = "268ca2341c224e5d5f397bf72ce3623c8d9fcb8a" , config = function ()
    require'telescope-tabs'.setup{
			-- Your custom config :^)
		}
  end}

  use {"https://github.com/octarect/telescope-menu.nvim", commit = "9751fc0cb7041ba436c27a86f8faefc5ffe7f8bd" , config = function ()
    require("telescope").setup {
      extensions = {
        menu = {
          default = {
            items = {
              -- You can add an item of menu in the form of { "<display>", "<command>" }
              { "Checkhealth", "checkhealth" },
              { "Show LSP Info", "LspInfo" },
              { "Files", "Telescope find_files" },

              -- The above examples are syntax-sugars of the following;
              { display = "Change colorscheme", value = "Telescope colorscheme" },
            },
          },
        },
      },
    }

    require("telescope").load_extension "menu"
  end}
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
