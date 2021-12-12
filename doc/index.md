# CC-GUI
CC-GUI is a Graphical User Interface library for assisting with making GUIs inside of ComputerCraft. It contains many functions, and other libraries inside of it.

# Docs
Available [here](https://skygui.madefor.cc/)

# Usage
To `require` the project, simply do `local gui = require("gui")` (`gui` being the folder itself)
```lua
local gui = require("gui")

-- frame
gui.frame.frame(x,y,w,h,fcol,bcol)

-- shape
gui.shape.rectangle(x,y,w,h,col)
gui.shape.filledRectangle(x,y,w,h,col)
```
# Install
Run the installer command with the `requirements.json` file.
> `wget run https://skydocs.madefor.cc/scripts/installer.lua https://raw.githubusercontent.com/SkyTheCodeMaster/cc-gui/master/requirements.json`