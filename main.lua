local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local cardSprite
local card = {
    dragging = false,
    transform = {
        x = (screenWidth - 126) / 2,
        y = (screenHeight - 176) / 2,
        width = 126,
        height = 176
    },
}

function love.load()
    cardSprite = love.graphics.newImage("card.png")
end

function love.draw()
    love.graphics.clear(0.937, 0.945, 0.96, 1)
    love.graphics.draw(cardSprite, card.transform.x, card.transform.y)
end

function love.mousepressed(x, y)
    if x > card.transform.x
        and x < card.transform.x + card.transform.width
        and y > card.transform.y
        and y < card.transform.y + card.transform.height
    then
        card.dragging = true
    end
end

function love.update()
    if card.dragging then
        card.transform.x = love.mouse.getX() - card.transform.width / 2
        card.transform.y = love.mouse.getY() - card.transform.height / 2
    end
end

function love.mousereleased()
    card.dragging = false
end
