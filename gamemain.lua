
require('state')
require('ship')
require('viewport')
require('testavatar')

GameMain = State("GameMain")

local mainViewport

local testAvatar

function GameMain:focus()
	if not self.ship then
		self.ship = Ship()
		mainViewport = Viewport(self.ship)
		testAvatar = TestAvatar(self.ship,128,128)
	end
end

function GameMain:update(dt)
	if self.dragging then 
		mx,my = love.mouse.getPosition()
		mainViewport:lookAt(self.dragging[3] + (self.dragging[1] - mx) / self.camera.scale, self.dragging[4] + (self.dragging[2] - my) / self.camera.scale,true)
	end
	mainViewport:setBounds(love.graphics.getWidth(), love.graphics.getHeight())
	mainViewport:update(dt)
	self.ship:update(dt)
end

function GameMain:mouseDown(x,y,b)
	if b == "r" then
		mainViewport:lookAt(mainViewport:worldCoords(x,y))
	elseif b == "m" then
		self.dragging = {x,y,mainViewport:getPosition()}
	elseif b == "wu" then
		mainViewport:zoomIn()
	elseif b == "wd" then
		mainViewport:zoomOut()
	elseif b == "l" then
		local o = self.ship:objectAt(mainViewport:worldCoords(x,y))
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
	mainViewport:draw(0,0)
end