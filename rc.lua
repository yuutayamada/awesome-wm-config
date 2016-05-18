awful = require("awful")
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
naughty = require("naughty")
beautiful = require("beautiful")
wibox = require("wibox")

-- User libraries
local vicious = require("vicious") -- ./vicious
-- Allow run_once, requrie_safe
local helpers = require("helpers") -- helpers.lua

terminal = whereis_app('urxvtc') and 'urxvtc' or whereis_app('xterm') and 'xterm'

mytag = require('my_layouts')

layouts = make_layouts()
tags = make_tags(layouts)
require('awesome_default')

-- Autostart script
run_once("nm-applet") -- networking
run_once("xsetroot", "-cursor_name left_ptr")  -- sets the cursor icon
run_once("redshift", "-o -l 0:0 -b 0.8 -t 6500:6500") -- brightness

-- Start XTerm automatically
run_once("xrdb", "-merge $XDG_CONFIG_HOME/X11/URxvt")
run_once("urxvtd", "-q -o -f && urxvtc")
-- f.lux
run_once("fluxgui")
