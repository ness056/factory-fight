local sounds = require("__base__.prototypes.entity.sounds")

local basic_belt_tint = { r = 1, g = 0.76, b = 0.25, a = 0.82}
local fast_belt_tint = { r = 0.89, g = 0.09, b = 0.09, a = 0.82}
local express_belt_tint = { r = 0.26, g = 0.75, b = 0.98, a = 0.82}

data:extend{
    {
        type = "loader-1x1",
        name = "loader_",
        icons = {
            {
                icon = "__factory-fight__/graphics/icons/loader-base.png",
                icon_size = 64
            },
            {
                icon = "__factory-fight__/graphics/icons/loader-mask.png",
                icon_size = 64,
                tint = basic_belt_tint
            }
        },
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "loader_"},
        max_health = 170,
        filter_count = 5,
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        working_sound = sounds.loader,
        corpse = "small-remnants",
        resistances = {
            {
                type = "fire",
                percent = 60
            }
        },
        collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        animation_speed_coefficient = 32,
        belt_animation_set = basic_belt_animation_set,
        fast_replaceable_group = "loader",
        speed = 0.03125,
        structure_render_layer = "lower-object",
        structure = {
            direction_in = {
                sheets = {
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-base.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-base.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-mask.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        tint = basic_belt_tint,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-mask.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            tint = basic_belt_tint,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-shadow.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-shadow.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            },
            direction_out = {
                sheets = {
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-base.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-base.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-mask.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        tint = basic_belt_tint,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-mask.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            tint = basic_belt_tint,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-shadow.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-shadow.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            }
        }
    },

    {
        type = "loader-1x1",
        name = "fast-loader_",
        icons = {
            {
                icon = "__factory-fight__/graphics/icons/loader-base.png",
                icon_size = 64
            },
            {
                icon = "__factory-fight__/graphics/icons/loader-mask.png",
                icon_size = 64,
                tint = fast_belt_tint
            }
        },
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "fast-loader_"},
        max_health = 170,
        filter_count = 5,
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        working_sound = sounds.loader,
        corpse = "small-remnants",
        resistances = {
            {
                type = "fire",
                percent = 60
            }
        },
        collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        animation_speed_coefficient = 32,
        belt_animation_set = fast_belt_animation_set,
        fast_replaceable_group = "loader",
        speed = 0.0625,
        structure_render_layer = "lower-object",
        structure = {
            direction_in = {
                sheets = {
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-base.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-base.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-mask.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        tint = fast_belt_tint,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-mask.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            tint = fast_belt_tint,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-shadow.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-shadow.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            },
            direction_out = {
                sheets = {
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-base.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-base.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-mask.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        tint = fast_belt_tint,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-mask.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            tint = fast_belt_tint,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-shadow.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-shadow.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            }
        }
    },

        {
        type = "loader-1x1",
        name = "express-loader_",
        icons = {
            {
                icon = "__factory-fight__/graphics/icons/loader-base.png",
                icon_size = 64
            },
            {
                icon = "__factory-fight__/graphics/icons/loader-mask.png",
                icon_size = 64,
                tint = express_belt_tint
            }
        },
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "express-loader_"},
        max_health = 170,
        filter_count = 5,
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        working_sound = sounds.loader,
        corpse = "small-remnants",
        resistances = {
            {
                type = "fire",
                percent = 60
            }
        },
        collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        animation_speed_coefficient = 32,
        belt_animation_set = express_belt_animation_set,
        fast_replaceable_group = "loader",
        speed = 0.09375,
        structure_render_layer = "lower-object",
        structure = {
            direction_in = {
                sheets = {
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-base.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-base.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-mask.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        tint = express_belt_tint,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-mask.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            tint = express_belt_tint,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-shadow.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-shadow.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            },
            direction_out = {
                sheets = {
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-base.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-base.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-mask.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        tint = express_belt_tint,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-mask.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            tint = express_belt_tint,
                            scale = 0.5
                        }
                    },
                    {
                        filename = "__factory-fight__/graphics/entities/loader-structure-shadow.png",
                        priority = "extra-high",
                        width = 96,
                        height = 96,
                        y = 96,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = "__factory-fight__/graphics/entities/hr-loader-structure-shadow.png",
                            priority = "extra-high",
                            width = 192,
                            height = 192,
                            y = 192,
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            }
        }
    }
}