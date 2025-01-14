local t = require "t"
local to, mt, utf8 = t.to, t.mt, t.utf8
local pkg = t.pkg(...)
local precision, number_format, round =
  pkg.precision,
  pkg.number_format,
  pkg.round

local this = {}
local mtf = {brev='__brev', __brev='__brev'}
return setmetatable(this, {
__call = function(self, it)
  if type(it)=='number' then
    return setmetatable({round(it, self.precision)}, getmetatable(self))
  end
  if type(it)=='table' then
    if rawequal(getmetatable(self), getmetatable(it)) then return it end
    if (not getmetatable(it)) and type(it[1])=='number' then return self(it[1]) end
    return self(to.number(it) or tostring(it))
  end
  if type(it)=='string' then
    local n, id = utf8.match(it, '(%-?%d+%.?%d*)%s*(%a*)%s*')
    return n and self((self[id] or 1)*tonumber(n))
  end
  return nil
end,
__index = function(self, x) return rawget(self, x) or mt(self)[mtf[x]] or self.brev[x] end,
__export = function(self) return to.number(self) end,
__tonumber = function(self) return self[1] end,
__tostring = function(self)
  local n = self[1]
  if n==0 then return '0' end
  local abbrev, power = self.brev(n)
  if abbrev and abbrev.value>1 then n=n/abbrev.value end

  local decimals = power==1 and (self.precision or 0) or self.decimals
  local fmt = number_format(precision(n, decimals))
  return string.format(fmt, self.prefix or '', n, abbrev)
end,
__add = function(a,b) return this(to.number(this(a))+to.number(this(b))) end,
__div = function(a,b) return this(to.number(this(a))/to.number(this(b))) end,
__eq = function(a,b) return to.number(this(a))==to.number(this(b)) end,
__le = function(a,b) return to.number(this(a))<=to.number(this(b)) end,
__lt = function(a,b) return to.number(this(a))<to.number(this(b)) end,
__mul = function(a,b) return this(to.number(this(a))*to.number(this(b))) end,
__mod = function(a,b) return this(to.number(this(a))%to.number(this(b))) end,
__pow = function(a,b) return this(to.number(this(a))^to.number(this(b))) end,
__sub = function(a,b) return this(to.number(this(a))-to.number(this(b))) end,
__unm = function(self) return self(-self[1]) end,
})