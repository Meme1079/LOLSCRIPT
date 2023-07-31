function onCreate()
     makeLuaText("tag", "Hi", 0, 0, 0)
     setObjectCamera("tag", "camHUD")
     setTextSize("tag", 2 * 30)
     addLuaText("tag")
end
 
function onCreatePost()
     setProperty("iconP1.visible", false)
     setObjectOrder("tag", getObjectOrder("iconP1"))
end
 
function onUpdatePost(elapsed)
     setProperty("tag.x", getProperty("iconP1.x") + 30)
     setProperty("tag.y", getProperty("iconP1.y") + 50)
     setProperty("tag.scale.x", getProperty("iconP1.scale.x"))
     setProperty("tag.scale.y", getProperty("iconP1.scale.y"))
end
