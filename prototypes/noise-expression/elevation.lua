local noise = require("noise")
local tne = noise.to_noise_expression

data:extend{{
    type = "noise-expression",
    name = "map",
    intended_property = "elevation",
    expression = {
        type = "function-application",
        function_name = "subtract",
        arguments = {
            tne(_CONFIG.generation.specIslandSize),
            noise.var("distance")
        }
    }
}}