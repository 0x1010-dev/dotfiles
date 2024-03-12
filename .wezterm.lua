local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- helpers

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end
  local success, stdout, stderr = wezterm.run_child_process { 'sh', '-c',
    'ps -o state= -o comm= -t' .. wezterm.shell_quote_arg(tty) .. ' | ' ..
    'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?nvim?x?)(diff)?$\''
  }
  return success
end

local function is_outside_vim(pane) return not is_inside_vim(pane) end

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

config.freetype_load_target = "Light"
-- config.font = wezterm.font 'IosevkaTerm Nerd Font Mono'
-- config.font = wezterm.font 'CozetteHiDpi'
config.font = wezterm.font 'Cozette'
config.font_size = 7.0

config.color_scheme = 'iTerm2 Smoooooth'

-- config.window_background_opacity = 0.75
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.enable_scroll_bar = true

-- keybindings
config.leader = { key = 'Space', mods = 'CTRL' }
config.keys = {
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  bind_if(is_outside_vim, 'h', 'CTRL', wezterm.action.ActivatePaneDirection('Left')),
  bind_if(is_outside_vim, 'l', 'CTRL', wezterm.action.ActivatePaneDirection('Right')),
  bind_if(is_outside_vim, 'j', 'CTRL', wezterm.action.ActivatePaneDirection('Down')),
  bind_if(is_outside_vim, 'k', 'CTRL', wezterm.action.ActivatePaneDirection('Up')),
}

return config
