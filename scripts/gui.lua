local Player = require("__factory-fight__.scripts.player")
local Utils = require("__factory-fight__.scripts.utils")
local Teams = require("__factory-fight__.scripts.teams")
local Game = require("__factory-fight__.scripts.game")

local Gui = {}

function Gui.refreshAllGui()
    for i, player in pairs(game.connected_players) do
        Gui.refreshGui(player)
    end
end

function Gui.refreshGui(player)
    Gui.destroyInfoTab(player)
    Gui.createInfoTab(player)
end

function Gui.createInfoTab(player)
    local team = Player.getTeamOfPlayer(player)

    local frame = player.gui.top.add{type = "frame", name = "info-tab-frame", direction = "vertical"}

    local timer = Utils.getGameTimerInSMinH()
    local s = {"game-timer-not-started"}
    if global.gameStarted then
        s = {"game-timer-started", timer.h .. "h ", timer.min .. "min ", timer.s .. "s"}
    end
    local timer_ = frame.add{type = "label", name = "info-tab-timer", caption = s}
    timer_.style.font = "default-large-bold"

    frame.add{type = "line", direction = "horizontal"}

    local leftTeam = frame.add{type = "label", name = "info-tab-left-team", caption = {"left-team"}}
    leftTeam.style.font = "default-bold"
    leftTeam.style.font_color = {r = 0, g = 0, b = 1}

    local leftTeamPlayer = table.concat(global.bluePlayers, ", ")
    local leftTeamPlayer_ = frame.add{type = "label", name = "info-tab-left-team-player", caption = {"player-list", #global.bluePlayers, leftTeamPlayer}}

    if team ~= "blue" then
        local button = frame.add{type = "sprite-button", name = "join-blue-team", caption = {"join"}}
        button.style.font = "default-bold"
        button.style.font_color = {r = 0.98, g = 0.66, b = 0.22}
        button.style.width = 50
        button.style.height = 35
    end

    frame.add{type = "line", direction = "horizontal"}

    local rightTeam = frame.add{type = "label", name = "info-tab-right-team", caption = {"right-team"}}
    rightTeam.style.font = "default-bold"
    rightTeam.style.font_color = {r = 1, g = 0, b = 0}

    local rightTeamPlayer = table.concat(global.redPlayers, ", ")
    local rightTeamPlayer_ = frame.add{type = "label", name = "info-tab-right-team-player", caption = {"player-list", #global.redPlayers, rightTeamPlayer}}

    if team ~= "red" then
        local button = frame.add{type = "sprite-button", name = "join-red-team", caption = {"join"}}
        button.style.font = "default-bold"
        button.style.font_color = {r = 0.98, g = 0.66, b = 0.22}
        button.style.width = 50
        button.style.height = 35
    end

    local frame_
    if team ~= "spec" or not global.gameStarted then
        frame.add{type = "line", direction = "horizontal"}
        frame_ = frame.add{type = "table", column_count = 2}
    end

    if team ~= "spec" then
        local button = frame_.add{type = "sprite-button", name = "join-spec", caption = {"spectate"}}
        button.style.font = "default-bold"
        button.style.font_color = {r = 0.98, g = 0.66, b = 0.22}
        button.style.width = 100
        button.style.height = 35
    end

    if not global.gameStarted then
        local button = frame_.add{type = "sprite-button", name = "start-game", caption = {"start-game"}}
        button.style.font = "default-bold"
        button.style.font_color = {r = 0.98, g = 0.66, b = 0.22}
        button.style.width = 100
        button.style.height = 35
    end
end

function Gui.destroyInfoTab(player)
    if player.gui.top["info-tab-frame"] then
        player.gui.top["info-tab-frame"].destroy()
    end
end

function Gui.onClick(event)
    local elementName = event.element.name
    local player = game.players[event.player_index]

    if elementName == "join-blue-team" then
        Teams.changeTeam(player, "blue")
    end

    if elementName == "join-red-team" then
        Teams.changeTeam(player, "red")
    end

    if elementName == "join-spec" then
        Teams.changeTeam(player, "spec")
    end

    if elementName == "start-game" then
        Game.start()
    end

    Gui.refreshGui(player)
end

return Gui