local control = require(string.gsub(..., "[\\.]%w+$", "") .. ".control")

local class = {
  x = 0, y = 0,
  width = 0, height = 0,
  scissor = false
}

class.__index = class
setmetatable(class, control)

function class:within_region(x, y)
  return
    x >= self.x and x < self.x + self.width and
    y >= self.y and y < self.y + self.height
end

function class:mousepressed(x, y, button)
  if self:within_region(x, y) then
    for i=#self, 1, -1 do
      if self[i]:mousepressed(x - self.x, y - self.y, button) then
        return true
      end
    end
  end

  return false
end

function class:mousereleased(x, y, button)
  if self:within_region(x, y) then
    for i=#self, 1, -1 do
      if self[i]:mousereleased(x - self.x, y - self.y, button) then
        return true
      end
    end
  end

  return false
end

function class:mousemoved(x, y)
  if self:within_region(x, y) then
    for i=#self, 1, -1 do
      if self[i]:mousemoved(x - self.x, y - self.y) then
        return true
      end
    end
  end

  return false
end

function class:draw()
  local x, y, width, height = love.graphics.getScissor()

  if self.scissor then
    love.graphics.setScissor(
      love.window.toPixels(self.x),
      love.window.toPixels(self.y),
      love.window.toPixels(self.width, self.height)
    )
  end

  love.graphics.push()
  love.graphics.translate(love.window.toPixels(self.x, self.y))

  for i, control in ipairs(self) do
    control:draw()
  end

  love.graphics.pop()

  if self.scissor then
    love.graphics.setScissor(x, y, width, height)
  end
end

return class
