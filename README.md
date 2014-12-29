automatic lua property tables
-----------------------------

a little excercise

```lua
local autoprop = assert( require 'autoprop' )

local config = autoprop.create()

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
