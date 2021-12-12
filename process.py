# Strip module tags
import json
import re

with open("downloaded") as f:
  downloads = json.loads(f.read())

def canRemove(line:str):
  return re.match("-- @module\[kind=.*?\] .*",line)

for file in downloads:
  with open(file) as r:
    lines = [line for line in r if not canRemove(line)]
    with open(file,"w") as w:
      w.write("\n".join(lines))