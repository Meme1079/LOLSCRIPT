local pos = {}
 
local xpos = {}
local ypos = {}
 
xpos[1] = 43; xpos[2] = 62
ypos[1] = 32; ypos[2] = 63 - 32 
 
pos[#pos + 1] = xpos
pos[#pos + 1] = ypos
local function toboolean(boo) -- yarn to troof
    return boo == "true" and true or false
end
 
local result = toboolean("true")
function onCreate()
    debugPrint(result)
    debugPrint(pos[1][2], pos[2][1])
end