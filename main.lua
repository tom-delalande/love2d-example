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
    target_transform = {
        x = (screenWidth - 126) / 2,
        y = (screenHeight - 176) / 2,
        width = 126,
        height = 176
    },
    velocity = {
        x = 0,
        y = 0,
    }
}

local function move(card, dt)
    local momentum = 0.75
    if (card.target_transform.x ~= card.transform.x or card.velocity.x ~= 0) or
        (card.target_transform.y ~= card.transform.y or card.velocity.y ~= 0) then
        card.velocity.x = momentum * card.velocity.x +
            (1 - momentum) * (card.target_transform.x - card.transform.x) * 30 * dt
        card.velocity.y = momentum * card.velocity.y +
            (1 - momentum) * (card.target_transform.y - card.transform.y) * 30 * dt
        card.transform.x = card.transform.x + card.velocity.x
        card.transform.y = card.transform.y + card.velocity.y
    end
end

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

function love.update(delta_time)
    if card.dragging then
        card.target_transform.x = love.mouse.getX() - card.transform.width / 2
        card.target_transform.y = love.mouse.getY() - card.transform.height / 2
    end
    move(card, delta_time)
end

function love.mousereleased()
    card.dragging = false
end

