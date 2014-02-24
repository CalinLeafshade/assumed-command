
Eventful = {}

function Eventful.subscribe(self,eventName,fn)
	self.events = self.events or {}
	self.events[eventName] = self.events[eventName] or {}
	table.insert(self.events[eventName],fn)
end

function Eventful.fire(self,eventName,...)
	self.events = self.events or {}
	if self.events[eventName] then
		for i,v in ipairs(self.events[eventName]) do
			v(self,...)
		end
	end
end

