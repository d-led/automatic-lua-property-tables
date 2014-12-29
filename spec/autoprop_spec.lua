package.path = './?.lua;'..package.path
local autoprop = require 'autoprop'

it("fresh tables do not contain metatables", function()
  assert.is.falsy(getmetatable {})
end)

describe("a utility for creating property paths automatically",function()
	it("should be a module as a table",function()
		assert.True(type(autoprop)=='table')
	end)
end)
