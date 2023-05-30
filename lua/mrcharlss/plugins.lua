local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- plugins here:
    use {"wbthomason/packer.nvim"} -- Have packer manage itself
    use { "nvim-lua/popup.nvim" } -- An implementation of the Popup API from vim in Neovim
    use { "nvim-lua/plenary.nvim" } -- Useful lua functions used ny lots of plugins

    use { "neovim/nvim-lspconfig" } -- enable LSP
    use { "lewis6991/impatient.nvim" }

    --Color Schemeplu
    use { "ellisonleao/gruvbox.nvim" }

    --Bufferline
    use { "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }

    -- load luasnips + cmp related in insert mode only
            use {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                requires = "rafamadriz/friendly-snippets",
            }

            use {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            }
            use {
                "windwp/nvim-autopairs",
            }
    use {
        "hrsh7th/nvim-cmp",
        -- event = "InsertEnter",
        -- dependencies = {

            -- cmp sources plugins
        -- },
            -- opts = function()
            --     return require("mrcharlss.cmp")
            -- end,
            -- config = function(_,opts)
            --     require("cmp").setup(opts)
            -- end
    }

            -- autopairing of (){}[] etc
    -- LSP
    use {
        "williamboman/mason.nvim",
        opts = function()
            return require("mrcharlss.mason")
        end,
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope-dap.nvim" }

  use {'ThePrimeagen/harpoon'}
    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    }
    use {
        "numToStr/Comment.nvim",
    }

    -- Git
    use { "lewis6991/gitsigns.nvim" }

    --Debug
    use { "mfussenegger/nvim-dap" }
    use { "theHamsta/nvim-dap-virtual-text" }
    use { "rcarriga/nvim-dap-ui" }

    --Terminal
    use { "akinsho/toggleterm.nvim" }

    -- BlankLine
    use { "lukas-reineke/indent-blankline.nvim" }
    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
