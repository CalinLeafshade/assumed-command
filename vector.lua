
Vector = Class('vector')

local function isVector(a)
	return type(a) == "table" and a.isInstanceOf and a:isInstanceOf(Vector)
end

function Vector:initialize(x,y)
	self.x = x
	self.y = y
end

function Vector:clone()
	return Vector(self:unpack())
end

function Vector:unpack()
	return self.x, self.y
end

function Vector:normalized()
	return self / self:len()
end

function Vector:len()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector:dist(other)
	if isVector(other) then
		return dist(self.x, self.y, other.x, other.y)
	else
		error("Incorrect type")
	end
end



function Vector.__add(a,b)
	if isVector(a) and isVector(b) then
		return Vector(a.x + b.x, a.y + b.y)
	else
		error("Incorrect types for vector addition")
	end
end

function Vector.__sub(a,b)
	if isVector(a) and isVector(b) then
		return Vector(a.x - b.x, a.y - b.y)
	else
		error("Incorrect types for vector subtraction")
	end
end

function Vector:__tostring()
	return "Vector (" .. self.x .. ", " .. self.y .. ")"
end

function Vector.__mul(a,b)
	if isVector(b) then
		if isVector(a) then
			return Vector(a.x * b.x, a.y * b.y)
		else
			a,b = b,a
		end
	end
	if type(b) == "number" then
		return Vector(a.x * b, a.y * b)
	else
		error("Cannot multiple vector with type " .. type(b))
	end
end

function Vector.__div(a,b)
	if isVector(b) then
		if isVector(a) then
			return Vector(a.x / b.x, a.y / b.y)
		else
			error("Cannot divide by vector")
		end
	end
	if type(b) == "number" then
		return Vector(a.x / b, a.y / b)
	else
		error("Cannot divide vector with type " .. type(b))
	end
end
