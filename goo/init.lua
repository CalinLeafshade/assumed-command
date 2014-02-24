

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
	Goo.base:onMouseDown(x,y,b)
end

Goo.mouseUp = function(x,y,b)
	Goo.base:onMouseUp(x,y,b)
end

