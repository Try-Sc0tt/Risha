local STI = require("sti")
require("player")

--loads assets
function love.load()
	Map = STI("Map/1.lua", {"box2d"})
	World = love.physics.newWorld(0,0)
	World:setCallbacks(beginContact, endContact)
	Map:box2d_init(World)
	Map.layers.solid.visible = false
	background = love.graphics.newImage("assets/backgrounds/background.png")
	Player:load()
end


--updates every frame
function love.update(dt)
	World:update(dt)
	Player:update(dt)
end


--draws assets
function love.draw()
	love.graphics.draw(background)
	Map:draw(0, 0, 2, 2)
	love.graphics.push()
	love.graphics.scale(2,2)

	Player:draw()

	love.graphics.pop()

end

function love.keypressed(key)
	Player:jump(key)
end

function beginContact(a, b, collision)
	Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
	Player:endContact(a, b, collision)
end