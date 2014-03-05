
require('goo.guicontrol')

GUITextBox = Class("GUITextBox", GUIControl)
insetPatch = NinePatch("gfx/gui/guiinset.png",8)

function GUITextBox:focus()
	self.caret = self.text:len()
	self.focussed = true
end

function GUITextBox:blur()
	self.focussed = false
end

function GUITextBox:onKeyDown(key)
	if key == "backspace" then
		self.text = self.text:sub(1,self.caret - 1) .. self.text:sub(self.caret + 1)
		self.caret = self.caret - 1
		self:onChange()
	elseif key == "delete" then
		self.text = self.text:sub(1,self.caret) .. self.text:sub(self.caret + 2)
		self:onChange()
	elseif key == "left" then
		self.caret = math.max(self.caret - 1,0)
	elseif key == "right" then
		self.caret = math.min(self.caret + 1, #self.text)
	elseif key == "return" then
		self:onActivate()
	end
end

function GUITextBox:onChange()
	self:fire("change")
end

function GUITextBox:onActivate()
	self:fire("activate")
end

function GUITextBox:onMouseDown(x,y)
	self:base().onMouseDown(self,x,y)
	self.caret = self:positionToCaret(x-5)
end

function GUITextBox:onTextEntry(text)
	self.text = self.text:sub(1,self.caret) .. text .. self.text:sub(self.caret + 1)
	self.caret = self.caret + text:len()
	self:onChange()
end

function GUITextBox:positionToCaret(x)
	for i=1,self.text:len() do
		if self.font:getWidth(self.text:sub(1,i)) > x then
			return i - 1
		end
	end
	return self.text:len()
end

function GUITextBox:draw()
	insetPatch:draw(self:getBounds())
	love.graphics.setScissor(self:getAbsoluteBounds())
	love.graphics.setFont(self.font)
	love.graphics.print(self.text,self.x + 5,self.y + self.height / 2 - self.font:getHeight() / 2)
	love.graphics.setScissor()
	if self.focussed then
		local caretPosition = self.font:getWidth(string.sub(self.text,1,self.caret))
		love.graphics.line(self.x + 5 + caretPosition,self.y + self.height / 2 - self.font:getHeight() / 2,self.x + 5 + caretPosition,self.y + self.height / 2 + self.font:getHeight() / 2)
	end
end