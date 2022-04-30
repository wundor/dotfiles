-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Signals
------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set every new window as a slave,
    if not awesome.startup then
        awful.client.setslave(c)
    end

    -- Add missing icon to client
    if not c.icon then
        local icon = gears.surface(beautiful.default_icon)
        c.icon = icon._native
        icon:finish()
    end
end)

-- Fixes wrong geometry when titlebars are enabled in fullscreen
client.connect_signal("manage", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

local function move_mouse_onto_focused_client(c)
    if mouse.object_under_pointer() ~= c and not client.floating then
        local geometry = c:geometry()
        local x = geometry.x + geometry.width / 2
        local y = geometry.y + geometry.height / 2
        mouse.coords({
            x = x,
            y = y
        }, true)
    end
end

-- Raise focused clients automatically
client.connect_signal("focus", function(c)
    c:raise()
    move_mouse_onto_focused_client(c)
end)

client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- make rofi possible to raise minimized clients
client.connect_signal("request::activate", function(c, context, hints)
    if c.minimized then
        c.minimized = false
    end
    awful.ewmh.activate(c, context, hints)
end)

-- Restore geometry for floating clients
------------------------------------------

tag.connect_signal('property::layout', function(t)
    for k, c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = awful.client.property.get(c, 'floating_geometry')
            if cgeo then
                c:geometry(awful.client.property.get(c, 'floating_geometry'))
            end
        end
    end
end)

client.connect_signal('manage', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)

client.connect_signal('property::geometry', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)

