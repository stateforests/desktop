local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono")
config.font_size = 11.0

config.window_background_opacity = 0.96

config.window_padding = {
  left = 10,
  right = 10,
  top = 8,
  bottom = 8,
}

config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

wezterm.on("format-tab-title", function(tab)
  local title = tab.active_pane.title or ""
  title = wezterm.truncate_right(title, 10, "...")

  return {
    { Text = "  " .. title .. "  " },
  }
end)

config.colors = {
  foreground = "#c8c8c8",
  background = "#111214",

  cursor_bg = "#c8c8c8",
  cursor_fg = "#111214",
  cursor_border = "#c8c8c8",

  selection_bg = "#303238",
  selection_fg = "#eeeeee",

  ansi = {
    "#111214",
    "#a0a0a0",
    "#a4a4a4",
    "#a8a8a8",
    "#a2a2a2",
    "#a5a5a5",
    "#a7a7a7",
    "#c8c8c8",
  },

  brights = {
    "#505050",
    "#b8b8b8",
    "#bcbcbc",
    "#c0c0c0",
    "#bababa",
    "#bdbdbd",
    "#bfbfbf",
    "#eeeeee",
  },

  tab_bar = {
    background = "#111214",

    active_tab = {
      bg_color = "#25272b",
      fg_color = "#d2d2d2",
      intensity = "Normal",
    },

    inactive_tab = {
      bg_color = "#111214",
      fg_color = "#707070",
    },

    inactive_tab_hover = {
      bg_color = "#1b1d20",
      fg_color = "#b0b0b0",
    },

    new_tab = {
      bg_color = "#111214",
      fg_color = "#666666",
    },

    new_tab_hover = {
      bg_color = "#1b1d20",
      fg_color = "#b0b0b0",
    },
  },
}

config.enable_scroll_bar = false
config.audible_bell = "Disabled"
config.animation_fps = 1

return config
