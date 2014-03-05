
astar = require('astar')

Path = Class("Path")

function Path:initialize(ship,fromX,fromY,toX,toY)
	self.ship = ship
	local start = ship:getPathNode(fromX, fromY)
	local goal = ship:getPathNode(toX, toY)
	self.finder = {}
	if not start or not goal then
		self.finder.unreachable = true
		return
	end
	self.finder.path = { start }
	--ship:getRoute(self.finder,toX,toY)
	
	local function valid_node_func(a,b)
		if math.abs(a.x-b.x) == 1 and math.abs(a.y-b.y) == 1 then -- diagonal
			if ship:isWalkable(a.x,b.y) and ship:isWalkable(b.x,a.y) then
				return dist(a.x,a.y,b.x,b.y) <= math.sqrt(2)
			else
				return false
			end
		end
		return dist(a.x,a.y,b.x,b.y) <= math.sqrt(2)
	end
	
	local path = astar.path ( start, goal, self.ship.pathNodes, false, valid_node_func )
	self.finder.path = path
	print("Path", path[1].x)
end

function Path:waiting()
	return false
	--return not (self.finder.path.unreachable or self.finder.path.done)
end

local function isWalkableBetween(ship,p1,p2,step)
	step = step or 0.5
	local p1 = Vector(p1.x - 0.5, p1.y - 0.5)
	local p2 = Vector(p2.x - 0.5, p2.y - 0.5)
	local stepVec = (p2-p1):normalized() * step
	local testPoint = p1:clone()
	local testPointL = p1 + Vector(p1.y,-p1.x):normalized() * 0.5
	local testPointR = p1 + Vector(-p1.y,p1.x):normalized() * 0.5
	local tests = {}
	testPoint = testPoint + stepVec
	testPointL = testPointL + stepVec
	testPointR = testPointR + stepVec
	local function test(p,tests)
		local x,y = math.floor(p.x) + 1, math.floor(p.y) + 1
		table.insert(tests, {x,y})
		print(x,y)
		if not ship:isWalkable(x,y) then
			return false
		end
		return true
	end
	while testPoint:dist(p2) > step do
		if not test(testPointL,tests) then
			return false, tests
		end
		if not test(testPointR,tests) then
			return false, tests
		end
		if not test(testPoint,tests) then
			return false, tests
		end
		testPoint = testPoint + stepVec
		testPointL = testPointL + stepVec
		testPointR = testPointR + stepVec
	end
	return true,tests
end

function Path:optimize()
	self.pathCopy = {}
	for i,v in ipairs(self.finder.path) do
		self.pathCopy[i] = self.finder.path[i]
	end
	local i = 2
	local squareTests = {}
	while i < #self.finder.path do
		local ok, tests = isWalkableBetween(self.ship,self.finder.path[i-1], self.finder.path[i+1])
		for i,v in ipairs(tests or {}) do
			table.insert(squareTests,v)
		end
		if ok then
			table.remove(self.finder.path,i)
		else
			i = i + 1
		end
	end
	self.optimPathCopy = {}
	for i,v in ipairs(self.finder.path) do
		self.optimPathCopy[i] = self.finder.path[i]
	end
	self.optimTests = squareTests
	print("Test Count " .. #squareTests)
end

function Path:unreachable()
	return self.finder.unreachable
end

function Path:next()
	return table.remove(self.finder.path,1)
end

function Path:peek()
	return self.finder.path[1]
end

function Path:draw()
	local function drawPath(p)
		if not p then return end
		if #p < 2 then return end
		local verts = {}
		for i,v in ipairs(p) do
			local x,y = self.ship:tileToWorld(v.x,v.y)
			table.insert(verts,x)
			table.insert(verts,y)
		end
		love.graphics.line(unpack(verts))
	end
	love.graphics.setColor(255,0,0)
	drawPath(self.pathCopy)
	love.graphics.setColor(0,255,0)
	drawPath(self.optimPathCopy)
	if self.optimTests then
		local drawn = {}
		love.graphics.setColor(255,0,0,128)
		for i,v in ipairs(self.optimTests) do
			local x,y = v[1],v[2]
			if not drawn[x .."," .. y] then
				drawn[x .."," .. y] = true
				x,y = self.ship:tileToWorld(x,y)
				love.graphics.rectangle("fill",x-8,y-8,16,16)
			end
		end
	end
end


