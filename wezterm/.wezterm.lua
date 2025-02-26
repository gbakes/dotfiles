-- Helper function:
-- returns color scheme dependant on operating system theme setting (dark/light)
local function color_scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Tokyo Night"
  else
    return "Tokyo Night Day"
  end
end

-- Pull in WezTerm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Maximise window on startup
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Appearance
config.font_size = 14.0
config.color_scheme = color_scheme_for_appearance(wezterm.gui.get_appearance())
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false

-- Appearance tabs

config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.colors = {
  tab_bar = {
    active_tab = { fg_color = "#6c7086", bg_color = "#74c7ec" },
  },
}

-- Leader Key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- Split Windows
local action = wezterm.action

-- function for moving cursor between split panes
local function move_pane(key, direction)
  return {
    key = key,
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

-- function to rename tab
wezterm.on("rename-tab", function(window, pane)
  window:perform_action(
    act.PromptInputLine({
      description = "Rename Tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
    pane
  )
end)
-- Keybindings
config.keys = {
  {
    key = "f",
    mods = "LEADER",
    action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "d",
    mods = "LEADER",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "A",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuickSelect,
  },
  { key = "[", mods = "LEADER", action = action.ActivateCopyMode },
  {
    key = "c",
    mods = "LEADER",
    action = action.SpawnTab("CurrentPaneDomain"),
  },
  move_pane("j", "Down"),
  move_pane("k", "Up"),
  move_pane("h", "Left"),
  move_pane("l", "Right"),
  {
    key = "p",
    mods = "LEADER",
    action = action.ActivateTabRelative(-1),
  },
  {
    key = "n",
    mods = "LEADER",
    action = action.ActivateTabRelative(1),
  },
  -- Show tab navigator
  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action.ShowTabNavigator,
  },
  -- Show launcher menu
  {
    key = "P",
    mods = "CMD|SHIFT",
    action = wezterm.action.ShowLauncher,
  },
  -- Quickly open config file with common macOS keybind
  {
    key = ",",
    mods = "SUPER",
    action = wezterm.action.SpawnCommandInNewWindow({
      cwd = os.getenv("WEZTERM_CONFIG_DIR"),
      args = { os.getenv("SHELL"), "-c", "$VISUAL $WEZTERM_CONFIG_FILE" },
    }),
  },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "[",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },
  -- sksesy = "n",
  -- mods = "CTRL|SHIFT",
  -- action = act.EmitEvent("rename-tab"),
  -- },
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = "LeftArrow",
    mods = "OPT",
    action = act.SendKey({
      key = "b",
      mods = "ALT",
    }),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = act.SendKey({ key = "f", mods = "ALT" }),
  },
  -- Moving cursor across terminal panes
  { key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
  { key = "h", mods = "CMD", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CMD", action = act.ActivatePaneDirection("Right") },

  { key = "j", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "k", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
  {
    key = "c",
    mods = "CTRL",
    action = wezterm.action.QuickSelectArgs({
      patterns = {
        "\\bhttps?://[^\\s]+", -- URLS
        "/[\\w./-]+", -- file path
        "\\b(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\b", -- IPv4
        "\\b(?:[A-Fa-f0-9]{1,4}:){7}[A-Fa-f0-9]{1,4}\\b", -- IPv6
        "\\b[a-fA-F0-9]{64}\\b", -- SHA256
        "\\b[a-fA-F0-9]{40}\\b", -- SHA1
        "\\b[a-fA-F0-9]{32}\\b", -- MD5
        -- "\\b[a-z0-9]([-a-z0-9]*[a-z0-9])?\\b", -- K8s pod names
        "\\b[a-fA-F0-9]{7,40}\\b", -- git commit
        "\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}\\b", -- email address
        "\\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\\b", -- UUIDS
        "\\b[0-9]{1,5}\\b", -- PIDs
        "\\b\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?Z?\\b", -- timestamps
      },
    }),
  },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = action.ActivateTab(i - 1),
  })
end

-- Return config to WezTerm
return config
