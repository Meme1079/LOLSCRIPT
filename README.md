# LOLSCRIPT
LOLSCRIPT a compiler that converts a LOLCODE code into a Lua code for Psych Engine `0.7.1h`, derived from LOLCODE which is an esoteric programming language inspired by lolspeak from lolcats a popular meme from 2006. Which features an image macro from cat(s) saying silly things.

LOLSCRIPT also changes some syntaxes to make it more possible to convert to Lua. Like when adding parameters to functions or adding arguements when calling a function, they must be surrounded by parenthesis characters `()`. And adding new features to it like assignment operators, local declaration which is `ONLY!`, and ternary operator `CHECK <condition> ORLY? <ifTrue> NAH ITZ <ifFalse>` which is `<condition> and <ifTrue> or <ifFalse>` in Lua.

Example of LOLSCRIPT:
```lolcode
HAI 1.3

ONLY! HOW IZ I toboolean(YR boo)
    FOUND YR CHECK BOTH SAEM boo AN "true" ORLY? WIN NAH ITZ LOSE
IF U SAY SO
 
ONLY! I HAS A result ITZ I IZ toboolean(YR "true") MKAY
VISIBLE (YR result)

KTHXBYE
```

Converted to:
```lua
local function toboolean(boo)
    return boo == "true" and true or false
end
 
local result = toboolean("true")
debugPrint(result)
```