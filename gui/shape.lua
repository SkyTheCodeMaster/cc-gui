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

return shape