# t.number.abbrev: lua number abbreviations for `t` lib
Defined abbreviation schemes.

## install
```bash
luarocks install --dev t-number-abbrev
```

## define abbreviations
```lua
local brev = t.number.abbrev

local dollar = brev(
{
  scale=1000,               -- abbrev step multiplier: 1, 1000, 1000^2, ...
  prefix='$',               -- tostring prefix
  precision=0,              -- use for keeping integer minimal units
  decimals=1,               -- display 1 decimal __tostring higher units
},
  {'Million', 'm', ''},     -- minimal unit: '1m' means '1', '1' means '1m'
                            -- 'Million' is default tostring output name
                            -- 'm' and other parsing aliases are case-insensitive
                            -- '' empty token auto defined for first unit by default

  {'b', 'Billion'},         -- second unit: '1b' beans '1000', '1000' means '1b'
  {'t', 'Trillion'},        -- everything larger shall use 't': '87255715351 Trillion'
}

local mem = brev({
  scale=1024                -- standard for memory size; could be 4kb blocks for example
}, 'b', {'KB','kb'},        -- using lowercased literal 'b' for 1 byte abbrev
  {'MB','mb'}, {'GB','gb'}, -- uppercased literals for tostring
  {'TB','tb', ''})          -- redefine mem(20)/mem('20') to be mem('20tb') by default


local ruble = brev({
  prefix='₽',               -- use default scale and precision
  decimals=1                -- but show 1 decimal
},
{'млн', 'миллион', 'mln'},  -- mixing is ok
{'млрд', 'миллиард'},
{'трлн', 'триллион'})
```

## some examples
```lua
dollar('$671 million')                                -- equivalent definitions
dollar(671)
dollar('671')
dollar({671})
dollar(setmetatable({},{__tostring=function(self) return '671' end}))
dollar(setmetatable({},{__tonumber=function(self) return 671 end}))

dollar('$671 million')-dollar(371)==dollar(300)       -- arithmetics are ok
mem('2tb') * 8 == mem('16tb')                         -- accept as much as possible

tostring(ruble('₽2800млн')) == '₽2.8млрд'             -- utf8 is ok
tostring(ruble('₽2.8 billion')) == '₽2.8млрд'         -- mixing is ok
```
More examples in `spec`.

## options
- `scale`: each abbreviation level multiplied on scale (default: `1000`)
- `prefix`: add before string (default: `empty`)
- `precision`: kept for minimal abbrev (default `0`)
- `decimals`: display #n decimals for larger abbrevs (default `1`)
- `abbrev list`: could be string (for fixed name) or table (for nameset)
  - empty name to define explicitly
  - first table key is used for tostring by default
  - `utf8` names supported
  - case-insensitive parsing

## operations and conventions
- all 5.1 operators accepted
- arithmetic operators accept convertable types as well
  - numbers, strings
  - table container with number or string
  - tables/userdata with mt methods `__tonumber` or `__tostring`

## depends luarocks
- `t`
- `t-utf8`
