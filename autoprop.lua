local autoprop = {}

autoprop.create = function(tracer)
	local meta = {}

	local function trace(...)
		if type(tracer)=='function' then
			tracer(...)
		end
	end

	------------
	meta.__index = function ( table, key )
		local value = rawget(table, key)
		if value == nil then
			local res = {}
			setmetatable(res,meta)
			trace('__index',table,key,res)
			rawset(table,key,res)
			return res
		end
		if type(value) == 'table' then
			setmetatable(value,meta)
		end

		return value
	end

	---------------
	meta.__newindex = function ( table, key, value )
		if type(value) == 'table' then
			setmetatable(value,meta)
		end
		trace('__newindex',table,key,value)
		rawset(table,key,value)
		return value
	end

	local result = {}
	setmetatable(result,meta)
	return result
end

return autoprop
