local cardSprite
local cardWidth = 126
local cardHeight = 176

function love.load()
    cardSprite = love.graphics.newImage("card.png")
end

function love.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.clear(0.937, 0.945, 0.96, 1)
    love.graphics.draw(cardSprite, (screenWidth - cardWidth) / 2, (screenHeight - cardHeight) / 2)
end
