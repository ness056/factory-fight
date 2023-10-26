local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
    {
        type = "simple-entity-with-owner",
        name = "teleporter",
        flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game" },
        animations = {{
            filename = "__factory-fight__/graphics/entities/teleporter-animation.png",
            priority = "extra-high",
            width = 500,
            height = 500,
            scale = 0.5,
            frame_count = 32,
            line_length = 8,
            animation_speed = 0.35
        }},
        collision_box = { { -2.25, -2.25 }, { 2.25, 2.25 } }
    },

    {
        type = "linked-container",
        name = "linked-chest",
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = "linked-chest" },
        max_health = 100,
        corpse = "wooden-chest-remnants",
        dying_explosion = "wooden-chest-explosion",
        collision_box = { { -0.35, -0.35 }, { 0.35, 0.35 } },
        fast_replaceable_group = "container",
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        inventory_size = 1000,
        open_sound = { filename = "__base__/sound/wooden-chest-open.ogg", volume = 0.6 },
        close_sound = { filename = "__base__/sound/wooden-chest-close.ogg", volume = 0.6 },
        gui_mode = "none",
        picture =
        {
            layers =
            {
                {
                    filename = "__base__/graphics/entity/linked-chest/linked-chest.png",
                    priority = "extra-high",
                    width = 34,
                    height = 38,
                    frame_count = 7,
                    shift = util.by_pixel(0, -2),
                    hr_version =
                    {
                        filename = "__base__/graphics/entity/linked-chest/hr-linked-chest.png",
                        priority = "extra-high",
                        width = 66,
                        height = 74,
                        frame_count = 7,
                        shift = util.by_pixel(0, -2),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/linked-chest/linked-chest-shadow.png",
                    priority = "extra-high",
                    width = 56,
                    height = 24,
                    repeat_count = 7,
                    shift = util.by_pixel(12, 5),
                    draw_as_shadow = true,
                    hr_version =
                    {
                        filename = "__base__/graphics/entity/linked-chest/hr-linked-chest-shadow.png",
                        priority = "extra-high",
                        width = 112,
                        height = 46,
                        repeat_count = 7,
                        shift = util.by_pixel(12, 4.5),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        }
    },

    {
        type = "simple-entity-with-owner",
        name = "linked-chest-blocker",
        flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game" },
        picture = {
            filename = "__base__/graphics/terrain/lab-tiles/lab-dark-2.png",
            size = 32
        },
        collision_box = { { -0.49, -0.49 }, { 0.49, 0.49 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
    },

    {
        type = "electric-pole",
        name = "giant-substation",
        icon = "__base__/graphics/icons/substation.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = "substation" },
        max_health = 200,
        corpse = "substation-remnants",
        dying_explosion = "substation-explosion",
        track_coverage_during_build_by_moving = true,
        resistances =
        {
            {
                type = "fire",
                percent = 90
            }
        },
        collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        damaged_trigger_effect = hit_effects.entity({ { -0.5, -2.5 }, { 0.5, 0.5 } }),
        drawing_box = { { -1, -3 }, { 1, 1 } },
        maximum_wire_distance = 64,
        supply_area_distance = 32,
        pictures =
        {
            layers =
            {

                {
                    filename = "__base__/graphics/entity/substation/substation.png",
                    priority = "high",
                    width = 70,
                    height = 136,
                    tint = {r=1, g=0.8, b=1, a=1},
                    direction_count = 4,
                    shift = util.by_pixel(0, 1 - 32),
                    hr_version =
                    {
                        filename = "__base__/graphics/entity/substation/hr-substation.png",
                        priority = "high",
                        width = 138,
                        height = 270,
                        tint = {r=1, g=0.8, b=1, a=1},
                        direction_count = 4,
                        shift = util.by_pixel(0, 1 - 32),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/substation/substation-shadow.png",
                    priority = "high",
                    width = 186,
                    height = 52,
                    direction_count = 4,
                    shift = util.by_pixel(62, 42 - 32),
                    draw_as_shadow = true,
                    hr_version =
                    {
                        filename = "__base__/graphics/entity/substation/hr-substation-shadow.png",
                        priority = "high",
                        width = 370,
                        height = 104,
                        direction_count = 4,
                        shift = util.by_pixel(62, 42 - 32),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        vehicle_impact_sound = sounds.generic_impact,
        open_sound = sounds.electric_network_open,
        close_sound = sounds.electric_network_close,
        working_sound =
        {
            sound =
            {
                filename = "__base__/sound/substation.ogg",
                volume = 0.4
            },
            max_sounds_per_type = 3,
            audible_distance_modifier = 0.32,
            fade_in_ticks = 30,
            fade_out_ticks = 40,
            use_doppler_shift = false
        },
        connection_points =
        {
            {
                shadow =
                {
                    copper = util.by_pixel(136, 8),
                    green = util.by_pixel(124, 8),
                    red = util.by_pixel(151, 9)
                },
                wire =
                {
                    copper = util.by_pixel(0, -86),
                    green = util.by_pixel(-21, -82),
                    red = util.by_pixel(22, -81)
                }
            },
            {
                shadow =
                {
                    copper = util.by_pixel(133, 9),
                    green = util.by_pixel(144, 21),
                    red = util.by_pixel(110, -3)
                },
                wire =
                {
                    copper = util.by_pixel(0, -85),
                    green = util.by_pixel(15, -70),
                    red = util.by_pixel(-15, -92)
                }
            },
            {
                shadow =
                {
                    copper = util.by_pixel(133, 9),
                    green = util.by_pixel(127, 26),
                    red = util.by_pixel(127, -8)
                },
                wire =
                {
                    copper = util.by_pixel(0, -85),
                    green = util.by_pixel(0, -66),
                    red = util.by_pixel(0, -97)
                }
            },
            {
                shadow =
                {
                    copper = util.by_pixel(133, 9),
                    green = util.by_pixel(111, 20),
                    red = util.by_pixel(144, -3)
                },
                wire =
                {
                    copper = util.by_pixel(0, -86),
                    green = util.by_pixel(-15, -71),
                    red = util.by_pixel(15, -92)
                }
            }
        },
        radius_visualisation_picture =
        {
            filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
            width = 12,
            height = 12,
            priority = "extra-high-no-scale"
        },
        water_reflection =
        {
            pictures =
            {
                filename = "__base__/graphics/entity/substation/substation-reflection.png",
                priority = "extra-high",
                width = 20,
                height = 28,
                shift = util.by_pixel(0, 55),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    },

    {
        type = "electric-pole",
        name = "invisible-giant-substation",
        icon = "__base__/graphics/icons/substation.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game", "not-on-map" },
        max_health = 200,
        track_coverage_during_build_by_moving = true,
        resistances =
        {
            {
                type = "fire",
                percent = 90
            }
        },
        drawing_box = { { -1, -3 }, { 1, 1 } },
        maximum_wire_distance = 64,
        supply_area_distance = 32,
        pictures = util.empty_sprite(),
        connection_points = 
        {
            {
                shadow =
                {
                    copper = util.by_pixel(136, 8),
                    green = util.by_pixel(124, 8),
                    red = util.by_pixel(151, 9)
                },
                wire =
                {
                    copper = util.by_pixel(0, -86),
                    green = util.by_pixel(-21, -82),
                    red = util.by_pixel(22, -81)
                }
            },
        },
        radius_visualisation_picture = util.empty_sprite(),
        water_reflection = {pictures = util.empty_sprite()},
        draw_copper_wires = false,
        draw_circuit_wires = false
    },
}

local giantStorageTank = table.deepcopy(data.raw["storage-tank"]["storage-tank"])
giantStorageTank.name = "giant-storage-tank"
giantStorageTank.fluid_box.base_area = 10000
giantStorageTank.flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game" }

data:extend{giantStorageTank}