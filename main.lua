package.path = package.path .. ";./?/init.lua"
require("bot")
require("bullet")

local screen_w = 0
local screen_h = 0

local lg = love.graphics
local font14 = nil

local bot = Bot(300, 600, 45, 50, 255, 50, 255)
local bot2 = Bot(120, 40, 45, 50, 255, 50, 255) 


print(bot, Bot)
function love.load()
    -- Setting up a nice font
    local font14 = love.graphics.newFont("assets/fonts/Hack-Regular.ttf", 14)
    love.graphics.setFont(font14)

    screen_w = love.graphics.getWidth( )
    screen_h = love.graphics.getHeight( )


end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        --bot:applyStrafeRightThruster()
        bot:fire()
    end
end

function love.keyreleased(key, scancode)

end

function love.mousemoved( x, y, dx, dy )
end

function love.update(dt)
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

    --if love.keyboard.isDown( "space" ) then
    --    bot:fire()
    --end




    --bot:update()
    bot:updatePosition()
	bot2:updatePosition()
	bot2:removeBullets()
    bot:removeBullets()
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
		bot2:draw()
        bot:drawBullets()
		bot2:drawBullets()
    lg.pop()


end
