local frame = {}

local expect = require("cc.expect").expect

--- Draw a frame with the specified colours
-- @tparam x number Top left X coordinate.
-- @tparam y number Top left Y coordinate.
-- @tparam w number Width.
-- @tparam h number Height.
-- @tparam fcol string|number Colour to draw as, accepts blit or `colours.` colour.
-- @tparam bcol string|number Border colour to draw, accepts blit or `colours.` colour.
function frame.frame(x,y,w,h,fcol,bcol)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,w,"number")
  expect(4,h,"number")
  expect(5,fcol,"number","string")
  expect(6,bcol,"number","string")
  if type(fcol) == "number" then
    fcol = colours.toBlit(fcol)
  end
  if type(bcol) == "number" then
    bcol = colours.toBlit(bcol)
  end

  -- draw the 1 pixel frame
  local top = "\135" .. ("\131"):rep(w-2) .. "\139"
  local bottom = "\139" .. ("\143"):rep(w-2) .. "\135"
  local middle = "\149" .. (" "):rep(w-2) .. ""
  local a = fcol:rep(w)
  local b = bcol:rep(w)
  term.setCursorPos(x,y)
  term.blit(top,b,a)
  term.setCursorPos(x,y+h-1)
  term.blit(bottom,a,b)
  term.setCursorPos(x,y)
  for i=1,h-1 do
    term.setCursorPos(x,y+i)
    term.blit()
  end
end

return frame