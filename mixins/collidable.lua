Class = require('hump.class')

local get_handler = function(coll, other)
	if not coll:is_a(Collidable) then return function(self, other, sep_v, dt) end end
	if coll.collision_handler[other.name] then
		return coll.collision_handler[other.name]
	end

	return coll.collision_handler["*"]
end

Collidable = Class{
	name = "Collidable";

	collision = function(self, other, sep_v, dt)
		local own = get_handler(self, other)
		local theirs = get_handler(other, self)
		local x=-sep_v.x
		local y=-sep_v.y
		return own(self, other, sep_v, dt), theirs(other, self, {x, y, x=x, y=y}, dt)
	end;
	collision_handler = {["*"] = function(self, other, sep_v, dt) end},
}
