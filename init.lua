local requireRoot = (...):gsub("[./]?[^./]+$", "") --Hell reduction behavior: root of requires, for requiring files inside of Hades

local class = require(requireRoot .. ".lib.classy")
local LazyLoader = require(requireRoot .. ".utils.LazyLoader")
local ReflowBatcher = require(requireRoot .. ".utils.ReflowBatcher")


--[[
function h()
    local COLOR = { 103 / 255, 134 / 255, 184 / 255 }
    local DEAD_COLOR = { 200 / 255, 200 / 255, 200 / 255 }

    function love.load()
        love.graphics.setDefaultFilter("nearest", "nearest")

        gradient = love.graphics.newShader("shaders/focused.frag")
        filledImage = love.graphics.newImage("window.png")
        local width, height = filledImage:getDimensions()

        gradient:send("u_texel", { 1 / width, 1 / height })
        gradient:sendColor("u_color", { COLOR[1], COLOR[2], COLOR[3] })
        gradient:send("u_alpha", 0.25)
    end

    function love.update()

    end

    function love.draw()
        love.graphics.setShader(gradient)
        love.graphics.draw(filledImage, 50, 50, 0, 10, 10, 0, 0)
        love.graphics.setShader()
    end

    function love.mousepressed()

    end

    function love.mousereleased()

    end

    function love.mousemoved(x, y, deltaX, deltaY, istouch)
        
    end
end]]


local Hades = {
    _root = nil,
    _tree = nil,

    class = class,
}
Hades.internal = LazyLoader.new("internal", Hades)
Hades.elements = LazyLoader.new("elements", Hades)


function Hades.init(tree)
    assert(Hades.tree == nil, "Hades already initialized")

    local root = Hades.elements.Root:new()
    tree:Reparent(root)
    
    Hades._root = root
    Hades._tree = tree
end


function Hades.update(delta)
    -- Handle batched reflows
    ReflowBatcher.update()
end


function Hades.draw()
    Hades._root:Draw()
end

function Hades.mousepressed()

end

function Hades.mousereleased()

end

function Hades.mousemoved()

end

function Hades.keypressed()

end

function Hades.keyreleased()

end

function Hades.textinput()

end


function Hades.reflow(element)
    element = element or Hades._root
    ReflowBatcher.add(element)
end


return Hades