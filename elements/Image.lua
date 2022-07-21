return function(hades)
    local Element = hades.elements.Element


    local Image = Element:subclass("Image", {
        Image = true,
        Quad = true,
    })


    function Image:__init__(props)
        Element.__init__(self, props)

        self.Image = props.Image
        self.Quad = props.Quad
    end


    function Image:Draw()
        local image = self.Image
        if image then
            local scaleX = self.Width / image:getWidth()
            local scaleY = self.Height / image:getHeight()
            
            local quad = self.Quad
            if quad then
                love.graphics.draw(image, quad, self.X, self.Y, 0, scaleX, scaleY)
            else
                love.graphics.draw(image, self.X, self.Y, 0, scaleX, scaleY)
            end
        end
        
        Element.Draw(self)
    end


    return Image:finalize()
end