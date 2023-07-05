local basic_belt_tint = { r = 1, g = 0.76, b = 0.25, a = 0.82}
local fast_belt_tint = { r = 0.89, g = 0.09, b = 0.09, a = 0.82}
local express_belt_tint = { r = 0.26, g = 0.75, b = 0.98, a = 0.82}

data:extend{
    {
        type = "item",
        name = "loader_",
        icons = {
            {
                icon = "__factory-fight__/graphics/icons/loader-base.png",
                icon_size = 64
            },
            {
                icon = "__factory-fight__/graphics/icons/loader-mask.png",
                icon_size = 64,
                tint = basic_belt_tint
            }
        },
        order = "d[loaders]-a[loader]",
        stack_size = 50,
        subgroup = "belt",
        place_result = "loader_"
    },
    {
        type = "item",
        name = "fast-loader_",
        icons = {
            {
                icon = "__factory-fight__/graphics/icons/loader-base.png",
                icon_size = 64
            },
            {
                icon = "__factory-fight__/graphics/icons/loader-mask.png",
                icon_size = 64,
                tint = fast_belt_tint
            }
        },
        order = "d[loaders]-b[fast-loader]",
        stack_size = 50,
        subgroup = "belt",
        place_result = "fast-loader_"
    },
    {
        type = "item",
        name = "express-loader_",
        icons = {
            {
                icon = "__factory-fight__/graphics/icons/loader-base.png",
                icon_size = 64
            },
            {
                icon = "__factory-fight__/graphics/icons/loader-mask.png",
                icon_size = 64,
                tint = express_belt_tint
            }
        },
        order = "d[loaders]-c[express-loader]",
        stack_size = 50,
        subgroup = "belt",
        place_result = "express-loader_"
    }
}