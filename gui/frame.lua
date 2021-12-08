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
  local top = "\151" .. ("\131"):rep(w-2) .. "\148"
  local topfg = fcol:rep(w-1) .. bcol
  local topbg = bcol:rep(w-1) .. fcol

  local mid = "\149" .. (" "):rep(w-2) .. "\149"
  local midfg = fcol:rep(w-1) .. bcol
  local midbg = bcol:rep(w-1) .. fcol
  
  local bot = "\138" .. ("\143"):rep(w-2) .. "\133"
  local botfg = bcol:rep(w)
  local botbg = fcol:rep(w)


  term.setCursorPos(x,y)
  term.blit(top,topfg,topbg)
  term.setCursorPos(x,y+h-1)
  term.blit(bot,botfg,botbg)
  term.setCursorPos(x,y)
  for i=1,h-1 do
    term.setCursorPos(x,y+i)
    term.blit(mid,midfg,midbg)
  end
end

return frame