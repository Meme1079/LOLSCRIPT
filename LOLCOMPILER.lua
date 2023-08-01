local function getTextFileContent(path)
     local file = io.open(path)
     local content = ''
     for line in file:lines() do  
          content = content .. line .. '\n'
     end
     return content
end

function string.split(str, pattern)
     local words = {}
     for w in str:gmatch("([^"..pattern.."]+)") do
          table.insert(words, w)
     end
     return words
end

local LOLCODE = getTextFileContent('mods/PsychPorts/scripts/LOLCODE.lol')
local codePattern = '^HAI%s%d%.%d\n\n(.+)\nKTHXBYE\n$'
local codeFilter  = LOLCODE:match(codePattern):split('\n')
for k,v in pairs(codeFilter) do
     codeFilter[k] = codeFilter[k]:gsub('VISIBLE (.+) WITH PRIDE (.+) MKAY', 'debugPrint(%1, %2)')
     codeFilter[k] = codeFilter[k]:gsub('VISIBLE (.+) MKAY', 'debugPrint(%1)')
     codeFilter[k] = codeFilter[k]:gsub('TIE', ']]')
     codeFilter[k] = codeFilter[k]:gsub('YARN', '[[')
     codeFilter[k] = codeFilter[k]:gsub('OBTW', '--[=[')
     codeFilter[k] = codeFilter[k]:gsub('TLDR', ']=]')
     codeFilter[k] = codeFilter[k]:gsub('BTW', '--')
     codeFilter[k] = codeFilter[k]:gsub('ITZ', '=')
     codeFilter[k] = codeFilter[k]:gsub('WIN', 'true'):gsub('LOSE', 'false')
     codeFilter[k] = codeFilter[k]:gsub('FOUND YR (.-)', 'return %1')
     codeFilter[k] = codeFilter[k]:gsub('IF U SAY SO', 'end')
     codeFilter[k] = codeFilter[k]:gsub('FOREVER', '...')
     
     -- Variables & Reassigning
     if v:match('ONLY! I HAS A %w+') then
          codeFilter[k] = codeFilter[k]:gsub('ONLY!', 'local')
          codeFilter[k] = codeFilter[k]:gsub('%s+I HAS A%s+', ' ')
     end
     if v:match('I HAS A %w+ ITZ .-') then
          codeFilter[k] = codeFilter[k]:gsub('I HAS A%s+', '')
     end
     
     -- Conditions
     codeFilter[k] = codeFilter[k]:gsub('BOTH SAEM (.-) AN (.-)', '%1 == %2')
     codeFilter[k] = codeFilter[k]:gsub('DIFFRINT (.-) AN (.-)', '%1 ~= %2')
     codeFilter[k] = codeFilter[k]:gsub('IS SAEM BIGGR (.-) AN (.-)', '%1 >= %2')
     codeFilter[k] = codeFilter[k]:gsub('IS SAEM SMALLR (.-) AN (.-)', '%1 <= %2')
     codeFilter[k] = codeFilter[k]:gsub('IS BIGGR (.-) AN (.-)', '%1 > %2')
     codeFilter[k] = codeFilter[k]:gsub('IS SMALLR (.-) AN (.-)', '%1 < %2')

     -- Operators
     codeFilter[k] = codeFilter[k]:gsub('SUM OF (.-) AN (.-)', '%1 + %2')
     codeFilter[k] = codeFilter[k]:gsub('DIFF OF (.-) AN (.-)', '%1 - %2')
     codeFilter[k] = codeFilter[k]:gsub('PRODUKT OF (.-) AN (.-)', '%1 * %2')
     codeFilter[k] = codeFilter[k]:gsub('QUOSHUNT OF (.-) AN (.-)', '%1 / %2')
     codeFilter[k] = codeFilter[k]:gsub('MOD OF (.-) AN (.-)', '%1 %% %2')
     codeFilter[k] = codeFilter[k]:gsub('EXPO OF (.-) AN (.-)', '%1^%2')
     codeFilter[k] = codeFilter[k]:gsub('BECOME EVIL (.-)', '-%1')
     codeFilter[k] = codeFilter[k]:gsub('LOOONG (.-)', '#%1')
     codeFilter[k] = codeFilter[k]:gsub('SMOOSH (.-) AN (.-)', '%1 .. %2')
     codeFilter[k] = codeFilter[k]:gsub('BOTH (.-) AN (.-)', '%1 and %2')
     codeFilter[k] = codeFilter[k]:gsub('EITHER (.-) AN (.-)', '%1 or %2')
     codeFilter[k] = codeFilter[k]:gsub('NOT (.-)', 'not %1')

     -- Statements
     codeFilter[k] = codeFilter[k]:gsub('O RLY (.-) THEN%?', 'if %1 then')
     codeFilter[k] = codeFilter[k]:gsub('MEBBE (.-) THIS%?', 'elseif %1 then')
     codeFilter[k] = codeFilter[k]:gsub('NO WAI', 'else')
     codeFilter[k] = codeFilter[k]:gsub('OIC', 'end')
     
     -- Functions
     if v:match('HOW IZ I %w+(.-)') then
          codeFilter[k] = codeFilter[k]:gsub('HOW IZ I', 'function')
          
          if v:match('YR (.-)') and not v:match(', YR') then
               codeFilter[k] = codeFilter[k]:gsub('%sAN%s', ', ')
               codeFilter[k] = codeFilter[k]:gsub('YR%s(.-)', '%1')
          end
     end
     if v:match('I IZ %w+(.-) MKAY') then
          codeFilter[k] = codeFilter[k]:gsub('I IZ%s', '')
          codeFilter[k] = codeFilter[k]:gsub('%sMKAY', '')

          if v:match('YR (.-)') and not v:match(', YR') then
               codeFilter[k] = codeFilter[k]:gsub('%sAN%s', ', ')
               codeFilter[k] = codeFilter[k]:gsub('YR%s(.-)', '%1')
          end
     end

     if v:match('HOW IZ I %w+()') then
          codeFilter[k] = codeFilter[k]:gsub('I IZ%s', '')
          codeFilter[k] = codeFilter[k]:gsub('%sMKAY', '')
     end
     if v:match('I IZ %w+() MKAY') then
          codeFilter[k] = codeFilter[k]:gsub('I IZ%s', '')
          codeFilter[k] = codeFilter[k]:gsub('%sMKAY', '')
     end
     
     if v:match('THAT (.-) ITZ (.-)') then
          codeFilter[k] = codeFilter[k]:gsub('THAT (.-) ITZ (.-)', '%1 = %')
          codeFilter[k] = codeFilter[k]:gsub('THAT%s*', '')
          codeFilter[k] = codeFilter[k]:gsub('%s+AN%s*', ', ')
     end
     if v:match('THAT (.-)') then
          codeFilter[k] = codeFilter[k]:gsub('THAT (.-) AN (.-)', '%1, ')
          codeFilter[k] = codeFilter[k]:gsub('THAT (.-)', '')
     end
end

local codeResult = ''
for k,v in pairs(codeFilter) do
    codeResult = codeResult .. v .. '\n'
end

function onCreate()
     saveFile('PsychPorts/scripts/LOLTEST.lua', codeResult:sub(1, #codeResult - #('\n')))
end