---Defines default config
_CONFIG = {
    generation = {
        specIslandSize = 16,                    -- ness - radius in tiles
        spawnerZoneHeight = 250,                -- ness - height in tiles
        spawnerZoneWidth = 250,                 -- ness - width in tiles
        spawnerZoneMaxHeight = 500,
        spawnerZoneMaxWidth = 500,
        spawnerZoneDistanceFromCenterX = 200,   -- ness - distance from the 0,0 to the start of the spawner zone
        playerBoxHeight = 100,
        playerBoxWidth = 100,
        playerBoxMaxSize = 150,
        playerNBoxPerLine = 3,
        bitterPathWidth = 20,
        bitterPathDistanceFromCenterY = 80,     -- ness - distance from the 0,0 to the start of the bitter paths
        bordersWidth = 15                       -- ness - width of the void borders which separate differents zones (like the spawner zones or the boxs)
    },
    income = {
        oilIncomeMult = 100,
        smallValue = 10,
        mediumValue = 40,
        bigValue = 150,
        behemothValue = 2000,
        base = 50
    },
    game = {
        autoGameRestart = false,
        autoGameReset = false,
        canPlayersJoinTeam = true,
        canPlayersChangeTeam = false
    },
    biters = {
        biter_tint1 = { r = 0.60, g = 0.58, b = 0.51, a = 1 },

        small_biter_scale = 0.5,
        medium_biter_scale = 0.7,
        big_biter_scale = 1.0,
        behemoth_biter_scale = 1.2,

        small_biter_default_hp = 15,
        medium_biter_default_hp = 75,
        big_biter_default_hp = 375,
        behemoth_biter_default_hp = 3000,

        small_spitter_default_hp = 10,
        medium_spitter_default_hp = 50,
        big_spitter_default_hp = 200,
        behemoth_spitter_default_hp = 1500,

        biterAiSettings = { destroy_when_commands_fail = false, allow_try_return_to_spawner = false },
        fire_lifetime = 2,

        neutral = {
            biter_tint2 = { r = 0.9, g = 0.83, b = 0.54, a = 1 },

            small_biter_damage = 7,
            medium_biter_damage = 15,
            big_biter_damage = 30,
            behemoth_biter_damage = 90
        },
        water = {
            biter_tint2 = { r = 0, g = 0.5, b = 1, a = 1 },
            stream_tint = { r = 0, g = 0.7, b = 1, a = 1 },

            small_biter_damage = 7,
            medium_biter_damage = 15,
            big_biter_damage = 30,
            behemoth_biter_damage = 90,

            small_biter_heathsteal_percentage = 0.25,
            medium_biter_heathsteal_percentage = 0.3,
            big_biter_heathsteal_percentage = 0.35,
            behemoth_biter_heathsteal_percentage = 0.4,

            small_spitter_impact_healing = 12 * 0.5, -- damage_modifier_spitter_small
            medium_spitter_impact_healing = 24 * 0.5, -- damage_modifier_spitter_medium
            big_spitter_impact_healing = 36 * 0.5, -- damage_modifier_spitter_big
            behemoth_spitter_impact_healing = 60 * 0.5, -- damage_modifier_spitter_behemoth

            small_spitter_fire_healing = 12 * 0.1,
            medium_spitter_fire_healing = 24 * 0.1,
            big_spitter_fire_healing = 36 * 0.1,
            behemoth_spitter_fire_healing = 60 * 0.1,

            small_spitter_fire_damage = 12 * 0.1,
            medium_spitter_fire_damage = 24 * 0.1,
            big_spitter_fire_damage = 36 * 0.1,
            behemoth_spitter_fire_damage = 60 * 0.1
        },
        fire = {
            biter_tint2 = { r = 1, g = 0, b = 0, a = 1 },

            small_biter_damage = 7,
            medium_biter_damage = 15,
            big_biter_damage = 30,
            behemoth_biter_damage = 90,

            small_biter_aoe_radius = 2.5,
            medium_biter_aoe_radius = 5,
            big_biter_aoe_radius = 7.5,
            behemoth_biter_aoe_radius = 10,

            small_biter_aoe_damage_percentage = 0.1,
            medium_biter_aoe_damage_percentage = 0.1,
            big_biter_aoe_damage_percentage = 0.15,
            behemoth_biter_aoe_damage_percentage = 0.2,

            small_spitter_impact_damage = 12 * 0.5, -- damage_modifier_spitter_small
            medium_spitter_impact_damage = 24 * 0.5, -- damage_modifier_spitter_medium
            big_spitter_impact_damage = 36 * 0.5, -- damage_modifier_spitter_big
            behemoth_spitter_impact_damage = 60 * 0.5, -- damage_modifier_spitter_behemoth

            small_spitter_fire_damage = 12 * 0.5,
            medium_spitter_fire_damage = 24 * 0.5,
            big_spitter_fire_damage = 36 * 0.5,
            behemoth_spitter_fire_damage = 60 * 0.5
        },
        plant = {
            biter_tint2 = { r = 0, g = 1, b = 0, a = 1 },

            small_biter_damage = 7,
            medium_biter_damage = 15,
            big_biter_damage = 30,
            behemoth_biter_damage = 90
        },
        electric = {
            biter_tint2 = { r = 1, g = 1, b = 0, a = 1 },

            small_biter_damage = 11,
            medium_biter_damage = 24,
            big_biter_damage = 48,
            behemoth_biter_damage = 140
        },
        rock = {
            biter_tint2 = { r = 0.54, g = 0.27, b = 0.07, a = 1 },

            small_biter_hp = 30,
            medium_biter_hp = 150,
            big_biter_hp = 750,
            behemoth_biter_hp = 6000,

            small_biter_damage = 7,
            medium_biter_damage = 15,
            big_biter_damage = 30,
            behemoth_biter_damage = 90,

            small_spitter_spell_range = 8,
            medium_spitter_spell_range = 10,
            big_spitter_spell_range = 12,
            behemoth_spitter_spell_range = 15,

            small_spitter_spell_proba = 0.33,
            medium_spitter_spell_proba = 0.33,
            big_spitter_spell_proba = 0.33,
            behemoth_spitter_spell_proba = 0.33,
        }
    },
    shieldTypes = {
        -- set isAnimation to true and put your variations in animations 
        small_spitter_spell = {
            duration = 120, -- in ticks
            power = 0.5,
            isSprite = true,
            isAnimation = false,
            sprites = {
                "s1-rock-spitter-passive-aura",
                "s2-rock-spitter-passive-aura",
                "s3-rock-spitter-passive-aura",
                "s4-rock-spitter-passive-aura"
            }
        },
        medium_spitter_spell = {
            duration = 120, -- in ticks
            power = 0.7,
            isSprite = true,
            isAnimation = false,
            sprites = {
                "s1-rock-spitter-passive-aura",
                "s2-rock-spitter-passive-aura",
                "s3-rock-spitter-passive-aura",
                "s4-rock-spitter-passive-aura"
            }
        },
        big_spitter_spell = {
            duration = 120, -- in ticks
            power = 0.85,
            isSprite = true,
            isAnimation = false,
            sprites = {
                "s1-rock-spitter-passive-aura",
                "s2-rock-spitter-passive-aura",
                "s3-rock-spitter-passive-aura",
                "s4-rock-spitter-passive-aura"
            }
        },
        behemoth_spitter_spell = {
            duration = 120, -- in ticks
            power = 0.93,
            isSprite = true,
            isAnimation = false,
            sprites = {
                "s1-rock-spitter-passive-aura",
                "s2-rock-spitter-passive-aura",
                "s3-rock-spitter-passive-aura",
                "s4-rock-spitter-passive-aura"
            }
        },
        god_shield = {
            duration = -1,  -- -1 means infinity
            power = 1,
            isSprite = true,
            isAnimation = false,
            sprites = {
                "god-shield"
            },
            offset = {0, -0.35}
        }
    },
    turrets = {
        {
            prototype = "behemoth-worm-turret",
            position = 0.8  -- percentage between 0, y and spawnerZoneDistanceFromCenterX, y
        }
    }
}