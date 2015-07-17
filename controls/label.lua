local region = require((...):gsub("[\\.]%w+$", "") .. ".region")

local class = {
  content = "",
  justify = "left",
  color = {0, 0, 0}
}

class.__index = class
setmetatable(class, region)

function class:draw()
  local x, y, width, height = love.graphics.getScissor()

  -- love.graphics.setScissor(
  --   x + love.window.toPixels(self.x),
  --   y + love.window.toPixels(self.y),
  --   love.window.toPixels(self.width, self.height)
  -- )

  local value = self.value

  if type(self.value) == "function" then
    value = value()
  end

  love.graphics.setColor(self.color)
  love.graphics.printf(tostring(value),
    love.window.toPixels(self.x),
    love.window.toPixels(self.y),
    love.window.toPixels(self.width),
    self.justify)
  -- love.graphics.setScissor(x, y, width, height)
end

return class
