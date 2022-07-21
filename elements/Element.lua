return function(hades)
    local HierarchicalObject = hades.internal.HierarchicalObject


    local Element = HierarchicalObject:subclass("Element", {
        -- Absolute values in pixels
        Width = true,
        Height = true,
        ContentWidth = true,
        ContentHeight = true,

        X = true,
        Y = true,
        ContentX = true,
        ContentY = true,

        -- Anchor point
        AnchorX = true,
        AnchorY = true,

        -- Size
        WidthScale = true,
        WidthOffset = true,

        HeightScale = true,
        HeightOffset = true,

        MinWidth = true,
        MaxWidth = true,

        MinHeight = true,
        MaxHeight = true,

        PaddingLeft = true,
        PaddingTop = true,
        PaddingRight = true,
        PaddingBottom = true,

        -- Position
        XScale = true,
        XOffset = true,

        YScale = true,
        YOffset = true,
    })


    function Element:__init__(props)
        props = props or {}
        
        self.AnchorX = props.AnchorX or 0
        self.AnchorY = props.AnchorY or 0

        self.WidthScale = props.WidthScale or 1
        self.WidthOffset = props.WidthOffset or 0
        self.HeightScale = props.HeightScale or 1
        self.HeightOffset = props.HeighrOffset or 0

        self.MinWidth = props.MinWidth or 0
        self.MaxWidth = props.MaxWidth or -1
        self.MinHeight = props.MinHeight or 0
        self.MaxHeight = props.MaxHeight or -1

        self.PaddingLeft = props.PaddingLeft or 0
        self.PaddingTop = props.PaddingTop or 0
        self.PaddingRight = props.PaddingRight or 0
        self.PaddingBottom = props.PaddingBottom or 0

        -- Position
        self.XScale = props.XScale or 0
        self.XOffset = props.XOffset or 0
        self.YScale = props.YScale or 0
        self.YOffset = props.YOffset or 0

        HierarchicalObject.__init__(self, props.Parent, props.Children)
    end


    -- Returns calculated width in pixels
    -- Called in RecalculateTransform
    function Element:CalculateWidth()
        return (self.Parent.ContentWidth * self.WidthScale) + self.WidthOffset
    end


    -- Returns calculated height in pixels
    -- Called in RecalculateTransform
    function Element:CalculateHeight()
        return (self.Parent.ContentHeight * self.HeightScale) + self.HeightOffset
    end


    -- Returns calculated X position in pixels
    -- Called in RecalculateTransform
    function Element:CalculateX()
        local anchorOffset = self.AnchorX * self.Width
        return self.Parent.ContentX + (self.Parent.ContentWidth * self.XScale) + self.XOffset - anchorOffset
    end


    -- Returns calculated Y position in pixels
    -- Called in RecalculateTransform
    function Element:CalculateY()
        local anchorOffset = self.AnchorY * self.Height
        return self.Parent.ContentY + (self.Parent.ContentHeight * self.YScale) + self.YOffset - anchorOffset
    end


    -- PURE
    -- Default implementation updates the size and position according to the parent, and then clamps to the maximum and minimum size
    -- Called when position or size is set
    function Element:RecalculateTransform()
        -- Recalculate and clamp size
        local width = self:CalculateWidth()
        local height = self:CalculateHeight()

        if self.MinWidth >= 0 then
            width = math.max(width, self.MinWidth)
        end
        if self.MaxWidth >= 0 then
            width = math.min(width, self.MaxWidth)
        end
        if self.MinHeight >= 0 then
            width = math.max(width, self.MinHeight)
        end
        if self.MaxHeight >= 0 then
            width = math.min(width, self.MaxHeight)
        end

        self.Width = width
        self.Height = height
        self.ContentWidth = width - self.PaddingLeft - self.PaddingRight
        self.ContentHeight = height - self.PaddingTop - self.PaddingBottom

        -- Recalculate position
        -- Varying amounts of width and height are subtracted from the final position based on the anchor point
        local x = self:CalculateX()
        local y = self:CalculateY()

        self.X = x
        self.Y = y
        self.ContentX = x + self.PaddingLeft
        self.ContentY = y + self.PaddingTop
    end


    -- PURE
    -- Called when position and size should be recalculated
    -- Default implementation does the calculation and reflows children afterward
    function Element:Reflow()
        self:RecalculateTransform()

        for child in next, self.Children do
            child:Reflow()
        end
    end


    -- PURE
    -- Called every frame
    -- Default implementation just renders children
    function Element:Draw()
        for child in next, self.Children do
            child:Draw()
        end
    end


    -- Reflow when reparented
    function Element:Reparent(parent)
        HierarchicalObject.Reparent(self, parent)
        hades.reflow(self)
    end


    function Element:SetSize(wscale, woffset, hscale, hoffset)
        self.WidthScale = wscale
        self.WidthOffset = woffset
        self.HeightScale = hscale
        self.HeightOffset = hoffset

        hades.reflow(self)
    end


    function Element:SetPosition(xscale, xoffset, yscale, yoffset)
        self.XScale = xscale
        self.XOffset = xoffset
        self.YScale = yscale
        self.YOffset = yoffset

        hades.reflow(self)
    end


    function Element:SetAnchorPoint(x, y)
        self.AnchorX = x
        self.AnchorY = y

        hades.reflow(self)
    end


    return Element:finalize()
end