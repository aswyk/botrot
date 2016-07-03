require("mixins.collidable")
Class = require("hump.class")

EntityManager = Class {
	name = "EntityManager";
	init = function (self)
		self.entities = {}
		self.free = {}
	end;

	update = function (self, dt)
		local i = 1
		while i <= #self.entities do
			local e = self.entities[i]
			if e ~= nil and type(e.update) == "function" then
				e:update(dt)
				i = i + 1
			end
		end
	end;

	render = function (self, dt)
		for i=1, #self.entities do
			local e = self.entities[i]
			if e ~= nil and type(e.draw) == "function" then
				e:draw(dt)
			end
		end
	end;

	add = function (self, entity)
		if #self.free > 0 then
			local pos = table.remove(self.free, #self.free)
			table.insert(self.entities, pos, entity)
			return pos
		end
		table.insert(self.entities, entity)
		return #self.entities
	end;

	update_collision = function(self, dt)
		for i, e in ipairs(self.entities) do
			if e:is_a(shapes.Shape) and e:is_a(Collidable) then
				for shape, delta in pairs(HC.collisions(e)) do
					if e:collision(shape, delta, dt) then
						HC:remove(e)
					end
				end
			end
		end
	end;

	remove = function (self, id)
		if type(id) ~= "number" then
			return false
		end
		self.entities[id] = nil
		table.insert(self.free, id)
		return true
	end;
}
