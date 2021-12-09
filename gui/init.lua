local gui = {}

-- built in stuff
gui.frame = require("gui.frame")

-- extensions (button, progressbar)
gui.ext = {}

local function safequire(path)
  local m = pcall(require,path)
  if type(m) ~= "table" or next(m) == nil then
    return nil
  end
  return m
end

for _,ext in pairs(fs.list("gui/ext")) do
  local m = safequire("gui.ext."..ext:match("(.+)%..+"))
  if m then
    gui.ext[ext] = m
  end
end

return gui