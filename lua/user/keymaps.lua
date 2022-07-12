-- Shorten function name
local function keymap(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {}
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- testing
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
--keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n","<Leader>h",":bdelete<CR>", opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("n", "<leader>c", ":bdelete!<CR>", opts)
keymap("n","<leader>e", ":Explore<CR>", opts)
keymap("n", "<space>hh", ":nohlsearch<CR>", opts)
--keymap("n", "FF","<cmd>lua print('hello')<CR>", opts)
keymap("n", "<leader>gt", [[<Cmd> Telescope git_status <CR>]], opts)

--keymap("n", "<space>f",":lua require('telescope')builtin.find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
--  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
--  ["w"] = { "<cmd>w!<CR>", "Save" },
--  ["q"] = { "<cmd>q!<CR>", "Quit" },
--  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
----  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
--  ["f"] = {
--    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--    "Find files",
--  },
--  ["F"] = { "<cmd>Telescope live_grep hidden_files = true theme=ivy<cr>", "Find Text" },
--  ["FF"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
--  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

