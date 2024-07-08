return {
    "telemachus/in-and-out.nvim",
    branch = "config",
    keys = {
        {
            "<C-CR>",
            function()
                require("in-and-out").in_and_out()
            end,
            mode = "i",
        },
    },
    opts = {
        additional_targets = { "“", "”" },
    },
}
