--- Draw various shapes on the screen.
local shape = {}

local expect = require("cc.expect").expect

--- Draw a filled rectangle.
-- @tparam number x X coordinate of rectangle.
-- @tparam number y Y coordinate of rectangle.
-- @tparam number w Width of rectangle.
-- @tparam number h Height of rectangle.
-- @tparam number|string col Colour of rectangle, accepts blit or `colours.` colour.
function shape.filledRectangle(x,y,w,h,col)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,w,"number")
  expect(4,h,"number")
  expect(5,col,"number","string")
  if type(col) == "number" then col = colours.toBlit(col) end

  for i=1,h do
    term.setCursorPos(x,y+i-1)
    term.blit((" "):rep(w),col:rep(w),col:rep(w))
  end
end

--- Draw a hollow rectangle.
-- @tparam number x X coordinate of rectangle.
-- @tparam number y Y coordinate of rectangle.
-- @tparam number w Width of rectangle.
-- @tparam number h Height of rectangle.
-- @tparam number|string col Colour of rectangle, accepts blit or `colours.` colour.
function shape.rectangle(x,y,w,h,col)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,w,"number")
  expect(4,h,"number")
  expect(5,col,"number","string")
  if type(col) == "number" then col = colours.toBlit(col) end

  for i=1,h do
    if i==y or i==h then
      term.setCursorPos(x,y+i-1)
      term.blit((" "):rep(w),col:rep(w),col:rep(w))
    else
      term.setCursorPos(x,y+i-1)
      term.blit(" ",col,col)
      term.setCursorPos(x+w-1,y+i-1)
      term.blit(" ",col,col)
    end
  end
end

--- Draw a hollow triangle. The X/Y is the top left of the triangle "box", and the W/H is the width and height of it. The bottomleft of the triangle is (x,y+h-1), bottom right is (x+w-1,y+h-1), and the top is (x+w/2,y)
-- @tparam number x X coordinate of the triangle.
-- @tparam number y Y coordinate of the triangle.
-- @tparam number w Width of the triangle.
-- @tparam number h Height of the triangle.
-- @tparam number col Colour of the triangle.
function shape.triangle(x,y,w,h,col)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,w,"number")
  expect(4,h,"number")
  expect(5,col,"number")

  local oX,oY = term.getCursorPos()
  local oCol = term.getBackgroundColour() -- restore stuff after painutils

  paintutils.drawLine(x,y+h-1, x+math.floor(w/2),y, col)
  paintutils.drawLine(x+w-1,y+h-1, x+math.floor(w/2),y, col)
  paintutils.drawLine(x,y+h-1, x+w-1,y+h-1, col)

  term.setCursorPos(oX,oY)
  term.setBackgroundColour(oCol)
end

--- Draw a filled triangle. This has no gauruntee of working correctly.
-- @tparam number x X coordinate of the triangle.
-- @tparam number y Y coordinate of the triangle.
-- @tparam number w Width of the triangle.
-- @tparam number h Height of the triangle.
-- @tparam number col Colour of the triangle.
function shape.filledTriangle(x,y,w,h,col)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,w,"number")
  expect(4,h,"number")
  expect(5,col,"number")

  for i=1,math.floor(h/2) do
    shape.triangle(x+i,y+i,w-i,h-i,col)
  end
end

return shape