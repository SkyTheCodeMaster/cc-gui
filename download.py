import asyncio
import json

import aiohttp

with open("requirements.json") as f:
  requirements = json.loads(f.read())

async def main():
  async with aiohttp.ClientSession() as session:
    for k,v in requirements.items():
      if v["folder"]: 
        print(k,"is a folder, skipping.")
        continue
      async with session.get(k) as resp:
        text = await resp.text()
        print("got",k,"writing to file.")
        with open(v["path"],"w") as f:
          f.write(text)
          print("wrote to file")

asyncio.run(main())