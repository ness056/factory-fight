data:extend {
    {
        type = "technology",
        name = "logistics",
        icon_size = 256,
        icon_mipmaps = 4,
        icon = "__base__/graphics/technology/logistics-1.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "underground-belt"
            },
            {
                type = "unlock-recipe",
                recipe = "splitter"
            },
            {
                type = "unlock-recipe",
                recipe = "loader_"
            }
        },
        unit = {
            count = 20,
            ingredients = { { "automation-science-pack", 1 } },
            time = 15
        },
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "logistics-2",
        icon_size = 256,
        icon_mipmaps = 4,
        icon = "__base__/graphics/technology/logistics-2.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "fast-transport-belt"
            },
            {
                type = "unlock-recipe",
                recipe = "fast-underground-belt"
            },
            {
                type = "unlock-recipe",
                recipe = "fast-splitter"
            },
            {
                type = "unlock-recipe",
                recipe = "fast-loader_"
            }
        },
        prerequisites = { "logistics", "logistic-science-pack" },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 }
            },
            time = 30
        },
        order = "a-f-b"
    },
    {
        type = "technology",
        name = "logistics-3",
        icon_size = 256,
        icon_mipmaps = 4,
        icon = "__base__/graphics/technology/logistics-3.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "express-transport-belt"
            },
            {
                type = "unlock-recipe",
                recipe = "express-underground-belt"
            },
            {
                type = "unlock-recipe",
                recipe = "express-splitter"
            },
            {
                type = "unlock-recipe",
                recipe = "express-loader_"
            }
        },
        prerequisites = { "production-science-pack", "lubricant" },
        unit = {
            count = 300,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 }
            },
            time = 15
        },
        order = "a-f-c"
    }
}
