local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")

local small_biter_scale = 0.5
local small_biter_tint1 = { r = 0.60, g = 0.58, b = 0.51, a = 1 }

local medium_biter_scale = 0.7
--local medium_biter_tint1 = {r=0.49, g=0.46, b=0.51, a=1}
local medium_biter_tint1 = { r = 0.60, g = 0.58, b = 0.51, a = 1 }

local big_biter_scale = 1.0
--local big_biter_tint1 = {r=0.37, g=0.40, b=0.55, a=1}
local big_biter_tint1 = { r = 0.60, g = 0.58, b = 0.51, a = 1 }

local behemoth_biter_scale = 1.2
--local behemoth_biter_tint1 = {r=0.21, g=0.19, b=0.25, a=1}
local behemoth_biter_tint1 = { r = 0.60, g = 0.58, b = 0.51, a = 1 }

-- grob : les biters elementaires partagent le size ET le tint1 avec les biters plus gros, mais leur tint2 diffère

local normal_biter_tint2 = { r = 0.9, g = 0.83, b = 0.54, a = 1 }
local water_biter_tint2 = { r = 0, g = 0.5, b = 1, a = 1 }
local fire_biter_tint2 = { r = 1, g = 0, b = 0, a = 1 }
local plant_biter_tint2 = { r = 0, g = 1, b = 0, a = 1 }
local rock_biter_tint2 = { r = 0.11, g = 0.44, b = 0.44, a = 1 }
local elec_biter_tint2 = { r = 1, g = 1, b = 0, a = 1 }


data:extend {

		----- normal biters -----

	-- biters

	{
		type = "unit",
		name = "small-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air" },
		max_health = 15,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(7),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, small_biter_tint1, normal_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.2,
		distance_per_frame = 0.125,
		pollution_to_join_attack = 4,
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		corpse = "small-biter-corpse",
		dying_explosion = "small-biter-die",
		dying_sound = sounds.biter_dying(0.5),
		working_sound = sounds.biter_calls(0.75),
		run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 75,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = make_unit_melee_ammo_type(15),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, normal_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.24,
		distance_per_frame = 0.188,
		-- in pu
		pollution_to_join_attack = 20,
		corpse = "medium-biter-corpse",
		dying_explosion = "medium-biter-die",
		working_sound = sounds.biter_calls(0.87),
		dying_sound = sounds.biter_dying(0.6),
		run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(medium_biter_scale)
	},

	{
		type = "unit",
		name = "big-biter",
		order = "b-a-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 375,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.02,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(30),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, big_biter_tint1, normal_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.23,
		distance_per_frame = 0.30,
		-- in pu
		pollution_to_join_attack = 80,
		corpse = "big-biter-corpse",
		dying_explosion = "big-biter-die",
		working_sound = sounds.biter_calls_big(0.67),
		dying_sound = sounds.biter_dying_big(0.45),
		run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(big_biter_scale)
	},

	{
		type = "unit",
		name = "behemoth-biter",
		order = "b-a-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 3000,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 10
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 10
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(90),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, normal_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.3,
		distance_per_frame = 0.32,
		-- in pu
		pollution_to_join_attack = 400,
		corpse = "behemoth-biter-corpse",
		dying_explosion = "behemoth-biter-die",
		working_sound = sounds.biter_calls_behemoth(0.97),
		dying_sound = sounds.biter_dying_big(0.52),
		run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(behemoth_biter_scale)
	},

	-- spitters

	{
		type = "unit",
		name = "small-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 10,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-small",
				range = range_spitter_small,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_small,
				scale = scale_spitter_small,
				tint1 = small_biter_tint1,
				tint2 = normal_biter_tint2,
				roarvolume = 0.4,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, small_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 50,
		order = "b-b-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.5, -0.7 }, { 0.5, 0.7 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_mid_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = medium_biter_tint1,
				tint2 = normal_biter_tint2,
				roarvolume = 0.5,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, medium_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 200,
		order = "b-b-c",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_big_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = big_biter_tint1,
				tint2 = normal_biter_tint2,
				roarvolume = 0.6,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, big_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 1500,
		order = "b-b-d",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_behemoth_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = behemoth_biter_tint1,
				tint2 = normal_biter_tint2,
				roarvolume = 0.8,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, behemoth_biter_tint1, normal_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	add_biter_die_animation(small_biter_scale, small_biter_tint1, normal_biter_tint2,
	{
	  type = "corpse",
	  name = "small-biter-corpse",
	  icon = "__base__/graphics/icons/small-biter-corpse.png",
	  icon_size = 64, icon_mipmaps = 4,
	  selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	  selectable_in_game = false,
	  subgroup="corpses",
	  order = "c[corpse]-a[biter]-a[small]",
	  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	}),

	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "medium-biter-corpse",
			icon = "__base__/graphics/icons/medium-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-b[medium]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(big_biter_scale, big_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "big-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_small, small_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "small-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_medium, medium_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "medium-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_big, big_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "big-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_behemoth, behemoth_biter_tint1, normal_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

		----- water biters -----

	-- biters

	{
		type = "unit",
		name = "small-water-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air" },
		max_health = 15,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(7),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, small_biter_tint1, water_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.2,
		distance_per_frame = 0.125,
		pollution_to_join_attack = 4,
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		corpse = "small-water-biter-corpse",
		dying_explosion = "small-biter-die",
		dying_sound = sounds.biter_dying(0.5),
		working_sound = sounds.biter_calls(0.75),
		run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-water-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 75,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = make_unit_melee_ammo_type(15),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, water_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.24,
		distance_per_frame = 0.188,
		-- in pu
		pollution_to_join_attack = 20,
		corpse = "medium-water-biter-corpse",
		dying_explosion = "medium-biter-die",
		working_sound = sounds.biter_calls(0.87),
		dying_sound = sounds.biter_dying(0.6),
		run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(medium_biter_scale)
	},

	{
		type = "unit",
		name = "big-water-biter",
		order = "b-a-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 375,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.02,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(30),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, big_biter_tint1, water_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.23,
		distance_per_frame = 0.30,
		-- in pu
		pollution_to_join_attack = 80,
		corpse = "big-water-biter-corpse",
		dying_explosion = "big-biter-die",
		working_sound = sounds.biter_calls_big(0.67),
		dying_sound = sounds.biter_dying_big(0.45),
		run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(big_biter_scale)
	},

	{
		type = "unit",
		name = "behemoth-water-biter",
		order = "b-a-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 3000,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 10
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 10
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(90),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, water_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.3,
		distance_per_frame = 0.32,
		-- in pu
		pollution_to_join_attack = 400,
		corpse = "behemoth-water-biter-corpse",
		dying_explosion = "behemoth-biter-die",
		working_sound = sounds.biter_calls_behemoth(0.97),
		dying_sound = sounds.biter_dying_big(0.52),
		run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(behemoth_biter_scale)
	},

	-- spitters

	{
		type = "unit",
		name = "small-water-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 10,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-small",
				range = range_spitter_small,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_small,
				scale = scale_spitter_small,
				tint1 = small_biter_tint1,
				tint2 = water_biter_tint2,
				roarvolume = 0.4,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-water-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, small_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-water-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 50,
		order = "b-b-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.5, -0.7 }, { 0.5, 0.7 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_mid_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = medium_biter_tint1,
				tint2 = water_biter_tint2,
				roarvolume = 0.5,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-water-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, medium_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-water-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 200,
		order = "b-b-c",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_big_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = big_biter_tint1,
				tint2 = water_biter_tint2,
				roarvolume = 0.6,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-water-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, big_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-water-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 1500,
		order = "b-b-d",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_behemoth_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = behemoth_biter_tint1,
				tint2 = water_biter_tint2,
				roarvolume = 0.8,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-water-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, behemoth_biter_tint1, water_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	add_biter_die_animation(small_biter_scale, small_biter_tint1, water_biter_tint2,
	{
	  type = "corpse",
	  name = "small-water-biter-corpse",
	  icon = "__base__/graphics/icons/small-biter-corpse.png",
	  icon_size = 64, icon_mipmaps = 4,
	  selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	  selectable_in_game = false,
	  subgroup="corpses",
	  order = "c[corpse]-a[biter]-a[small]",
	  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	}),

	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "medium-water-biter-corpse",
			icon = "__base__/graphics/icons/medium-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-b[medium]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(big_biter_scale, big_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "big-water-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-water-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_small, small_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "small-water-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_medium, medium_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "medium-water-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_big, big_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "big-water-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_behemoth, behemoth_biter_tint1, water_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-water-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

		----- fire biters -----

	-- biters

	{
		type = "unit",
		name = "small-fire-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air" },
		max_health = 15,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(7),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, small_biter_tint1, fire_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.2,
		distance_per_frame = 0.125,
		pollution_to_join_attack = 4,
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		corpse = "small-fire-biter-corpse",
		dying_explosion = "small-biter-die",
		dying_sound = sounds.biter_dying(0.5),
		working_sound = sounds.biter_calls(0.75),
		run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-fire-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 75,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = make_unit_melee_ammo_type(15),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, fire_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.24,
		distance_per_frame = 0.188,
		-- in pu
		pollution_to_join_attack = 20,
		corpse = "medium-fire-biter-corpse",
		dying_explosion = "medium-biter-die",
		working_sound = sounds.biter_calls(0.87),
		dying_sound = sounds.biter_dying(0.6),
		run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(medium_biter_scale)
	},

	{
		type = "unit",
		name = "big-fire-biter",
		order = "b-a-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 375,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.02,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(30),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, big_biter_tint1, fire_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.23,
		distance_per_frame = 0.30,
		-- in pu
		pollution_to_join_attack = 80,
		corpse = "big-fire-biter-corpse",
		dying_explosion = "big-biter-die",
		working_sound = sounds.biter_calls_big(0.67),
		dying_sound = sounds.biter_dying_big(0.45),
		run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(big_biter_scale)
	},

	{
		type = "unit",
		name = "behemoth-fire-biter",
		order = "b-a-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 3000,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 10
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 10
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(90),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, fire_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.3,
		distance_per_frame = 0.32,
		-- in pu
		pollution_to_join_attack = 400,
		corpse = "behemoth-fire-biter-corpse",
		dying_explosion = "behemoth-biter-die",
		working_sound = sounds.biter_calls_behemoth(0.97),
		dying_sound = sounds.biter_dying_big(0.52),
		run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(behemoth_biter_scale)
	},

	-- spitters

	{
		type = "unit",
		name = "small-fire-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 10,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-small",
				range = range_spitter_small,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_small,
				scale = scale_spitter_small,
				tint1 = small_biter_tint1,
				tint2 = fire_biter_tint2,
				roarvolume = 0.4,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-fire-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, small_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-fire-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 50,
		order = "b-b-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.5, -0.7 }, { 0.5, 0.7 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_mid_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = medium_biter_tint1,
				tint2 = fire_biter_tint2,
				roarvolume = 0.5,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-fire-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, medium_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-fire-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 200,
		order = "b-b-c",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_big_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = big_biter_tint1,
				tint2 = fire_biter_tint2,
				roarvolume = 0.6,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-fire-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, big_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-fire-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 1500,
		order = "b-b-d",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_behemoth_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = behemoth_biter_tint1,
				tint2 = fire_biter_tint2,
				roarvolume = 0.8,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-fire-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, behemoth_biter_tint1, fire_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	add_biter_die_animation(small_biter_scale, small_biter_tint1, fire_biter_tint2,
	{
	  type = "corpse",
	  name = "small-fire-biter-corpse",
	  icon = "__base__/graphics/icons/small-biter-corpse.png",
	  icon_size = 64, icon_mipmaps = 4,
	  selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	  selectable_in_game = false,
	  subgroup="corpses",
	  order = "c[corpse]-a[biter]-a[small]",
	  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	}),

	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "medium-fire-biter-corpse",
			icon = "__base__/graphics/icons/medium-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-b[medium]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(big_biter_scale, big_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "big-fire-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-fire-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_small, small_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "small-fire-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_medium, medium_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "medium-fire-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_big, big_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "big-fire-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_behemoth, behemoth_biter_tint1, fire_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-fire-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

		----- plant biters -----

	-- biters

	{
		type = "unit",
		name = "small-plant-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air" },
		max_health = 15,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(7),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, small_biter_tint1, plant_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.2,
		distance_per_frame = 0.125,
		pollution_to_join_attack = 4,
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		corpse = "small-plant-biter-corpse",
		dying_explosion = "small-biter-die",
		dying_sound = sounds.biter_dying(0.5),
		working_sound = sounds.biter_calls(0.75),
		run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-plant-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 75,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = make_unit_melee_ammo_type(15),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, plant_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.24,
		distance_per_frame = 0.188,
		-- in pu
		pollution_to_join_attack = 20,
		corpse = "medium-plant-biter-corpse",
		dying_explosion = "medium-biter-die",
		working_sound = sounds.biter_calls(0.87),
		dying_sound = sounds.biter_dying(0.6),
		run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(medium_biter_scale)
	},

	{
		type = "unit",
		name = "big-plant-biter",
		order = "b-a-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 375,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.02,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(30),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, big_biter_tint1, plant_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.23,
		distance_per_frame = 0.30,
		-- in pu
		pollution_to_join_attack = 80,
		corpse = "big-plant-biter-corpse",
		dying_explosion = "big-biter-die",
		working_sound = sounds.biter_calls_big(0.67),
		dying_sound = sounds.biter_dying_big(0.45),
		run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(big_biter_scale)
	},

	{
		type = "unit",
		name = "behemoth-plant-biter",
		order = "b-a-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 3000,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 10
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 10
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(90),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, plant_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.3,
		distance_per_frame = 0.32,
		-- in pu
		pollution_to_join_attack = 400,
		corpse = "behemoth-plant-biter-corpse",
		dying_explosion = "behemoth-biter-die",
		working_sound = sounds.biter_calls_behemoth(0.97),
		dying_sound = sounds.biter_dying_big(0.52),
		run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(behemoth_biter_scale)
	},

	-- spitters

	{
		type = "unit",
		name = "small-plant-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 10,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-small",
				range = range_spitter_small,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_small,
				scale = scale_spitter_small,
				tint1 = small_biter_tint1,
				tint2 = plant_biter_tint2,
				roarvolume = 0.4,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-plant-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, small_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-plant-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 50,
		order = "b-b-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.5, -0.7 }, { 0.5, 0.7 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_mid_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = medium_biter_tint1,
				tint2 = plant_biter_tint2,
				roarvolume = 0.5,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-plant-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, medium_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-plant-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 200,
		order = "b-b-c",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_big_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = big_biter_tint1,
				tint2 = plant_biter_tint2,
				roarvolume = 0.6,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-plant-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, big_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-plant-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 1500,
		order = "b-b-d",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_behemoth_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = behemoth_biter_tint1,
				tint2 = plant_biter_tint2,
				roarvolume = 0.8,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-plant-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, behemoth_biter_tint1, plant_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	add_biter_die_animation(small_biter_scale, small_biter_tint1, plant_biter_tint2,
	{
	  type = "corpse",
	  name = "small-plant-biter-corpse",
	  icon = "__base__/graphics/icons/small-biter-corpse.png",
	  icon_size = 64, icon_mipmaps = 4,
	  selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	  selectable_in_game = false,
	  subgroup="corpses",
	  order = "c[corpse]-a[biter]-a[small]",
	  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	}),

	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "medium-plant-biter-corpse",
			icon = "__base__/graphics/icons/medium-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-b[medium]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(big_biter_scale, big_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "big-plant-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-plant-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_small, small_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "small-plant-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_medium, medium_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "medium-plant-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_big, big_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "big-plant-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_behemoth, behemoth_biter_tint1, plant_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-plant-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	----- rock biters -----

	-- biters

	{
		type = "unit",
		name = "small-rock-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air" },
		max_health = 15,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(7),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, small_biter_tint1, rock_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.2,
		distance_per_frame = 0.125,
		pollution_to_join_attack = 4,
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		corpse = "small-rock-biter-corpse",
		dying_explosion = "small-biter-die",
		dying_sound = sounds.biter_dying(0.5),
		working_sound = sounds.biter_calls(0.75),
		run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-rock-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 75,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = make_unit_melee_ammo_type(15),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, rock_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.24,
		distance_per_frame = 0.188,
		-- in pu
		pollution_to_join_attack = 20,
		corpse = "medium-rock-biter-corpse",
		dying_explosion = "medium-biter-die",
		working_sound = sounds.biter_calls(0.87),
		dying_sound = sounds.biter_dying(0.6),
		run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(medium_biter_scale)
	},

	{
		type = "unit",
		name = "big-rock-biter",
		order = "b-a-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 375,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.02,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(30),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, big_biter_tint1, rock_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.23,
		distance_per_frame = 0.30,
		-- in pu
		pollution_to_join_attack = 80,
		corpse = "big-rock-biter-corpse",
		dying_explosion = "big-biter-die",
		working_sound = sounds.biter_calls_big(0.67),
		dying_sound = sounds.biter_dying_big(0.45),
		run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(big_biter_scale)
	},

	{
		type = "unit",
		name = "behemoth-rock-biter",
		order = "b-a-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 3000,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 10
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 10
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(90),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, rock_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.3,
		distance_per_frame = 0.32,
		-- in pu
		pollution_to_join_attack = 400,
		corpse = "behemoth-rock-biter-corpse",
		dying_explosion = "behemoth-biter-die",
		working_sound = sounds.biter_calls_behemoth(0.97),
		dying_sound = sounds.biter_dying_big(0.52),
		run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(behemoth_biter_scale)
	},

	-- spitters

	{
		type = "unit",
		name = "small-rock-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 10,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-small",
				range = range_spitter_small,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_small,
				scale = scale_spitter_small,
				tint1 = small_biter_tint1,
				tint2 = rock_biter_tint2,
				roarvolume = 0.4,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-rock-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, small_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-rock-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 50,
		order = "b-b-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.5, -0.7 }, { 0.5, 0.7 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_mid_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = medium_biter_tint1,
				tint2 = rock_biter_tint2,
				roarvolume = 0.5,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-rock-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, medium_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-rock-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 200,
		order = "b-b-c",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_big_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = big_biter_tint1,
				tint2 = rock_biter_tint2,
				roarvolume = 0.6,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-rock-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, big_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-rock-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 1500,
		order = "b-b-d",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_behemoth_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = behemoth_biter_tint1,
				tint2 = rock_biter_tint2,
				roarvolume = 0.8,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-rock-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, behemoth_biter_tint1, rock_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	add_biter_die_animation(small_biter_scale, small_biter_tint1, rock_biter_tint2,
	{
	  type = "corpse",
	  name = "small-rock-biter-corpse",
	  icon = "__base__/graphics/icons/small-biter-corpse.png",
	  icon_size = 64, icon_mipmaps = 4,
	  selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	  selectable_in_game = false,
	  subgroup="corpses",
	  order = "c[corpse]-a[biter]-a[small]",
	  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	}),

	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "medium-rock-biter-corpse",
			icon = "__base__/graphics/icons/medium-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-b[medium]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(big_biter_scale, big_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "big-rock-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-rock-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_small, small_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "small-rock-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_medium, medium_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "medium-rock-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_big, big_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "big-rock-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_behemoth, behemoth_biter_tint1, rock_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-rock-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

		----- electric biters -----

	-- biters

	{
		type = "unit",
		name = "small-electric-biter",
		icon = "__base__/graphics/icons/small-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air" },
		max_health = 15,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(7),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, small_biter_tint1, elec_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.2,
		distance_per_frame = 0.125,
		pollution_to_join_attack = 4,
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		corpse = "small-electric-biter-corpse",
		dying_explosion = "small-biter-die",
		dying_sound = sounds.biter_dying(0.5),
		working_sound = sounds.biter_calls(0.75),
		run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-electric-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 75,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 4,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = make_unit_melee_ammo_type(15),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, elec_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.24,
		distance_per_frame = 0.188,
		-- in pu
		pollution_to_join_attack = 20,
		corpse = "medium-electric-biter-corpse",
		dying_explosion = "medium-biter-die",
		working_sound = sounds.biter_calls(0.87),
		dying_sound = sounds.biter_dying(0.6),
		run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(medium_biter_scale)
	},

	{
		type = "unit",
		name = "big-electric-biter",
		order = "b-a-c",
		icon = "__base__/graphics/icons/big-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 375,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 8,
				percent = 10
			},
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.02,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(30),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, big_biter_tint1, elec_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.23,
		distance_per_frame = 0.30,
		-- in pu
		pollution_to_join_attack = 80,
		corpse = "big-electric-biter-corpse",
		dying_explosion = "big-biter-die",
		working_sound = sounds.biter_calls_big(0.67),
		dying_sound = sounds.biter_dying_big(0.45),
		run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(big_biter_scale)
	},

	{
		type = "unit",
		name = "behemoth-electric-biter",
		order = "b-a-d",
		icon = "__base__/graphics/icons/behemoth-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 3000,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 10
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 10
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.6, -0.8 }, { 0.6, 0 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			range = 1.5,
			cooldown = 50,
			cooldown_deviation = 0.15,
			ammo_type = make_unit_melee_ammo_type(90),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, elec_biter_tint2),
			range_mode = "bounding-box-to-bounding-box"
		},
		vision_distance = 30,
		movement_speed = 0.3,
		distance_per_frame = 0.32,
		-- in pu
		pollution_to_join_attack = 400,
		corpse = "behemoth-electric-biter-corpse",
		dying_explosion = "behemoth-biter-die",
		working_sound = sounds.biter_calls_behemoth(0.97),
		dying_sound = sounds.biter_dying_big(0.52),
		run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = biter_ai_settings,
		water_reflection = biter_water_reflection(behemoth_biter_scale)
	},

	-- spitters

	{
		type = "unit",
		name = "small-electric-spitter",
		icon = "__base__/graphics/icons/small-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 10,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-small",
				range = range_spitter_small,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_small,
				scale = scale_spitter_small,
				tint1 = small_biter_tint1,
				tint2 = elec_biter_tint2,
				roarvolume = 0.4,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-electric-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, small_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-electric-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 50,
		order = "b-b-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 10
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.5, -0.7 }, { 0.5, 0.7 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_mid_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = medium_biter_tint1,
				tint2 = elec_biter_tint2,
				roarvolume = 0.5,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-electric-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, medium_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-electric-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 200,
		order = "b-b-c",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 15
			}
		},
		healing_per_tick = 0.01,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_big_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = big_biter_tint1,
				tint2 = elec_biter_tint2,
				roarvolume = 0.6,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-electric-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, big_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-electric-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = 1500,
		order = "b-b-d",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "explosion",
				percent = 30
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.0 }, { 0.7, 1.0 } },
		damaged_trigger_effect = hit_effects.biter(),
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_behemoth_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = behemoth_biter_tint1,
				tint2 = elec_biter_tint2,
				roarvolume = 0.8,
				range_mode = "bounding-box-to-bounding-box"
			}),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-electric-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, behemoth_biter_tint1, elec_biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = biter_ai_settings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	add_biter_die_animation(small_biter_scale, small_biter_tint1, elec_biter_tint2,
	{
	  type = "corpse",
	  name = "small-electric-biter-corpse",
	  icon = "__base__/graphics/icons/small-biter-corpse.png",
	  icon_size = 64, icon_mipmaps = 4,
	  selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
	  selectable_in_game = false,
	  subgroup="corpses",
	  order = "c[corpse]-a[biter]-a[small]",
	  flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
	}),

	add_biter_die_animation(medium_biter_scale, medium_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "medium-electric-biter-corpse",
			icon = "__base__/graphics/icons/medium-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-b[medium]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(big_biter_scale, big_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "big-electric-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-electric-biter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-a[biter]-c[big]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_small, small_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "small-electric-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_medium, medium_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "medium-electric-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_big, big_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "big-electric-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),

	add_spitter_die_animation(scale_spitter_behemoth, behemoth_biter_tint1, elec_biter_tint2,
		{
			type = "corpse",
			name = "behemoth-electric-spitter-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64,
			icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = { { -1, -1 }, { 1, 1 } },
			subgroup = "corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
		}),
}