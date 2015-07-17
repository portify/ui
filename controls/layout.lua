local region = require((...):gsub("[\\.]%w+$", "") .. ".region")

local class = {}
class.__index = class
setmetatable(class, region)

function class:new(t, ...)
  local instance = setmetatable(t or {}, self)
  instance:reflow()
  return instance
end

function class:add_child(control)
  region.add_child(self, control)
  self:reflow()
end

function class:remove_child(control)
  if region.remove_child(self, control) then
    self:reflow()
    return true
  end

  return false
end

function class:reflow()
end

return class
