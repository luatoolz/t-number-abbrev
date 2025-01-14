local t = require "t"
local pkg = t.pkg(...)
local is, mt, utf8 = t.is, t.mt, t.utf8
local grade, num = pkg.grade, pkg.num

local this = {}
return setmetatable(this, {
__call = function(self, it, ...)
  if rawequal(self, this) then
    it=it or {}
    it.scale = it.scale or 1000
    return mt({}, getmetatable(num),
      {__brev=setmetatable(it, getmetatable(self)) .. {...}})
  elseif type(it)=='number' then
    it=math.abs(it)
    local scale = self.scale
    local pow = it>scale and math.ceil(math.log(it)/math.log(scale)) or 1
    return self[pow], pow
  end
end,
__concat = function(self, brevs)
  if rawequal(self, this) then return self end
  for i,b in ipairs(brevs) do self[i]=b end
  return self
end,
__index = function(self, x)
  if rawequal(self, this) then return rawget(self, x) or mt.loader(self, x) end
  if type(x)=='number' and is.natural(x) then return rawget(self, x>#self and #self or x) end
  if type(x)=='string' then return rawget(self, x) or rawget(self, utf8.lower(x)) end
end,
__newindex = function(self, k, v)
  if rawequal(self, this) then return nil end
  if type(k)=='number' and is.natural(k) then
    local name = type(v)=='table' and v[1] or v
    local g = grade({scale=self.scale, name=name, power=k-1})
    rawset(self, k, g)
    rawset(self, utf8.lower(name), g)
    if type(v)=='table' then
      for i=2,#v do rawset(self, utf8.lower(v[i]), g) end
    end
  end
end,
})