local region = require(string.gsub(..., "[\\.]%w+$", "") .. ".region")

local class = {
  min = 0,
  max = 10,
  step = 1
}

class.__index = class
setmetatable(class, region)

function class:new(...)
  local instance = region.new(self, ...)
  instance.dragging = false
  return instance
end

function class:mousepressed(x, y, button)
  if self.set and button == "l" and self:within_region(x, y) then
    self.dragging = true
    self:mousemoved(x, y)
    return true
  end
end

function class:mousereleased(x, y, button)
  if self.dragging and button == "l" then
    self.dragging = false
    return true
  end
end

function class:mousemoved(x, y)
  if self.dragging then
    local x = math.max(0, math.min(1, (x - self.x) / self.width))
    local value = self.min + x * (self.max - self.min)

    if self.step then
      value = math.floor(value / self.step + 0.5) * self.step
    end

    self.set(value)
    return true
  end
end

function class:draw()
  local x = self.x + self.width * ((self.get() - self.min) / (self.max - self.min))
  local y = self.y + self.height / 2

  love.graphics.setColor(0, 0, 0, 127)
  love.graphics.setLineWidth(2)
  love.graphics.line(
    love.window.toPixels(self.x),
    love.window.toPixels(y),
    love.window.toPixels(self.x + self.width, y))

  love.graphics.setColor(75, 175, 255)
  love.graphics.circle("fill",
    love.window.toPixels(x),
    love.window.toPixels(y),
    love.window.toPixels(self.height, self.height * 2))
end

return class
