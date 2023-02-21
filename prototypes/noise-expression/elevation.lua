local config = require "config"
local noise = require("noise")
local tne = noise.to_noise_expression

data:extend{{
    type = "noise-expression",
    name = "map",
    intended_property = "elevation",
    expression = {
        type = "function-application",
        function_name = "clamp",
        arguments = {
            tne(config.generation.specIslandSize) - noise.var("distance"),
            {
                type = "function-application",
                function_name = "clamp",
                arguments = {
                    {
                        type = "function-application",
                        function_name = "clamp",
                        arguments = {
                            {
                                type = "function-application",
                                function_name = "clamp",
                                arguments = {
                                    {
                                        type = "function-application",
                                        function_name = "absolute-value",
                                        arguments = {noise.var("x")}
                                    } - tne(config.generation.spawnerZoneDistanceFromCenterX),
                                    tne(-math.huge),
                                    tne(config.generation.spawnerZoneDistanceFromCenterX) + tne(config.generation.spawnerZoneWidth) - {
                                        type = "function-application",
                                        function_name = "absolute-value",
                                        arguments = {noise.var("x")}
                                    }
                                }
                            },
                            tne(-math.huge),
                            tne(config.generation.spawnerZoneHeight / 2) - {
                                type = "function-application",
                                function_name = "absolute-value",
                                arguments = {noise.var("y")}
                            }
                        }
                    },
                    {
                        type = "function-application",
                        function_name = "clamp",
                        arguments = {
                            {
                                type = "function-application",
                                function_name = "clamp",
                                arguments = {
                                    {
                                        type = "function-application",
                                        function_name = "absolute-value",
                                        arguments = {noise.var("y")}
                                    } - tne(config.generation.bitterPathDistanceFromCenterY),
                                    tne(-math.huge),
                                    tne(config.generation.bitterPathDistanceFromCenterY) + tne(config.generation.bitterPathWidth) - {
                                        type = "function-application",
                                        function_name = "absolute-value",
                                        arguments = {noise.var("y")}
                                    }
                                }
                            },
                            tne(-math.huge),
                            tne(config.generation.spawnerZoneDistanceFromCenterX) - {
                                type = "function-application",
                                function_name = "absolute-value",
                                arguments = {noise.var("x")}
                            }
                        }
                    },
                    tne(math.huge)
                }
            },
            tne(math.huge)
        }
    }
}}