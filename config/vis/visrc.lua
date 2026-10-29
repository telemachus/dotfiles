-- load standard vis module, providing parts of the Lua API
require("vis")

-- Configure cursor shapes for different modes
vis.cursor_shapes = {
	[vis.modes.NORMAL] = 2, -- steady block
	[vis.modes.INSERT] = 3, -- blinking underline
	[vis.modes.REPLACE] = 3, -- blinking underline
	[vis.modes.VISUAL] = 2, -- steady block
	[vis.modes.VISUAL_LINE] = 2, -- steady block
}

vis.events.subscribe(vis.events.INIT, function()
	vis:command("set escdelay 0")
	vis:command("set autoindent on")
	vis:command("set theme minimum")
end)

-- Reset cursor shape to terminal default on exit
vis.events.subscribe(vis.events.QUIT, function()
	-- Only reset if we were using cursor shapes
	if vis.ui.cursor_shape and vis.ui.cursor_shape >= 0 then
		vis.ui:set_cursor_shape(0)
	end
end)
