# LOLSCRIPT
LOLSCRIPT a compiler that converts a LOLCODE code into a Lua code for Psych Engine `0.7.1h`, derived from LOLCODE which is an esoteric programming language inspired by lolspeak from lolcats a popular meme from 2006. Which features an image macro from cat(s) saying silly things.

LOLSCRIPT also changes some syntaxes to make it more possible to convert to Lua. Like when adding parameters to functions or adding arguements when calling a function, they must be surrounded by parenthesis characters `()`. And adding new features to it like assignment operators, local declaration which is `ONLY!`, and ternary operator `CHECK <condition> ORLY? <ifTrue> NAH ITZ <ifFalse>` which is `<condition> and <ifTrue> or <ifFalse>` in Lua.

Example of LOLSCRIPT:
```lolcode
HAI 1.3

BTW LOLCOMPILER says hi!!!~~~
VISIBLE (YR "HAI, WORLD!")

KTHXBYE
```

Converted to:
```lua
-- LOLCOMPILER says hi!!!~~~
debugPrint("HAI, WORLD!")
```