data:extend {
    {
        type = "recipe",
        name = "loader_",
        enabled = false,
        ingredients =
        {
            { "iron-plate", 10 },
            { "iron-gear-wheel", 6 },
            { "electronic-circuit", 6 },
            { "transport-belt", 4 },
        },
        energy_required = 1.5,
        result = "loader_"
    },
    {
        type = "recipe",
        name = "fast-loader_",
        enabled = false,
        ingredients =
        {
            { "iron-plate", 20 },
            { "iron-gear-wheel", 15 },
            { "electronic-circuit", 10 },
            { "loader_", 1 },
        },
        energy_required = 1.5,
        result = "fast-loader_"
    },
    {
        type = "recipe",
        name = "express-loader_",
        enabled = false,
        ingredients =
        {
            { "iron-plate", 25 },
            { "iron-gear-wheel", 20 },
            { "advanced-circuit", 10 },
            { "fast-loader_", 1 },
        },
        energy_required = 1.5,
        result = "express-loader_"
    }
}