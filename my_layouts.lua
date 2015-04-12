function make_layouts()
  return {
    awful.layout.suit.max,
    awful.layout.suit.spiral,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen
  }
end

function make_tags(layouts)
  local max       = 1
  local spiral    = 2
  local float     = 3
  local bottom    = 4
  tags = {
    names  = { "☆", "✍", "☁", "✐", "♪", '✆', '✇', '☺', '✉' },
    layout = {
      layouts[max],       -- 1
      layouts[spiral],    -- 2
      layouts[bottom],    -- 3
      layouts[max],       -- 4
      layouts[float],     -- 5
      layouts[max],       -- 6
      layouts[max],       -- 7
      layouts[max],       -- 8
      layouts[max]        -- 9
  }}

  for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
  end
  return tags
end

function make_rules(tags)
  awful.rules.rules = {
    { rule = { },
      properties = {
        focus = true,      size_hints_honor = false,
        keys = clientkeys, buttons = clientbuttons,
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal }
    },
    { rule = { class = "xterm" },
      properties = { opacity = 0.75 } },
    { rule = { class = "Emacs" },
      properties = { tag = tags[1][2]} },
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][3], opacity = 1.0 } },
    { rule = { class = "Gimp" },
      properties = { tag = tags[1][4], floating = true} },
    { rule = { class = "Mplayer" },
      properties = { tag = tags[1][5], floating = true} },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Skype" },
      properties = { tag = tags[1][6], floating = true, opacity = 0.7 } },
    { rule = { class = "ROX-Filer" },   properties = { floating = true } },
    { rule = { class = "Chromium-browser" },   properties = { floating = false } },
    { rule = { class = "Google-chrome" },   properties = { floating = false } },
  }
  return awful.rules.rules
end
