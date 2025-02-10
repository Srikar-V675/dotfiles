require("render-markdown").setup({
    latex = {
        enabled = true,
        converter = "latex2text",
        highlight = "RenderMarkdownMath",
        top_pad = 1,
        bottom_pad = 1,
    },
})
