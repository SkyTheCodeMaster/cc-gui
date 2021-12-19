--- Provides image support for the library.
-- @module[kind=ext] image
local image = {}

local expect = require("cc.expect")
local nft = require("cc.image.nft")

local function split(b,c)expect(1,b,"string")expect(1,c,"string","nil")c=c or","local d={}for e in string.gmatch(b,"([^"..c.."]+)")do table.insert(d,e)end;return d end;local function f(g)expect(1,g,"string")local h=fs.open(g,"r")local i=h.readAll()h.close()return i end;local function encfread(g)local i=f(g)return textutils.unserialize(i)end

--- Load an image file.
-- @tparam string path Path to the file, supported types are ".skimg", ".skgrp", ".blit", ".nfp", and ".nft".
-- @tparam string override Type to load file as, overriding the file type.
-- @treturn table The image file, to be fed into a drawing routine.
function image.load(file,override)
  expect(1,file,"string")
  expect(2,override,"string","nil")
  if not fs.exists(file) then
    error("file does not exist",2)
  end
  local fileName = fs.getName(file)
  local fileType = override or split(fileName,".")[2]
  local mt = {
    __index = function(self,i)
      if i == "format" then
        return fileType
      end
      return rawget(self,i)
    end,
  }
  local img = {}
  -- skimg loader
  if fileType == "skimg" then
    img = encfread(file)
  -- skgrp loader (old & outdated)
  elseif fileType == "skgrp" then
    for x in io.lines(file) do
      table.insert(img,x)
    end
  -- blit loader, similar to `.skimg`
  elseif fileType == "blit" then
    img = encfread(file)
  -- nfp loader, for paintutils
  elseif fileType == "nfp" then
    img = paintutils.loadImage(file)
  -- nft loader, "Nitrogen Fingers Text"
  elseif fileType == "nft" then
    img = nft.load(file)
  end
  return setmetatable(img,mt)
end

--[[- Draw an image produced by @{load}.
@param image Image to draw.
@tparam {format? = string, x? = number, y? = number} opts Options for picture drawing.
 - `format`: Format to draw image as, if unpassed will try to figure out the image type.
 - `x`: X position to draw image at. Defaults to 1.
 - `y`: Y position to draw image at. Defaults to 1.
@tparam[opt] table tOutput Terminal to draw to. Has different requirements based on image type. Defaults to `term.current()`
]] 
function image.draw(image,options,tOutput)
  expect(1,image,"string","table")
  expect(2,options,"table","nil")
  expect(3,tOutput,"table","nil")
  tOutput = tOutput or term.current()
  local opts = options or {}
  local x = opts["x"] or 1
  local y = opts["y"] or 1
  local format,sType,sDelay
  -- Default the table!
  if not opts["format"] or not image["format"] then
    -- Now we need to figure it out.
    if type(image) == "table" then -- This is a skimg or skgrp.
      if image["attributes"] and image["data"] then -- This is a skimg. Lets figure out it's type.
        if image["attributes"]["type"] then
          sType = image["attributes"]["type"]
          format = "skimg"
        else
          sType = 1
          format = "skimg"
        end
        if sType == 2 then -- ok, get it's speed. (This is stored inside of attributes, and defaults to 0.05)
          sDelay = image["attributes"]["speed"] or 0.05
        end
      else -- Check if it's a blit, nft or skgrp.
        if type(image[1]) == "table" then
          -- It's a blit or nft.
          if image[1]["text"] then
            format = "nft"
          else
            format = "blit"
          end
        elseif type(image[1]) == "string" then
          -- It's a skgrp.
          format = "skgrp"
        end
      end
    elseif type(image) == "string" then
      -- It's an NFP.
      format = "nfp"
    end
  else
    format = opts["format"] or image["format"]
  end
  if format == "skimg" and sType == 1 then
    -- Type one skimg. Easy to draw.
    -- make sure tOutput has blit and setCursorPos
    if not tOutput.setCursorPos or not tOutput.blit then
      error("tOutput is incompatible!",2)
    end
    for i,v in ipairs(image.data) do
      tOutput.setCursorPos(x,y+i-1)
      tOutput.blit(v[1],v[2],v[3])
    end
  elseif format == "skimg" and sType == 2 then
    -- Basically calls the type 1 parser on each frame, with a `sleep` in between.
    -- make sure tOutput has blit and setCursorPos
    if not tOutput.setCursorPos or not tOutput.blit then
      error("tOutput is incompatible!",2)
    end
    local frames = image.data
    for _,v in ipairs(frames) do
      local frame = v
      for i,l in ipairs(frame) do
        tOutput.setCursorPos(x,y+i-1)
        tOutput.blit(l[1],l[2],l[3])
      end
      sleep(sDelay)
    end
  elseif format == "blit" then
    -- Relatively the same as skimg type 1.
    -- make sure tOutput has blit and setCursorPos
    if not tOutput.setCursorPos or not tOutput.blit then
      error("tOutput is incompatible!",2)
    end
    for i,v in ipairs(image) do
      tOutput.setCursorPos(x,y+i-1)
      tOutput.blit(v[1],v[2],v[3])
    end
  elseif format == "nft" then
    nft.draw(image,x,y,tOutput)
  elseif format == "nfp" then
    paintutils.drawImage(image,x,y) -- SkyOS no longer uses modded paintutils, so drawImage will exist.
  elseif format == "skgrp" then
    for i=1,#image do
      local grpTable = split(image[i],",")
      local operation = grpTable[1]
      if operation == "P" then
        paintutils.drawPixel(grpTable[2],grpTable[3],tonumber(grpTable[4]))
      elseif operation == "B" then
        paintutils.drawBox(grpTable[2],grpTable[3],grpTable[4],grpTable[5],tonumber(grpTable[6]))
      elseif operation == "F" then
        paintutils.drawFilledBox(grpTable[2],grpTable[3],grpTable[4],grpTable[5],tonumber(grpTable[6]))
      elseif operation == "L" then
        paintutils.drawLine(grpTable[2],grpTable[3],grpTable[4],grpTable[5],tonumber(grpTable[6]))
      elseif operation == "TEXT" then
        paintutils.drawText(grpTable[2],grpTable[3],grpTable[4],grpTable[5],grpTable[6])
      end
    end
  end
end

return image