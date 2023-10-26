data:extend{
    {
		type = "stream",
		name = "small-plant-spitter-stream",
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
						-- {
						-- 	type = "create-fire",
						-- 	entity_name = data.splash_fire_name,
						-- 	tile_collision_mask = { "water-tile" },
						-- 	show_in_tooltip = true
						-- },
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "create-small-biter",
							probability = 0.5,
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
							damage = { amount = damage_modifier_spitter_small * 0.35, type = "acid" }
						},
						{
							type = "damage",
							damage = { amount = damage_modifier_spitter_small * 0.65, type = "plant" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
			draw_as_glow = true,
			line_length = 5,
			width = 22,
			height = 84,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_small*1.1),
			tint = stream_tint_spitter_small,
			priority = "high",
			scale = scale_spitter_small*1.1,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
				draw_as_glow = true,
				line_length = 5,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_small*1.1),
				tint = stream_tint_spitter_small,
				priority = "high",
				scale = 0.5 * scale_spitter_small*1.1,
				animation_speed = 1
			}
		},
		spine_animation =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
			draw_as_glow = true,
			line_length = 5,
			width = 66,
			height = 12,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(0, -2), scale_spitter_small*1.1),
			tint = stream_tint_spitter_small,
			priority = "high",
			scale = scale_spitter_small*1.1,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
				draw_as_glow = true,
				line_length = 5,
				width = 132,
				height = 20,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(0, -1), scale_spitter_small*1.1),
				tint = stream_tint_spitter_small,
				priority = "high",
				scale = 0.5 * scale_spitter_small*1.1,
				animation_speed = 1
			}
		},
		shadow =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
			line_length = 15,
			width = 22,
			height = 84,
			frame_count = 15,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_small*1.1),
			draw_as_shadow = true,
			scale = scale_spitter_small*1.1,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
				line_length = 15,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_small*1.1),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_small*1.1,
				animation_speed = 1
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	},

	{
		type = "stream",
		name = "medium-plant-spitter-stream",
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
						-- {
						-- 	type = "create-fire",
						-- 	entity_name = data.splash_fire_name,
						-- 	tile_collision_mask = { "water-tile" },
						-- 	show_in_tooltip = true
						-- },
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "create-small-plant-biter",
							probability = 0.5,
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
							damage = { amount = damage_modifier_spitter_medium * 0.35, type = "acid" }
						},
						{
							type = "damage",
							damage = { amount = damage_modifier_spitter_medium * 0.65, type = "plant" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
			draw_as_glow = true,
			line_length = 5,
			width = 22,
			height = 84,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_medium),
			tint = stream_tint_spitter_medium,
			priority = "high",
			scale = scale_spitter_medium,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
				draw_as_glow = true,
				line_length = 5,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_medium),
				tint = stream_tint_spitter_medium,
				priority = "high",
				scale = 0.5 * scale_spitter_medium,
				animation_speed = 1
			}
		},
		spine_animation =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
			draw_as_glow = true,
			line_length = 5,
			width = 66,
			height = 12,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(0, -2), scale_spitter_medium),
			tint = stream_tint_spitter_medium,
			priority = "high",
			scale = scale_spitter_medium,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
				draw_as_glow = true,
				line_length = 5,
				width = 132,
				height = 20,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(0, -1), scale_spitter_medium),
				tint = stream_tint_spitter_medium,
				priority = "high",
				scale = 0.5 * scale_spitter_medium,
				animation_speed = 1
			}
		},
		shadow =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
			line_length = 15,
			width = 22,
			height = 84,
			frame_count = 15,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_medium),
			draw_as_shadow = true,
			scale = scale_spitter_medium,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
				line_length = 15,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_medium),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_medium,
				animation_speed = 1
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	},

	{
		type = "stream",
		name = "big-plant-spitter-stream",
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
						-- {
						-- 	type = "create-fire",
						-- 	entity_name = data.splash_fire_name,
						-- 	tile_collision_mask = { "water-tile" },
						-- 	show_in_tooltip = true
						-- },
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "create-medium-plant-biter",
							probability = 0.5,
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
							damage = { amount = damage_modifier_spitter_big * 0.35, type = "acid" }
						},
						{
							type = "damage",
							damage = { amount = damage_modifier_spitter_big * 0.65, type = "plant" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
			draw_as_glow = true,
			line_length = 5,
			width = 22,
			height = 84,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_big),
			tint = stream_tint_spitter_big,
			priority = "high",
			scale = scale_spitter_big,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
				draw_as_glow = true,
				line_length = 5,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_big),
				tint = stream_tint_spitter_big,
				priority = "high",
				scale = 0.5 * scale_spitter_big,
				animation_speed = 1
			}
		},
		spine_animation =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
			draw_as_glow = true,
			line_length = 5,
			width = 66,
			height = 12,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(0, -2), scale_spitter_big),
			tint = stream_tint_spitter_big,
			priority = "high",
			scale = scale_spitter_big,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
				draw_as_glow = true,
				line_length = 5,
				width = 132,
				height = 20,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(0, -1), scale_spitter_big),
				tint = stream_tint_spitter_big,
				priority = "high",
				scale = 0.5 * scale_spitter_big,
				animation_speed = 1
			}
		},
		shadow =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
			line_length = 15,
			width = 22,
			height = 84,
			frame_count = 15,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_big),
			draw_as_shadow = true,
			scale = scale_spitter_big,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
				line_length = 15,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_big),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_big,
				animation_speed = 1
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	},

	{
		type = "stream",
		name = "behemoth-plant-spitter-stream",
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
						-- {
						-- 	type = "create-fire",
						-- 	entity_name = data.splash_fire_name,
						-- 	tile_collision_mask = { "water-tile" },
						-- 	show_in_tooltip = true
						-- },
						{
							type = "create-entity",
							entity_name = "water-splash",
							tile_collision_mask = { "ground-tile" }
						},
						{
							type = "script",
							effect_id = "create-big-plant-biter",
							probability = 0.5,
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
							damage = { amount = damage_modifier_spitter_behemoth * 0.35, type = "acid" }
						},
						{
							type = "damage",
							damage = { amount = damage_modifier_spitter_behemoth * 0.65, type = "plant" }
						}
					}
				}
			}
		},
		particle =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
			draw_as_glow = true,
			line_length = 5,
			width = 22,
			height = 84,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_behemoth),
			tint = stream_tint_spitter_behemoth,
			priority = "high",
			scale = scale_spitter_behemoth,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
				draw_as_glow = true,
				line_length = 5,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_behemoth),
				tint = stream_tint_spitter_behemoth,
				priority = "high",
				scale = 0.5 * scale_spitter_behemoth,
				animation_speed = 1
			}
		},
		spine_animation =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
			draw_as_glow = true,
			line_length = 5,
			width = 66,
			height = 12,
			frame_count = 15,
			shift = util.mul_shift(util.by_pixel(0, -2), scale_spitter_behemoth),
			tint = stream_tint_spitter_behemoth,
			priority = "high",
			scale = scale_spitter_behemoth,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
				draw_as_glow = true,
				line_length = 5,
				width = 132,
				height = 20,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(0, -1), scale_spitter_behemoth),
				tint = stream_tint_spitter_behemoth,
				priority = "high",
				scale = 0.5 * scale_spitter_behemoth,
				animation_speed = 1
			}
		},
		shadow =
		{
			filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
			line_length = 15,
			width = 22,
			height = 84,
			frame_count = 15,
			priority = "high",
			shift = util.mul_shift(util.by_pixel(-2, 30), scale_spitter_behemoth),
			draw_as_shadow = true,
			scale = scale_spitter_behemoth,
			animation_speed = 1,
			hr_version =
			{
				filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
				line_length = 15,
				width = 42,
				height = 164,
				frame_count = 15,
				shift = util.mul_shift(util.by_pixel(-2, 31), scale_spitter_behemoth),
				draw_as_shadow = true,
				priority = "high",
				scale = 0.5 * scale_spitter_behemoth,
				animation_speed = 1
			}
		},
		oriented_particle = true,
		shadow_scale_enabled = true
	}
}