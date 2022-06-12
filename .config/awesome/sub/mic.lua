local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

mic_widget = wibox.widget.textbox()
mic_widget.align = "center"
mic_widget.valign = "center"

local home = os.getenv("HOME")
function toggleMute()
    awful.spawn.easy_async('python ' .. home .. '/.bin/mic-mute.py', function(stdout, stderr, exitreason, exitcode)
        local micStat = tonumber(stdout)
        if (micStat == 0) then
            mic_widget:set_text("🟩")
        else
            -- naughty.notify({ text = "OFF" })
            mic_widget:set_text("🟥")
        end
    end)
end
