require 't'
return function(x, max)
  if (not x) or (not max) or max==0 then return nil end
  local rv = string.format('%.' .. tostring(max) .. 'f', x)
  local matched = rv:gsub('0*$',''):gsub('^.*%.',''):null()
  return matched and #matched
end