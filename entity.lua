Class = require("hump.class")
require("entity_manager")
Entity = Class{
	name = "Entity";
	init = function(self)
		print(self.em)
		self.em:add(self)
	end;

	die = function(self)
		self.em:remove(self)
	end;
	em = EntityManager(12)
}
