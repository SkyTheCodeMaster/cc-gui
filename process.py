# Strip module tags
import json
import os
import re

with open("downloaded.json") as f:
  downloads = json.loads(f.read())
  print(downloads)

def canRemove(line:str):
  return re.match("-- @module\[kind=.*?\] .*",line)

for file in downloads:
  print("opening",file)
  with open(file) as r:
    lines = [line for line in r if not canRemove(line)]
    print("writing",file)
    with open(file,"w") as w:
      w.write("\n".join(lines))

# remove init.lua from being documented
os.remove("gui/init.lua")