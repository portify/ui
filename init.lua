return setmetatable({
  region = require(... .. ".controls.region"),
  rowlist = require(... .. ".controls.rowlist"),
  swatch = require(... .. ".controls.swatch"),
  slider = require(... .. ".controls.slider"),
  label = require(... .. ".controls.label"),
}, {
  __call = function(t, name)
    return function(...)
      t[name]:new(...)
    end
  end
})
