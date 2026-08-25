local mainMod = "SUPER"

-- Start desktop services after the Wayland socket is ready.
hl.exec_cmd("sh -c 'sleep 1; exec waybar'")
hl.exec_cmd("sh -c 'sleep 1; exec hyprpaper'")

local function launch(command)
    return function()
        hl.exec_cmd(command)
    end
end

-- Replace generated bindings so the shortcut viewer gets stable, useful names.
local bindings = {
    "Q", "Return", "Space", "C", "M", "E", "T", "B", "D", "K", "A", "H", "F",
    "SHIFT + B", "SHIFT + V", "SHIFT + M", "SHIFT + A", "SHIFT + T",
    "V", "R", "P", "J", "left", "right", "up", "down", "S", "SHIFT + S",
    "mouse_down", "mouse_up", "mouse:272", "mouse:273",
}

for _, binding in ipairs(bindings) do
    hl.unbind(mainMod .. " + " .. binding)
end

for i = 1, 10 do
    local key = i % 10
    hl.unbind(mainMod .. " + " .. key)
    hl.unbind(mainMod .. " + SHIFT + " .. key)
end

local mediaKeys = {
    "XF86AudioRaiseVolume", "XF86AudioLowerVolume", "XF86AudioMute", "XF86AudioMicMute",
    "XF86MonBrightnessUp", "XF86MonBrightnessDown", "XF86AudioNext", "XF86AudioPause",
    "XF86AudioPlay", "XF86AudioPrev",
}

for _, key in ipairs(mediaKeys) do
    hl.unbind(key)
end

hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close focused window" })
hl.bind(mainMod .. " + Return", launch("alacritty"), { description = "Open Alacritty" })
hl.bind(mainMod .. " + Space", launch("wofi --show drun"), { description = "Open application launcher" })
hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close focused window" })
hl.bind(mainMod .. " + M", launch("hyprshutdown"), { description = "Open shutdown menu" })

hl.bind(mainMod .. " + E", launch("nemo"), { description = "Open Nemo" })
hl.bind(mainMod .. " + T", launch("alacritty"), { description = "Open Alacritty" })
hl.bind(mainMod .. " + B", launch("firefox"), { description = "Open Firefox" })
hl.bind(mainMod .. " + D", launch("code"), { description = "Open Visual Studio Code" })
hl.bind(mainMod .. " + K", launch("krita"), { description = "Open Krita" })
hl.bind(mainMod .. " + A", launch("cherry-studio"), { description = "Open Cherry Studio" })
hl.bind(mainMod .. " + H", launch("helium-browser"), { description = "Open Helium" })
hl.bind(mainMod .. " + F", launch("shelly-ui"), { description = "Open Shelly" })
hl.bind(mainMod .. " + SHIFT + B", launch("blender"), { description = "Open Blender" })
hl.bind(mainMod .. " + SHIFT + V", launch("vlc"), { description = "Open VLC" })
hl.bind(mainMod .. " + SHIFT + M", launch("meld"), { description = "Open Meld" })
hl.bind(mainMod .. " + SHIFT + A", launch("pavucontrol"), { description = "Open volume control" })
hl.bind(mainMod .. " + SHIFT + T", launch("alacritty -e btop"), { description = "Open btop" })

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating window" })
hl.bind(mainMod .. " + R", launch("wofi --show drun"), { description = "Open application launcher" })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudo tiling" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split direction" })
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Focus window left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus window right" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Focus window above" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Focus window below" })

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end

hl.bind(mainMod .. " + S", launch("hypr-shortcuts"), { description = "Show shortcut viewer" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Move window to special workspace" })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Switch to next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Switch to previous workspace" })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

hl.bind("XF86AudioRaiseVolume", launch("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true, description = "Increase volume" })
hl.bind("XF86AudioLowerVolume", launch("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true, description = "Decrease volume" })
hl.bind("XF86AudioMute", launch("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true, description = "Toggle audio mute" })
hl.bind("XF86AudioMicMute", launch("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true, description = "Toggle microphone mute" })
hl.bind("XF86MonBrightnessUp", launch("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", launch("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true, description = "Decrease brightness" })
hl.bind("XF86AudioNext", launch("playerctl next"), { locked = true, description = "Next media track" })
hl.bind("XF86AudioPause", launch("playerctl play-pause"), { locked = true, description = "Pause or resume media" })
hl.bind("XF86AudioPlay", launch("playerctl play-pause"), { locked = true, description = "Play or pause media" })
hl.bind("XF86AudioPrev", launch("playerctl previous"), { locked = true, description = "Previous media track" })
