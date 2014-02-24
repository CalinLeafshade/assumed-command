
require('goo.ninepatch')
require('goo.button')

GUI = Class("GUI", GUIControl)


guiPatch = NinePatch("gfx/gui/guimain.png",15)
insetPatch = NinePatch("gfx/gui/guiinset.png",8)

function GUI:initialize()
	GUIControl.initialize(self)
	self.titleBarHeight = 40
	self.closeButton = GUIButton(self)
	
	self.closeButton.text = "X"
	self:initializeLayout()
end

function GUI:initializeLayout() end

function GUI:onMouseEnter()
	self.hovered = true
end

function GUI:onMouseLeave()
	self.hovered = false
end

function GUI:onMouseDown(x,y)
	if y < self.titleBarHeight then
		self.dragging = {x,y}
	end
end

function GUI:onMouseUp()
	self.dragging = nil
end

function GUI:update(dt)
	
	self.closeButton:setBounds(self.width - self.titleBarHeight,7,self.titleBarHeight - 10,self.titleBarHeight - 15)
	if self.dragging then
		local mx,my = love.mouse.getPosition()
		local lx,ly = self.parent:absolutePosition()
		self:setPosition(mx - lx - self.dragging[1], my - ly - self.dragging[2])
	end
	self:updateChildren(dt)
end

function GUI:draw()
	love.graphics.setColor(255,255,255)
	local x,y,w,h = self:getBounds()
	guiPatch:draw(x,y,w,h)
	insetPatch:draw(x + 5,y + 5, w - 10, self.titleBarHeight - 10)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, x + 15, y + 10)
	self:drawChildren()
end

