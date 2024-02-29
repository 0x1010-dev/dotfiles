local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.freetype_load_target = "Light"
config.font = wezterm.font 'IosevkaTerm Nerd Font Mono'
config.font_size = 10.0

config.color_scheme = 'iTerm2 Smoooooth'

config.window_background_opacity = 0.75
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.enable_scroll_bar = true

return config
