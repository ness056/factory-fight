local hit_effects = require("__base__.prototypes.entity.hit-effects")

local function spawner_integration(scale)
    return
    {
        filename = "__base__/graphics/entity/spawner/spawner-idle-integration.png",
        variation_count = 4,
        width = 258,
        height = 188,
        shift = util.by_pixel(2, -2),
        frame_count = 1,
        line_length = 1,
        scale = scale,
        hr_version =
        {
            filename = "__base__/graphics/entity/spawner/hr-spawner-idle-integration.png",
            variation_count = 4,
            width = 522,
            height = 380,
            shift = util.by_pixel(3, -3),
            frame_count = 1,
            line_length = 1,
            scale = 0.5 * scale
        }
    }
end

local function spawner_idle_animation(variation, tint, scale)
    return {
        layers =
        {
            {
                filename = "__base__/graphics/entity/spawner/spawner-idle.png",
                line_length = 4,
                width = 248,
                height = 180,
                frame_count = 8,
                animation_speed = 0.18,
                direction_count = 1,
                run_mode = "forward-then-backward",
                shift = util.by_pixel(2, -4),
                y = variation * 180 * 2,
                scale = scale,
                hr_version =
                {
                    filename = "__base__/graphics/entity/spawner/hr-spawner-idle.png",
                    line_length = 4,
                    width = 490,
                    height = 354,
                    frame_count = 8,
                    animation_speed = 0.18,
                    direction_count = 1,
                    run_mode = "forward-then-backward",
                    shift = util.by_pixel(3, -2),
                    y = variation * 354 * 2,
                    scale = 0.5 * scale
                }
            },
            {
                filename = "__base__/graphics/entity/spawner/spawner-idle-mask.png",
                flags = { "mask" },
                width = 140,
                height = 118,
                frame_count = 8,
                animation_speed = 0.18,
                run_mode = "forward-then-backward",
                shift = util.by_pixel(-2, -14),
                line_length = 4,
                tint = tint,
                y = variation * 118 * 2,
                scale = scale,
                hr_version =
                {
                    filename = "__base__/graphics/entity/spawner/hr-spawner-idle-mask.png",
                    flags = { "mask" },
                    width = 276,
                    height = 234,
                    frame_count = 8,
                    animation_speed = 0.18,
                    run_mode = "forward-then-backward",
                    shift = util.by_pixel(-1, -14),
                    line_length = 4,
                    tint = tint,
                    y = variation * 234 * 2,
                    scale = 0.5 * scale
                }
            },
            {
                filename = "__base__/graphics/entity/spawner/spawner-idle-shadow.png",
                draw_as_shadow = true,
                width = 232,
                height = 176,
                frame_count = 8,
                animation_speed = 0.18,
                run_mode = "forward-then-backward",
                shift = util.by_pixel(36, -2),
                line_length = 4,
                y = variation * 176 * 2,
                scale = scale,
                hr_version =
                {
                    filename = "__base__/graphics/entity/spawner/hr-spawner-idle-shadow.png",
                    draw_as_shadow = true,
                    width = 464,
                    height = 406,
                    frame_count = 8,
                    animation_speed = 0.18,
                    run_mode = "forward-then-backward",
                    shift = util.by_pixel(36, 10),
                    line_length = 4,
                    y = variation * 406 * 2,
                    scale = 0.5 * scale
                }
            }
        }
    }
end

local function spawner_die_animation(variation, tint, scale)
    return
    {
        layers =
        {
            {
                filename = "__base__/graphics/entity/spawner/spawner-die.png",
                line_length = 8,
                width = 248,
                height = 178,
                frame_count = 8,
                direction_count = 1,
                shift = util.by_pixel(2, -2),
                y = variation * 178,
                scale = scale,
                hr_version =
                {
                    filename = "__base__/graphics/entity/spawner/hr-spawner-die.png",
                    line_length = 8,
                    width = 490,
                    height = 354,
                    frame_count = 8,
                    direction_count = 1,
                    shift = util.by_pixel(3, -2),
                    y = variation * 354,
                    scale = 0.5 * scale
                }
            },
            {
                filename = "__base__/graphics/entity/spawner/spawner-die-mask.png",
                flags = { "mask" },
                width = 140,
                height = 118,
                frame_count = 8,
                direction_count = 1,
                shift = util.by_pixel(-2, -14),
                line_length = 8,
                tint = tint,
                y = variation * 118,
                scale = scale,
                hr_version =
                {
                    filename = "__base__/graphics/entity/spawner/hr-spawner-die-mask.png",
                    flags = { "mask" },
                    width = 276,
                    height = 234,
                    frame_count = 8,
                    direction_count = 1,
                    shift = util.by_pixel(-1, -14),
                    line_length = 8,
                    tint = tint,
                    y = variation * 234,
                    scale = 0.5 * scale
                }
            },
            {
                filename = "__base__/graphics/entity/spawner/spawner-die-shadow.png",
                draw_as_shadow = true,
                width = 232,
                height = 176,
                frame_count = 8,
                direction_count = 1,
                shift = util.by_pixel(36, -2),
                line_length = 8,
                y = variation * 176,
                scale = scale,
                hr_version =
                {
                    filename = "__base__/graphics/entity/spawner/hr-spawner-die-shadow.png",
                    draw_as_shadow = true,
                    width = 466,
                    height = 406,
                    frame_count = 8,
                    direction_count = 1,
                    shift = util.by_pixel(36, 10),
                    line_length = 8,
                    y = variation * 406,
                    scale = 0.5 * scale
                }
            }
        }
    }
end

local function create_spawner_size(typeName, size, scale)

    local typeName_ = typeName .. "-"
    if typeName == "normal" then
        typeName_ = ""
    end

    data:extend{
        {
            type = "unit-spawner",
            name = size .. "-" .. typeName_ .. "biter-spawner",
            minable = {mining_time = 1, result = size .. "-" .. typeName_ .. "biter-spawner"},
            icon = "__base__/graphics/icons/biter-spawner.png",
            icon_size = 64,
            icon_mipmaps = 4,
            flags = { "placeable-player", "placeable-enemy", "not-repairable" },
            max_health = 350,
            order = "b-d-a",
            subgroup = "enemies",
            resistances =
            {
                {
                    type = "physical",
                    decrease = 2,
                    percent = 15
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            working_sound =
            {
                sound =
                {
                    {
                        filename = "__base__/sound/creatures/spawner.ogg",
                        volume = 0.6
                    }
                }
            },
            dying_sound =
            {
                {
                    filename = "__base__/sound/creatures/spawner-death-1.ogg",
                    volume = 1.0
                },
                {
                    filename = "__base__/sound/creatures/spawner-death-2.ogg",
                    volume = 1.0
                }
            },
            healing_per_tick = 0.02,
            collision_box = { { -3.05, -2.05 }, { 2.05, 2.05 } },
            map_generator_bounding_box = { { -4.2, -3.2 }, { 3.2, 3.2 } },
            selection_box = { { -3.5 * scale, -2.5 * scale }, { 2.5 * scale, 2.5 * scale } },
            damaged_trigger_effect = hit_effects.biter(),
            -- in ticks per 1 pu
            pollution_absorption_absolute = 20,
            pollution_absorption_proportional = 0.01,
            corpse = size .. "-" .. typeName_ .. "biter-spawner-corpse",
            dying_explosion = "biter-spawner-die",
            max_count_of_owned_units = 7,
            max_friends_around_to_spawn = 5,
            animations =
            {
                spawner_idle_animation(0, biter_spawner_tint, scale),
                spawner_idle_animation(1, biter_spawner_tint, scale),
                spawner_idle_animation(2, biter_spawner_tint, scale),
                spawner_idle_animation(3, biter_spawner_tint, scale)
            },
            integration =
            {
                sheet = spawner_integration(scale)
            },
            result_units = {{ size .. "-" .. typeName_ .. "biter", {{ 0.0, 1 }}}},
            -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
            spawning_cooldown = { 360, 150 },
            spawning_radius = 0,
            spawning_spacing = 3,
            max_spawn_shift = 0,
            max_richness_for_spawn_shift = 100,
            autoplace = enemy_autoplace.enemy_spawner_autoplace(0),
            call_for_help_radius = 50,
            spawn_decorations_on_expansion = true,
            spawn_decoration =
            {
                {
                    decorative = "light-mud-decal",
                    spawn_min = 0,
                    spawn_max = 2,
                    spawn_min_radius = 2,
                    spawn_max_radius = 5
                },
                {
                    decorative = "dark-mud-decal",
                    spawn_min = 0,
                    spawn_max = 3,
                    spawn_min_radius = 2,
                    spawn_max_radius = 6
                },
                {
                    decorative = "enemy-decal",
                    spawn_min = 3,
                    spawn_max = 5,
                    spawn_min_radius = 2,
                    spawn_max_radius = 7
                },
                {
                    decorative = "enemy-decal-transparent",
                    spawn_min = 4,
                    spawn_max = 20,
                    spawn_min_radius = 2,
                    spawn_max_radius = 14,
                    radius_curve = 0.9
                },
                {
                    decorative = "muddy-stump",
                    spawn_min = 2,
                    spawn_max = 5,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6
                },
                {
                    decorative = "red-croton",
                    spawn_min = 2,
                    spawn_max = 8,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6
                },
                {
                    decorative = "red-pita",
                    spawn_min = 1,
                    spawn_max = 5,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6
                }
            }
        },

        {
            type = "corpse",
            name = size .. "-" .. typeName_ .. "biter-spawner-corpse",
            flags = { "placeable-neutral", "placeable-off-grid", "not-on-map" },
            icon = "__base__/graphics/icons/biter-spawner-corpse.png",
            icon_size = 64,
            icon_mipmaps = 4,
            collision_box = { { -2 * scale, -2 * scale }, { 2 * scale, 2 * scale } },
            selection_box = { { -2 * scale, -2 * scale }, { 2 * scale, 2 * scale } },
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = 15 * 60 * 60,
            subgroup = "corpses",
            order = "c[corpse]-b[biter-spawner]",
            final_render_layer = "remnants",
            animation =
            {
                spawner_die_animation(0, biter_spawner_tint, scale),
                spawner_die_animation(1, biter_spawner_tint, scale),
                spawner_die_animation(2, biter_spawner_tint, scale),
                spawner_die_animation(3, biter_spawner_tint, scale)
            },
            ground_patch =
            {
                sheet = spawner_integration(scale)
            }
        },

        {
            type = "unit-spawner",
            name = size .. "-" .. typeName_ .. "spitter-spawner",
            minable = {mining_time = 1, result = size .. "-" .. typeName_ .. "spitter-spawner"},
            icon = "__base__/graphics/icons/spitter-spawner.png",
            icon_size = 64,
            icon_mipmaps = 4,
            flags = { "placeable-player", "placeable-enemy", "not-repairable" },
            max_health = 350,
            order = "b-d-b",
            subgroup = "enemies",
            working_sound =
            {
                sound =
                {
                    {
                        filename = "__base__/sound/creatures/spawner-spitter.ogg",
                        volume = 0.6
                    }
                }
            },
            dying_sound =
            {
                {
                    filename = "__base__/sound/creatures/spawner-death-1.ogg",
                    volume = 1.0
                },
                {
                    filename = "__base__/sound/creatures/spawner-death-2.ogg",
                    volume = 1.0
                }
            },
            resistances =
            {
                {
                    type = "physical",
                    decrease = 2,
                    percent = 15
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            healing_per_tick = 0.02,
            collision_box = { { -3.05, -2.05 }, { 2.05, 2.05 } },
            map_generator_bounding_box = { { -4.2, -3.2 }, { 3.2, 3.2 } },
            selection_box = { { -3.5 * scale, -2.5 * scale }, { 2.5 * scale, 2.5 * scale } },
            damaged_trigger_effect = hit_effects.biter(),
            pollution_absorption_absolute = 20,
            pollution_absorption_proportional = 0.01,
            corpse = size .. "-" .. typeName_ .. "spitter-spawner-corpse",
            dying_explosion = "spitter-spawner-die",
            max_count_of_owned_units = 7,
            max_friends_around_to_spawn = 5,
            animations =
            {
                spawner_idle_animation(0, spitter_spawner_tint, scale),
                spawner_idle_animation(1, spitter_spawner_tint, scale),
                spawner_idle_animation(2, spitter_spawner_tint, scale),
                spawner_idle_animation(3, spitter_spawner_tint, scale)
            },
            integration = spawner_integration(scale),
            result_units = {{ size .. "-" .. typeName_ .. "spitter", {{ 0.0, 1 }}}},
            -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
            spawning_cooldown = { 360, 360 },
            spawning_radius = 0,
            spawning_spacing = 3,
            max_spawn_shift = 0,
            max_richness_for_spawn_shift = 100,
            -- distance_factor used to be 1, but Twinsen says:
            -- "The number or spitter spwners should be roughly equal to the number of biter spawners(regardless of difficulty)."
            -- (2018-12-07)
            autoplace = enemy_autoplace.enemy_spawner_autoplace(0),
            call_for_help_radius = 50,
            spawn_decorations_on_expansion = true,
            spawn_decoration =
            {
                {
                    decorative = "light-mud-decal",
                    spawn_min = 0,
                    spawn_max = 2,
                    spawn_min_radius = 2,
                    spawn_max_radius = 5
                },
                {
                    decorative = "dark-mud-decal",
                    spawn_min = 0,
                    spawn_max = 3,
                    spawn_min_radius = 2,
                    spawn_max_radius = 6
                },
                {
                    decorative = "enemy-decal",
                    spawn_min = 3,
                    spawn_max = 5,
                    spawn_min_radius = 2,
                    spawn_max_radius = 7
                },
                {
                    decorative = "enemy-decal-transparent",
                    spawn_min = 4,
                    spawn_max = 20,
                    spawn_min_radius = 2,
                    spawn_max_radius = 14,
                    radius_curve = 0.9
                },
                {
                    decorative = "muddy-stump",
                    spawn_min = 2,
                    spawn_max = 5,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6
                },
                {
                    decorative = "red-croton",
                    spawn_min = 2,
                    spawn_max = 8,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6
                },
                {
                    decorative = "red-pita",
                    spawn_min = 1,
                    spawn_max = 5,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6
                },
                {
                    decorative = "lichen-decal",
                    spawn_min = 1,
                    spawn_max = 2,
                    spawn_min_radius = 2,
                    spawn_max_radius = 7
                }
            }
        },

        {
            type = "corpse",
            name = size .. "-" .. typeName_ .. "spitter-spawner-corpse",
            flags = { "placeable-neutral", "placeable-off-grid", "not-on-map" },
            icon = "__base__/graphics/icons/biter-spawner-corpse.png",
            icon_size = 64,
            icon_mipmaps = 4,
            collision_box = { { -2 * scale, -2 * scale }, { 2 * scale, 2 * scale } },
            selection_box = { { -2 * scale, -2 * scale }, { 2 * scale, 2 * scale } },
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = 15 * 60 * 60,
            subgroup = "corpses",
            order = "c[corpse]-b[biter-spawner]",
            final_render_layer = "remnants",
            animation =
            {
                spawner_die_animation(0, biter_spawner_tint, scale),
                spawner_die_animation(1, biter_spawner_tint, scale),
                spawner_die_animation(2, biter_spawner_tint, scale),
                spawner_die_animation(3, biter_spawner_tint, scale)
            },
            ground_patch =
            {
                sheet = spawner_integration(scale)
            }
        }
    }
end

local function create_spawner_type(typeName)
    create_spawner_size(typeName, "small", 0.7)
    create_spawner_size(typeName, "medium", 0.8)
    create_spawner_size(typeName, "big", 0.9)
    create_spawner_size(typeName, "behemoth", 1)
end

create_spawner_type("normal")
create_spawner_type("water")
create_spawner_type("fire")
create_spawner_type("plant")
create_spawner_type("rock")
create_spawner_type("electric")