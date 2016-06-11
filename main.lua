package.path = package.path .. ";./?/init.lua"
require("bot")
HC = require("HC")
shapes = require("HC.shapes")
local screen_w = 0
local screen_h = 0

local lg = love.graphics
local font14 = nil

local bot = bot.create(50, 50, 0, 50, 255, 50, 255)
local colliding = false

function love.load()
    -- Setting up a nice font
    local font14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
    love.graphics.setFont(font14)

    screen_w = love.graphics.getWidth( )
    screen_h = love.graphics.getHeight( )
	mouse = HC.circle(400, 300, 20)
	mouse:moveTo(love.mouse.getPosition())
	foo = HC.circle(400, 300, 30)
end

function love.keypressed(key, scancode, isrepeat)


end

function love.keyreleased(key, scancode)

end

function love.update(dt)
	colliding = false
	mouse:moveTo(love.mouse.getPosition())

	for shape, delta in pairs(HC.collisions(mouse)) do
		colliding = true
		break
	end
end

function love.mousemoved( x, y, dx, dy )
end

function love.draw()
    lg.push()

        lg.setColor(255,100,100,150)
        lg.line(5,5,  screen_w-5,5,  screen_w-5,screen_h-5,  5,screen_h-5,  5,5)

        lg.push()
            lg.setColor(150,255,150,255)
            --love.graphics.setFont(font_14)
            lg.print( "botrot", 10, 10)
        lg.pop()

        bot:draw()
		foo:draw('fill')
		if colliding then
			mouse:draw('line')
		else
			mouse:draw('fill')
		end
    lg.pop()


end
