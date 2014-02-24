
require('goo.base')

GUIControl = Class("GUIControl", GUIBase)

function GUIControl:initialize(parent)
	GUIBase.initialize(self)
	self.parent = parent or Goo.base
	self.parent:add(self)
end

function GUIControl:update(dt)
	self:updateChildren(dt)
end

function GUIControl:onMouseEnter()
	self.hovered = true
end

function GUIControl:onMouseLeave()
	self.hovered = false
end

--Events

local function setEventHandler(gui,name)
	gui["on" .. name] = function(self,...)
		local eventName = name
		self:fire(eventName,...)
	end
end

local events = {"MouseEnter", "MouseHover", "MouseLeave", "MouseDown", "MouseUp"}

for i,v in ipairs(events) do
	setEventHandler(GUIControl,v)
end


