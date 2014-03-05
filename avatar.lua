
require('shipobject')
require('actions.walkaction')
require('guis.avatargui')

Avatar = Class("Avatar", ShipObject)

function Avatar:initialize(ship,x,y)
	ShipObject.initialize(self,ship,x,y)
	self.queue = {}
	
end

function Avatar:getSpeed()
	return 40
end

function Avatar:getStatus()
	return #self.queue == 0 and "Idle" or "Busy"
end

function Avatar:queueAction(action)
	table.insert(self.queue, action)
end

function Avatar:clearQueue()
	self.queue = {}
end

function Avatar:contains(x,y)
	local d = dist(x,y,self.position:unpack())
	print(d)
	return  d < 8
end

function Avatar:getPathNode()
	local x,y = self.position:unpack()
	x,y = math.floor(x / 16), math.floor(y / 16)
	return self.ship.nodeLookUp[x][y]
end

function Avatar:walk(x,y,now)
	print("Walk", x, y)
	if now then
		self:clearQueue()
	end
	self:queueAction(WalkAction(self,x,y))
end

function Avatar:getTile()
	return math.floor(self.position.x / 16), math.floor(self.position.y / 16)
end

function Avatar:updateQueue(dt)
	local action = self.queue[1]
	if action then
		action:update(dt)
		if action.dead then
			table.remove(self.queue, 1)
		end
	end
end

function Avatar:onClick(b)
	local g = AvatarGUI(200,200,self)
	g:bringToFront()
end

function Avatar:update(dt)
	self:updateQueue(dt)
end


function Avatar:draw()
	love.graphics.setColor(255,0,0)
	love.graphics.circle("fill",self.position.x,self.position.y,8)
	if self.queue[1] then
		--self.queue[1]:draw()
	end
end