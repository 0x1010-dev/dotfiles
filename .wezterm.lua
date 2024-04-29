local wezterm = require("wezterm")
local config = wezterm.config_builder()
local a = wezterm.action

-- helpers

local function is_inside_vim(pane)
	local tty = pane:get_tty_name()
	if tty == nil then
		return false
	end
	local success, stdout, stderr = wezterm.run_child_process({
		"sh",
		"-c",
		"ps -o state= -o comm= -t"
			.. wezterm.shell_quote_arg(tty)
			.. " | "
			.. "grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?nvim?x?)(diff)?$'",
	})
	return success
end

local function is_outside_vim(pane)
	return not is_inside_vim(pane)
end

local function bind_if(cond, key, mods, action)
	local function callback(win, pane)
		if cond(pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(wezterm.action.SendKey({ key = key, mods = mods }), pane)
		end
	end
	return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

-- configuration

config.enable_wayland = true
config.freetype_load_target = "Light"
-- config.font = wezterm.font 'IosevkaTerm Nerd Font Mono'
-- config.font = wezterm.font 'CozetteHiDpi'
config.font = wezterm.font("Cozette")
config.font_size = 7.0
config.warn_about_missing_glyphs = false

config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.95
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_scroll_bar = true
config.max_fps = 255

config.inactive_pane_hsb = {
	saturation = 0.75,
	brightness = 0.60,
}

-- keybindings
config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	{ key = "l", mods = "CTRL|SHIFT", action = a.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "j", mods = "CTRL|SHIFT", action = a.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "CTRL", action = a.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL", action = a.AdjustPaneSize({ "Right", 5 }) },
	{ key = "DownArrow", mods = "CTRL", action = a.AdjustPaneSize({ "Down", 5 }) },
	{ key = "UpArrow", mods = "CTRL", action = a.AdjustPaneSize({ "Up", 5 }) },
	bind_if(is_outside_vim, "h", "CTRL", a.ActivatePaneDirection("Left")),
	bind_if(is_outside_vim, "l", "CTRL", a.ActivatePaneDirection("Right")),
	bind_if(is_outside_vim, "j", "CTRL", a.ActivatePaneDirection("Down")),
	bind_if(is_outside_vim, "k", "CTRL", a.ActivatePaneDirection("Up")),
	bind_if(is_outside_vim, "w", "CTRL", a.CloseCurrentPane({ confirm = true })),
}

return config
