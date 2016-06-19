Class = require("hump.class")
require("entity_manager")
Entity = Class{
	name = "Entity";
	init = function(self)
		self.em:add(self)
	end;

	die = function(self)
		self.em:remove(self)
	end;
	em = EntityManager()
}
