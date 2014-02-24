
GUILabel = Class("GUILabel", GUIControl)

function GUILabel:update(dt)
	GUIControl.update(self,dt)
	self:setSize(self.font:getWidth(self.text), self.font:getHeight())
end

function GUILabel:draw()
	love.graphics.setFont(self.font)
	love.graphics.print(self.text,self.x,self.y)
end