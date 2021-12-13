# Strip module tags
import json
import os
import re

with open("downloaded.json") as f:
  downloads = json.loads(f.read())
  print(downloads)

def getLine(line:str):
  match = re.match("-- @module\[kind=.*?\] (.*)",line)
  if not match:
    return line
  else:
    return f"-- @module[kind=ext] {match.group(1)}"

for file in downloads:
  print("opening",file)
  with open(file) as r:
    lines = []
    for line in r:
      lines.append(getLine(line))
    print("writing",file)
    with open(file,"w") as w:
      w.write("\n".join(lines))

# remove init.lua from being documented
os.remove("src/main/gui/init.lua")