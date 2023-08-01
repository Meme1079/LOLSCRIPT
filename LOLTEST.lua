function median(min, max) -- Gets the mid value of the min and max value
     return (min + max) / 2
end
 
function isEven(num) -- Checks if it's an even number
     return num % 2 == 0
end
 
local red = "ff0000"
local green = "00ff00"
debugPrint(median(13, 83), red) -- will print > 'false'
debugPrint(isEven(13), green) -- will print > 48