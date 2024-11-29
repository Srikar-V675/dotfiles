---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "catppuccin",
    -- transparency = true,
    -- hl_override = {
    --     Comment = { italic = true },
    --     ["@comment"] = { italic = true },
    -- },
}

M.plugins = {
    override = {
        ["nvim-telescope/telescope.nvim"] = {
            defaults = {
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        width = 0.75,
                        height = 0.9,
                        preview_height = 0.6,
                    },
                },
                border = true,
                borderchars = {
                    prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
            },
        },
    },
}

return M
