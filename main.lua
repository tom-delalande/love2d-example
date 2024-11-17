local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

local cardSprite

local deck = {
    cards = {},
    transform = {
        x = screenWidth / 2 - 63,
        y = screenHeight / 2 - 88,
        width = 126,
        height = 176,
    },
}

local cards = {}

local function align(deck)
    local deck_height = 10 / #deck.cards
    for position, card in ipairs(deck.cards) do
        if not card.dragging then
            card.target_transform.x = deck.transform.x - deck_height * (position - 1)
            card.target_transform.y = deck.transform.y + deck_height * (position - 1)
        end
    end
end


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

local function new_card()
    return {
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
        },
        is_on_deck = true,
    }
end

function love.load()
    cardSprite = love.graphics.newImage("card.png")

    for _ = 1, 52 do
        local card = new_card()
        table.insert(cards, card)
        table.insert(deck.cards, card)
    end
end

function love.draw()
    love.graphics.clear(0.937, 0.945, 0.96, 1)
    for _, card in ipairs(deck.cards) do
        love.graphics.draw(cardSprite, card.transform.x, card.transform.y)
    end
    for _, card in ipairs(cards) do
        if not card.is_on_deck then
            love.graphics.draw(cardSprite, card.transform.x, card.transform.y)
        end
    end
end

function love.mousepressed(x, y)
    for position = #deck.cards, 1, -1 do
        local card = deck.cards[position]
        if x > card.transform.x
            and x < card.transform.x + card.transform.width
            and y > card.transform.y
            and y < card.transform.y + card.transform.height
        then
            card.dragging = true
            break
        end
    end
end

function love.update(delta_time)
    for _, card in ipairs(cards) do
        if card.dragging then
            card.target_transform.x = love.mouse.getX() - card.transform.width / 2
            card.target_transform.y = love.mouse.getY() - card.transform.height / 2
        end
        move(card, delta_time)
        align(deck)
    end
end

function love.mousereleased()
    for position, card in ipairs(deck.cards) do
        if card.dragging == true then
            card.dragging = false
            card.is_on_deck = false
            table.remove(deck.cards, position)
        end
    end
end
