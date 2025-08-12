require 't'
return function(it, decimals)
  if (not decimals) then return math.round(it) end
  local multiplier = 10 ^ decimals
  local left = it%1
  local int = it-left
  return int + math.round(left * multiplier) / multiplier
end