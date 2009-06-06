-- author: Ole Jørgen Brønner (olejorgenb@yahoo.no)

local warp_hook = ioncore.get_hook("region_do_warp_alt")

-- protect against file reloads
if warp_hook:listed(warp_hook_fn) then
	warp_hook:remove(warp_hook_fn)
	io.stderr:write("removed warp_hook\n")
end

local function absolute_geom(reg)
	if reg:parent() then
		local g = reg:geom()
		local absolute_parent_g = absolute_geom(reg:parent())
		return { x = g.x + absolute_parent_g.x, y = g.y + absolute_parent_g.y }
	else
		return { x = 0, y = 0 }
	end
end

-- Needs to be global for the reload "trick" to work.
-- Although it doesn't seem like region_do_warp_alt allows multiple hook
-- functions?
function warp_hook_fn(reg)
	local g = table.join(absolute_geom(reg), reg:geom())
	local x = g.x + g.w/2;
	local y = g.y + g.h/2;

--	debug.print_line("warp, regname: "..reg:name())
--	debug.print_line("warp, x = "..x..", y = "..y)

	-- warp pointer to center:
	-- AFAIK, this functionality is not exposed to lua, so we use
	-- an external program.
	-- 'swarp' comes from dwm-tools in debian.
	-- (http://tools.suckless.org/swarphttp://tools.suckless.org/swarp)
	os.execute("swarp "..x.." "..y)
	return true;
end

warp_hook:add(warp_hook_fn)

