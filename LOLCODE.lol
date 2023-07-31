HAI 1.3

HOW IZ I onCreate()
     I IZ makeLuaText(YR "tag" AN YR "Hi" AN YR 0 AN YR 0 AN YR 0) MKAY
     I IZ setObjectCamera(YR "tag" AN YR "camHUD") MKAY
     I IZ setTextSize(YR "tag" AN YR PRODUKT OF 2 AN 30) MKAY
     I IZ addLuaText(YR "tag") MKAY
IF U SAY SO
 
HOW IZ I onCreatePost()
     I IZ setProperty(YR "iconP1.visible" AN YR LOSE) MKAY
     I IZ setObjectOrder(YR "tag" AN YR I IZ getObjectOrder(YR "iconP1") MKAY) MKAY
IF U SAY SO
 
HOW IZ I onUpdatePost(YR elapsed)
     I IZ setProperty(YR "tag.x" AN YR SUM OF I IZ getProperty(YR "iconP1.x") AN 30 MKAY) MKAY
     I IZ setProperty(YR "tag.y" AN YR SUM OF I IZ getProperty(YR "iconP1.y") AN 50 MKAY) MKAY
     I IZ setProperty(YR "tag.scale.x" AN YR I IZ getProperty(YR "iconP1.scale.x") MKAY) MKAY
     I IZ setProperty(YR "tag.scale.y" AN YR I IZ getProperty(YR "iconP1.scale.y") MKAY) MKAY
IF U SAY SO

KTHXBYE