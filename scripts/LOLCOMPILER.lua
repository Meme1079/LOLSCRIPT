local function getTextFileContent(path)
     local file = io.open(path)
     local content = ''
     for line in file:lines() do  
          content = content .. line .. '\n'
     end
     return content
end

local function removeDuplicates(arr)
	local newArray = {}
	local checkerTbl = {}
	for _, element in ipairs(arr) do
	     if not checkerTbl[element] then 
	          checkerTbl[element] = true
	          table.insert(newArray, element)
	     end
	end
	return newArray
end

function string.split(str, pattern)
     local words = {}
     for w in str:gmatch("([^"..pattern.."]+)") do
          table.insert(words, w)
     end
     return words
end

function table.find(tab, value)
     for k,v in pairs(tab) do
          if v == value then return k end
     end
end

function table.sub(tab, startPos, endPos)
     local faker = {}
     for i = startPos, endPos or #tab do
          table.insert(faker, tab[i])
     end
     return faker
end

local LOLCODE = getTextFileContent('mods/LOLSCRIPT/scripts/LOLCODE.lol')
local codePattern = '^HAI%s%d%.%d\n\n(.+)\nKTHXBYE\n$'
local codeFilter  = LOLCODE:match(codePattern)
local saveLOLCODE = {}
function filterLOLCODE()
     local checkIfVarExist = {}
     for matchy in LOLCODE:gmatch('I HAS A ([%w+_]+)') do
          table.insert(checkIfVarExist, matchy)
     end
     
     local checkIfVarIsBukkit = {}
     for matchy in LOLCODE:gmatch('I HAS A (%a[%w+_]*) ITZ A BUKKIT') do
          table.insert(checkIfVarIsBukkit, matchy)
     end
     
     local saveToMultiYarns    = {}
     local saveToSingleYarn    = {}
     local saveToMultiComments = {}
     local saveToSingleComment = {}
    
     local function hideSyntaxLOLCODE(tableToSave, patternToMatch, patternToReplace)
          for matches in codeFilter:gmatch(patternToMatch) do
               tableToSave[#tableToSave + 1] = matches:gsub('%%', '%%%1')
          end
          codeFilter = codeFilter:gsub(patternToMatch, patternToReplace)
     end
    
     local function showSyntaxLOLCODE(tableToSave, patternToMatch)
          for k,v in pairs(tableToSave) do
               codeFilter = codeFilter:gsub(patternToMatch, v, 1)
          end
     end
    
     codeFilter = codeFilter:gsub(':<"', '@MULTI_YARN_START!')
     codeFilter = codeFilter:gsub(':>"', '@MULTI_YARN_ENDSTART!')
     codeFilter = codeFilter:gsub(':"', '@DOUBLE_QUOTE!')
    
     hideSyntaxLOLCODE(saveToMultiYarns, '<".-">', '$MultiYarn!')
     hideSyntaxLOLCODE(saveToSingleYarn, '".-"', '$SingleYarn!')
     hideSyntaxLOLCODE(saveToMultiComments, 'OBTW%s.-TLDR', '$MultiComment!')
     hideSyntaxLOLCODE(saveToSingleComment, 'BTW.-[^\n]+', '$SingleComment!')
    
     local escape_keywords = {
          'and', 'or', 'not', 'elseif', 'else', 'if', 'then', 'for', 'while', 'in', 'do',
          'repeat', 'until', 'function', 'end', 'local', 'return', 'break', 'true', 'false', 
          'nil', '%+', '%-', '%*', '/', '%%', '%^', '#', '<', '>', '=', '~', ',', '%.%.', '%[', 
          '%]', '\''
     }
    
     if codeFilter:match('\'') then
          error(("ATtemptd to use\n singlekwotesn in lolsCRipT!?? [\'] just use\n doublEKWotEz [\"] sily!?? plz?"):upper())
     end
    
     local getKeywordStart = table.find(escape_keywords, 'and')
     local getKeywordEnd   = table.find(escape_keywords, 'nil')
     local getKeywords = table.sub(escape_keywords, getKeywordStart, getKeywordEnd)
     for k,v in pairs(getKeywords) do
          if codeFilter:match('%W+'..v..'%W+') then
               error(("ATtempTd to ENSeRt\nlua keyword\'z entO Lolcode [ "):upper()..codeFilter:match(v).." ]")
          end
     end
    
     local getOperatorStart = table.find(escape_keywords, '%+')
     local getOperatorEnd   = table.find(escape_keywords, '%]')
     local getOperators = table.sub(escape_keywords, getOperatorStart, getOperatorEnd)
     for k,v in pairs(getOperators) do
          if codeFilter:match(v) then
               error(("ATtempTd to ENSeRt\nlua operatr\'s entO Lolcode [ "..codeFilter:match(v).." ]"):upper())
          end
     end

     showSyntaxLOLCODE(saveToMultiYarns, '$MultiYarn!')
     showSyntaxLOLCODE(saveToSingleYarn, '$SingleYarn!')
     showSyntaxLOLCODE(saveToMultiComments, '$MultiComment!')
     showSyntaxLOLCODE(saveToSingleComment, '$SingleComment!')
     
     local getBukkits = {}
     for l in codeFilter:gmatch('{(.-)}') do
          if l:match('{') or l:match('}') then
               local errorMsg = 'oh hi attemptd tO ENsert\nnestd bukkitz to avoid this just BUKKIT Variabl\nEnside teh bukKIT'
               error(errorMsg:upper())
               break
          end
          getBukkits[#getBukkits + 1] = l:gsub('%sAN%s', ','):match('.+')
     end

     for k,v in pairs(getBukkits) do
          for o,p in pairs(v:split(',')) do
               if p:gsub('^%s', '') ~= p:gsub('^%s', ''):match('^YR .+') then
                    error(('mizin YR syntaks\non '..p:gsub('^%s', '')..' whin deeclarin bukkits'):upper())
               end
          end
     end
    
     codeFilter = codeFilter:split('\n')
     for k,v in pairs(codeFilter) do
          -- Variables/Reassigning & Bukkits???
          codeFilter[k] = codeFilter[k]:gsub('ONLY! I HAS A (%a[%w+_]*) ITZ A BUKKIT', 'local %1 = {}')
          codeFilter[k] = codeFilter[k]:gsub('I HAS A (%a[%w+_]*) ITZ A BUKKIT', '%1 = {}')
          
          codeFilter[k] = codeFilter[k]:gsub('ONLY! I HAS A (%a[%w+_]*) ITZ (.-)', 'local %1 = %2')
          codeFilter[k] = codeFilter[k]:gsub('ONLY! I HAS A (%a[%w+_]*)', 'local %1')
          codeFilter[k] = codeFilter[k]:gsub('I HAS A (%a[%w+_]*) ITZ (.-)', '%1 = %2')
          
          for e,r in pairs(checkIfVarExist) do
               codeFilter[k] = codeFilter[k]:gsub('SUM OF ('..r..') R (.-)', '%1 = %1 + %2')
               codeFilter[k] = codeFilter[k]:gsub('DIFF OF ('..r..') R (.-)', '%1 = %1 - %2')
               codeFilter[k] = codeFilter[k]:gsub('PRODUKT OF ('..r..') R (.-)', '%1 = %1 * %2')
               codeFilter[k] = codeFilter[k]:gsub('QUOSHUNT OF ('..r..') R (.-)', '%1 = %1 / %2')
               codeFilter[k] = codeFilter[k]:gsub('MOD OF ('..r..') R (.-)', '%1 = %1 %% %2')
               codeFilter[k] = codeFilter[k]:gsub('EXPO OF ('..r..') R (.-)', '%1 = %1^%2')
               codeFilter[k] = codeFilter[k]:gsub('SMOOSH ('..r..') R (.-)', '%1 = %1..%2')
               codeFilter[k] = codeFilter[k]:gsub('('..r..') R (.-)', '%1 = %2')
          end
          for e,r in pairs(checkIfVarIsBukkit) do
               codeFilter[k] = codeFilter[k]:gsub('('..r..') HAS A (.-) ITZ (.-)', '%1[%2] = %3')
               codeFilter[k] = codeFilter[k]:gsub(' Z (.-) NOW', '[%1]')
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
          codeFilter[k] = codeFilter[k]:gsub('SMOOSH (.-) AN (.-)', '%1..%2')
          codeFilter[k] = codeFilter[k]:gsub('BOTH (.-) AN (.-)', '%1 and %2')
          codeFilter[k] = codeFilter[k]:gsub('EITHER (.-) AN (.-)', '%1 or %2')
          codeFilter[k] = codeFilter[k]:gsub('NOT (.-)', 'not %1')
          
          -- Other
          codeFilter[k] = codeFilter[k]:gsub('CHECK (.-) ORLY%? (.-) NAH ITZ (.-)', '%1 and %2 or %3')
          codeFilter[k] = codeFilter[k]:gsub('FOUND YR (.-)', 'return %1')
          codeFilter[k] = codeFilter[k]:gsub('INFINITE', '...')
          codeFilter[k] = codeFilter[k]:gsub('WIN', 'true')
          codeFilter[k] = codeFilter[k]:gsub('LOSE', 'false')
          codeFilter[k] = codeFilter[k]:gsub('IDK', 'nil')
     end
    
     codeFilter = table.concat(codeFilter, '\n')
    
     codeFilter = codeFilter:gsub('@MULTI_YARN_START!', '[[')
     codeFilter = codeFilter:gsub('@MULTI_YARN_END!', ']]')
     codeFilter = codeFilter:gsub('@DOUBLE_QUOTE!', '\"')
    
     local function checkParamSyntax(startPtrn, endPtrn, erroMsg)
          local getParams = {}
          for g in codeFilter:gmatch(startPtrn..'.-'..endPtrn) do
               for d in g:gmatch(startPtrn..'.-%((.-)%)') do
                    getParams[#getParams + 1] = d:gsub('%sAN%s', ','):match('.+')
               end
          end
        
          for k,v in pairs(getParams) do
               for o,p in pairs(v:split(',')) do
                    if p:gsub('^%s', '') ~= p:gsub('^%s', ''):match('^YR .+') then
                         error(('mizin YR syntaks\non '..p:gsub('^%s', '')..' '..erroMsg):upper())
                    end
               end
          end
     end
     
     checkParamSyntax('HOW IZ I', 'IF U SAY SO', 'whin deeclarin funcshun k?')
     checkParamSyntax('I IZ', 'MKAY', 'whin caling teh funcshun k?')
     checkParamSyntax('VISIBLE', '[^\n]*', 'whin prnting aa valeu k?')
     checkParamSyntax('INVISIBLE', '[^\n]*', 'whin prnting aa erroz k?')
     checkParamSyntax('TYPEZ', '[^\n]*', 'whin cheking typez of teh valeu k?')
    
     codeFilter = codeFilter:gsub('ONLY! HOW IZ I (%a[%w+_]*%(.-%))(.-)IF U SAY SO', 'local function %1%2end')
     codeFilter = codeFilter:gsub('HOW IZ I (%a[%w+_]*%(.-%))(.-)IF U SAY SO', 'function %1%2end')
     codeFilter = codeFilter:gsub('HOW IZ I(%(.-%))(.-)IF U SAY SO', 'function%1%2end')
     codeFilter = codeFilter:gsub('I IZ (%a[%w+_]*%[.-%]%(.-%))(.-) MKAY', '%1%2')
     codeFilter = codeFilter:gsub('I IZ (%a[%w+_]*%(.-%))(.-) MKAY', '%1%2')
     
     -- Sugar Syntax
     for i = 1, 100 do
          codeFilter = codeFilter:gsub('VISIBLE (%(.-%))(.*)[^\n]*', 'debugPrint%1%2')
          codeFilter = codeFilter:gsub('INVISIBLE (%(.-%))(.*)[^\n]*', 'error%1%2')
          codeFilter = codeFilter:gsub('TYPEZ (%(.-%))(.*)[^\n]*', 'type%1%2')
     end
    
     codeFilter = codeFilter:gsub('EXTEND 3 OBTW (.-)TLDR', '--[===[%1]===]')
     codeFilter = codeFilter:gsub('EXTEND 2 OBTW (.-)TLDR', '--[==[%1]==]')
     codeFilter = codeFilter:gsub('EXTEND 1 OBTW (.-)TLDR', '--[=[%1]=]')
     codeFilter = codeFilter:gsub('OBTW (.-)TLDR', '--[[%1]]')
    
     codeFilter = codeFilter:gsub('EXTEND 3 <"(.-)">', '[===[%1]===]')
     codeFilter = codeFilter:gsub('EXTEND 2 <"(.-)">', '[==[%1]==]')
     codeFilter = codeFilter:gsub('EXTEND 1 <"(.-)">', '[=[%1]=]')
     codeFilter = codeFilter:gsub('<"(.-)">', '[[%1]]')
     
     codeFilter = codeFilter:gsub('BLOCK(.-)OK', 'do%1end')
    
     codeFilter = codeFilter:split('\n')
     for k,v in pairs(codeFilter) do
          codeFilter[k] = codeFilter[k]:gsub('BTW (.*)', '-- %1')
          codeFilter[k] = codeFilter[k]:gsub('YR%s(.-)%sAN', '%1,')
          codeFilter[k] = codeFilter[k]:gsub('YR%s(.-)', '%1')
     end
end

function checkLOLCODE()
     local LOLVARS1 = {}
     local LOLVARS2 = {}
     for matchy in LOLCODE:gmatch('I HAS A ([%w+_.]+)') do
          table.insert(LOLVARS1, matchy)
          table.insert(LOLVARS2, matchy)
     end

     local isDuplicate = false
     if (#removeDuplicates(LOLVARS1) < #LOLVARS2) then
          isDuplicate = true
     end
     if isDuplicate == false then
          filterLOLCODE()
     end
     
     local codeResult = ''
     for k,v in pairs(codeFilter) do
          codeResult = codeResult .. v .. '\n'
     end
     
     local function checkSyntax(syntax, replace)
          local kywCount = 1
          for detect in codeResult:gmatch(syntax) do
               kywCount = kywCount + 1
          end
          for i = 1, kywCount do
               codeResult = codeResult:gsub(syntax, replace)
          end
     end
     
     return codeResult:sub(1, #codeResult - #'\n')
end

local hi = checkLOLCODE()
saveFile('LOLSCRIPT/scripts/LOLTEST.lua', hi)