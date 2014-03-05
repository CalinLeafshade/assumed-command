
require('vector')

ShipObject = Class("ShipObject")

function ShipObject:initialize(ship,x,y)
	self.ship = ship
	self.position = Vector(x,y)
	self.ship:add(self)
end

function ShipObject:contains(x,y)
	return false -- default implementation
end

function ShipObject:onClick(b)
	
end

