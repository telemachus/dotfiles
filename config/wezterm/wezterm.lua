local wezterm = require("wezterm")

local config = {
    window_close_confirmation = "NeverPrompt",
    scrollback_lines = 10000,
    enable_tab_bar = true,
    show_tab_index_in_tab_bar = false,
    use_fancy_tab_bar = true,
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",

    font = wezterm.font_with_fallback({
        { family = "Source Code Pro", weight = "Medium" },
        { family = "JetBrains Mono", weight = "Medium" },
        { family = "SF Mono", weight = "Medium" },
    }),
    bold_brightens_ansi_colors = "No",
    front_end = "WebGpu",
    font_size = 16,
    default_cursor_style = "SteadyBlock",
    cursor_thickness = 3,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    -- Use left option as macOS option and right option as alt.
    send_composed_key_when_left_alt_is_pressed = true,
    send_composed_key_when_right_alt_is_pressed = false,

    colors = {
        foreground = "090909",
        background = "white",

        cursor_bg = "090909",
        cursor_fg = "white",

        selection_bg = "d5e5f6",
        selection_fg = "black",

        ansi = {
            "000000",
            "800000",
            "194a1f",
            "808000",
            "000075",
            "8b008b",
            "469990",
            "c5c6c8",
        },
        brights = {
            "737373",
            "d20f2c",
            "3cb44d",
            "ffe119",
            "4363d8",
            "f032e6",
            "42d4f4",
            "ffffff",
        },
        tab_bar = {
            background = "white",
            inactive_tab_edge = "white",
            active_tab = {
                bg_color = "eeeeee",
                fg_color = "black",
            },
            inactive_tab = {
                bg_color = "white",
                fg_color = "black",
            },
            inactive_tab_hover = {
                bg_color = "d5e5f6",
                fg_color = "black",
            },
            new_tab = {
                bg_color = "white",
                fg_color = "black",
            },
            new_tab_hover = {
                bg_color = "d5e5f6",
                fg_color = "black",
            },
        },
    },
    window_frame = {
        font = wezterm.font_with_fallback({
            { family = "Source Code Pro", weight = "Bold" },
            { family = "JetBrains Mono", weight = "Bold" },
            { family = "SF Mono", weight = "Bold" },
        }),
        font_size = 12.5,
        active_titlebar_bg = "white",
    },
    -- window_background_opacity = 0.92,
    -- macos_window_background_blur = 10,
    window_padding = {
        bottom = 0,
    },
}

return config
