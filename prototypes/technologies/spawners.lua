data:extend{
    {
        type = "technology",
        name = "small-spawner",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/biter-spawner.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "small-biter-spawner"
            },
            {
                type = "unlock-recipe",
                recipe = "small-spitter-spawner"
            }
        },
        prerequisites = { "military" },
        unit = {
            count = 75,
            ingredients = { { "automation-science-pack", 1 } },
            time = 15
        },
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "medium-spawner",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/biter-spawner.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "medium-biter-spawner"
            },
            {
                type = "unlock-recipe",
                recipe = "medium-spitter-spawner"
            }
        },
        prerequisites = { "small-spawner", "military-2", "steel-processing" },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 }
            },
            time = 15
        },
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "big-spawner",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/biter-spawner.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "big-biter-spawner"
            },
            {
                type = "unlock-recipe",
                recipe = "big-spitter-spawner"
            }
        },
        prerequisites = { "medium-spawner", "military-3" },
        unit = {
            count = 150,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 }
            },
            time = 15
        },
        order = "a-f-a"
    },
    {
        type = "technology",
        name = "behemoth-spawner",
        icon_size = 64,
        icon_mipmaps = 4,
        icon = "__base__/graphics/icons/biter-spawner.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "behemoth-biter-spawner"
            },
            {
                type = "unlock-recipe",
                recipe = "behemoth-spitter-spawner"
            }
        },
        prerequisites = { "big-spawner", "military-4", "production-science-pack" },
        unit = {
            count = 250,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
                { "utility-science-pack",    1 }
            },
            time = 15
        },
        order = "a-f-a"
    }
}