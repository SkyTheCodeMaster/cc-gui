local frame = require("gui.frame")
local expect = require("cc.expect").expect
local s = require("cc.strings")

local text = {}

--- Draw a string at the X/Y coordinates
-- @tparam number x X coordinate of the text.
-- @tparam number y Y coordinate of the text.
-- @tparam string text Text to draw
-- @tparam[opt] number|string fcol Text colour. Accepts `blit` or `colours.`. Defaults to current text colour.
-- @tparam[opt] number|string bcol Background colour. Accepts `blit` or `colours.`. Defaults to current background colour.
function text.text(x,y,txt,fcol,bcol)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,txt,"string")
  expect(4,fcol,"number","string")
  expect(5,bcol,"number","string")
  if type(fcol)=="number"then fcol=colours.toBlit(fcol)end
  if type(bcol)=="number"then bcol=colours.toBlit(bcol)end

  term.setCursorPos(x,y)
  term.blit(text)
end

--- Draw a frame around the text. The x/y coordinates is where the text starts, and the frame is drawn around it.
-- @tparam number x X coordinate of the text.
-- @tparam number y Y coordinate of the text.
-- @tparam string text Text to draw
-- @tparam[opt] number|string fcol Text colour. Accepts `blit` or `colours.`. Defaults to current text colour.
-- @tparam[opt] number|string bcol Background colour. Accepts `blit` or `colours.`. Defaults to current background colour.
-- @tparam[opt] number|nil wrap Whether or not to wrap the text. If unpassed it will be a single line, or wrapped at the length passed.
function text.framedText(x,y,txt,fcol,bcol,wrap)
  expect(1,x,"number")
  expect(2,y,"number")
  expect(3,txt,"string")
  expect(4,fcol,"number","string")
  expect(5,bcol,"number","string")
  if type(fcol)=="number"then fcol=colours.toBlit(fcol)end
  if type(bcol)=="number"then bcol=colours.toBlit(bcol)end
  expect(6,wrap,"number","nil")

  if not wrap then
    frame.frame(x-1,y-1,#text+2,3,fcol,bcol) -- Draw the frame around the window
    term.setCursorPos(x,y) -- Draw the text
    term.blit(text,fcol:rep(#text),bcol:rep(#text))
  else
    local lines = s.wrap(txt,wrap)
    frame.frame(x-1,y-1,wrap+2,#lines+2,fcol,bcol)
    for i,line in ipairs(lines) do
      term.setCursorPos(x,y+i-1)
      term.blit(line,fcol:rep(#line),bcol:rep(#line))
    end
  end
end