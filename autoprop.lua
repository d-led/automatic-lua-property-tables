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
