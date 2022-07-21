return function(hades)
    local Element = hades.elements.Element


    local FunnyRectangle = Element:subclass("FunnyRectangle", {
        Color = true,
        Thickness = true,
    })


    function FunnyRectangle:__init__(props)
        Element.__init__(self, props)

        self.Color = props.Color or {1, 1, 1, 1}
        self.Thickness = props.Thickness or 25
    end


    function FunnyRectangle:Draw()
        love.graphics.setColor(self.Color)
        love.graphics.setLineWidth(self.Thickness)
        love.graphics.rectangle("line", self.X, self.Y, self.Width, self.Height)

        Element.Draw(self)
    end

    
    return FunnyRectangle:finalize()
end