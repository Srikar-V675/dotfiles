require("nvchad.mappings")

-- add yours here
-- obsidian.nvim keymaps
local map = vim.keymap.set

map("n", "<leader>no", ":ObsidianOpen<CR>", { noremap = true }) -- Open a note
map("n", "<leader>nq", ":ObsidianQuickSwitch<CR>", { noremap = true }) -- Quick switch to another note
map("n", "<leader>nf", ":ObsidianFollowLink<CR>", { noremap = true }) -- Follow link
map("n", "<leader>nb", ":ObsidianBacklinks<CR>", { noremap = true }) -- Get backlinks
map("n", "<leader>nt", ":ObsidianTags<CR>", { noremap = true }) -- Get tags
map("n", "<leader>ns", ":ObsidianSearch<CR>", { noremap = true }) -- Search notes
map("n", "<leader>nl", ":ObsidianLinks<CR>", { noremap = true }) -- Collect links in current buffer
map("v", "<leader>ne", ":ObsidianExtractNote<CR>", { noremap = true }) -- Extract selected text into a new note
map("n", "<leader>ni", ":ObsidianPasteImg<CR>", { noremap = true }) -- Paste image from clipboard
map("n", "<leader>nr", ":ObsidianRename<CR>", { noremap = true }) -- Rename current note
map("n", "<leader>nn", ":ObsidianNewFromTemplate<CR>", { noremap = true }) -- Create new note from template
map("n", "<leader>nc", ":ObsidianTOC<CR>", { noremap = true }) -- Load table of contents

-- Unmap the default line number toggle
map("n", "<leader>n", "<Nop>", { desc = "Disable line number toggle" })

-- Set a new mapping for toggling line numbers
map("n", "<leader>l", ":set number!<CR>", { desc = "Toggle line numbers" })

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
