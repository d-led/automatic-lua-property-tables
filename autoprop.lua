local autoprop = {}

autoprop.create = function(tracer)
	local meta = {}

	local function trace(...)
		if type(tracer)=='function' then
			tracer(...)
		end
	end

	local function set_metatable_of_all_values(t)
		local seen = {}
		local stack = { t }
		while #stack > 0 do
			local candidate = stack[#stack]
			stack[#stack] = nil
			if not seen[candidate] and type(candidate)==type{} then
				setmetatable(candidate,meta)
				seen[#seen+1] = candidate

				for _,v in pairs(candidate) do
					stack[#stack+1] = v
				end
			end
		end
	end

	------------ on access: t.unknown_key
	meta.__index = function ( table, key )
		local value = rawget(table, key)

		if value == nil then
			-- create a new table entry
			local res = {}
			setmetatable(res,meta)
			trace('__index',table,key,res)
			rawset(table,key,res)
			return res
		end

		return value
	end

	--------------- on assignment: t.some_key = value
	meta.__newindex = function ( table, key, value )

		if type(value) == 'table' then
			set_metatable_of_all_values(value)
		end

		trace('__newindex',table,key,value)
		rawset(table,key,value)
		return value
	end	

	local result = {}
	setmetatable(result,meta)
	return result
end

setmetatable(autoprop,{
	__call = function()
		return autoprop.create()
	end	
})

return autoprop
