-- Use Gruvbox theme consistently
local function color_scheme_for_appearance(appearance)
  return "Gruvbox dark, medium (base16)"
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
    background = "#282828",
    active_tab = {
      bg_color = "#ebdbb2",
      fg_color = "#282828",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#3c3836",
      fg_color = "#a89984",
    },
    inactive_tab_hover = {
      bg_color = "#504945",
      fg_color = "#ebdbb2",
    },
  },
}

-- Leader Key
config.leader = { key = ";", mods = "CTRL", timeout_milliseconds = 2000 }

-- Split Windows
local action = wezterm.action

-- Disable wezterm pane management in favor of tmux
-- Remove wezterm's pane navigation to avoid conflicts with tmux

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
-- Keybindings - Simplified for tmux workflow
config.keys = {
  {
    key = "A",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuickSelect,
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
  {
    key = "c",
    mods = "CTRL|SHIFT",
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

-- Remove wezterm tab switching - let tmux handle it

-- Return config to WezTerm
return config
