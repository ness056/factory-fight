data:extend{
    {
        type = "technology",
        name = "new-linked-chest-1",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        effects = {
            {
                type = "give-item",
                item = "linked-chest",
                count = 1
            }
        },
        prerequisites = {"logistics"},
        unit = {
            count = 100,
            ingredients = { { "automation-science-pack", 1 } },
            time = 15
        },
        upgrade = true,
        order = "a-f-a"
    }
}