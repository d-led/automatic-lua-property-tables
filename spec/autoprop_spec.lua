package.path = './?.lua;'..package.path
local autoprop = require 'autoprop'

it("fresh tables do not contain metatables", function()
  assert.is.falsy(getmetatable {})
end)

describe("a utility for creating property paths automatically",function()
	it("should be a module as a table",function()
		assert.True(type(autoprop)=='table')
	end)

	it("should be empty on creation",function( )
		assert.True(type(autoprop.create()) == 'table')
		assert.are_equal(0,#autoprop.create())
	end)

	it("should be able to create properties automatically",function()
		local t = autoprop.create()
		assert.has_no.errors(function()
			t.first_level_fresh.second_level_value = 42
		end)
		assert.are_equal(42,t.first_level_fresh.second_level_value)
	end)

	it("raises an error if a non-table value is accessed as table",function()
		local t = autoprop.create()
		t.first_level_fresh.second_level_value = 42
		assert.has.error(function()
			t.first_level_fresh.second_level_value.third_level_illegal = 42
		end)
	end)

	it("should replace the behavior of all tables passed to it",function()
		local t = autoprop.create()
		t.a = {}
		assert.has_no.errors(function()
			t.a.b.c = 42
		end)
		assert.are_equal(42,t.a.b.c)
	end)
end)

describe("example",function()
	it ("should be clear from an example",function()

		local config = autoprop() -- callable table
		config.some.url = 'http://olivinelabs.com/busted'
		config.some.number = 42
		config.some.other.url = 'https://github.com/nrother/dynamiclua'

		print(config.some.url, config.some.number, config.some.other.url)
	end)
end)
