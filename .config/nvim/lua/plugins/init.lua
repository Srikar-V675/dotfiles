return {

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        config = function()
            require("configs.render-markdown")
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- {
    --     "goolord/alpha-nvim",
    --     lazy = false,
    --     config = function()
    --         require("alpha").setup(require("alpha.themes.dashboard").config)
    --     end,
    -- },

    {
        "startup-nvim/startup.nvim",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            require("startup").setup({ theme = "dashboard" })
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "rcarriga/nvim-notify" },
        config = function()
            require("noice").setup({
                cmdline = {
                    enabled = true,
                    view = "cmdline_popup",
                },
                notify = {
                    enabled = true,
                    view = "notify",
                },
                lsp = {
                    progress = {
                        enabled = true,
                        view = "notify",
                    },
                    message = {
                        enabled = true,
                        view = "notify",
                    },
                },
                --     presets = {
                --         bottom_search = true, -- use a classic bottom cmdline for search
                --         command_palette = true, -- position the cmdline and popupmenu together
                --         long_message_to_split = true, -- long messages will be sent to a split
                --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
                --         lsp_doc_border = false, -- add a border to hover docs and signature help
                --     },
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup({
                stages = "fade",
                timeout = 3000,
                top_down = true, -- Change this to true for top-down positioning
            })
            vim.notify = require("notify") -- Set nvim-notify as default notify function
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("configs.telescope")
        end,
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        init = function()
            vim.opt.conceallevel = 1
        end,
        ft = "markdown",
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "scrolls",
                    path = "/home/srikarv/Documents/scrolls",
                },
            },
            notes_subdir = "/content/🥷🏽 jutsus",
            log_level = vim.log.levels.INFO,
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
            },
            new_notes_location = "notes_subdir",
            -- Optional, customize how note IDs are generated given an optional title.
            ---@param title string|?
            ---@return string
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,

            -- Optional, customize how note file names are generated given the ID, target directory, and title.
            ---@param spec { id: string, dir: obsidian.Path, title: string|? }
            ---@return string|obsidian.Path The full path to the new note.
            note_path_func = function(spec)
                -- This is equivalent to the default behavior.
                local path = spec.dir / tostring(spec.id)
                return path:with_suffix(".md")
            end,
            wiki_link_func = "prepend_note_path",
            markdown_link_func = function(opts)
                return require("obsidian.util").markdown_link(opts)
            end,
            -- Either 'wiki' or 'markdown'.
            preferred_link_style = "wiki",
            disable_frontmatter = false,
            -- Optional, alternatively you can customize the frontmatter data.
            ---@return table
            note_frontmatter_func = function(note)
                -- Add the title of the note as an alias.
                if note.title then
                    note:add_alias(note.title)
                end
                local out = { id = note.id, aliases = note.aliases, tags = note.tags }
                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end
                return out
            end,
            ---@param url string
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                -- vim.fn.jobstart({"open", url})  -- Mac OS
                vim.fn.jobstart({ "xdg-open", url }) -- linux
                -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
                -- vim.ui.open(url) -- need Neovim 0.10.0+
            end,
            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
            -- file it will be ignored but you can customize this behavior here.
            ---@param img string
            follow_img_func = function(img)
                -- vim.fn.jobstart { "qlmanage", "-p", img }  -- Mac OS quick look preview
                vim.fn.jobstart({ "xdg-open", url }) -- linux
                -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
            end,
            picker = {
                name = "telescope.nvim",
            },
            sort_by = "modified",
            sort_reversed = true,
            search_max_lines = 1000,
            open_notes_in = "vsplit",
            attachments = {
                img_folder = "/content/attachments",
                -- A function that determines the text to insert in the note when pasting an image.
                -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
                -- This is the default implementation.
                ---@param client obsidian.Client
                ---@param path obsidian.Path the absolute path to the image file
                ---@return string
                img_text_func = function(client, path)
                    path = client:vault_relative_path(path) or path
                    return string.format("![%s](%s)", path.name, path)
                end,
            },
            templates = {
                folder = "/home/srikarv/Documents/scrolls/content/templates",
                date_format = "%Y-%m-%d-%a",
                time_format = "%H:%M",
            },
        },
    },
}
