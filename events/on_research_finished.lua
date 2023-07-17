local Generation = require("__factory-fight__.scripts.generation")

return function (event)
    local research = event.research
    local force = research.force

    if research.name == "new-linked-chest-1" then
        Generation.addLinkedChest(force, 2)
    end
end