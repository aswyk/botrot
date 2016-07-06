Class = require("hump.class")
require("mixins.collidable")
require("mixins.linked_list")

EntityManager = Class {
	name = "EntityManager";
	__includes = {LinkedList};
	update = function (self, dt)
		local curr = self.head
		while curr do
			if curr.__is_dead then
				_, curr = self:remove(curr)
			else
				curr:update(dt)
				if curr:is_a(shapes.Shape) and curr:is_a(Collidable) then
					for shape, delta in pairs(HC.collisions(curr)) do
						curr:collision(shape, delta, dt)
					end
				end
				curr = curr.n
			end
		end
	end;

	render = function (self, dt)
		local curr = self.head
		while curr do
			if type(curr.draw) == "function" then
				curr:draw(dt)
			end
			curr = curr.n
		end
	end;

	update_collision = function(self, dt)
	end;

	remove = function (self, entity)
		print("removing", entity)
		local p, n = LinkedList.remove(self, entity)
		entity:decon();
		return p, n
	end;
}
