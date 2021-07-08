love.graphics.setDefaultFilter("nearest", "nearest")
local Player = require("player")
local Coin = require("coin")
local GUI = require("gui")
local Spike = require("spike")
local Camera = require("camera")
local Map = require("map")

function love.load()
	Map:load()
	background = love.graphics.newImage("assets/backgrounds/background.png")
	GUI:load()
	Player:load()
end

function love.update(dt)
	World:update(dt)
	Player:update(dt)
	Coin.updateAll(dt)
	Spike.updateAll(dt)
	GUI:update(dt)
	Camera:setPosition(Player.x, 0)
	Map:update(dt)
end

function love.draw()
	love.graphics.draw(background)
	Map.level:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)

	Camera:apply()
	Player:draw()
	Coin.drawAll()
	Spike.drawAll()
	Camera:clear()

	GUI:draw()
end

function love.keypressed(key)
	Player:jump(key)
end

function beginContact(a, b, collision)
	if Coin.beginContact(a, b, collision) then return end
	if Spike.beginContact(a, b, collision) then return end
	Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
	Player:endContact(a, b, collision)
end