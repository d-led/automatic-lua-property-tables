local autoprop = {}

autoprop.create = function()
	local function get_metatable()
		local meta = {}
		return meta
	end

	local result = {}
	return result
end

return autoprop