local class = {}
class.__index = class

function class:new(t)
  return setmetatable(t or {}, self)
end

function class:add_child(control)
  table.insert(self, control)
end

function class:remove_child(control)
  for i, other in ipairs(self) do
    if other == control then
      table.remove(self, i)
      return true
    end
  end

  return false
end

local function create_bubbler(name)
  return function(self, ...)
    for i=#self, 1, -1 do
      if self[i][name](self[i], ...) then
        return true
      end
    end

    return false
  end
end

class.mousepressed = create_bubbler("mousepressed")
class.mousereleased = create_bubbler("mousereleased")
class.mousemoved = create_bubbler("mousemoved")
class.keypressed = create_bubbler("keypressed")
class.keyreleased = create_bubbler("keyreleased")
class.textinput = create_bubbler("textinput")

function class:update(dt)
  for i, control in ipairs(self) do
    control:update(dt)
  end
end

function class:draw()
  for i, control in ipairs(self) do
    control:draw()
  end
end

return class
