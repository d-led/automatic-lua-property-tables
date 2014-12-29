package.path = './?.lua;'..package.path
local autoprop = require 'autoprop'

it("fresh tables do not contain metatables", function()
  assert.is.falsy(getmetatable {})
end)

describe("a utility for creating property paths automatically",function()
	it("should be a module as a table",function()
		assert.True(type(autoprop)=='table')
	end)

	it("should create an empty table",function( )
		assert.True(type(autoprop.create()) == 'table')
		assert.are_equal(0,#autoprop.create())
	end)

	it("should be able to create properties automatically",function ( )
		local t = autoprop.create()
		assert.has_no.errors(function()
			t.first_level_fresh.second_level_value = {}--42 
		end)
	end)
end)
