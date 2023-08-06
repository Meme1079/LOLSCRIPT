local xpos = {}
local ypos = {}
pos[#pos + 1] = xpos
pos[#pos + 1] = ypos
local function toboolean(boo) -- yarn to troof
    return boo == "true" and true or false
end
 
local result = toboolean("true")
function onCreate()
    debugPrint(result)
    debugPrint(pos[1], pos[2])
end