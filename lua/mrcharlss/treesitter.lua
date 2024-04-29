
require('nvim-treesitter.configs').setup {
	ensure_installed = { "typescript", "go", "javascript", "lua", "json", "templ"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	--  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = true,
		use_languagetree = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
}
