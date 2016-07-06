Class = require("hump.class")
require("entity_manager")
require("mixins.linked_list")
em = EntityManager()

Entity = Class{
	name = "Entity";
	__includes = {LinkedList.Node};
	init = function(self)
		em:push_front(self)
	end;

	die = function(self)
		if self.__can_die then
			self.__is_dead = true
		end
	end;
	__can_die = true;
	__is_dead = false;
}

