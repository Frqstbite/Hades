return function(hades)
    local class = hades.class


    local HierarchicalObject = class("HierarchicalObject", {
        Parent = 0, --Nil by default
        Children = 0, --Empty table by default
    })


    function HierarchicalObject:__init__(parent, children)
        self.Parent = nil
        self.Children = children or {}

        if parent then
            self:Reparent(parent)
        end
    end


    function HierarchicalObject:Reparent(parent)
        if self.Parent then
            self.Parent.Children[self] = nil
        end

        if parent then
            self.Parent = parent
            parent.Children[self] =  true
        end
    end


    function HierarchicalObject:Destroy()
        self:Reparent(nil)

        for child in next, self.Children do
            child:Destroy()
        end

        self.Children = nil
    end


    return HierarchicalObject:finalize()
end