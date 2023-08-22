data:extend{
    {
        type = "technology",
        name = "new-linked-chest-1",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        prerequisites = {"logistics"},
        unit = {
            count = 100,
            ingredients = { { "automation-science-pack", 1 } },
            time = 15
        },
        upgrade = true,
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "new-linked-chest-2",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        prerequisites = {"logistics-2", "new-linked-chest-1"},
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 }
            },
            time = 15
        },
        upgrade = true,
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "new-linked-chest-3",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        prerequisites = {"logistics-3", "new-linked-chest-2"},
        unit = {
            count = 250,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 }
            },
            time = 15
        },
        upgrade = true,
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "new-linked-chest-4",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        prerequisites = {"logistics-3", "utility-science-pack", "new-linked-chest-3"},
        unit = {
            count = 250,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 }
            },
            time = 15
        },
        upgrade = true,
        order = "a-f-a"
    }
}