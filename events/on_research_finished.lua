local Generation = require("__factory-fight__.scripts.generation")

return function (event)
    local research = event.research
    local forceName = research.force.name

    if research.name == "new-linked-chest-1" then
        Generation.addLinkedChest(forceName, 1)
    elseif research.name == "new-linked-chest-2" then
        Generation.addLinkedChest(forceName, 2)
    elseif research.name == "new-linked-chest-3" then
        Generation.addLinkedChest(forceName, 3)
    elseif research.name == "new-linked-chest-4" then
        Generation.addLinkedChest(forceName, 4)
    end
end