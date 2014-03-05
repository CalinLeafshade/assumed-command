
require('state')
require('ship')
require('camera')
require('testavatar')

GameMain = State("GameMain")

GameMain.camera = Camera()

local testAvatar

function GameMain:focus()
	if not self.ship then
		self.ship = Ship()
		testAvatar = TestAvatar(self.ship,128,128)
	end
end

function GameMain:update(dt)
	if self.dragging then 
		mx,my = love.mouse.getPosition()
		self.camera:lookAt(self.dragging[3] + (self.dragging[1] - mx) / self.camera.scale, self.dragging[4] + (self.dragging[2] - my) / self.camera.scale,true)
	end
	self.camera:update(dt)
	self.ship:update(dt)
end

function GameMain:mouseDown(x,y,b)
	if b == "r" then
		self.camera:lookAt(self.camera:worldCoords(x,y))
	elseif b == "m" then
		self.dragging = {x,y,self.camera:getPosition()}
	elseif b == "wu" then
		self.camera:zoomIn()
	elseif b == "wd" then
		self.camera:zoomOut()
	elseif b == "l" then
		local o = self.ship:objectAt(self.camera:worldCoords(x,y))
		if o then
			o:onClick(b)
		end
	end
end

function GameMain:mouseUp(x,y,b)
	if b == "m" then
		self.dragging = false
	end
end

function GameMain:draw()
	self.camera:attach()
	self.ship:draw()
	self.camera:detach()
	love.graphics.print(TLpath.status,5,5)
end