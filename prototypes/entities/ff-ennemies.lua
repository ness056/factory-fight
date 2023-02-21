small_biter_scale = 0.5
small_biter_tint1 = {r=0.60, g=0.58, b=0.51, a=1}
small_biter_tint2 = {r=0.9 , g=0.83, b=0.54, a=1}

medium_biter_scale = 0.7
medium_biter_tint1 = {r=0.49, g=0.46, b=0.51, a=1}
medium_biter_tint2 = {r=0.9 , g=0.83, b=0.54, a=1}

big_biter_scale = 1.0
big_biter_tint1 = {r=0.37, g=0.40, b=0.72, a=1}
big_biter_tint2 = {r=0.9 , g=0.83, b=0.54, a=1}

behemoth_biter_scale = 1.2
behemoth_biter_tint1 = {r=0.21, g=0.19, b=0.25, a=1}
behemoth_biter_tint2 = {r=0.9 , g=0.83, b=0.54, a=1}

-- grob : les biters elementaires partagent le size ET le tint1 avec les biters plus gros, mais leur tint2 diffère

water_biter_tint2 = {r=0, g=0, b=1, a=1}
fire_biter_tint2 = {r=1, g=0, b=0, a=1}
plant_biter_tint2 = {r=0, g=1, b=0, a=1}
rock_biter_tint2 = {r=0, g=1, b=1, a=1}
elec_biter_tint2 = {r=1, g=1, b=0, a=1}


data:extend(
{
  {
    type = "unit",
    name = "small-biter",
    icon = "__base__/graphics/icons/small-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    max_health = 15,
    order = "b-a-a",
    subgroup="enemies",
    resistances = {},
    healing_per_tick = 0.01,
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -0.7}, {0.4, 0.4}},
    damaged_trigger_effect = hit_effects.biter(),
    attack_parameters =
      {
      type = "projectile",
      range = 0.5,
      cooldown = 35,
      cooldown_deviation = 0.15,
      ammo_type = make_unit_melee_ammo_type(7),
      sound = sounds.biter_roars(0.35),
      animation = biterattackanimation(small_biter_scale, small_biter_tint1, small_biter_tint2),
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
    dying_sound =  sounds.biter_dying(0.5),
    working_sound =  sounds.biter_calls(0.75),
    run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, small_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk(0.3),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(small_biter_scale)
  },

  {
    type = "unit",
    name = "medium-biter",
    icon = "__base__/graphics/icons/medium-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 75,
    order="b-a-b",
    subgroup="enemies",
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
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
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
      animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2),
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
    run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk(0.4),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(medium_biter_scale)
  },

  {
    type = "unit",
    name = "big-biter",
    order="b-a-c",
    icon = "__base__/graphics/icons/big-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 375,
    subgroup="enemies",
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
    spawning_time_modifier = 3,
    healing_per_tick = 0.02,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_big(0.37),
      animation = biterattackanimation(big_biter_scale, big_biter_tint1, big_biter_tint2),
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
    run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, big_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.7),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(big_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  {
    type = "unit",
    name = "behemoth-biter",
    order="b-a-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
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
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    damaged_trigger_effect = hit_effects.biter(),
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
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
      sound =  sounds.biter_roars_behemoth(0.65),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
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
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    running_sound_animation_positions = {2,},
    walking_sound = sounds.biter_walk_big(0.78),
    ai_settings = biter_ai_settings,
    water_reflection = biter_water_reflection(behemoth_biter_scale)
  },

  add_biter_die_animation(small_biter_scale, small_biter_tint1, small_biter_tint2,
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

  add_biter_die_animation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2,
  {
    type = "corpse",
    name = "medium-biter-corpse",
    icon = "__base__/graphics/icons/medium-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-a[biter]-b[medium]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  }),

  add_biter_die_animation(big_biter_scale, big_biter_tint1, big_biter_tint2,
  {
    type = "corpse",
    name = "big-biter-corpse",
    icon = "__base__/graphics/icons/big-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-a[biter]-c[big]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  }),

  add_biter_die_animation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2,
  {
    type = "corpse",
    name = "behemoth-biter-corpse",
    icon = "__base__/graphics/icons/big-biter-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    subgroup="corpses",
    order = "c[corpse]-a[biter]-c[big]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
  }),