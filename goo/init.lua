

require('goo.guicontrol')
require('goo.gui')
require('goo.button')

Goo = {}

guiPatch = NinePatch("gfx/gui/guimain.png",15)
insetPatch = NinePatch("gfx/gui/guiinset.png",8)

Goo.base = GUIBase()

Goo.update = function(dt)
	Goo.base:update(dt)
end

Goo.draw = function()
	Goo.base:draw()
end

Goo.mouseDown = function(x,y,b)
	return Goo.base:onMouseDown(x,y,b)
end

Goo.mouseUp = function(x,y,b)
	return Goo.base:onMouseUp(x,y,b)
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

