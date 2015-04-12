-- {{{ Helper functions

function run_once(prg,arg_string,pname,screen)
	if not prg then
		do return nil end
	end

	if not pname then
		pname = prg
	end

	if not arg_string then
		awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
	else
		awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
	end
end

function dbg(vars)
	local text = ""
	if type(vars) == "table" then
		for i=1, #vars do text = text .. vars[i] .. " | " end
	elseif type(vars) == "string" then
		text = vars
	end
	naughty.notify({ text = text, timeout = 0 })
end

function clean(string)
	s = string.gsub(string, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function file_exists(file)
	local cmd = "/bin/bash -c 'if [ -e " .. file .. " ]; then echo true; fi;'"
	local fh = io.popen(cmd)

	s = clean(fh:read('*a'))

	if s == 'true' then return true else return nil end
end

--% Find the path of an application, return nil of doesn't exist
----@ app (string) Text of the first parameter
----@ return string of app path, or nil (remember, only nil and false is false in lua)
function whereis_app(app)
	local fh = io.popen('which ' .. app)
	s = clean(fh:read('*a'))

	if s == "" then return nil else return s end
	return s
end

function require_safe(lib)
	if file_exists(awful.util.getdir("config") .. '/' .. lib ..'.lua') or
		file_exists(awful.util.getdir("config") .. '/' .. lib) then
			require(lib)
	end
end

-----------------------
-- change background --
-----------------------
function change_bg()
  if whereis_app('feh') then
    mytimer = timer { timeout = 0 }
    mytimer:connect_signal("timeout",
                           function()
                             -- tell awsetbg to randomly choose a wallpaper from your wallpaper directory
                             if file_exists(wallpaper_dir) then
                               os.execute(wallpaper_cmd)
                             end
                             -- stop the timer (we don't need multiple instances running at the same time)
                             mytimer:stop()
                             -- define the interval in which the next wallpaper change should occur in seconds
                             -- (in this case anytime between 10 and 20 minutes)
                             x = math.random(600, 1200)
                             --restart the timer
                             mytimer.timeout = x
                             mytimer:start()
    end)
    -- initial start when rc.lua is first run
    mytimer:start()
  end
end

-- }}}
