data:extend{
    {
        type = "simple-entity-with-owner",
        name = "teleporter",
        flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game" },
        animations = {{
            filename = "__factory-fight__/graphics/entities/teleporter-animation.png",
            priority = "extra-high",
            width = 500,
            height = 500,
            scale = 0.5,
            frame_count = 32,
            line_length = 8,
            animation_speed = 0.35
        }},
        collision_box = { { -2.25, -2.25 }, { 2.25, 2.25 } }
    },

    {
        type = "linked-container",
        name = "linked-chest",
        icon = "__base__/graphics/icons/linked-chest-icon.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = "linked-chest" },
        max_health = 100,
        corpse = "wooden-chest-remnants",
        dying_explosion = "wooden-chest-explosion",
        collision_box = { { -0.35, -0.35 }, { 0.35, 0.35 } },
        fast_replaceable_group = "container",
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        inventory_size = 1000,
        open_sound = { filename = "__base__/sound/wooden-chest-open.ogg", volume = 0.6 },
        close_sound = { filename = "__base__/sound/wooden-chest-close.ogg", volume = 0.6 },
        gui_mode = "none",
        picture =
        {
            layers =
            {
                {
                    filename = "__base__/graphics/entity/linked-chest/linked-chest.png",
                    priority = "extra-high",
                    width = 34,
                    height = 38,
                    frame_count = 7,
                    shift = util.by_pixel(0, -2),
                    hr_version =
                    {
                        filename = "__base__/graphics/entity/linked-chest/hr-linked-chest.png",
                        priority = "extra-high",
                        width = 66,
                        height = 74,
                        frame_count = 7,
                        shift = util.by_pixel(0, -2),
                        scale = 0.5
                    }
                },
                {
                    filename = "__base__/graphics/entity/linked-chest/linked-chest-shadow.png",
                    priority = "extra-high",
                    width = 56,
                    height = 24,
                    repeat_count = 7,
                    shift = util.by_pixel(12, 5),
                    draw_as_shadow = true,
                    hr_version =
                    {
                        filename = "__base__/graphics/entity/linked-chest/hr-linked-chest-shadow.png",
                        priority = "extra-high",
                        width = 112,
                        height = 46,
                        repeat_count = 7,
                        shift = util.by_pixel(12, 4.5),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        }
    },

    {
        type = "simple-entity-with-owner",
        name = "linked-chest-blocker",
        flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game" },
        picture = {
            filename = "__base__/graphics/terrain/lab-tiles/lab-dark-2.png",
            size = 32
        },
        collision_box = { { -0.49, -0.49 }, { 0.49, 0.49 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
    }
}

local giantStorageTank = table.deepcopy(data.raw["storage-tank"]["storage-tank"])
giantStorageTank.name = "giant-storage-tank"
giantStorageTank.fluid_box.base_area = 10000
giantStorageTank.flags = { "not-rotatable", "not-deconstructable", "not-flammable", "not-blueprintable", "not-selectable-in-game" }

data:extend{giantStorageTank}