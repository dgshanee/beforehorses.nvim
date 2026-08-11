---@tag BeforeHorses

-- Module definition ==========================================================
local BeforeHorses = {}
local H = {}

-- Module setup
--
--@param config table|nil Module config table. See |BeforeHorses.config|
--
--@usage >lua
--  require('beforehorses').setup() -- use default config
--  -- OR
--  require('beforehorses').setup({}) -- replace {} with your config table
BeforeHorses.setup = function(config)
	-- Export module
	_G.BeforeHorses = BeforeHorses

	-- Setup config
	config = H.setup_config(config)

	-- Apply config
	H.apply_config(config)
end

--- Defaults ~
---@text # Options ~
---
--- ## Search directory ~
---
--- `options.search_directory` is where beforehorses looks for project templates.
--- Each project template should be a directory at the root of `options.search_directory`
--- or it is rendered invalid.
BeforeHorses.config = {
	options = {
		search_directory = "$HOME/.config/beforehorses",
	},
}

H.command_callback = function()
	print(H.config)
end
vim.api.nvim_create_user_command("BeforeHorses", H.command_callback, {})

-- Helper data ================================================================
-- Module default config
H.default_config = vim.deepcopy(BeforeHorses.config)

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.check_type = function(name, val, ref, allow_nil)
	if type(val) == ref or (ref == "callable" and vim.is_callable(val)) or (allow_nil and val == nil) then
		return
	end
	H.error(string.format("`%s` should be %s, not %s", name, ref, type(val)))
end

H.setup_config = function(config)
	H.check_type("config", config, "table", true)
	config = vim.tbl_deep_extend("force", vim.deepcopy(H.default_config), config or {})
	return config
end

H.apply_config = function(config)
	BeforeHorses.config = config
end

return BeforeHorses
