local stream_sprites =
{
    spine_animation = util.draw_as_glow
        {
            filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
            blend_mode = "additive",
            --tint = {r=1, g=1, b=1, a=0.5},
            line_length = 4,
            width = 32,
            height = 18,
            frame_count = 32,
            axially_symmetrical = false,
            direction_count = 1,
            animation_speed = 2,
            shift = { 0, 0 }
        },

    shadow =
    {
        filename = "__base__/graphics/entity/acid-projectile/projectile-shadow.png",
        line_length = 5,
        width = 28,
        height = 16,
        frame_count = 33,
        priority = "high",
        shift = { -0.09, 0.395 }
    },

    particle = util.draw_as_glow
        {
            filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
            priority = "extra-high",
            width = 64,
            height = 64,
            frame_count = 32,
            line_length = 8
        }
}

data:extend{
    {
        type = "stream",
        name = "small-fire-spitter-stream",
        flags = { "not-on-map" },
        -- disable to reduce lag
        -- smoke_sources =
        -- {
        --     {
        --         name = "soft-fire-smoke",
        --         frequency = 0.05, --0.25,
        --         position = { 0.0, 0 }, -- -0.8},
        --         starting_frame_deviation = 60
        --     }
        -- },
        particle_buffer_size = 90,
        particle_spawn_interval = 2,
        particle_spawn_timeout = 8,
        particle_vertical_acceleration = 0.005 * 0.60,
        particle_horizontal_speed = 0.2 * 0.75 * 1.5,
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_start_scale = 0.2,
        particle_loop_frame_count = 3,
        particle_fade_out_threshold = 0.9,
        particle_loop_exit_threshold = 0.25,
        action =
        {
            {
                type = "area",
                radius = 2.5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        -- {
                        --     type = "create-sticker",
                        --     sticker = "fire-sticker",
                        --     show_in_tooltip = true
                        -- },
                        {
                            type = "damage",
                            damage = { amount = _CONFIG.biters.fire.small_spitter_impact_damage / 6, type = "fire" },
                            apply_damage_to_trees = false
                        }
                    }
                }
            },
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-fire",
                            entity_name = "small-fire-spitter-fire",
                            show_in_tooltip = true
                        }
                    }
                }
            }
        },
        spine_animation = stream_sprites.spine_animation,
        shadow = stream_sprites.shadow,
        particle = stream_sprites.particle
    },

    {
        type = "stream",
        name = "medium-fire-spitter-stream",
        flags = { "not-on-map" },
        -- disable to reduce lag
        -- smoke_sources =
        -- {
        --     {
        --         name = "soft-fire-smoke",
        --         frequency = 0.05, --0.25,
        --         position = { 0.0, 0 }, -- -0.8},
        --         starting_frame_deviation = 60
        --     }
        -- },
        particle_buffer_size = 90,
        particle_spawn_interval = 2,
        particle_spawn_timeout = 8,
        particle_vertical_acceleration = 0.005 * 0.60,
        particle_horizontal_speed = 0.2 * 0.75 * 1.5,
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_start_scale = 0.2,
        particle_loop_frame_count = 3,
        particle_fade_out_threshold = 0.9,
        particle_loop_exit_threshold = 0.25,
        action =
        {
            {
                type = "area",
                radius = 2.5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        -- {
                        --     type = "create-sticker",
                        --     sticker = "fire-sticker",
                        --     show_in_tooltip = true
                        -- },
                        {
                            type = "damage",
                            damage = { amount = _CONFIG.biters.fire.medium_spitter_impact_damage / 6, type = "fire" },
                            apply_damage_to_trees = false
                        }
                    }
                }
            },
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-fire",
                            entity_name = "medium-fire-spitter-fire",
                            show_in_tooltip = true
                        }
                    }
                }
            }
        },
        spine_animation = stream_sprites.spine_animation,
        shadow = stream_sprites.shadow,
        particle = stream_sprites.particle
    },

    {
        type = "stream",
        name = "big-fire-spitter-stream",
        flags = { "not-on-map" },
        -- disable to reduce lag
        -- smoke_sources =
        -- {
        --     {
        --         name = "soft-fire-smoke",
        --         frequency = 0.05, --0.25,
        --         position = { 0.0, 0 }, -- -0.8},
        --         starting_frame_deviation = 60
        --     }
        -- },
        particle_buffer_size = 90,
        particle_spawn_interval = 2,
        particle_spawn_timeout = 8,
        particle_vertical_acceleration = 0.005 * 0.60,
        particle_horizontal_speed = 0.2 * 0.75 * 1.5,
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_start_scale = 0.2,
        particle_loop_frame_count = 3,
        particle_fade_out_threshold = 0.9,
        particle_loop_exit_threshold = 0.25,
        action =
        {
            {
                type = "area",
                radius = 2.5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        -- {
                        --     type = "create-sticker",
                        --     sticker = "fire-sticker",
                        --     show_in_tooltip = true
                        -- },
                        {
                            type = "damage",
                            damage = { amount = _CONFIG.biters.fire.big_spitter_impact_damage / 6, type = "fire" },
                            apply_damage_to_trees = false
                        }
                    }
                }
            },
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-fire",
                            entity_name = "big-fire-spitter-fire",
                            show_in_tooltip = true
                        }
                    }
                }
            }
        },
        spine_animation = stream_sprites.spine_animation,
        shadow = stream_sprites.shadow,
        particle = stream_sprites.particle
    },

    {
        type = "stream",
        name = "behemoth-fire-spitter-stream",
        flags = { "not-on-map" },
        -- disable to reduce lag
        -- smoke_sources =
        -- {
        --     {
        --         name = "soft-fire-smoke",
        --         frequency = 0.05, --0.25,
        --         position = { 0.0, 0 }, -- -0.8},
        --         starting_frame_deviation = 60
        --     }
        -- },
        particle_buffer_size = 90,
        particle_spawn_interval = 2,
        particle_spawn_timeout = 8,
        particle_vertical_acceleration = 0.005 * 0.60,
        particle_horizontal_speed = 0.2 * 0.75 * 1.5,
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5,
        particle_end_alpha = 1,
        particle_start_scale = 0.2,
        particle_loop_frame_count = 3,
        particle_fade_out_threshold = 0.9,
        particle_loop_exit_threshold = 0.25,
        action =
        {
            {
                type = "area",
                radius = 2.5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        -- {
                        --     type = "create-sticker",
                        --     sticker = "fire-sticker",
                        --     show_in_tooltip = true
                        -- },
                        {
                            type = "damage",
                            damage = { amount = _CONFIG.biters.fire.behemoth_spitter_impact_damage / 6, type = "fire" },
                            apply_damage_to_trees = false
                        }
                    }
                }
            },
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-fire",
                            entity_name = "behemoth-fire-spitter-fire",
                            show_in_tooltip = true
                        }
                    }
                }
            }
        },
        spine_animation = stream_sprites.spine_animation,
        shadow = stream_sprites.shadow,
        particle = stream_sprites.particle
    }
}