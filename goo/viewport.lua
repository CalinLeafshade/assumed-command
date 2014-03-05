
require('goo.guicontrol')

GUIViewport = Class("GUIViewport", GUIControl)

function GUIViewport:initialize(parent,ship,follow)
	GUIControl.initialize(self,parent)
	self.viewport = Viewport(ship)
	self.viewport:follow(follow)
end

function GUIViewport:onResize()
	GUIControl.onResize(self)
	self.viewport:setBounds(self:getSize())
end

function GUIViewport:update(dt)
	GUIControl.update(self,dt)
	self.viewport:update(dt)
end

function GUIViewport:draw()
	self.viewport:draw(self.x,self.y)
end
	