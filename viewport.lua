
local lg = love.graphics

require('camera')

Viewport = Class("Viewport")


function Viewport:initialize(ship)
	self.ship = ship
	self.width = love.graphics.getWidth()
	self.height = love.graphics.getHeight()
	self.camera = Camera()
	self:makeCanvas()
end

function Viewport:makeCanvas()
	self.canvas = lg.newCanvas(self.width, self.height)
end

function Viewport:setBounds(w,h)
	self.width = w
	self.height = h
	self:makeCanvas()
end

function Viewport:lookAt(x,y,snap)
	self.camera:lookAt(x,y,snap)
end

function Viewport:zoomIn()
	self.camera:zoomIn()
end

function Viewport:zoomOut()
	self.camera:zoomOut()
end

function Viewport:getPosition(x,y)
	return self.camera:getPosition()
end

function Viewport:follow(object)
	self.follower = object
	self:lookAt(self.follower.position.x, self.follower.position.y, true)
end

function Viewport:worldCoords(x,y)
	return self.camera:worldCoords(x,y)
end

function Viewport:update(dt)
	self.camera.width = self.width
	self.camera.height = self.height
	if self.follower then
		self:lookAt(self.follower:getPosition())
	end
	self.camera:update(dt)
end

function Viewport:draw(x,y)
	lg.setCanvas(self.canvas)
	lg.clear()
	lg.push()
	lg.origin()
	self.camera:attach()
	self.ship:draw()
	self.camera:detach()
	lg.pop()
	lg.setCanvas()
	lg.setColor(255,255,255)
	lg.draw(self.canvas,x,y)
end
