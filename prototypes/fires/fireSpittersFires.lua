local fireutil = require("__base__.prototypes.fire-util")

data:extend{
	{
		type = "fire",
		name = "small-fire-spitter-fire",
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
							damage = { amount = _CONFIG.biters.fire.small_spitter_fire_damage, type = "fire" },
							apply_damage_to_trees = false
						}
					}
				}
			}
		},

		pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = _CONFIG.biters.small_biter_scale})
	},

    {
		type = "fire",
		name = "medium-fire-spitter-fire",
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
							damage = { amount = _CONFIG.biters.fire.medium_spitter_fire_damage, type = "fire" },
							apply_damage_to_trees = false
						}
					}
				}
			}
		},

		pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = _CONFIG.biters.medium_biter_scale})
	},

    {
		type = "fire",
		name = "big-fire-spitter-fire",
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
							damage = { amount = _CONFIG.biters.fire.big_spitter_fire_damage, type = "fire" },
							apply_damage_to_trees = false
						}
					}
				}
			}
		},

		pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = _CONFIG.biters.big_biter_scale})
	},

    {
		type = "fire",
		name = "behemoth-fire-spitter-fire",
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
							damage = { amount = _CONFIG.biters.fire.behemoth_spitter_fire_damage, type = "fire" },
							apply_damage_to_trees = false
						}
					}
				}
			}
		},

		pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = _CONFIG.biters.behemoth_biter_scale}),
	}
}