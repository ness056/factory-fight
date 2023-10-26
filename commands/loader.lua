local force_map_reset = require "force-map-reset"
local create_god_shield = require "create-god-shield"

commands.add_command(force_map_reset.name, force_map_reset.description, force_map_reset.f)
commands.add_command(create_god_shield.name, create_god_shield.description, create_god_shield.f)