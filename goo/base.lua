
require("lib.eventful")

GUIBase = Class("GUIBase")

GUIBase:include(Eventful)

baseFont = love.graphics.newFont(14)

function GUIBase:initialize()
	self.id = tostring({})
	self.controls = {}
	self.x = 0
	self.y = 0
	self.z = 0
	self.font = baseFont
	self.text = "Text"
	self.width = 100
	self.height = 100
end

function GUIBase:base()
	return self.class.super
end

function GUIBase:onMouseDown(x,y,b)
	local c = self:controlAt(x,y)
	if c ~= self then
		local ax,ay = c:absolutePosition()
		c:onMouseDown(x-ax,y-ay,b)
		return true
	end
	return false -- no hit
end

function GUIBase:onMouseUp(x,y,b)
	local c = self:controlAt(x,y)
	if c ~= self then
		local ax,ay = c:absolutePosition()
		c:onMouseUp(x-ax,y-ay,b)
	end	
end

function GUIBase:bringToFront()
	if self.parent then
		self.parent:sendControlToFront(self)
	end
end

function GUIBase:sendControlToFront(c)
	local min = math.huge
	for i,v in ipairs(self.controls) do
		min = math.min(min,v.z)
	end
	c.z = min - 1
end

function GUIBase:blur() end

function GUIBase:focus(control)
	if self.focussed and self.focussed ~= control then
		self.focussed:blur(control)
	end
	self.focussed = control
end

function GUIBase:sendMessageUpwards(name, ...)
	if type(self[name]) == "function" then
		self[name](self,...)
	end
	if self.parent then
		self.parent:sendMessageUpwards(name,...)
	end
end

function GUIBase:getAbsoluteBounds()
	local x,y = self:absolutePosition()
	return x,y,self.width,self.height
end

function GUIBase:onKeyDown(key)
	if self.focussed then
		self.focussed:onKeyDown(key)
	end
end

function GUIBase:onKeyUp(key)
	if self.focussed then
		self.focussed:onKeyUp(key)
	end
end

function GUIBase:onTextEntry(text)
	if self.focussed then
		self.focussed:onTextEntry(text)
	end
end

function GUIBase:update(dt)
	self:setBounds(0,0,love.graphics.getWidth(),love.graphics.getHeight())
	local mouseOver = self:controlAt(love.mouse.getPosition())
	if self.lastMouseOver then
		if mouseOver == self.lastMouseOver then
			mouseOver:onMouseHover()
		else
			self.lastMouseOver:onMouseLeave()
			self.lastMouseOver = mouseOver
			if mouseOver then
				mouseOver:onMouseEnter()
			end
		end
	elseif mouseOver then
		self.lastMouseOver = mouseOver
		mouseOver:onMouseEnter()
	end
	self:updateChildren(dt)
end

function GUIBase:add(c)
	table.insert(self.controls,c)
end

function GUIBase:updateChildren(dt)
	for i,v in ipairs(self.controls) do
		v:update(dt)
	end
end

function GUIBase:controlAt(x,y)
	self:sortControls()
	x,y = x - self.x, y - self.y
	local c
	for i,v in ipairs(self.controls) do
		if v:contains(x,y) then
			c = v
			break
		end
	end
	if c then
		return c:controlAt(x,y) or c
	else
		return self
	end
end

function GUIBase:sortControls()
	table.sort(self.controls, function(a,b)
			if a.z ~= b.z then
				return a.z < b.z
			else
				return a.id < b.id
			end
		end)
end

function GUIBase:drawChildren()
	self:sortControls()
	love.graphics.push()
	love.graphics.translate(self.x,self.y)
	for i=#self.controls,1,-1 do
		self.controls[i]:draw()
	end
	love.graphics.pop()
end

function GUIBase:draw()
	self:drawChildren()
end

function GUIBase:absolutePosition()
	if not self.parent then
		return self.x, self.y
	else
		local px,py = self.parent:absolutePosition()
		return self.x + px, self.y + py
	end
end

function GUIBase:screenToLocal(x,y)
	local ax,ay = self:absolutePosition()
	return x - ax, y - ay
end

function GUIBase:contains(x,y,absolute)
	if absolute then
		x,y = self:screenToLocal(x,y)
	end
	return self.x <= x and x < self.x + self.width and self.y <= y and y < self.y + self.height
end

function GUIBase:setPosition(x,y)
	self.x = x
	self.y = y
end

function GUIBase:setSize(w,h)
	self.width = w
	self.height = h
end

function GUIBase:setBounds(x,y,w,h)
	self:setPosition(x,y)
	self:setSize(w,h)
end

function GUIBase:getBounds()
	return self.x,self.y,self.width,self.height
end

function GUIBase:onMouseEnter() end
function GUIBase:onMouseLeave() end
function GUIBase:onMouseHover() end

