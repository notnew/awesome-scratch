awesome-scratch
===============

scratchpad windows (similar to a quake console) for awesome wm

###Usage
`scratch.toggle` is used to show and hide scratch windows.  It takes a shell command to launch the scratch window and a rule to match the scratch window.

for example using ezconfig we can add bindings for a scratch terminal and a scratch python repl:
```
  local launchprogs = ezconfig.keytable.join({
      -- scratchpad programs
       ['M-c']   = { scratch.toggle, "urxvt -name scratch-term"             
                                   , { instance = "scratch-term" } }
     , ['M-S-p'] = { scratch.toggle, "urxvt -name scratch-python -e python"
                                   , { instance = "scratch-python" } }
     ...
```

You'll also probably want to add a rule to make the scratch windows float:
```
    awful.rules.rules = {
        ...
        { rule = { instance = "scratch" },
          properties = { floating = true} },
    }
```
