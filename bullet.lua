Class = require("hump.class")
require("entity")
require("mixins.health")
require("entity")
shapes = require("HC.shapes")
Polygon = require("HC.polygon")
local lg = love.graphics

local AngCor = -90
Bullet = Class {name = "Bullet", __includes = {Entity, Damage, shapes.ConvexPolygonShape, Collidable}}
function Bullet:init(x, y, ang, r, g, b, a)
	Entity.init(self)
	Damage.init(self)
    self.m_x = x
    self.m_y = y
    self.m_ang_deg = ang
    self.m_ang_rad = self.m_ang_deg * math.pi / 180
    self.m_turnAngSlow = 3
    self.m_turnAngFast = 8

    self.m_active = false

    self.m_r = r
    self.m_g = g
    self.m_b = b
    self.m_a = a

    self.m_x_size = 4;
    self.m_y_size = 20;
    self.m_scale = 0.25;

    self.m_bulletSpeedUnScaled = 100;
    self.m_bulletSpeed = self.m_bulletSpeedUnScaled * self.m_scale;
    self.m_xVel = 0
    self.m_yVel = 0

    self.m_xVel = self.m_bulletSpeed * math.cos((AngCor+self.m_ang_deg) * math.pi / 180)
    self.m_yVel = self.m_bulletSpeed * math.sin((AngCor+self.m_ang_deg) * math.pi / 180)

    shapes.ConvexPolygonShape.init(self, Polygon(-self.m_x_size*self.m_scale, -self.m_y_size*self.m_scale,
                    self.m_x_size*self.m_scale , -self.m_y_size*self.m_scale ,
                    self.m_x_size*self.m_scale, self.m_y_size*self.m_scale,
                    -self.m_x_size*self.m_scale, self.m_y_size*self.m_scale))
end

function Bullet:decon()
	HC.remove(self)
end

function Bullet:update(dt)
    self.m_x = self.m_x + self.m_xVel
    self.m_y = self.m_y + self.m_yVel
	if self.m_x > 1280 then
		self:die()
	elseif self.m_x < 0 then
		self:die()
	end

	if self.m_y > 720 then
		self:die()
	elseif self.m_y < 0 then
		self:die()
	end

	self:moveTo(self.m_x, self.m_y)
	self:setRotation(self.m_ang_rad)
end

function Bullet:printInfo()
    local str = "Bullet[" .. self.m_x .. "," .. self.m_y .. "]"
    print(str)
end

function Bullet:getX()
    return self.m_x
end

function Bullet:getY()
    return self.m_y
end

function Bullet:draw(dt)
    lg.push()

    lg.setColor(self.m_r, self.m_g, self.m_b, self.m_a)

	love.graphics.polygon('line', self._polygon:unpack())

    lg.pop()
end

Bullet.collision_handler["*"] = function(self, other, sep_v, dt)
	self:die()
end

