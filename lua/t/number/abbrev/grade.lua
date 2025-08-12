local t = require 't'
local save = table.save

local this = {}
return setmetatable(this, {
__call = function(self, it)
  if it.scale and it.name and it.power then
    return setmetatable(it, getmetatable(self))
  end
end,
__mul = function(self, x) return x and (self.value or 1)*x end,
__index = function(self, k) return k=='value' and save(self, k, self.scale^self.power) end,
__tostring = function(self) return self.name end,
__tonumber = function(self) return self.value end,
})