local gui = {}

-- built in stuff
gui.frame = require("gui.frame")
gui.shape = require("gui.shape")
gui.text = require("gui.text")

-- extensions (button, progressbar)
gui.ext = {}

local function safequire(path)
  local ok,m = pcall(require,path)
  if not ok or type(m) ~= "table" or next(m) == nil then
    return nil
  end
  return m
end

for _,ext in pairs(fs.list("gui/ext")) do
  local m = safequire("gui.ext."..ext:match("(.+)%..+"))
  if m then
    gui.ext[ext:match("(.+)%..+")] = m
  end
end

return gui