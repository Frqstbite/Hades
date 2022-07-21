return function(hades)
    local Element = hades.elements.Element


    local Root = Element:subclass("Root")


    function Root:__init__()
        Element.__init__(self, {
            MinWidth = -1,
            MinHeight = -1,
            MaxWidth = -1,
            MaxHeight = -1,
        })

        self:Reflow() --Run calculations immediately
    end


    function Root:CalculateWidth()
        return love.graphics.getWidth()
    end


    function Root:CalculateHeight()
        return love.graphics.getHeight()
    end


    function Root:CalculateX()
        return 0
    end


    function Root:CalculateY()
        return 0
    end


    -- Setters error
    function Root:Reparent(parent)
        error("Attempt to set parent of root element (no)")
    end


    function Root:SetSize(wscale, woffset, hscale, hoffset)
        error("Attempt to set size of root element (no)")
    end


    function Root:SetPosition(xscale, xoffset, yscale, yoffset)
        error("Attempt to set position of root element (no)")
    end


    function Root:SetAnchorPoint(x, y)
        error("Attempt to set anchor point of root element (no)")
    end


    return Root:finalize()
end