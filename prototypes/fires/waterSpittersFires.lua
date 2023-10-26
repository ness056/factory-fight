data:extend{
	--- SMALL ---
    {
		type = "fire",
		name = "small-water-spitter-fire",
		flags = { "placeable-off-grid", "not-on-map" },
		damage_per_tick = { amount = 0 / 60, type = "acid" },
		damage_multiplier_increase_per_added_fuel = 1,
		damage_multiplier_decrease_per_tick = 0.005,

		--spawn_entity = "fire-flame-on-tree",
		uses_alternative_behavior = true,
		limit_overlapping_particles = true,
		initial_render_layer = "object",
		render_layer = "lower-object-above-shadow",
		secondary_render_layer = "higher-object-above",
		secondary_picture_fade_out_start = 30,
		secondary_picture_fade_out_duration = 60,

		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,

		particle_alpha = 0.6,
		particle_alpha_blend_duration = 60 * 5,
		--flame_alpha = 0.35,
		--flame_alpha_deviation = 0.05,

		emissions_per_second = 0,

		add_fuel_cooldown = 10,
		fade_in_duration = 1,
		fade_out_duration = 30,

		initial_lifetime = 60 * _CONFIG.biters.fire_lifetime,
		lifetime_increase_by = 0,
		lifetime_increase_cooldown = 4,
		maximum_lifetime = 1800,
		delay_between_initial_flames = 10,
		initial_flame_count = 1,
		burnt_patch_lifetime = 0,

		on_damage_tick_effect =
		{
			{
				type = "direct",
				force = "enemy",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = data.sticker_name,
						-- 	show_in_tooltip = true
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.water.small_spitter_fire_damage / 6, type = "water" },
							apply_damage_to_trees = false
						}
					}
				}
			},
			{
				type = "direct",
				force = "ally",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						type = "damage",
						damage = { amount = -_CONFIG.biters.water.small_spitter_fire_healing / 6, type = "water" }
					}
				}
			}
		},

		pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_small),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_small),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_small
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_small),
						draw_as_shadow = true,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_small),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_small),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_small),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_small
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_small),
						draw_as_shadow = true,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_small),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_small),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_small),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_small
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_small),
						draw_as_shadow = true,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_small),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_small),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_small),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_small
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_small),
						draw_as_shadow = true,
						scale = scale_spitter_small,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_small),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small
						}
					}
				}
			}
		},

		secondary_pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_small * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_small * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_small * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_small * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_small * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_small * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_small * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_small * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_small * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_small * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_small * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_small * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_small * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_small * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_small * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_small * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_small * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_small * ground_patch_scale_modifier
						}
					}
				}
			}
		}
	},

	--- MEDIUM ---
	{
		type = "fire",
		name = "medium-water-spitter-fire",
		flags = { "placeable-off-grid", "not-on-map" },
		damage_per_tick = { amount = 0 / 60, type = "acid" },
		damage_multiplier_increase_per_added_fuel = 1,
		damage_multiplier_decrease_per_tick = 0.005,

		--spawn_entity = "fire-flame-on-tree",
		uses_alternative_behavior = true,
		limit_overlapping_particles = true,
		initial_render_layer = "object",
		render_layer = "lower-object-above-shadow",
		secondary_render_layer = "higher-object-above",
		secondary_picture_fade_out_start = 30,
		secondary_picture_fade_out_duration = 60,

		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,

		particle_alpha = 0.6,
		particle_alpha_blend_duration = 60 * 5,
		--flame_alpha = 0.35,
		--flame_alpha_deviation = 0.05,

		emissions_per_second = 0,

		add_fuel_cooldown = 10,
		fade_in_duration = 1,
		fade_out_duration = 30,

		initial_lifetime = 60 * _CONFIG.biters.fire_lifetime,
		lifetime_increase_by = 0,
		lifetime_increase_cooldown = 4,
		maximum_lifetime = 1800,
		delay_between_initial_flames = 10,
		initial_flame_count = 1,
		burnt_patch_lifetime = 0,

		on_damage_tick_effect =
		{
			{
				type = "direct",
				force = "enemy",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = data.sticker_name,
						-- 	show_in_tooltip = true
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.water.medium_spitter_fire_damage / 6, type = "water" },
							apply_damage_to_trees = false
						}
					}
				}
			},
			{
				type = "direct",
				force = "ally",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						type = "damage",
						damage = { amount = -_CONFIG.biters.water.medium_spitter_fire_healing / 6, type = "water" }
					}
				}
			}
		},

		pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_medium),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_medium),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_medium
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_medium),
						draw_as_shadow = true,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_medium),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_medium),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_medium),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_medium
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_medium),
						draw_as_shadow = true,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_medium),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_medium),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_medium),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_medium
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_medium),
						draw_as_shadow = true,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_medium),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_medium),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_medium),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_medium
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_medium),
						draw_as_shadow = true,
						scale = scale_spitter_medium,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_medium),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium
						}
					}
				}
			}
		},

		secondary_pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_medium * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_medium * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_medium * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_medium * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_medium * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_medium * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_medium * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_medium * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_medium * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_medium * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_medium * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_medium * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_medium * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_medium * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_medium * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_medium * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_medium * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_medium * ground_patch_scale_modifier
						}
					}
				}
			}
		}
	},

	--- BIG ---
	{
		type = "fire",
		name = "big-water-spitter-fire",
		flags = { "placeable-off-grid", "not-on-map" },
		damage_per_tick = { amount = 0 / 60, type = "acid" },
		damage_multiplier_increase_per_added_fuel = 1,
		damage_multiplier_decrease_per_tick = 0.005,

		--spawn_entity = "fire-flame-on-tree",
		uses_alternative_behavior = true,
		limit_overlapping_particles = true,
		initial_render_layer = "object",
		render_layer = "lower-object-above-shadow",
		secondary_render_layer = "higher-object-above",
		secondary_picture_fade_out_start = 30,
		secondary_picture_fade_out_duration = 60,

		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,

		particle_alpha = 0.6,
		particle_alpha_blend_duration = 60 * 5,
		--flame_alpha = 0.35,
		--flame_alpha_deviation = 0.05,

		emissions_per_second = 0,

		add_fuel_cooldown = 10,
		fade_in_duration = 1,
		fade_out_duration = 30,

		initial_lifetime = 60 * _CONFIG.biters.fire_lifetime,
		lifetime_increase_by = 0,
		lifetime_increase_cooldown = 4,
		maximum_lifetime = 1800,
		delay_between_initial_flames = 10,
		initial_flame_count = 1,
		burnt_patch_lifetime = 0,

		on_damage_tick_effect =
		{
			{
				type = "direct",
				force = "enemy",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = data.sticker_name,
						-- 	show_in_tooltip = true
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.water.big_spitter_fire_damage / 6, type = "water" },
							apply_damage_to_trees = false
						}
					}
				}
			},
			{
				type = "direct",
				force = "ally",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						type = "damage",
						damage = { amount = -_CONFIG.biters.water.big_spitter_fire_healing / 6, type = "water" }
					}
				}
			}
		},

		pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_big),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_big),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_big
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_big),
						draw_as_shadow = true,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_big),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_big),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_big),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_big
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_big),
						draw_as_shadow = true,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_big),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_big),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_big),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_big
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_big),
						draw_as_shadow = true,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_big),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_big),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_big),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_big
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_big),
						draw_as_shadow = true,
						scale = scale_spitter_big,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_big),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big
						}
					}
				}
			}
		},

		secondary_pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_big * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_big * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_big * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_big * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_big * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_big * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_big * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_big * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_big * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_big * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_big * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_big * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_big * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_big * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_big * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_big * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_big * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_big * ground_patch_scale_modifier
						}
					}
				}
			}
		}
	},

	--- BEHEMOTH ---
	{
		type = "fire",
		name = "behemoth-water-spitter-fire",
		flags = { "placeable-off-grid", "not-on-map" },
		damage_per_tick = { amount = 0 / 60, type = "acid" },
		damage_multiplier_increase_per_added_fuel = 1,
		damage_multiplier_decrease_per_tick = 0.005,

		--spawn_entity = "fire-flame-on-tree",
		uses_alternative_behavior = true,
		limit_overlapping_particles = true,
		initial_render_layer = "object",
		render_layer = "lower-object-above-shadow",
		secondary_render_layer = "higher-object-above",
		secondary_picture_fade_out_start = 30,
		secondary_picture_fade_out_duration = 60,

		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,

		particle_alpha = 0.6,
		particle_alpha_blend_duration = 60 * 5,
		--flame_alpha = 0.35,
		--flame_alpha_deviation = 0.05,

		emissions_per_second = 0,

		add_fuel_cooldown = 10,
		fade_in_duration = 1,
		fade_out_duration = 30,

		initial_lifetime = 60 * _CONFIG.biters.fire_lifetime,
		lifetime_increase_by = 0,
		lifetime_increase_cooldown = 4,
		maximum_lifetime = 1800,
		delay_between_initial_flames = 10,
		initial_flame_count = 1,
		burnt_patch_lifetime = 0,

		on_damage_tick_effect =
		{
			{
				type = "direct",
				force = "enemy",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						-- {
						-- 	type = "create-sticker",
						-- 	sticker = data.sticker_name,
						-- 	show_in_tooltip = true
						-- },
						{
							type = "damage",
							damage = { amount = _CONFIG.biters.water.behemoth_spitter_fire_damage / 6, type = "water" },
							apply_damage_to_trees = false
						}
					}
				}
			},
			{
				type = "direct",
				force = "ally",
				ignore_collision_condition = true,
				trigger_target_mask = { "ground-unit" },
				filter_enabled = true,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						type = "damage",
						damage = { amount = -_CONFIG.biters.water.behemoth_spitter_fire_healing / 6, type = "water" }
					}
				}
			}
		},

		pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_behemoth),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_behemoth),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_behemoth
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_behemoth),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_behemoth),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_behemoth),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_behemoth),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_behemoth
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_behemoth),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_behemoth),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_behemoth),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_behemoth),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_behemoth
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_behemoth),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_behemoth),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_behemoth),
						tint = _CONFIG.biters.water.stream_tint,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_behemoth),
							tint = _CONFIG.biters.water.stream_tint,
							scale = 0.5 * scale_spitter_behemoth
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_behemoth),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_behemoth),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth
						}
					}
				}
			}
		},

		secondary_pictures =
		{
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 106,
						height = 116,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(-12, -10), scale_spitter_behemoth * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 210,
							height = 224,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(-12, -8), scale_spitter_behemoth * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 134,
						height = 98,
						frame_count = 26,
						shift = util.mul_shift(util.by_pixel(2, 0), scale_spitter_behemoth * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 266,
							height = 188,
							frame_count = 26,
							shift = util.mul_shift(util.by_pixel(2, 2), scale_spitter_behemoth * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 88,
						height = 76,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(-10, -18), scale_spitter_behemoth * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 174,
							height = 150,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(-9, -17), scale_spitter_behemoth * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 120,
						height = 136,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(6, 28), scale_spitter_behemoth * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 238,
							height = 266,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(6, 29), scale_spitter_behemoth * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 118,
						height = 104,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_behemoth * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 236,
							height = 208,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(22, -16), scale_spitter_behemoth * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 110,
						height = 70,
						frame_count = 29,
						shift = util.mul_shift(util.by_pixel(16, 2), scale_spitter_behemoth * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 214,
							height = 140,
							frame_count = 29,
							shift = util.mul_shift(util.by_pixel(17, 2), scale_spitter_behemoth * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					}
				}
			},
			{
				layers =
				{
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
						draw_as_glow = true,
						line_length = 8,
						direction_count = 1,
						width = 128,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(16, -20), scale_spitter_behemoth * ground_patch_scale_modifier),
						tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
							draw_as_glow = true,
							line_length = 8,
							direction_count = 1,
							width = 252,
							height = 154,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(17, -19), scale_spitter_behemoth * ground_patch_scale_modifier),
							tint = util.multiply_color(_CONFIG.biters.water.stream_tint, patch_opacity),
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					},
					{
						filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
						line_length = 8,
						direction_count = 1,
						width = 124,
						height = 80,
						frame_count = 24,
						shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_behemoth * ground_patch_scale_modifier),
						draw_as_shadow = true,
						scale = scale_spitter_behemoth * ground_patch_scale_modifier,
						hr_version =
						{
							filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
							line_length = 8,
							direction_count = 1,
							width = 248,
							height = 160,
							frame_count = 24,
							shift = util.mul_shift(util.by_pixel(18, -16), scale_spitter_behemoth * ground_patch_scale_modifier),
							draw_as_shadow = true,
							scale = 0.5 * scale_spitter_behemoth * ground_patch_scale_modifier
						}
					}
				}
			}
		}
	}
}