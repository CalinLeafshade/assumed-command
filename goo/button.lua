
require('goo.guicontrol')

GUIButton = Class("GUIButton", GUIControl)

local buttonPatch = NinePatch("gfx/gui/guibutton.png",8)
local buttonDownPatch = NinePatch("gfx/gui/guibuttondown.png",8)

function GUIButton:onMouseDown(...)
	self.pressed = true
	self:base().onMouseDown(self,...)
end

function GUIButton:onMouseUp(...)
	if self.pressed then
		self:onClick()
	end
	self.pressed = false
	self:base().onMouseUp(self,...)
end

function GUIButton:onMouseLeave(...)
	self.pressed = false
	self:base().onMouseLeave(self,...)
end

function GUIButton:onClick()
	self:fire("Click")
end

function GUIButton:draw()
	local patch = self.pressed and buttonDownPatch or buttonPatch
	patch:draw(self:getBounds())
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text,self.x,self.y + self.height / 2 - self.font:getHeight() / 2,self.width,"center")
end