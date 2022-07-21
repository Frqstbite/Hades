local ReflowBatcher = {
    _reflowingSet = {},
    _reflowingArray = {},
}


function ReflowBatcher.update()
    if #ReflowBatcher._reflowingArray > 0 then
        for _, element in next, ReflowBatcher._reflowingArray do
            element:Reflow()
        end

        ReflowBatcher._reflowingSet = {}
        ReflowBatcher._reflowingArray = {}
    end
end


function ReflowBatcher.add(element)
    if ReflowBatcher._reflowingSet[element] then
        return
    end

    ReflowBatcher._reflowingSet[element] = true
    table.insert(ReflowBatcher._reflowingArray, element)
end


return ReflowBatcher