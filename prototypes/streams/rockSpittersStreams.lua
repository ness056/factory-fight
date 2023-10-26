data:extend{
    {
		type = "stream",
		name = "small-rock-spitter-stream",
		flags = { "not-on-map" },
		particle_buffer_size = 90,
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		particle_vertical_acceleration = 0.005 * 0.60 * 1.5, --x
		particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, --x
		particle_horizontal_speed_deviation = 0.005 * 0.70,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_alpha_per_part = 0.8,
		particle_scale_per_part = 0.8,
		particle_loop_frame_count = 15,
		--particle_fade_out_threshold = 0.95,
		particle_fade_out_duration = 2,
		particle_loop_exit_threshold = 0.25,
		special_neutral_target_damage = { amount = damage_modifier_spitter_small, type = "acid" },
		working_sound =
		{
			sound =
			{
				{
					filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
					volume = 0.4
				}
			}
		},
		initial_action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "play-sound",
							sound =
							{
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
									volume = 0.6
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
									volume = 0.6
								}
							}
						},
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "small-rock-spitter-spell",
							probability = _CONFIG.biters.rock.small_spitter_spell_proba,
						}
					}
				}
			},
			{
				type = "area",
				radius = stream_radius_spitter_small,
				force = "enemy",
				ignore_collision_condition = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = "acid-sticker-small"
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.small_biter_damage * 0.35, type = "rock" }
						},
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.small_biter_damage * 0.65, type = "water" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/decorative/rock-small/rock-small-09.png",
			draw_as_glow = true,
			width = 23,
			height = 17,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_small*1.1),
			priority = "high",
			scale = scale_spitter_small * 3,
			hr_version =
			{
				filename = "__base__/graphics/decorative/rock-small/hr-rock-small-09.png",
				draw_as_glow = true,
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_small*1.1),
				priority = "high",
				scale = 0.5 * scale_spitter_small * 3
			}
		},
		shadow =
		{
			filename = "__factory-fight__/graphics/streams/rock-09-shadow.png",
			width = 23,
			height = 17,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_small*1.1),
			draw_as_shadow = true,
			scale = scale_spitter_small * 3,
			hr_version =
			{
				filename = "__factory-fight__/graphics/streams/hr-rock-09-shadow.png",
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_small*1.1),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_small * 3,
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	},
	{
		type = "stream",
		name = "medium-rock-spitter-stream",
		flags = { "not-on-map" },
		particle_buffer_size = 90,
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		particle_vertical_acceleration = 0.005 * 0.60 * 1.5, --x
		particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, --x
		particle_horizontal_speed_deviation = 0.005 * 0.70,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_alpha_per_part = 0.8,
		particle_scale_per_part = 0.8,
		particle_loop_frame_count = 15,
		--particle_fade_out_threshold = 0.95,
		particle_fade_out_duration = 2,
		particle_loop_exit_threshold = 0.25,
		special_neutral_target_damage = { amount = damage_modifier_spitter_medium, type = "acid" },
		working_sound =
		{
			sound =
			{
				{
					filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
					volume = 0.4
				}
			}
		},
		initial_action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "play-sound",
							sound =
							{
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
									volume = 0.6
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
									volume = 0.6
								}
							}
						},
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "medium-rock-spitter-spell",
							probability = _CONFIG.biters.rock.medium_spitter_spell_proba,
						}
					}
				}
			},
			{
				type = "area",
				radius = stream_radius_spitter_medium,
				force = "enemy",
				ignore_collision_condition = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = "acid-sticker-medium"
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.medium_biter_damage * 0.35, type = "rock" }
						},
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.medium_biter_damage * 0.65, type = "water" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/decorative/rock-small/rock-small-09.png",
			draw_as_glow = true,
			width = 23,
			height = 17,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_medium*1.1),
			priority = "high",
			scale = scale_spitter_medium * 3,
			hr_version =
			{
				filename = "__base__/graphics/decorative/rock-small/hr-rock-small-09.png",
				draw_as_glow = true,
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_medium*1.1),
				priority = "high",
				scale = 0.5 * scale_spitter_medium * 3
			}
		},
		shadow =
		{
			filename = "__factory-fight__/graphics/streams/rock-09-shadow.png",
			width = 23,
			height = 17,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_medium*1.1),
			draw_as_shadow = true,
			scale = scale_spitter_medium * 3,
			hr_version =
			{
				filename = "__factory-fight__/graphics/streams/hr-rock-09-shadow.png",
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_medium*1.1),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_medium * 3,
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	},
	{
		type = "stream",
		name = "big-rock-spitter-stream",
		flags = { "not-on-map" },
		particle_buffer_size = 90,
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		particle_vertical_acceleration = 0.005 * 0.60 * 1.5, --x
		particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, --x
		particle_horizontal_speed_deviation = 0.005 * 0.70,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_alpha_per_part = 0.8,
		particle_scale_per_part = 0.8,
		particle_loop_frame_count = 15,
		--particle_fade_out_threshold = 0.95,
		particle_fade_out_duration = 2,
		particle_loop_exit_threshold = 0.25,
		special_neutral_target_damage = { amount = damage_modifier_spitter_big, type = "acid" },
		working_sound =
		{
			sound =
			{
				{
					filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
					volume = 0.4
				}
			}
		},
		initial_action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "play-sound",
							sound =
							{
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
									volume = 0.6
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
									volume = 0.6
								}
							}
						},
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "big-rock-spitter-spell",
							probability = _CONFIG.biters.rock.big_spitter_spell_proba,
						}
					}
				}
			},
			{
				type = "area",
				radius = stream_radius_spitter_big,
				force = "enemy",
				ignore_collision_condition = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = "acid-sticker-big"
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.big_biter_damage * 0.35, type = "rock" }
						},
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.big_biter_damage * 0.65, type = "water" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/decorative/rock-small/rock-small-09.png",
			draw_as_glow = true,
			width = 23,
			height = 17,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_big*1.1),
			priority = "high",
			scale = scale_spitter_big * 3,
			hr_version =
			{
				filename = "__base__/graphics/decorative/rock-small/hr-rock-small-09.png",
				draw_as_glow = true,
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_big*1.1),
				priority = "high",
				scale = 0.5 * scale_spitter_big * 3
			}
		},
		shadow =
		{
			filename = "__factory-fight__/graphics/streams/rock-09-shadow.png",
			width = 23,
			height = 17,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_big*1.1),
			draw_as_shadow = true,
			scale = scale_spitter_big * 3,
			hr_version =
			{
				filename = "__factory-fight__/graphics/streams/hr-rock-09-shadow.png",
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_big*1.1),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_big * 3,
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	},
	{
		type = "stream",
		name = "behemoth-rock-spitter-stream",
		flags = { "not-on-map" },
		particle_buffer_size = 90,
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		particle_vertical_acceleration = 0.005 * 0.60 * 1.5, --x
		particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, --x
		particle_horizontal_speed_deviation = 0.005 * 0.70,
		particle_start_alpha = 0.5,
		particle_end_alpha = 1,
		particle_alpha_per_part = 0.8,
		particle_scale_per_part = 0.8,
		particle_loop_frame_count = 15,
		--particle_fade_out_threshold = 0.95,
		particle_fade_out_duration = 2,
		particle_loop_exit_threshold = 0.25,
		special_neutral_target_damage = { amount = damage_modifier_spitter_behemoth, type = "acid" },
		working_sound =
		{
			sound =
			{
				{
					filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
					volume = 0.4
				}
			}
		},
		initial_action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "play-sound",
							sound =
							{
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
									volume = 0.65
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
									volume = 0.6
								},
								{
									filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
									volume = 0.6
								}
							}
						},
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "behemoth-rock-spitter-spell",
							probability = _CONFIG.biters.rock.behemoth_spitter_spell_proba,
						}
					}
				}
			},
			{
				type = "area",
				radius = stream_radius_spitter_behemoth,
				force = "enemy",
				ignore_collision_condition = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = "acid-sticker-behemoth"
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.behemoth_biter_damage * 0.35, type = "rock" }
						},
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.rock.behemoth_biter_damage * 0.65, type = "water" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/decorative/rock-small/rock-small-09.png",
			draw_as_glow = true,
			width = 23,
			height = 17,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_behemoth*1.1),
			priority = "high",
			scale = scale_spitter_behemoth * 3,
			hr_version =
			{
				filename = "__base__/graphics/decorative/rock-small/hr-rock-small-09.png",
				draw_as_glow = true,
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_behemoth*1.1),
				priority = "high",
				scale = 0.5 * scale_spitter_behemoth * 3
			}
		},
		shadow =
		{
			filename = "__factory-fight__/graphics/streams/rock-09-shadow.png",
			width = 23,
			height = 17,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_behemoth*1.1),
			draw_as_shadow = true,
			scale = scale_spitter_behemoth * 3,
			hr_version =
			{
				filename = "__factory-fight__/graphics/streams/hr-rock-09-shadow.png",
				width = 46,
				height = 34,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_behemoth*1.1),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_behemoth * 3,
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	}
}