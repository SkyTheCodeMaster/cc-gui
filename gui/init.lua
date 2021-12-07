local gui = {}

-- built in stuff
gui.frame = require("gui.frame")

-- extensions (button, progressbar)
gui.ext = {}

for _,ext in pairs(fs.list("gui/ext")) do
  gui.ext[ext] = require("gui.ext."..ext:match("(.+)%..+"))
end

return gui