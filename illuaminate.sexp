; -*- mode: Lisp;-*-

(sources
  /gui/
  -/gui/init.lua
)


(doc
  (destination build/docs/lua)
  (index doc/index.md)

  (site
    (title "CC-GUI")
    (logo doc/pack.png)
    (url https://skygui.madefor.cc/)
    (source-link https://github.com/SkyTheCodeMaster/cc-gui/blob/${commit}/${path}#L${line})

    (styles doc/styles.css)
    ;;(scripts build/rollup/index.js)
    (head doc/head.html)
  )

  (module-kinds
    (gui GUI)
  )

  (library-path
    /gui/
  )
)

(at /
  (linters
    -syntax:string-index
    -format:separator-space
    -format:bracket-space
  )
  (lint
    (bracket-spaces
      (call no-space)
      (function-args no-space)
      (parens no-space)
      (table space)
      (index no-space)
    )

    (globals
      :max
      _CC_DEFAULT_SETTINGS
      _CC_DISABLE_LUA51_FEATURES
      sleep 
      write 
      printError 
      read 
      rs 
      SkyOS
      colors
      colours
      commands
      disk
      fs
      gps
      help
      http
      io
      keys
      multishell
      os 
      paintutils
      parallel
      peripheral
      pocket
      rednet
      redstone
      settings 
      shell
      term
      textutils
      turtle
      vector
      window
      _HOST
    )
  )
)