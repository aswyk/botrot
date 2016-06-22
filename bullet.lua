Class = require("hump.class")
require("entity")
require("mixins.health")
require("entity")
local lg = love.graphics
--local lk = love.keyboard
--local font_14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
--local font_16 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 16)

local AngCor = -90
Bullet = Class {name = "Bullet", __includes = {"Entity", "Damage"}}
function Bullet:init(x, y, ang, r, g, b, a)
	Entity.init(self)
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
    --self.m_scale = 0.25
    self.m_scale = 0.25

    -- Original m_bulletSpeedUnScaled value = 50
    self.m_bulletSpeedUnScaled = 100;
    self.m_bulletSpeed = self.m_bulletSpeedUnScaled * self.m_scale;
    self.m_xVel = 0
    self.m_yVel = 0

    self.m_xVel = self.m_BulletSpeed * math.cos((AngCor+self.m_ang_deg) * math.pi / 180)
    self.m_yVel = self.m_BulletSpeed * math.sin((AngCor+self.m_ang_deg) * math.pi / 180)

    --self.m_geom = {32,0,    64,64,   0,64,   32,0}
    -- Making bot smaller, 64 is a bit to big

    --self.m_geom = {0,-5,   2,-3,  2,5,  -2,5,  -2,-3,  0,-5}

    --[[
        Define geomerty with scale variable in play. This means we can scale the
        object without touching the geometry.
    ]]--

    --[[
    self.m_geom = {0, -5*self.m_scale,
                    2*self.m_scale, -3*self.m_scale,
                    2*self.m_scale ,5*self.m_scale ,
                    -2*self.m_scale ,5*self.m_scale,
                    -2*self.m_scale,-3*self.m_scale,
                    0,-5*self.m_scale}
    ]]--

    -- Redefining the geometry so its just a rect. At small scales its hard to see the pointed shape.
    self.m_geom = { -self.m_x_size*self.m_scale, -self.m_y_size*self.m_scale,
                    self.m_x_size*self.m_scale , -self.m_y_size*self.m_scale ,
                    self.m_x_size*self.m_scale, self.m_y_size*self.m_scale,
                    -self.m_x_size*self.m_scale, self.m_y_size*self.m_scale,
                    -self.m_x_size*self.m_scale, -self.m_y_size*self.m_scale}


    --love.graphics.line( points )
end

function Bullet:updatePosition()

    self.m_x = self.m_x + self.m_xVel
    self.m_y = self.m_y + self.m_yVel

    --[[if self.m_y <= 0 then
        self.m_y = 720
    end
    if self.m_x >= 1280 then
        self.m_x = 350
    end]]--

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

function Bullet:draw()

    -- Attemppting to draw to framebuffer for shell. Its not called framebuffer
    -- anymore, but rather "canvas"

    -- Changing framebuffers. This means any drawing commands will be drawing on the fb, duh. ;git add -
    --lg.setCanvas(self.m_fb)

    --lg.clear( )

    lg.push()

    lg.setColor(self.m_r, self.m_g, self.m_b, self.m_a)

    lg.translate( self.m_x, self.m_y )
    lg.rotate( self.m_ang_rad )
    love.graphics.line( self.m_geom )

    lg.pop()
end
