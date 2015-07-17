local region = require(string.gsub(..., "[\\.]%w+$", "") .. ".region")

local class = {
  color = {255, 0, 0, 255}
}

class.__index = class
setmetatable(class, region)

function class:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill",
    love.window.toPixels(self.x),
    love.window.toPixels(self.y),
    love.window.toPixels(self.width, self.height)
  )

  region.draw(self)
end

return class

-- return setmetatable({}, {
--   __call = function(t, ...) return class:new(...) end,
-- })
