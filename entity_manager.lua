Class = require("hump.class")

EntityManager = Class {name = "EntityManager"; entities = {}}

function EntityManager:update(dt)
	local i = 1
	local remove = {}
	for k, v in pairs(self.entities) do
		if v == false then
			table.insert(remove, i)
		end
		if v == true and k:update(dt) == true then
			table.remove(remove, i)
		end
		i = i + 1
	end

	for i, v in ipairs(remove) do
		table.remove(self.entities, v)
	end
end

function EntityManager:render(dt)
	for k, v in pairs(self.entities) do
		if v == true then
			k:draw(dt)
		end
	end
end

function EntityManager:add(entity)
	self.entities[entity] = true
end

function EntityManager:remove(entity)
	self.entities[entity] = false
end
