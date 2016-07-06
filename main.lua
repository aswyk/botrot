package.path = package.path .. ";./?/init.lua"
HC = require("HC")
require("bot")
require("bullet")
require("entity")
shapes = require("HC.shapes")
require("ai")
local screen_w = 0
local screen_h = 0

local lg = love.graphics
local font14 = nil

local bot = Bot(300, 600, 45, 50, 255, 50, 255)
local bot2 = Bot(120, 40, 45, 50, 255, 50, 255)


local dt = 0.1
function love.load()
    -- Setting up a nice font
    local font14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
    love.graphics.setFont(font14)

    screen_w = love.graphics.getWidth( )
    screen_h = love.graphics.getHeight( )
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        bot:fire()
    end
end

function love.keyreleased(key, scancode)

end

function love.mousemoved( x, y, dx, dy )
end

function love.update(_dt)
    if love.keyboard.isDown( "a" ) then
        bot:turnLeftSlow()
    end

    if love.keyboard.isDown( "d" ) then
        bot:turnRightSlow()
    end

    if love.keyboard.isDown( "w" ) then
        bot:applyMainThruster()
    end

    if love.keyboard.isDown( "s" ) then
        bot:applyReverseThruster()
    end

    if love.keyboard.isDown( "q" ) then
        bot:applyStrafeLeftThruster()
    end

    if love.keyboard.isDown( "e" ) then
        bot:applyStrafeRightThruster()
    end

	if love.keyboard.isDown("lshift") then
		--awww yes, bullet hell!
        bot:fire()
	end


	em:update(_dt)
	em:update_collision(_dt)
	dt = _dt
end

function love.draw()
    lg.push()

        lg.setColor(255,100,100,150)
        lg.line(5,5,  screen_w-5,5,  screen_w-5,screen_h-5,  5,screen_h-5,  5,5)

        lg.push()
            lg.setColor(150,255,150,255)
            lg.print( "botrot", 10, 10)
        lg.pop()
	em:render(dt)
    lg.pop()
end
