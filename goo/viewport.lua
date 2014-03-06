
require('goo.guicontrol')

GUIViewport = Class("GUIViewport", GUIControl)

function GUIViewport:initialize(parent,ship,follow)
	GUIControl.initialize(self,parent)
	self.viewport = Viewport(ship)
	self.viewport:follow(follow)
end

function GUIViewport:onResize()
	GUIControl.onResize(self)
	local w,h = self:getSize()
	self.viewport:setBounds(w-4,h-4)
end

function GUIViewport:update(dt)
	GUIControl.update(self,dt)
	self.viewport:update(dt)
end

function GUIViewport:draw()
	insetPatch:draw(self:getBounds())
	self.viewport:draw(self.x + 2,self.y + 2)
end
	