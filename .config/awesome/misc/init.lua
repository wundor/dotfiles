-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget library
local wibox = require("wibox")

-- Bling
local bling = require("lib.bling")

-- rubato (animations)
local rubato = require("lib.rubato")

-- Helpers
local helpers = require("helpers")

-- Task Preview
----------------

bling.widget.task_preview.enable {
    -- x = 20,
    -- y = 20,
    height = dpi(150),
    width = dpi(220),
    placement_fn = function(c)
        awful.placement.top_left(c, {
            margins = {
                top = beautiful.useless_gap,
                left = beautiful.wibar_width + beautiful.useless_gap
            }
        })
    end
}

-- Window switcher
--------------------

bling.widget.window_switcher.enable {
    type = "thumbnail",

    hide_window_switcher_key = "Escape",
    minimize_key = "n",
    unminimize_key = "N",
    kill_client_key = "q",
    cycle_key = "Tab",
    previous_key = "Right",
    next_key = "Left",
    vim_previous_key = "l",
    vim_next_key = "h"
}

-- Scratchpad
---------------

local anim_y = rubato.timed {
    pos = -1090,
    rate = 120,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true -- this option must be set to true.
}

local anim_x = rubato.timed {
    pos = 1530,
    rate = 120,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true -- this option must be set to true.
}

local kitty_scratch = bling.module.scratchpad:new{
    command = "kitty --class scratchkitty",
    rule = {
        instance = "scratchkitty"
    },
    sticky = false,
    autoclose = true,
    floating = true,
    geometry = {
        x = 345,
        y = 95,
        height = 768,
        width = 1024
    },
    reapply = true,
    dont_focus_before_close = false,
    rubato = {
        -- x = anim_x,
        y = anim_y
    }
}

-- Signals
------------

awesome.connect_signal("scratch::kitty", function()
    kitty_scratch:toggle()
end)

-- Stuff
----------

require("misc.ping")
require("misc.bar")
require("misc.titlebar")
require("misc.tooltip")
require("misc.pop")
require("misc.deco")
require("misc.fake")

