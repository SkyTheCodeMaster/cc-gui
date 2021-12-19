--- Provides functions for window objects
-- @module[kind=gui]
local w = {}

local expect = require("cc.expect").expect

local function isWindow(obj)
  return type("obj") == "table" and obj.setVisible and obj.isVisible and obj.redraw and obj.restoreCursor and obj.getPosition and obj.reposition
end

--- Slides a window in a direction.
-- @tparam table win Window to slide.
-- @tparam string dir Direction to slide, has to be "up", "down", "left", or "right".
-- @tparam number distance Distance to slide in pixels. Must be positive.
-- @tparam[opt=0.05] number delay Time between repositions.
function w.slide(win,dir,distance,delay)
  expect(1,win,"table")
  expect(2,dir,"string")
  expect(3,distance,"number")
  expect(4,delay,"number","nil")
  delay = delay or 0.05
  local x,y = win.getPosition()
  if dir == "up" then
    for i=1,distance do
      win.reposition(x,y-i)
      sleep(delay)
    end
  elseif dir == "down" then
    for i=1,distance do
      win.reposition(x,y+i)
      sleep(delay)
    end
  elseif dir == "left" then
    for i=1,distance do
      win.reposition(x-i,y)
      sleep(delay)
    end
  elseif dir == "right" then
    for i=1,distance do
      win.reposition(x+i,y)
      sleep(delay)
    end
  end
end

return w