

require('goo.guicontrol')
require('goo.gui')
require('goo.button')

Goo = {}



Goo.base = GUIBase()

Goo.update = function(dt)
	Goo.base:update(dt)
end

Goo.draw = function()
	Goo.base:draw()
end

Goo.mouseDown = function(x,y,b)
	if not Goo.base:onMouseDown(x,y,b) then -- Goo didnt catch the click
		
	end
end

Goo.mouseUp = function(x,y,b)
	Goo.base:onMouseUp(x,y,b)
end

Goo.keyDown = function(key)
	Goo.base:onKeyDown(key)
end

Goo.keyUp = function(key)
	Goo.base:onKeyUp(key)
end

Goo.textEntry = function(text)
	Goo.base:onTextEntry(text)
end

