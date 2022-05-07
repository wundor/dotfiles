-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme handling library
local beautiful = require("beautiful")

-- Notifications library
local naughty = require("naughty")

-- Bling
local bling = require("lib.bling")
local playerctl = bling.signal.playerctl.lib()

-- ignoring mpd because I don't use it.
local player_command = "playerctl -i mpd"

-- Helpers
local helpers = require("helpers")

-- for toggleMute mic function
require("sub.mic")
require("misc.fake")

local machi = require("lib.layout-machi")

-- Make key easier to call
----------------------------

local super = "Mod4"
local alt = "Mod1"
local ctrl = "Control"
local shift = "Shift"

------------------------
awful.keyboard.append_global_keybindings({ -- Terminal
awful.key({super}, "Return", function()
    awful.spawn(launcher)
end, {
    description = "Spawn launcher",
    group = "App"
}), awful.key({super, alt}, 'f', function()
    _G.screen.emit_signal('toggle_fake')
end, {
    description = 'show/hide fake screen',
    group = 'fake screen'
}), -- Create or remove
awful.key({super, alt, ctrl}, 'f', function()
    if screen_has_fake() then
        _G.screen.emit_signal('remove_fake')
    else
        _G.screen.emit_signal('create_fake')
    end
end, {
    description = 'create/remove fake screen',
    group = 'fake screen'
}), -- Increase fake screen size
awful.key({super, alt}, 'Left', function()
    _G.screen.emit_signal('resize_fake', -10)
end, {
    description = 'resize fake screen',
    group = 'fake screen'
}), -- Decrease fake screen size
awful.key({super, alt}, 'Right', function()
    _G.screen.emit_signal('resize_fake', 10)
end, {
    description = 'resize fake screen',
    group = 'fake screen'
}), -- Reset screen sizes to initial size
awful.key({super, alt}, 'r', function()
    _G.screen.emit_signal('reset_fake')
end, {
    description = 'reset fake screen size',
    group = 'fake screen'
}), awful.key({super}, "\\", hotkeys_popup.show_help, {
    description = "Hotkeys menu",
    group = "App"
}), ---- WM
-- Toggle titlebar
awful.key({super, shift}, "t", function()
    awful.titlebar.toggle(client.focus, beautiful.titlebar_pos)
end, {
    description = "Toggle titlebar",
    group = "WM"
}), -- Restart awesome
awful.key({super, shift}, "r", awesome.restart, {
    description = "Reload awesome",
    group = "WM"
}), -- Quit awesome
awful.key({super, shift}, "q", awesome.quit, {
    description = "Quit awesome",
    group = "WM"
}), ---- Window
-- Focus client by direction
awful.key({super}, "k", function()
    local c = client.focus
    if c.maximized then
        awful.client.focus.byidx(-1)
    else
        awful.client.focus.bydirection("up")
        if client.focus then
            client.focus:raise()
        end
    end
end, {
    description = "Focus up/previour",
    group = "Window"
}), awful.key({super}, "h", function()
    awful.client.focus.bydirection("left")
end, {
    description = "Focus left",
    group = "Window"
}), awful.key({super}, "j", function()
    local c = client.focus
    if c.maximized then
        awful.client.focus.byidx(1)
    else
        awful.client.focus.bydirection("down")
        if client.focus then
            client.focus:raise()
        end
        awful.placement.closest_corner(mouse, {
            include_sides = true,
            parent = client.focus
        })
    end
end, {
    description = "Focus down/next",
    group = "Window"
}), awful.key({super}, "l", function()
    awful.client.focus.bydirection("right")
end, {
    description = "Focus right",
    group = "Window"
}), -- Resize focused client
awful.key({super, ctrl}, "k", function(c)
    helpers.resize_client(client.focus, "up")
end, {
    description = "Resize to the up",
    group = "Window"
}), awful.key({super}, "u", awful.client.urgent.jumpto, {
    description = "jump to urgent client",
    group = "Window"
}), awful.key({super, ctrl}, "h", function(c)
    helpers.resize_client(client.focus, "left")
end, {
    description = "Resize to the left",
    group = "Window"
}), awful.key({super, ctrl}, "j", function(c)
    helpers.resize_client(client.focus, "down")
end, {
    description = "Resize to the down",
    group = "Window"
}), awful.key({super, ctrl}, "l", function(c)
    helpers.resize_client(client.focus, "right")
end, {
    description = "Resize to the right",
    group = "Window"
}), -- Un-minimize windows
awful.key({super, shift}, "n", function()
    local c = awful.client.restore()
    if c then
        c:activate{
            raise = true,
            context = "key.unminimize"
        }
    end
end), ---- Bling
-- Add client to tabbed layout
awful.key({super, shift}, "e", function()
    awesome.emit_signal("tabbed::add")
end, {
    description = "Add client to tabbed layout",
    group = "Bling"
}), -- Remove client from tabbed layout
awful.key({super, ctrl}, "e", function()
    awesome.emit_signal("tabbed::destroy")
end, {
    description = "Remove client from tabbed layout",
    group = "Bling"
}), -- Cycle through client in tabbed layout
awful.key({super}, "`", function()
    awesome.emit_signal("tabbed::cycle")
end, {
    description = "Cycle through client in tabbed layout",
    group = "Bling"
}), -- Terminal scratchpad
awful.key({super}, ";", function()
    awesome.emit_signal("scratch::kitty")
end, {
    description = "Toggle terminal scratchpad",
    group = "Bling"
}), ---- Misc
-- Screen brightness
awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("brightnessctl set 5%- -q")
end, {
    description = "Decrease screen brightness",
    group = "Misc"
}), awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn("brightnessctl set 5%+ -q")
end, {
    description = "Increase screen brightness",
    group = "Misc"
}), -- Volume
awful.key({}, "XF86AudioMute", function()
    helpers.volume_control(0)
end, {
    description = "Toggle volume",
    group = "Misc"
}), awful.key({}, "XF86AudioLowerVolume", function()
    helpers.volume_control(-2)
end, {
    description = "Lower volume",
    group = "Misc"
}), awful.key({}, "XF86AudioRaiseVolume", function()
    helpers.volume_control(2)
end, {
    description = "Raise volume",
    group = "Misc"
}), -- Music
awful.key({}, "XF86AudioPlay", function()
    awful.util.spawn(player_command .. " play-pause", false)
    -- playerctl:play_pause()
end, {
    description = "Toggle music",
    group = "Misc"
}), awful.key({}, "XF86AudioPrev", function()
    awful.util.spawn(player_command .. " previous", false)
    -- playerctl:previous()
end, {
    description = "Previous music",
    group = "Misc"
}), awful.key({}, "XF86AudioNext", function()
    awful.util.spawn(player_command .. " next", false)
    -- playerctl:next()
end, {
    description = "Next music",
    group = "Misc"
}), -- Screenshot
awful.key({super}, "/", function()
    awful.spawn.with_shell("screensht")
end, {
    description = "Take screenshot",
    group = "Misc"
}), awful.key({super}, "e", function()
    awful.util.spawn("rofimoji", false)
end, {
    description = "Emoji keyboard",
    group = "Misc"
}), awful.key({super}, "p", function()
    awful.util.spawn("bwmenu", false)
end, {
    description = "bitwarden cli",
    group = "Misc"
}), awful.key({}, "Print", function()
    awful.util.spawn("flameshot gui", false)
end), -- Window switcher
awful.key({}, "Pause", function()
    toggleMute()
end), -- Window switcher
awful.key({super}, ".", function()
    machi.default_editor.start_interactive()
end, {
    description = "edit the current layout if it is a machi layout",
    group = "layout"
}), awful.key({super}, "/", function()
    machi.switcher.start(client.focus)
end, {
    description = "switch between windows for a machi layout",
    group = "layout"
}), awful.key({super}, "Tab", function()
    awesome.emit_signal("bling::window_switcher::turn_on")
end, {
    description = "Window switcher",
    group = "Misc"
})})

-- Client key bindings
------------------------

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({ -- Move or swap by direction
    awful.key({super, shift}, "k", function(c)
        helpers.move_client(c, "up")
    end), awful.key({super, shift}, "h", function(c)
        helpers.move_client(c, "left")
    end), awful.key({super, shift}, "j", function(c)
        helpers.move_client(c, "down")
    end), awful.key({super, shift}, "l", function(c)
        helpers.move_client(c, "right")
    end), -- Relative move client
    awful.key({super, shift, ctrl}, "j", function(c)
        c:relative_move(0, dpi(20), 0, 0)
    end), awful.key({super, shift, ctrl}, "k", function(c)
        c:relative_move(0, dpi(-20), 0, 0)
    end), awful.key({super, shift, ctrl}, "h", function(c)
        c:relative_move(dpi(-20), 0, 0, 0)
    end), awful.key({super, shift, ctrl}, "l", function(c)
        c:relative_move(dpi(20), 0, 0, 0)
    end), -- Toggle floating
    awful.key({super, ctrl}, " ", awful.client.floating.toggle),

    awful.key({}, "XF86LaunchA", awful.client.floating.toggle), -- Toggle fullscreen
    awful.key({super}, "r", function()
        client.focus.fullscreen = not client.focus.fullscreen
        client.focus:raise()
    end), -- Toggle maximize
    awful.key({super}, "m", function()
        client.focus.maximized = not client.focus.maximized
    end), -- Minimize windows
    awful.key({super}, "n", function()
        client.focus.minimized = true
    end), -- Keep on top
    awful.key({super}, "t", function(c)
        c.ontop = not c.ontop
    end), -- Close window
    awful.key({super}, "q", function()
        client.focus:kill()
    end), -- Center window
    awful.key({super}, "c", function()
        awful.placement.centered(c, {
            honor_workarea = true,
            honor_padding = true
        })
    end)})
end)

-- Move through workspaces
----------------------------
awful.key.keygroups.home_left = {{"a", 1}, {"s", 2}, {"d", 3}, {"f", 4}, {"g", 5}}

awful.keyboard.append_global_keybindings({awful.key {
    modifiers = {super},
    keygroup = "home_left",
    description = "Only view tag",
    group = "Tag",
    on_press = function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
            tag:view_only()
        end
    end
}, awful.key {
    modifiers = {super, ctrl},
    keygroup = "home_left",
    description = "Toggle tag",
    group = "Tag",
    on_press = function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end
}, awful.key {
    modifiers = {super, shift},
    keygroup = "home_left",
    description = "Move focused client to tag",
    group = "Tag",
    on_press = function(index)
        if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end
}})

-- Mouse bindings on desktop
------------------------------

awful.mouse.append_global_mousebindings({ -- Left click
awful.button({}, 1, function()
    naughty.destroy_all_notifications()
    if mymainmenu then
        mymainmenu:hide()
    end
end), -- Right click
awful.button({}, 3, function()
    mymainmenu:toggle()
end), -- Side key
awful.button({}, 8, awful.tag.viewprev), awful.button({}, 9, awful.tag.viewnext)})

-- Mouse buttons on the client
--------------------------------

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({awful.button({}, 1, function(c)
        c:activate{
            context = "mouse_click"
        }
    end), awful.button({super}, 1, function(c)
        c:activate{
            context = "mouse_click",
            action = "mouse_move"
        }
    end), awful.button({super}, 2, function(c)
        c:activate{
            context = "mouse_click",
            action = "toggle_minimization"
        }
    end), awful.button({super}, 3, function(c)
        c:activate{
            context = "mouse_click",
            action = "mouse_resize"
        }
    end)})
end)

