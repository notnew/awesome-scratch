local client = client
local awful = require("awful")
local util = require("awful.util")

local scratch = {}
local defaultRule = {instance = "scratch"}

function scratch.raise(cmd, rule)
    local rule = rule or defaultRule
    local function matcher(c) return awful.rules.match(c, rule) end

    -- logic mostly copied form awful.client.run_or_raise, except we don't want
    -- to change to or merge with scratchpad tag, just show the window
    local clients = client.get()
    local findex  = util.table.hasitem(clients, client.focus) or 1
    local start   = util.cycle(#clients, findex + 1)

    for c in awful.client.iterate(matcher, start) do
        c.sticky = true
        c:raise()
        -- end
        client.focus = c
        return
    end

    -- client not found, spawn it
    util.spawn(cmd)
end

function scratch.toggle(cmd, rule, alwaysclose)
    local rule = rule or defaultRule
    if client.focus and awful.rules.match(client.focus, rule) then
       local scratchWin = client.focus
       awful.client.focus.history.previous()
       scratchWin.sticky = false
    elseif client.focus and awful.rules.match(client.focus, defaultRule) then
        if alwaysclose then
            local scratchWin = client.focus
            awful.client.focus.history.previous()
            scratchWin.sticky = false
        else
            client.focus.sticky = false
            scratch.raise(cmd, rule)
        end
    else
        scratch.raise(cmd, rule)
    end
end

return scratch
