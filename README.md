automatic lua property tables
-----------------------------

[![Build Status](https://travis-ci.org/d-led/automatic-lua-property-tables.svg?branch=master)](https://travis-ci.org/d-led/automatic-lua-property-tables)

a little excercise

```lua
local autoprop = assert( require 'autoprop' )

local config = autoprop()

config.some.url = 'http://olivinelabs.com/busted'
config.some.number = 42
config.some.other.url = 'https://github.com/nrother/dynamiclua'

print(config.some.url, config.some.number, config.some.other.url)
```
&darr;
```
http://olivinelabs.com/busted       42      https://github.com/nrother/dynamiclua
```


to be refactored ...
