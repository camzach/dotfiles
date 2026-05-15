local mainMod = "SUPER"
local terminal = "wezterm"
local xdgConfig = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"

-- Terminal and menu launches
hl.bind(mainMod .. "+C", hl.dsp.exec_cmd(terminal))
local rofiDir = xdgConfig .. "/rofi"
hl.bind(mainMod .. "+R", hl.dsp.exec_cmd(rofiDir .. "/launcher/launcher.sh"))
hl.bind(mainMod .. "+L", hl.dsp.exec_cmd(rofiDir .. "/powermenu/powermenu.sh"))

-- Window management
hl.bind(mainMod .. "+Q", hl.dsp.window.close())
hl.bind(mainMod .. "+V", hl.dsp.window.float())
hl.bind(mainMod .. "+P", hl.dsp.window.pseudo())
hl.bind(mainMod .. "+J", hl.dsp.layout("rotatesplit"))

-- 1Password quick access
hl.bind("CTRL+SHIFT+SPACE", hl.dsp.exec_cmd("/usr/bin/1password --quick-access"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. "+left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. "+right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. "+up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. "+down", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. "+1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. "+2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. "+3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. "+4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. "+5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. "+6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. "+7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. "+8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. "+9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. "+0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. "+SHIFT+1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. "+SHIFT+2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. "+SHIFT+3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. "+SHIFT+4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. "+SHIFT+5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. "+SHIFT+6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. "+SHIFT+7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. "+SHIFT+8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. "+SHIFT+9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. "+SHIFT+0", hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. "+S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. "+SHIFT+S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. "+mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. "+mouse:273", hl.dsp.window.resize())

-- Screenshot bindings
hl.bind("Print", hl.dsp.exec_cmd('exec grim -g "$(slurp)" - | satty --floating-hack -f -'))
hl.bind("SHIFT+Print", hl.dsp.exec_cmd("exec grim - | satty --floating-hack -f -"))
hl.bind("ALT+SHIFT+Print", hl.dsp.exec_cmd('exec grim -g "$(slurp -o)" - | satty --floating-hack -f -'))
hl.bind("ALT+Print", hl.dsp.exec_cmd(xdgConfig .. "/hypr/copy-window.sh"))

-- Audio picker
hl.bind(mainMod .. "+SHIFT+M", hl.dsp.exec_cmd(xdgConfig .. "/hypr/audio-picker-currentwindow.sh"))
hl.bind(mainMod .. "+M", hl.dsp.exec_cmd(xdgConfig .. "/hypr/audio-picker.sh"))
