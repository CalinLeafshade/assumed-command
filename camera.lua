
local lg = love.graphics

require('vector')
Camera = Class("Camera")

function Camera:initialize()
	self.position = Vector(0,0)
	self.scale = 1
	self.speed = 5
	
end

function Camera:attach()
	local cx,cy = (self.width or lg.getWidth())/(2*self.scale), (self.height or lg.getHeight())/(2*self.scale)
	lg.push()
	lg.scale(self.scale)
	lg.translate(cx, cy)
	lg.translate(-self.position.x, -self.position.y)
end

function Camera:detach()
	lg.pop()
end

function Camera:draw(fn)
	self:attach()
	fn()
	self:detach()
end

function Camera:getPosition()
	return self.position:unpack()
end

function Camera:zoomIn()
	self.scale = math.min(self.scale * 2,4)
end

function Camera:zoomOut()
	self.scale = math.max(self.scale / 2,1)
end

function Camera:lookAt(x,y,snap)
	self.target = Vector(x,y)
	if snap then
		self.position = self.target:clone()
	end
end

function Camera:update(dt)
	self.position = lerp(self.position, self.target or self.position,dt * self.speed)
end

function Camera:localCoords(x,y)
	local w,h = self.width or love.graphics.getWidth(),self.height or love.graphics.getHeight()
	x,y = x - self.position.x, y - self.position.y
	return x*self.scale + w/2, y*self.scale + h/2
end

function Camera:worldCoords(x,y)
	local w,h = self.width or love.graphics.getWidth(),self.height or love.graphics.getHeight()
	x,y = (x - w/2) / self.scale, (y - h/2) / self.scale
	return x+self.position.x, y+self.position.y
end

function Camera:mousepos()
	return self:worldCoords(love.mouse.getPosition())
end