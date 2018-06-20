-- MES - Monochrome Entertainment System
-- Credits:
-- Mr_Iron2 - Concept, startup, menu, wrapper compatibility guide + testing
-- Gonow32 - Colour to Monochrome Wrapper and improvements
-- MultMine: Code cleanup
-- Luca_S - Compatibility List [with Wrapper]

local function center(y,string)
  local w,h = term.getSize()
  local x = (w/2)-(#string/2)
  term.setCursorPos(x,y)
  print(string)
end

local function centerSlow(y,string)
  local w,h = term.getSize()
  local x = (w/2)-(#string/2)
  term.setCursorPos(x,y)
  textutils.slowPrint(string)
end

-- Wrapper code
local current = term.current()
term.redirect(window.create(current,1,1,current.getSize()))

if not term.isColour() then
  local oldback = term.setBackgroundColour
  function term.setBackgroundColor(colour)
    if colour == 1 then
      oldback(colour)
    else
      oldback(colours.black)
    end
  end

  term.setBackgroundColour = term.setBackgroundColor

  local oldtext = term.setTextColour
  function term.setTextColor(colour)
    if colour == 32768 then
      oldtext(colour)
    else
      oldtext(colours.white)
    end  
  end
end

-- Auto-booting compatible games
for i, v in ipairs({peripheral.find("drive")}) do
  if v.isDiskPresent() and v.getMountPath() and fs.exists(v.getMountPath().."/game") then
    shell.run("/"..v.getMountPath().."/game")
    break
  end
end

-- Startup animation
term.setTextColour = term.setTextColor
term.setBackgroundColour(colours.white)
term.clear()
term.setTextColour(colours.black)
center(8,"Welcome to MES.")
sleep(1.25)


local function render()
  term.setBackgroundColour(colours.black)
  term.setTextColour(colours.white)
  center(7,"Press a number to continue")
  term.clear()
  term.setBackgroundColour(colours.white)
  term.setTextColour(colours.black)
  center(3,"             ")
  center(4,"     MES     ")
  center(5,"             ")
  term.setCursorPos(5,8)
  print("             ")
  term.setCursorPos(5,9)
  print("     [1]     ")
  term.setCursorPos(5,10)
  print("    Disk     ")
  term.setCursorPos(5,11)
  print("             ")
  term.setCursorPos(33,8)
  print("             ")
  term.setCursorPos(33,9)
  print("     [2]     ")
  term.setCursorPos(33,10)
  print("   Shutdown  ")
  term.setCursorPos(33,11)
  print("             ")
end

local function sdk()
  local function draw()
   term.clear()
   center(2,"MES Development Software")
   center(5," 1. Boot to shell ")
   center(7," 2. Development Kit ")
   center(9," 3. Shut down ")
   term.setBackgroundColour(colours.black)
   term.setTextColour(colours.white)
  end

while true do draw()
  local event,key = os.pullEvent("key")
  if key == keys.one then
    shell.run("shell")
  elseif key == keys.two then 
    shell.run("/sdk")
  elseif key == keys.three then
    os.shutdown()
  end
end
end
  
while true do 
  render()
  local event,key = os.pullEvent("key")
  if key == keys.one then
    term.setBackgroundColour(colours.black)
    term.setTextColour(colours.white)
    term.clear()
    term.setCursorPos(1,1) 
    shell.run("/disk/game")  
  elseif key == keys.two then 
    os.shutdown()
  elseif key == keys.zero then
    sdk()
  end
end
