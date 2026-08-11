---@tag BeforeHorses

-- Module definition ==========================================

local BeforeHorses = {}
local H = {}

BeforeHorses.setup = function(config)
	-- Export module
	_G.BeforeHorses = BeforeHorses

	config = H.setup_config(config)

	H.apply_config(config)
end

BeforeHorses.config = {}

H.command_callback = function()
	print(H.config)
end

vim.api.nvim_create_user_command("BeforeHorses", H.command_callback, {})

H.check_type = function(name, val, ref, allow_nil)
	if type(val) == ref or (ref == "callable" and vim.is_callable(val)) or (allow_nil and val == nil) then
		return
	end
	H.error(string.format("`%s` should be %s, not %s", name, ref, type(val)))
end

H.default_config = vim.deepcopy(BeforeHorses.config)

H.setup_config = function(config)
	H.check_type("config", config, "table", true)
	config = vim.tbl_deep_extend("force", vim.deepcopy(H.default_config), config or {})
	return config
end

H.apply_config = function(config)
	BeforeHorses.config = config
end

return BeforeHorses
