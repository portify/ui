local layout = require((...):gsub("[\\.]%w+$", "") .. ".layout")

local class = {
  padding = 0,
  spacing = 0,
  span = true,
  auto_height = true
}

class.__index = class
setmetatable(class, layout)

function class:reflow()
  local y = self.padding

  for i, control in ipairs(self) do
    if self.span then
      control.width = self.width - self.padding * 2
    end

    if control.reflow then
      control:reflow()
    end

    if self.span then
      control.x = self.padding
    end

    control.y = y
    y = y + control.height + self.spacing
  end

  if self.auto_height then
    rawset(self, "_height", y - self.spacing + self.padding)
  end
end

return class
