local bh = {}

if not fs.exists("gui/ext/button.lua") then
  return {}
end
local button = require("gui.ext.button")
local expect = require("cc.expect").expect

--- Create a button that just queues an event.
-- @tparam number x X coordinate of the button.
-- @tparam number y Y coordinate of the button.
-- @tparam number w Width of the button.
-- @tparam number h Heigth of the button.
-- @tparam string|nil name Name of the event queued, defaults to `"button_click"`.
-- @treturn string ID of the button, use it in `gui.ext.button` functions
function bh.eventButton(x,y,w,h,name)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,w,"number")
  expect(4,h,"number")
  expect(5,name,"string","nil")
  name = name or "button_click"
  local function func(x,y)
    os.queueEvent(name,x,y)
  end
  return button.new(x,y,w,h,func)
end

return bh