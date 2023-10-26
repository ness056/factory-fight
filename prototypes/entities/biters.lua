local sounds = require("__base__.prototypes.entity.sounds")

local function addBiterDieAnimation(scale, tint1, tint2, corpse)
	corpse.animation = biterdieanimation(scale, tint1, tint2)
	corpse.dying_speed = 0.04
	corpse.time_before_removed = 5 * 60
	corpse.time_before_shading_off = 4 * 60
	corpse.direction_shuffle = { { 1, 2, 3, 16 }, { 4, 5, 6, 7 }, { 8, 9, 10, 11 }, { 12, 13, 14, 15 } }
	corpse.shuffle_directions_at_frame = 7
	corpse.final_render_layer = "lower-object-above-shadow"

	corpse.ground_patch_render_layer = "decals" -- "transport-belt-integration"
	corpse.ground_patch_fade_in_delay = 1 /
	0.02                                      --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
	corpse.ground_patch_fade_in_speed = 0.002
	corpse.ground_patch_fade_out_start = 6 * 60
	corpse.ground_patch_fade_out_duration = 5 * 60

	local a = 1
	local d = 0.9
	corpse.ground_patch =
	{
		sheet =
		{
			filename = "__base__/graphics/entity/biter/blood-puddle-var-main.png",
			flags = { "low-object" },
			line_length = 4,
			variation_count = 4,
			frame_count = 1,
			width = 84,
			height = 68,
			shift = util.by_pixel(1, 0),
			tint = { r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a },
			scale = scale,
			hr_version =
			{
				filename = "__base__/graphics/entity/biter/hr-blood-puddle-var-main.png",
				flags = { "low-object" },
				line_length = 4,
				variation_count = 4,
				frame_count = 1,
				width = 164,
				height = 134,
				shift = util.by_pixel(-0.5, -0.5),
				tint = { r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a },
				scale = 0.5 * scale
			}
		}
	}
	return corpse
end

local function addSpitterDieAnimation(scale, tint1, tint2, corpse)
	corpse.animation = spitterdyinganimation(scale, tint1, tint2)
	corpse.dying_speed = 0.04
	corpse.time_before_removed = 5 * 60
	corpse.time_before_shading_off = 4 * 60
	corpse.direction_shuffle = { { 1, 2, 3, 16 }, { 4, 5, 6, 7 }, { 8, 9, 10, 11 }, { 12, 13, 14, 15 } }
	corpse.shuffle_directions_at_frame = 4
	corpse.final_render_layer = "lower-object-above-shadow"

	corpse.ground_patch_render_layer = "decals" -- "transport-belt-integration"
	corpse.ground_patch_fade_in_delay = 1 /
	0.02                                      --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
	corpse.ground_patch_fade_in_speed = 0.002
	corpse.ground_patch_fade_out_start = 6 * 60
	corpse.ground_patch_fade_out_duration = 5 * 60

	local a = 1
	local d = 0.9
	corpse.ground_patch =
	{
		sheet =
		{
			filename = "__base__/graphics/entity/biter/blood-puddle-var-main.png",
			flags = { "low-object" },
			line_length = 4,
			variation_count = 4,
			frame_count = 1,
			width = 84,
			height = 68,
			shift = util.by_pixel(1, 0),
			tint = { r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a },
			scale = scale,
			hr_version =
			{
				filename = "__base__/graphics/entity/biter/hr-blood-puddle-var-main.png",
				flags = { "low-object" },
				line_length = 4,
				variation_count = 4,
				frame_count = 1,
				width = 164,
				height = 134,
				shift = util.by_pixel(-0.5, -0.5),
				tint = { r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a },
				scale = 0.5 * scale
			}
		}
	}
	return corpse
end

---@param damagevalue number @how many damage the biter does
---@param damageType string @damage type
---@param actions? table
---@return table
local function makeUnitMeleeAmmoType(damagevalue, damageType, actions)
	if not actions then
		actions = {}
	end
	actions[#actions+1] = {
		type = "direct",
		action_delivery = {
			{
				type = "instant",
				target_effects =
				{
					type = "damage",
					damage = { amount = damagevalue * 0.65, type = damageType }
				}
			},
			{
				type = "instant",
				target_effects =
				{
					type = "damage",
					damage = { amount = damagevalue * 0.35, type = "physical" }
				}
			}
		}
	}

	return
	{
		category = "melee",
		target_type = "entity",
		action = actions
	}
end

---@param damagevalue number
---@param lifestealPercentage number
---@return table
local function makeWaterUnitMeleeAmmoType(damagevalue, lifestealPercentage)
	local actions = {
		{
			type = "direct",
			action_delivery = {
				type = "instant",
				source_effects = {
					type = "damage",
					damage = { amount = -damagevalue * lifestealPercentage, type = "water" }
				}
			}
		}
	}
	return makeUnitMeleeAmmoType(damagevalue, "water", actions)
end

---@param damagevalue number
---@param radius number
---@param areaDamagePercentage number
---@return table
local function makeFireUnitMeleeAmmoType(damagevalue, radius, areaDamagePercentage)
	local actions = {
		{
			type = "area",
			radius = radius,
			force = "enemy",
			action_delivery = {
				type = "instant",
				target_effects =
				{
					type = "damage",
					damage = { amount = damagevalue * areaDamagePercentage, type = "fire" }
				}
			}
		}
	}
	return makeUnitMeleeAmmoType(damagevalue, "fire", actions)
end

---@param cooldown number
---@param range number
---@param damagevalue number
---@param scale number
---@param tint1 Color @https://lua-api.factorio.com/latest/concepts.html#Color
---@param tint2 Color @https://lua-api.factorio.com/latest/concepts.html#Color
---@param acidStreamName string
---@return table
local function spitterAttackParameters(cooldown, range, scale, tint1, tint2, acidStreamName)
	return
	{
		type = "stream",
		cooldown = cooldown,
		cooldown_deviation = 0.15,
		range = range,
		range_mode = "bounding-box-to-bounding-box",
		min_attack_distance = 10,
		--projectile_creation_distance = 1.9,
		warmup = 30,
		projectile_creation_parameters = spitter_shoot_shiftings(scale, scale * scale_spitter_stream),
		use_shooter_direction = true,

		lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

		ammo_type =
		{
			category = "biological",
			action =
			{
				type = "direct",
				action_delivery =
				{
					{
						type = "stream",
						stream = acidStreamName
					}
				}
			}
		},
		cyclic_sound =
		{
			begin_sound =
			{
				{
					filename = "__base__/sound/creatures/spitter-spit-start-1.ogg",
					volume = 0.27
				},
				{
					filename = "__base__/sound/creatures/spitter-spit-start-2.ogg",
					volume = 0.27
				},
				{
					filename = "__base__/sound/creatures/spitter-spit-start-3.ogg",
					volume = 0.27
				},
				{
					filename = "__base__/sound/creatures/spitter-spit-start-4.ogg",
					volume = 0.27
				}
			},
			middle_sound =
			{
				{
					filename = "__base__/sound/fight/flamethrower-mid.ogg",
					volume = 0
				}
			},
			end_sound =
			{
				{
					filename = "__base__/sound/creatures/spitter-spit-end-1.ogg",
					volume = 0
				}
			}
		},
		--sound = sounds.spitter_roars(data.roarvolume),
		animation = spitterattackanimation(scale, tint1, tint2)
	}
end

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
		max_health = _CONFIG.biters.neutral.small_biter_hp or _CONFIG.biters.small_biter_default_hp,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.neutral.small_biter_damage, "neutral"),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
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
		run_animation = biterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.neutral.medium_biter_hp or _CONFIG.biters.medium_biter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.neutral.medium_biter_damage, "neutral"),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
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
		run_animation = biterrunanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.neutral.big_biter_hp or _CONFIG.biters.big_biter_default_hp,
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.neutral.big_biter_damage, "neutral"),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
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
		run_animation = biterrunanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.neutral.behemoth_biter_hp or _CONFIG.biters.behemoth_biter_default_hp,
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.neutral.behemoth_biter_damage, "neutral"),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
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
		run_animation = biterrunanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.neutral.small_spitter_hp or _CONFIG.biters.small_spitter_default_hp,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_small, scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2, "small-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.neutral.medium_spitter_hp or _CONFIG.biters.medium_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_medium, scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2, "medium-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.neutral.big_spitter_hp or _CONFIG.biters.big_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_big, scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2, "big-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.neutral.behemoth_spitter_hp or _CONFIG.biters.behemoth_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_behemoth, scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2, "behemoth-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	addBiterDieAnimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addBiterDieAnimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addBiterDieAnimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addBiterDieAnimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.neutral.biter_tint2,
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
		max_health = _CONFIG.biters.water.small_biter_hp or _CONFIG.biters.small_biter_default_hp,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = makeWaterUnitMeleeAmmoType(_CONFIG.biters.water.small_biter_damage, _CONFIG.biters.water.small_biter_heathsteal_percentage),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
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
		run_animation = biterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-water-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.water.medium_biter_hp or _CONFIG.biters.medium_biter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = makeWaterUnitMeleeAmmoType(_CONFIG.biters.water.medium_biter_damage, _CONFIG.biters.water.medium_biter_heathsteal_percentage),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
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
		run_animation = biterrunanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.water.big_biter_hp or _CONFIG.biters.big_biter_default_hp,
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
			ammo_type = makeWaterUnitMeleeAmmoType(_CONFIG.biters.water.big_biter_damage, _CONFIG.biters.water.big_biter_heathsteal_percentage),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
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
		run_animation = biterrunanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.water.behemoth_biter_hp or _CONFIG.biters.behemoth_biter_default_hp,
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
			ammo_type = makeWaterUnitMeleeAmmoType(_CONFIG.biters.water.behemoth_biter_damage, _CONFIG.biters.water.behemoth_biter_heathsteal_percentage),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
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
		run_animation = biterrunanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.water.small_spitter_hp or _CONFIG.biters.small_spitter_default_hp,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_small, scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2, "small-water-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-water-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-water-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.water.medium_spitter_hp or _CONFIG.biters.medium_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_medium, scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2, "medium-water-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-water-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-water-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.water.big_spitter_hp or _CONFIG.biters.big_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_big, scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2, "big-water-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-water-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-water-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.water.behemoth_spitter_hp or _CONFIG.biters.behemoth_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_behemoth, scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2, "behemoth-water-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-water-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	addBiterDieAnimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addBiterDieAnimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addBiterDieAnimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addBiterDieAnimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.water.biter_tint2,
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
		max_health = _CONFIG.biters.fire.small_biter_hp or _CONFIG.biters.small_biter_default_hp,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = makeFireUnitMeleeAmmoType(_CONFIG.biters.fire.small_biter_damage, _CONFIG.biters.fire.small_biter_aoe_radius, _CONFIG.biters.fire.small_biter_aoe_damage_percentage),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
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
		run_animation = biterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-fire-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.fire.medium_biter_hp or _CONFIG.biters.medium_biter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = makeFireUnitMeleeAmmoType(_CONFIG.biters.fire.medium_biter_damage, _CONFIG.biters.fire.medium_biter_aoe_radius, _CONFIG.biters.fire.medium_biter_aoe_damage_percentage),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
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
		run_animation = biterrunanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.fire.big_biter_hp or _CONFIG.biters.big_biter_default_hp,
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
			ammo_type = makeFireUnitMeleeAmmoType(_CONFIG.biters.fire.big_biter_damage, _CONFIG.biters.fire.big_biter_aoe_radius, _CONFIG.biters.fire.big_biter_aoe_damage_percentage),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
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
		run_animation = biterrunanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.fire.behemoth_biter_hp or _CONFIG.biters.behemoth_biter_default_hp,
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
			ammo_type = makeFireUnitMeleeAmmoType(_CONFIG.biters.fire.behemoth_biter_damage, _CONFIG.biters.fire.behemoth_biter_aoe_radius, _CONFIG.biters.fire.behemoth_biter_aoe_damage_percentage),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
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
		run_animation = biterrunanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.fire.small_spitter_hp or _CONFIG.biters.small_spitter_default_hp,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_small, scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2, "small-fire-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-fire-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-fire-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.fire.medium_spitter_hp or _CONFIG.biters.medium_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_medium, scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2, "medium-fire-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-fire-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-fire-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.fire.big_spitter_hp or _CONFIG.biters.big_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_big, scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2, "big-fire-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-fire-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-fire-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.fire.behemoth_spitter_hp or _CONFIG.biters.behemoth_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_behemoth, scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2, "behemoth-fire-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-fire-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	addBiterDieAnimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addBiterDieAnimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addBiterDieAnimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addBiterDieAnimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.fire.biter_tint2,
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
		max_health = _CONFIG.biters.plant.small_biter_hp or _CONFIG.biters.small_biter_default_hp,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.plant.small_biter_damage, "plant"),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
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
		run_animation = biterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-plant-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.plant.medium_biter_hp or _CONFIG.biters.medium_biter_default_hp,
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
		dying_trigger_effect = {
			type = "script",
			effect_id = "create-small-plant-biter",
		},
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.plant.medium_biter_damage, "plant"),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
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
		run_animation = biterrunanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.plant.big_biter_hp or _CONFIG.biters.big_biter_default_hp,
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
		dying_trigger_effect = {
			type = "script",
			effect_id = "create-medium-plant-biter",
			repeat_count = 2
		},
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.plant.big_biter_damage, "plant"),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
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
		run_animation = biterrunanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.plant.behemoth_biter_hp or _CONFIG.biters.behemoth_biter_default_hp,
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
		dying_trigger_effect = {
			type = "script",
			effect_id = "create-big-plant-biter",
			repeat_count = 2
		},
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.plant.behemoth_biter_damage, "plant"),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
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
		run_animation = biterrunanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.plant.small_spitter_hp or _CONFIG.biters.small_spitter_default_hp,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_small, scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2, "small-plant-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-plant-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-plant-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.plant.medium_spitter_hp or _CONFIG.biters.medium_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_medium, scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2, "medium-plant-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-plant-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-plant-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.plant.big_spitter_hp or _CONFIG.biters.big_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_big, scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2, "big-plant-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-plant-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-plant-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.plant.behemoth_spitter_hp or _CONFIG.biters.behemoth_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_behemoth, scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2, "behemoth-plant-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-plant-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	addBiterDieAnimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addBiterDieAnimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addBiterDieAnimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addBiterDieAnimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.plant.biter_tint2,
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
		max_health = _CONFIG.biters.rock.small_biter_hp or _CONFIG.biters.small_biter_default_hp,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.05,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.rock.small_biter_damage, "rock"),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
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
		run_animation = biterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-rock-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.rock.medium_biter_hp or _CONFIG.biters.medium_biter_default_hp,
		order = "b-a-b",
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 6,
				percent = 20
			},
			{
				type = "explosion",
				percent = 20
			}
		},
		healing_per_tick = 0.05,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.rock.medium_biter_damage, "rock"),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
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
		run_animation = biterrunanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.rock.big_biter_hp or _CONFIG.biters.big_biter_default_hp,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 12,
				percent = 25
			},
			{
				type = "explosion",
				percent = 25
			}
		},
		healing_per_tick = 0.1,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.rock.big_biter_damage, "rock"),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
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
		run_animation = biterrunanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.rock.behemoth_biter_hp or _CONFIG.biters.behemoth_biter_default_hp,
		subgroup = "enemies",
		resistances =
		{
			{
				type = "physical",
				decrease = 18,
				percent = 30
			},
			{
				type = "explosion",
				decrease = 12,
				percent = 30
			}
		},
		healing_per_tick = 0.5,
		collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		selection_box = { { -0.7, -1.5 }, { 0.7, 0.3 } },
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.rock.behemoth_biter_damage, "rock"),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
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
		run_animation = biterrunanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.rock.small_spitter_hp or _CONFIG.biters.small_spitter_default_hp,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_small, scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2, "small-rock-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.185,
		distance_per_frame = 0.04,
		-- in pu
		pollution_to_join_attack = 4,
		corpse = "small-rock-spitter-corpse",
		dying_explosion = "small-spitter-die",
		working_sound = sounds.spitter_calls(0.44),
		dying_sound = sounds.spitter_dying(0.45),
		run_animation = spitterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-rock-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.rock.medium_spitter_hp or _CONFIG.biters.medium_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_medium, scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2, "medium-rock-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.165,
		distance_per_frame = 0.055,
		-- in pu
		pollution_to_join_attack = 12,
		corpse = "medium-rock-spitter-corpse",
		dying_explosion = "medium-spitter-die",
		working_sound = sounds.spitter_calls_med(0.53),
		dying_sound = sounds.spitter_dying_mid(0.65),
		run_animation = spitterrunanimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-rock-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.rock.big_spitter_hp or _CONFIG.biters.big_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_big, scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2, "big-rock-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.07,
		-- in pu
		pollution_to_join_attack = 30,
		corpse = "big-rock-spitter-corpse",
		dying_explosion = "big-spitter-die",
		working_sound = sounds.spitter_calls_big(0.46),
		dying_sound = sounds.spitter_dying_big(0.71),
		run_animation = spitterrunanimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-rock-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.rock.behemoth_spitter_hp or _CONFIG.biters.behemoth_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitterAttackParameters(
			100, range_spitter_behemoth, scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2, "behemoth-rock-spitter-stream"
		),
		vision_distance = 30,
		movement_speed = 0.15,
		distance_per_frame = 0.084,
		pollution_to_join_attack = 200,
		corpse = "behemoth-rock-spitter-corpse",
		dying_explosion = "behemoth-spitter-die",
		working_sound = sounds.spitter_calls_big(0.6),
		dying_sound = sounds.spitter_dying_behemoth(0.70),
		run_animation = spitterrunanimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	addBiterDieAnimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addBiterDieAnimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addBiterDieAnimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addBiterDieAnimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.rock.biter_tint2,
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
		max_health = _CONFIG.biters.electric.small_biter_hp or _CONFIG.biters.small_biter_default_hp,
		order = "b-a-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
		selection_box = { { -0.4, -0.7 }, { 0.4, 0.4 } },
		attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 35,
			cooldown_deviation = 0.15,
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.electric.small_biter_damage, "electric"),
			sound = sounds.biter_roars(0.35),
			animation = biterattackanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
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
		run_animation = biterrunanimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = biter_water_reflection(small_biter_scale)
	},

	{
		type = "unit",
		name = "medium-electric-biter",
		icon = "__base__/graphics/icons/medium-biter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.electric.medium_biter_hp or _CONFIG.biters.medium_biter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		attack_parameters =
		{
			type = "projectile",
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.electric.medium_biter_damage, "electric"),
			range = 1,
			cooldown = 35,
			cooldown_deviation = 0.15,
			sound = sounds.biter_roars_mid(0.73),
			animation = biterattackanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
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
		run_animation = biterrunanimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk(0.4),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.electric.big_biter_hp or _CONFIG.biters.big_biter_default_hp,
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.electric.big_biter_damage, "electric"),
			sound = sounds.biter_roars_big(0.37),
			animation = biterattackanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
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
		run_animation = biterrunanimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.7),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.electric.behemoth_biter_hp or _CONFIG.biters.behemoth_biter_default_hp,
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
			ammo_type = makeUnitMeleeAmmoType(_CONFIG.biters.electric.behemoth_biter_damage, "electric"),
			sound = sounds.biter_roars_behemoth(0.65),
			animation = biterattackanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
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
		run_animation = biterrunanimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.biter_walk_big(0.78),
		ai_settings = _CONFIG.biters.biterAiSettings,
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
		max_health = _CONFIG.biters.electric.small_spitter_hp or _CONFIG.biters.small_spitter_default_hp,
		order = "b-b-a",
		subgroup = "enemies",
		resistances = {},
		healing_per_tick = 0.01,
		collision_box = { { -0.3, -0.3 }, { 0.3, 0.3 } },
		selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
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
				tint1 = _CONFIG.biters.biter_tint1,
				tint2 = _CONFIG.biters.electric.biter_tint2,
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
		run_animation = spitterrunanimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.3),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_small)
	},

	{
		type = "unit",
		name = "medium-electric-spitter",
		icon = "__base__/graphics/icons/medium-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.electric.medium_spitter_hp or _CONFIG.biters.medium_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-medium",
				range = range_spitter_medium,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_medium,
				scale = scale_spitter_medium,
				tint1 = _CONFIG.biters.biter_tint1,
				tint2 = _CONFIG.biters.electric.biter_tint2,
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
		run_animation = spitterrunanimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_medium)
	},

	{
		type = "unit",
		name = "big-electric-spitter",
		icon = "__base__/graphics/icons/big-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.electric.big_spitter_hp or _CONFIG.biters.big_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-big",
				range = range_spitter_big,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_big,
				scale = scale_spitter_big,
				tint1 = _CONFIG.biters.biter_tint1,
				tint2 = _CONFIG.biters.electric.biter_tint2,
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
		run_animation = spitterrunanimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.5),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_big)
	},

	{
		type = "unit",
		name = "behemoth-electric-spitter",
		icon = "__base__/graphics/icons/behemoth-spitter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
		max_health = _CONFIG.biters.electric.behemoth_spitter_hp or _CONFIG.biters.behemoth_spitter_default_hp,
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
		sticker_box = { { -0.3, -0.5 }, { 0.3, 0.1 } },
		distraction_cooldown = 300,
		min_pursue_time = 10 * 60,
		max_pursue_distance = 50,
		alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
		attack_parameters = spitter_attack_parameters(
			{
				acid_stream_name = "acid-stream-spitter-behemoth",
				range = range_spitter_behemoth,
				min_attack_distance = 10,
				cooldown = 100,
				cooldown_deviation = 0.15,
				damage_modifier = damage_modifier_spitter_behemoth,
				scale = scale_spitter_behemoth,
				tint1 = _CONFIG.biters.biter_tint1,
				tint2 = _CONFIG.biters.electric.biter_tint2,
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
		run_animation = spitterrunanimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2),
		running_sound_animation_positions = { 2, },
		walking_sound = sounds.spitter_walk_big(0.6),
		ai_settings = _CONFIG.biters.biterAiSettings,
		water_reflection = spitter_water_reflection(scale_spitter_behemoth)
	},

	addBiterDieAnimation(small_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addBiterDieAnimation(medium_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addBiterDieAnimation(big_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addBiterDieAnimation(behemoth_biter_scale, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_small, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_medium, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_big, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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

	addSpitterDieAnimation(scale_spitter_behemoth, _CONFIG.biters.biter_tint1, _CONFIG.biters.electric.biter_tint2,
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