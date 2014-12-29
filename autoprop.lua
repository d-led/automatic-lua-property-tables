local autoprop = {}

autoprop.create = function()
	local meta = {}

	------------
	meta.__index = function ( table, key )
		local value = rawget(table, key)
		if value == nil then
			local res = {}
			setmetatable(res,meta)
			rawset(table,key,res)
			print("new:",key,res)
			return res
		end
		if type(value) == 'table' then
			setmetatable(value,meta)
		end

		return value
		-- error(table,key..' is already taken ('..type(value)..')')
	end

	---------------
	meta.__newindex = function ( table, key, value )
		print("new_:",key,value)
		if type(value) == 'table' then
			setmetatable(value,meta)
		end

		rawset(table,key,value)
		return value
	end

	local result = {}
	setmetatable(result,meta)
	return result
end

return autoprop