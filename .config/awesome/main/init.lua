-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Bling
local bling = require("lib.bling")
bling.module.flash_focus.enable()

local machi = require("lib.layout-machi")
beautiful.layout_machi = machi.get_icon()

-- Desktop
------------

-- Layouts
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({awful.layout.suit.tile, awful.layout.suit.fair, machi.default_layout})
end)

-- Tags
screen.connect_signal("request::desktop_decoration", function(s)

    -- Tag layouts
    local taglayouts = {awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile, awful.layout.suit.tile,
                        awful.layout.suit.tile}

    -- Tag names
    local tagnames = {"1", "2", "3", "4", "5"}

    -- Each screen has its own tag table.
    awful.tag(tagnames, s, taglayouts)

end)

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)
end)

-- Stuff
----------

require("main.keys")
require("main.ruled")
require("main.menu")
require("main.extras")

