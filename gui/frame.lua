local frame = {}

local expect = require("cc.expect").expect
local s = require("cc.strings")

--- Draw a frame with the specified colours
-- @tparam number x Top left X coordinate.
-- @tparam number y Top left Y coordinate.
-- @tparam number w Width.
-- @tparam number h Height.
-- @tparam string|number fcol Colour to draw as, accepts blit or `colours.` colour.
-- @tparam string|number bcol Border colour to draw, accepts blit or `colours.` colour.
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
  for i=1,h-2 do
    term.setCursorPos(x,y+i)
    term.blit(mid,midfg,midbg)
  end
end

if fs.exists("gui/ext/button.lua") then
  local button = require("gui.ext.button")
  --- Draws a clickable button with text inside. The button toggles when you click it. This requires the `button` extension to be installed.
  -- @tparam number x X coordinate of the button.
  -- @tparam number y Y coordinate of the button.
  -- @tparam number w Width of the button.
  -- @tparam number h Height of the button.
  -- @tparam {borderOn=number,borderOff=number,backOn=number,backOff=number,text=number} cols Colours of the button when it is on or off. 
  -- @tparam string text The text that is centered (and wrapped) in the button.
  -- @tparam function func The function that is ran when the button is toggled, with a state argument.
  -- @tparam[opt=false] boolean state The starting state of the button, defaults to off.
  -- @treturn string The ID of the button.
  function frame.button(x,y,w,h,cols,text,func,state)
    -- standard argument checking
    expect(1,x,"number")
    expect(2,y,"number")
    expect(3,w,"number")
    expect(4,h,"number")
    expect(5,cols,"table")
    if not cols.borderOn then
      error("Cols table missing borderOn",3)
    end
    if not cols.borderOff then
      error("Cols table missing borderOff",3)
    end
    if not cols.backOn then
      error("Cols table missing backOn",3)
    end
    if not cols.backOff then
      error("Cols table missing backOff",3)
    end
    if not cols.text then
      error("Cols table missing text",3)
    end
    expect(6,text,"string")
    expect(7,func,"function")
    expect(8,state,"boolean")
    if state == nil then state = false end

    local lines = s.wrap(text,w-2)
    while #lines > h-1 do
      table.remove(lines,6)
    end
    local function drawText()
      term.setTextColour(cols.text)
      term.setBackgroundColour(state and cols.backOn or cols.backOff)
      for i,line in ipairs(lines) do
        term.setCursorPos(math.ceil(((w-2)/2)-(line:len()/2)),y+i)
        term.write(line)
      end
    end

    local function toggle()
      if state then
        frame.frame(x,y,w,h,cols.borderOn,cols.backOn)
        drawText()
        func(true)
      else
        frame.frame(x,y,w,h,cols.borderOff,cols.backOff)
        drawText()
        func(false)
      end
    end

    frame.frame(x,y,w,h,state and cols.borderOn or cols.borderOff,state and cols.backOn or cols.backOff)
    drawText()
    return button.new(x,y,w,h,toggle)
  end
end

return frame