
local status_ok, blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end
blankline.setup({

  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "",
  },
  buftype_exclude = { "terminal" },
    space_char_blankline = " ",
    --show_trailing_blankline_indent = false,
    --show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = true,
})
