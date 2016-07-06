Class = require("hump.class")

LinkedList = Class{
	name = "LinkedList";
	head = nil;
	tail = nil;
	__ll_len = 0;
	push_back = function(self, node)
		if not self.head and not self.tail then
			self.head = node
			self.tail = self.head
			self.__ll_len = 1
			return
		end

		self.tail:insert_next(node)
		self.tail = node
		self.__ll_len = self.__ll_len + 1
	end;

	push_front = function(self, node)
		if not self.head and not self.tail then
			self.head = node
			self.tail = self.head
			self.__ll_len = 1
			return
		end

		self.head:insert_prev(node)
		self.head = node
		self.__ll_len = self.__ll_len + 1
	end;

	remove = function(self, node)
		if not node.p and not node.n then return nil, nil end
		p, n = node:remove()
		if not p and not n then
			--linked list is empty
			self.head = nil
			self.tail = nil
		end

		if node == self.head and n then
			self.head = n
		end

		if node == self.tail and p then
			self.tail = p
		end
		self.__ll_len = self.__ll_len - 1
		return p, n
	end;

	len = function(self)
		return self.__ll_len
	end;

	Node = Class {
		-- seriously, don't call these functions directly unless you're only using Node by itself (no LinkedList).
		-- you can fuck up the LinkedList's bookeeping if you don't use it's functions
		name = "LinkedListNode";
		n = nil;
		p = nil;

		insert_next = function(self, n)
			if self.n then
				self.n.p = n
			end
			n.n = self.n
			n.p = self
			self.n = n
		end;

		insert_prev = function(self, p)
			if self.p then
				self.p.n = p
			end
			p.p = self.p
			p.n = self
			self.p = p
		end;

		remove = function(self)
			if self.p then
				self.p.n = self.n
			end

			if self.n then
				self.n.p = self.p
			end
			local p = self.p
			local n = self.n
			self.p = nil
			self.n = nil
			return p, n
		end;
	};
}
