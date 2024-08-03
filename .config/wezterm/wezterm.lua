-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'Adventure Time (Gogh)'
--config.color_scheme = 'Ciapre'
config.color_scheme = 'duckbones'
--config.color_scheme = 'Ef-Deuteranopia-Dark'
--config.color_scheme = 'Ef-Duo-Dark'
--config.color_scheme = 'Ef-Night'
config.color_scheme = 'FrontEndDelight'
config.color_scheme = 'Glacier'
config.color_scheme = 'Google (dark) (terminal.sexy)'
--config.color_scheme = 'Grape'
--config.color_scheme = 'Harmonic16 Dark (base16)'
--config.color_scheme = 'Outrun Dark (base16)'
config.color_scheme = 'PhD (base16)'
--config.color_scheme = 'Silk Dark (base16)'
config.color_scheme = 'Spacedust'

-- Font
--config.font = wezterm.font("FiraCode Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"})
config.font = wezterm.font("JetBrains Mono", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 15

-- Temporary fix for https://github.com/wez/wezterm/issues/4483
config.enable_wayland = true
config.front_end = "OpenGL"

-- Window decorations
config.window_padding = {
	top = "0.5cell",
	bottom = "0.5cell",
	right = "1cell",
	left = "1cell",
}

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20
config.colors = {
  tab_bar = {
    background = '#2a2a37',
    active_tab = {
      bg_color = '#54546d',
      fg_color = '#dcd7ba',
      italic = true,
    },
    inactive_tab = {
      bg_color = '#363646',
      fg_color = '#727169'
    },
    new_tab = {
      bg_color = '#363646',
      fg_color = '#717c7c'
    }
  }
}
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false

config.default_cursor_style = 'SteadyBlock' --'BlinkingBlock'
--config.cursor_blink_rate = 500
--config.cursor_blink_ease_in = "Constant"
--config.cursor_blink_ease_out = "Constant"

--config.unzoom_on_switch_pane = true
--config.keys = {
--  {
--    key = 'Z',
--    mods = 'CTRL',
--    action = wezterm.action.TogglePaneZoomState,
--  },
--}
--config.visual_bell = {
--  fade_in_function = 'EaseIn',
--  fade_in_duration_ms = 150,
--  fade_out_function = 'EaseOut',
--  fade_out_duration_ms = 150,
--}
--config.colors = {
--  visual_bell = '#202020',
--}
--config.visual_bell = {
--  fade_in_duration_ms = 75,
--  fade_out_duration_ms = 75,
--  target = 'CursorColor',
--}


-- Other
config.warn_about_missing_glyphs = true
config.term = "xterm-256color"

-- and finally, return the configuration to wezterm
return config
