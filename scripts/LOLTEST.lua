local function toboolean(boo)
    return boo == "true" and true or false
end
 
local result = toboolean("true")
debugPrint(result)