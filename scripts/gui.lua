local Player = require("__factory-fight__.scripts.player")
local Utils = require("__factory-fight__.scripts.utils")
local Teams = require("__factory-fight__.scripts.teams")
local Game = require("__factory-fight__.scripts.game")
local Config = require "__factory-fight__.config"

Gui = {}

---creates the given player's gui
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createGui(player)
    Gui.createInfoTab(player)
    Gui.createIncomeTab(player)
    Gui.createIncomeTabButton(player)
    Gui.createAdminTab(player)
    Gui.createAdminTabButton(player)
    Gui.createChangePlayerTeam(player)
end

function Gui.updateAllGui()
    for i, player in pairs(game.connected_players) do
        Gui.updateGui(player)
    end
end

---updates the given player's gui
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateGui(player)
    Gui.updateInfoTab(player)
    Gui.updateIncomeTabButton(player)
    Gui.updateIncomeTab(player)
    Gui.updateAdminTabButton(player)
    Gui.updateAdminTab(player)
end

---destroys the given player's gui
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyGui(player)
    Gui.destroyInfoTab(player)
    Gui.destroyIncomeTabButton(player)
    Gui.destroyIncomeTab(player)
    Gui.destroyAdminTabButton(player)
    Gui.destroyAdminTab(player)
    Gui.destroyChangePlayerTeam(player)
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createInfoTab(player)
    local team = Player.getTeamOfPlayer(player)

    local frame = player.gui.top.add { type = "frame", name = "info-tab-frame", direction = "vertical" }

    local timer = Utils.getGameTimerInSMinH()
    local s
    if global.isGameRunning then
        s = { "game-timer-started", timer.h, timer.min, timer.s }
    elseif not global.isGameRunning and global.winner == "" then
        s = { "game-timer-not-started" }
    else
        s = { "end-timer", timer.h, timer.min, timer.s }
    end
    local timer_ = frame.add { type = "label", name = "info-tab-timer", caption = s }
    timer_.style.font = "default-large-bold"

    frame.add { type = "line", direction = "horizontal" }

    local leftTeam = frame.add { type = "label", name = "info-tab-left-team", caption = { "left-team" } }
    leftTeam.style.font = "default-bold"
    leftTeam.style.font_color = { r = 0, g = 0, b = 1 }

    local leftTeamPlayer = table.concat(global.bluePlayers, ", ")
    local leftTeamPlayer_ = frame.add { type = "label", name = "info-tab-left-team-player", caption = { "player-list", #global.bluePlayers,
        leftTeamPlayer } }

    local joinBlueButton = frame.add { type = "sprite-button", name = "join-blue-team", caption = { "join" } }
    joinBlueButton.style.font = "default-bold"
    joinBlueButton.style.font_color = { r = 0.98, g = 0.66, b = 0.22 }
    joinBlueButton.style.width = 50
    joinBlueButton.style.height = 35

    if team == "blue" or (not global.isGameRunning and global.winner ~= "") then
        joinBlueButton.visible = false
    end

    local line1 = frame.add { type = "line", name = "line1", direction = "horizontal" }

    local rightTeam = frame.add { type = "label", name = "info-tab-right-team", caption = { "right-team" } }
    rightTeam.style.font = "default-bold"
    rightTeam.style.font_color = { r = 1, g = 0, b = 0 }

    local rightTeamPlayer = table.concat(global.redPlayers, ", ")
    local rightTeamPlayer_ = frame.add { type = "label", name = "info-tab-right-team-player", caption = { "player-list", #global.redPlayers,
        rightTeamPlayer } }

    local joinRedButton = frame.add { type = "sprite-button", name = "join-red-team", caption = { "join" } }
    joinRedButton.style.font = "default-bold"
    joinRedButton.style.font_color = { r = 0.98, g = 0.66, b = 0.22 }
    joinRedButton.style.width = 50
    joinRedButton.style.height = 35
    if team == "red" or (not global.isGameRunning and global.winner ~= "") then
        joinRedButton.visible = false
    end

    local line2 = frame.add { type = "line", name = "spec-start-table1", direction = "horizontal" }
    local table = frame.add { type = "table", name = "spec-start-table2", column_count = 2 }
    if (team == "spec" and (global.isGameRunning or not player.admin)) or (not global.isGameRunning and global.winner ~= "") then
        table.visible = false
    end

    local joinSpecButton = table.add { type = "sprite-button", name = "join-spec", caption = { "spectate" } }
    joinSpecButton.style.font = "default-bold"
    joinSpecButton.style.font_color = { r = 0.98, g = 0.66, b = 0.22 }
    joinSpecButton.style.width = 100
    joinSpecButton.style.height = 35
    if team == "spec" or (not global.isGameRunning and global.winner ~= "") then
        joinSpecButton.visible = false
    end

    local startButton = table.add { type = "sprite-button", name = "start-game", caption = { "start-game" } }
    startButton.style.font = "default-bold"
    startButton.style.font_color = { r = 0.98, g = 0.66, b = 0.22 }
    startButton.style.width = 100
    startButton.style.height = 35
    if global.isGameRunning or not player.admin or (not global.isGameRunning and global.winner ~= "") then
        startButton.visible = false
    end

    local winnerLabel = frame.add{ type = "label", name = "winner-label", caption = {"winner-label", global.winner} }
    winnerLabel.style.font = "default-large-bold"
    local nextGameLabel = frame.add{ type = "label", name = "next-game-label", caption = {"next-game-label", math.ceil(Utils.getResetTimer() / 60)}}

    if not global.isGameRunning and global.winner ~= "" then
        leftTeamPlayer_.visible = false
        leftTeam.visible = false
        rightTeamPlayer_.visible = false
        rightTeam.visible = false
        line1.visible = false
        line2.visible = false
    else
        winnerLabel.visible = false
        nextGameLabel.visible = false
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateInfoTab(player)
    local team = Player.getTeamOfPlayer(player)

    local timer = Utils.getGameTimerInSMinH()
    local s
    if global.isGameRunning then
        s = { "game-timer-started", timer.h, timer.min, timer.s }
    elseif not global.isGameRunning and global.winner == "" then
        s = { "game-timer-not-started" }
    else
        s = { "end-timer", timer.h, timer.min, timer.s }
    end
    player.gui.top["info-tab-frame"]["info-tab-timer"].caption = s

    local leftTeamPlayer = table.concat(global.bluePlayers, ", ")
    player.gui.top["info-tab-frame"]["info-tab-left-team-player"].caption = { "player-list", #global.bluePlayers,
        leftTeamPlayer }

    if team == "blue" or (not global.isGameRunning and global.winner ~= "") then
        player.gui.top["info-tab-frame"]["join-blue-team"].visible = false
    else
        player.gui.top["info-tab-frame"]["join-blue-team"].visible = true
    end

    local rightTeamPlayer = table.concat(global.redPlayers, ", ")
    player.gui.top["info-tab-frame"]["info-tab-right-team-player"].caption = { "player-list", #global.redPlayers,
        rightTeamPlayer }

    if team == "red" or (not global.isGameRunning and global.winner ~= "") then
        player.gui.top["info-tab-frame"]["join-red-team"].visible = false
    else
        player.gui.top["info-tab-frame"]["join-red-team"].visible = true
    end

    if (team == "spec" and (global.isGameRunning or not player.admin)) or (not global.isGameRunning and global.winner ~= "") then
        player.gui.top["info-tab-frame"]["spec-start-table1"].visible = false
        player.gui.top["info-tab-frame"]["spec-start-table2"].visible = false
    else
        player.gui.top["info-tab-frame"]["spec-start-table1"].visible = true
        player.gui.top["info-tab-frame"]["spec-start-table2"].visible = true
    end

    if team == "spec" or (not global.isGameRunning and global.winner ~= "") then
        player.gui.top["info-tab-frame"]["spec-start-table2"]["join-spec"].visible = false
    else
        player.gui.top["info-tab-frame"]["spec-start-table2"]["join-spec"].visible = true
    end

    if global.isGameRunning or not player.admin or (not global.isGameRunning and global.winner ~= "") then
        player.gui.top["info-tab-frame"]["spec-start-table2"]["start-game"].visible = false
    else
        player.gui.top["info-tab-frame"]["spec-start-table2"]["start-game"].visible = true
    end

    player.gui.top["info-tab-frame"]["winner-label"].caption = {"winner-label", global.winner}
    player.gui.top["info-tab-frame"]["next-game-label"].caption = {"next-game-label", math.ceil(Utils.getResetTimer() / 60)}

    if not global.isGameRunning and global.winner ~= "" then
        player.gui.top["info-tab-frame"]["info-tab-left-team-player"].visible = false
        player.gui.top["info-tab-frame"]["info-tab-left-team"].visible = false
        player.gui.top["info-tab-frame"]["info-tab-right-team-player"].visible = false
        player.gui.top["info-tab-frame"]["info-tab-right-team"].visible = false
        player.gui.top["info-tab-frame"]["line1"].visible = false
        player.gui.top["info-tab-frame"]["winner-label"].visible = true
        player.gui.top["info-tab-frame"]["next-game-label"].visible = true
    else
        player.gui.top["info-tab-frame"]["info-tab-left-team-player"].visible = true
        player.gui.top["info-tab-frame"]["info-tab-left-team"].visible = true
        player.gui.top["info-tab-frame"]["info-tab-right-team-player"].visible = true
        player.gui.top["info-tab-frame"]["info-tab-right-team"].visible = true
        player.gui.top["info-tab-frame"]["line1"].visible = true
        player.gui.top["info-tab-frame"]["winner-label"].visible = false
        player.gui.top["info-tab-frame"]["next-game-label"].visible = false
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyInfoTab(player)
    if player.gui.top["info-tab-frame"] then
        player.gui.top["info-tab-frame"].destroy()
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createIncomeTabButton(player)
    local button = player.gui.top.add { type = "sprite-button", name = "income-tab-button", sprite = "item/coin" }
    if Player.getTeamOfPlayer(player) == "spec" or not global.isGameRunning or player.gui.top["income-tab"].visible then
        button.visible = false
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateIncomeTabButton(player)
    if Player.getTeamOfPlayer(player) == "spec" or not global.isGameRunning or player.gui.top["income-tab"].visible then
        player.gui.top["income-tab-button"].visible = false
    else
        player.gui.top["income-tab-button"].visible = true
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyIncomeTabButton(player)
    if player.gui.top["income-tab-button"] then
        player.gui.top["income-tab-button"].destroy()
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createIncomeTab(player)
    local totalIncome = "null"
    local ironIncome = "null"
    local ironIncomeValue = 20
    local copperIncome = "null"
    local copperIncomeValue = 20
    local stoneIncome = "null"
    local stoneIncomeValue = 20
    local coalIncome = "null"
    local coalIncomeValue = 20
    local oilIncome = "null"
    local oilIncomeValue = 20

    local frame = player.gui.top.add { type = "frame", name = "income-tab", direction = "vertical" }

    if not (Player.getTeamOfPlayer(player) == "spec") and global.isGameRunning then
        local income = Player.getIncome(player, 1)
        local team = Player.getTeamOfPlayer(player)
        local incomePercentage = global.boxs[team .. "~" .. player.name].incomePercentage

        totalIncome = Utils.ceilNthDecimal(income, 2)

        ironIncome = Utils.ceilNthDecimal((incomePercentage.iron * income), 2)
        ironIncomeValue = Utils.ceilNthDecimal(incomePercentage.iron * 100, 2)

        copperIncome = Utils.ceilNthDecimal((incomePercentage.copper * income), 2)
        copperIncomeValue = Utils.ceilNthDecimal(incomePercentage.copper * 100, 2)

        stoneIncome = Utils.ceilNthDecimal((incomePercentage.stone * income), 2)
        stoneIncomeValue = Utils.ceilNthDecimal(incomePercentage.stone * 100, 2)

        coalIncome = Utils.ceilNthDecimal((incomePercentage.coal * income), 2)
        coalIncomeValue = Utils.ceilNthDecimal(incomePercentage.coal * 100, 2)

        oilIncome = Utils.ceilNthDecimal((incomePercentage.oil * income), 2)
        oilIncomeValue = Utils.ceilNthDecimal(incomePercentage.oil * 100, 2)
    end

    local table = frame.add{type = "table", name = "income-table", column_count = 3}
    table.add{ type = "label", name = "total-income", caption = { "total-income", totalIncome } }
    local infoButton = table.add{ type = "sprite-button", name = "info-income-tab", style = "frame_action_button", sprite = "info_no_border", tooltip = {"info"} }
    infoButton.style.left_margin = 20
    infoButton.style.width = 25
    infoButton.style.height = 25
    local closeButton = table.add{ type = "sprite-button", name = "close-income-tab", style = "frame_action_button", sprite = "utility/close_white", clicked_sprite = "utility/close_black", tooltip = {"close"} }
    closeButton.style.width = 25
    closeButton.style.height = 25
    frame.add{ type = "line", direction = "horizontal" }

    local ironTable = frame.add { type = "table", name = "iron-table", column_count = 2 }
    ironTable.add { type = "sprite", sprite = "item/iron-plate" }
    ironTable.add { type = "label", name = "iron-income1", caption = { "income", "Iron plate", ironIncome, ironIncomeValue } }
    frame.add { type = "slider", name = "iron-income2", minimum_value = 0, maximum_value = 100, value = ironIncomeValue }

    local copperTable = frame.add { type = "table", name = "copper-table", column_count = 2 }
    copperTable.add { type = "sprite", sprite = "item/copper-plate" }
    copperTable.add { type = "label", name = "copper-income1", caption = { "income", "Copper plate", copperIncome,
        copperIncomeValue } }
    frame.add { type = "slider", name = "copper-income2", minimum_value = 0, maximum_value = 100, value =
    copperIncomeValue }

    local stoneTable = frame.add { type = "table", name = "stone-table", column_count = 2 }
    stoneTable.add { type = "sprite", sprite = "item/stone" }
    stoneTable.add { type = "label", name = "stone-income1", caption = { "income", "Stone", stoneIncome, stoneIncomeValue } }
    frame.add { type = "slider", name = "stone-income2", minimum_value = 0, maximum_value = 100, value = stoneIncomeValue }

    local coalTable = frame.add { type = "table", name = "coal-table", column_count = 2 }
    coalTable.add { type = "sprite", sprite = "item/coal" }
    coalTable.add { type = "label", name = "coal-income1", caption = { "income", "Coal", coalIncome, coalIncomeValue } }
    frame.add { type = "slider", name = "coal-income2", minimum_value = 0, maximum_value = 100, value = coalIncomeValue }

    local oilTable = frame.add { type = "table", name = "oil-table", column_count = 2 }
    oilTable.add { type = "sprite", sprite = "fluid/crude-oil" }
    oilTable.add { type = "label", name = "oil-income1", caption = { "income", "Oil", oilIncome, oilIncomeValue } }
    frame.add { type = "slider", name = "oil-income2", minimum_value = 0, maximum_value = 100, value = oilIncomeValue }

    local alert = frame.add{type = "label", name = "losing-r-alert", caption = {"losing-resources-alert"}, visible = false}
    alert.style.font_color = {1, 0, 0, 1}

    frame.add{ type = "line", direction = "horizontal" }

    local spyFlow = frame.add{ type = "flow", direction = "horizontal" }
    spyFlow.add{ type = "sprite-button", name = "spy-button", sprite = "item/raw-fish", tooltip = {"spy-tooltip"} }
    local labelFlow = spyFlow.add{ type = "flow", direction = "vertical" }
    labelFlow.add{ type = "label", caption = {"spy-1"} }
    labelFlow.add{ type = "label", caption = {"spy-2"} }

    frame.visible = false
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateIncomeTab(player)
    local totalIncome = "null"
    local ironIncome = "null"
    local ironIncomeValue = 20
    local copperIncome = "null"
    local copperIncomeValue = 20
    local stoneIncome = "null"
    local stoneIncomeValue = 20
    local coalIncome = "null"
    local coalIncomeValue = 20
    local oilIncome = "null"
    local oilIncomeValue = 20

    if not (Player.getTeamOfPlayer(player) == "spec") and global.isGameRunning then
        local income = Player.getIncome(player, 1)
        local team = Player.getTeamOfPlayer(player)
        local incomePercentage = global.boxs[team .. "~" .. player.name].incomePercentage

        totalIncome = Utils.ceilNthDecimal(income, 2)

        ironIncome = Utils.ceilNthDecimal((incomePercentage.iron * income), 2)
        ironIncomeValue = Utils.ceilNthDecimal(incomePercentage.iron * 100, 2)

        copperIncome = Utils.ceilNthDecimal((incomePercentage.copper * income), 2)
        copperIncomeValue = Utils.ceilNthDecimal(incomePercentage.copper * 100, 2)

        stoneIncome = Utils.ceilNthDecimal((incomePercentage.stone * income), 2)
        stoneIncomeValue = Utils.ceilNthDecimal(incomePercentage.stone * 100, 2)

        coalIncome = Utils.ceilNthDecimal((incomePercentage.coal * income), 2)
        coalIncomeValue = Utils.ceilNthDecimal(incomePercentage.coal * 100, 2)

        oilIncome = Utils.ceilNthDecimal((incomePercentage.oil * income * Config.income.oilIncomeMult), 2)
        oilIncomeValue = Utils.ceilNthDecimal(incomePercentage.oil * 100, 2)
    end

    player.gui.top["income-tab"]["income-table"]["total-income"].caption = { "total-income", totalIncome }

    player.gui.top["income-tab"]["iron-table"]["iron-income1"].caption = { "income", "Iron plate", ironIncome, ironIncomeValue }

    player.gui.top["income-tab"]["copper-table"]["copper-income1"].caption = { "income", "Copper plate", copperIncome, copperIncomeValue }

    player.gui.top["income-tab"]["stone-table"]["stone-income1"].caption = { "income", "Stone", stoneIncome, stoneIncomeValue }

    player.gui.top["income-tab"]["coal-table"]["coal-income1"].caption = { "income", "Coal", coalIncome, coalIncomeValue }

    player.gui.top["income-tab"]["oil-table"]["oil-income1"].caption = { "income", "Oil", oilIncome, oilIncomeValue }
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyIncomeTab(player)
    if player.gui.top["income-tab"] then
        player.gui.top["income-tab"].destroy()
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createAdminTabButton(player)
    local button = player.gui.top.add{ type = "sprite-button", name = "admin-tab-button", sprite = "item/iron-gear-wheel" }
    if not player.admin or player.gui.center["admin-tab"].visible then
        button.visible = false
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateAdminTabButton(player)
    if not player.admin or player.gui.center["admin-tab"].visible then
        player.gui.top["admin-tab-button"].visible = false
    else
        player.gui.top["admin-tab-button"].visible = true
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyAdminTabButton(player)
    if player.gui.top["admin-tab-button"] then
        player.gui.top["admin-tab-button"].destroy()
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createAdminTab(player)
    local frame = player.gui.center.add{ type = "frame", name = "admin-tab", direction = "vertical" }

    local titleFlow = frame.add{ type = "flow", name = "title-flow" }
    titleFlow.add{ type = "label", caption = {"admin-frame-title"}, style = "frame_title" }
    local dragger = titleFlow.add{ type = "empty-widget", style = "draggable_space_header" }
    dragger.style.horizontally_stretchable = true
    dragger.style.vertically_stretchable = true
    titleFlow.add{ type = "sprite-button", name = "info-admin-tab", style = "frame_action_button", sprite = "info_no_border", tooltip = {"info"} }
    titleFlow.add{ type = "sprite-button", name = "close-admin-tab", style = "frame_action_button", sprite = "utility/close_white", clicked_sprite = "utility/close_black", tooltip = {"close"} }

    local frame_ = frame.add{ type = "frame", name = "admin-tab_", style = "inside_deep_frame_for_tabs" }

    local tabbedPane = frame_.add{ type = "tabbed-pane", name = "admin-tabbed-pane" }

    local teamManager = tabbedPane.add{ type = "tab", caption = {"team-manager"} }
    local teamManagerFlow = tabbedPane.add{ type = "flow", name = "team-manager-flow", direction = "vertical" }
    tabbedPane.add_tab(teamManager, teamManagerFlow)

    local teamFlow = teamManagerFlow.add{ type = "flow", name = "team-flow", direction = "horizontal" }

    local blueTeamFlow = teamFlow.add{ type = "flow", name = "blue-team-flow", direction = "vertical" }
    local blueTeamTitleFrame = blueTeamFlow.add{ type = "frame", style = "inside_deep_frame_for_tabs" }
    blueTeamTitleFrame.style.top_padding = 0
    blueTeamTitleFrame.style.horizontal_align = "center"
    local blueTeamTitle = blueTeamTitleFrame.add{ type = "sprite-button", caption = {"left-team"} }
    blueTeamTitle.style.width = 160
    blueTeamTitle.style.height = 38
    blueTeamTitle.style.font = "heading-1"
    blueTeamTitle.style.font_color = {r = 0, g = 0, b = 1}
    local blueBox = blueTeamFlow.add{ type = "list-box", name = "blue-player-list", items = global.bluePlayers }
    blueBox.style.width = 160
    blueBox.style.height = 360

    local line1 = teamFlow.add{ type = "line", direction = "vertical" }
    line1.style.left_margin = 8
    line1.style.right_margin = 8

    local specTeamFlow = teamFlow.add{ type = "flow", name = "spec-team-flow", direction = "vertical" }
    local specTeamTitleFrame = specTeamFlow.add{ type = "frame", style = "inside_deep_frame_for_tabs" }
    specTeamTitleFrame.style.top_padding = 0
    specTeamTitleFrame.style.horizontal_align = "center"
    local specTeamTitle = specTeamTitleFrame.add{ type = "sprite-button", caption = {"spec"} }
    specTeamTitle.style.width = 160
    specTeamTitle.style.height = 38
    specTeamTitle.style.font = "heading-1"
    specTeamTitle.style.font_color = {r = 0.55, g = 0.55, b = 0.55}
    local specBox = specTeamFlow.add{ type = "list-box", name = "spec-player-list", items = global.specPlayers }
    specBox.style.width = 160
    specBox.style.height = 360

    local line2 = teamFlow.add{ type = "line", direction = "vertical" }
    line2.style.left_margin = 8
    line2.style.right_margin = 8

    local redTeamFlow = teamFlow.add{ type = "flow", name = "red-team-flow", direction = "vertical" }
    local redTeamTitleFrame = redTeamFlow.add{ type = "frame", style = "inside_deep_frame_for_tabs" }
    redTeamTitleFrame.style.top_padding = 0
    redTeamTitleFrame.style.horizontal_align = "center"
    local redTeamTitle = redTeamTitleFrame.add{ type = "sprite-button", caption = {"right-team"} }
    redTeamTitle.style.width = 160
    redTeamTitle.style.height = 38
    redTeamTitle.style.font = "heading-1"
    redTeamTitle.style.font_color = {r = 1, g = 0, b = 0}
    local redBox = redTeamFlow.add{ type = "list-box", name = "red-player-list", items = global.redPlayers }
    redBox.style.width = 160
    redBox.style.height = 360

    local config = tabbedPane.add{ type = "tab", caption = {"config"} }
    local configManagerFlow = tabbedPane.add{ type = "flow", direction = "vertical" }
    tabbedPane.add_tab(config, configManagerFlow)



    frame.visible = false
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateAdminTab(player)
    if not player.gui.center["admin-tab"] then
        return
    end

    player.gui.center["admin-tab"]["admin-tab_"]["admin-tabbed-pane"]["team-manager-flow"]["team-flow"]["blue-team-flow"]["blue-player-list"].items = global.bluePlayers
    player.gui.center["admin-tab"]["admin-tab_"]["admin-tabbed-pane"]["team-manager-flow"]["team-flow"]["spec-team-flow"]["spec-player-list"].items = global.specPlayers
    player.gui.center["admin-tab"]["admin-tab_"]["admin-tabbed-pane"]["team-manager-flow"]["team-flow"]["red-team-flow"]["red-player-list"].items = global.redPlayers
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyAdminTab(player)
    if player.gui.center["admin-tab"] then
        player.gui.center["admin-tab"].destroy()
    end
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.createChangePlayerTeam(player)
    local frame = player.gui.screen.add{ type = "frame", name = "change-player-team-frame", direction = "vertical" }
    frame.visible = false
    frame.auto_center = true

    local titleFlow = frame.add{ type = "flow" }
    titleFlow.add{ type = "label", caption = {"change-player-team-frame-title"}, style = "frame_title" }
    local dragger = titleFlow.add{ type = "empty-widget", style = "draggable_space_header" }
    dragger.style.horizontally_stretchable = true
    dragger.style.height = 28
    titleFlow.add{ type = "sprite-button", name = "close-change-player-team", style = "frame_action_button", sprite = "utility/close_white", clicked_sprite = "utility/close_black", tooltip = {"close"} }

    frame.add{ type = "label", name = "text_", caption = { "change-player-team-label", "nil", "nil" } }

    local buttonFlow = frame.add{ type = "flow", name = "button-flow" }

    local moveBlueButton = buttonFlow.add { type = "sprite-button", name = "move-blue-team", caption = { "move", { "left-team" } } }
    moveBlueButton.style.font = "default-bold"
    moveBlueButton.style.font_color = { r = 0, g = 0, b = 1 }
    moveBlueButton.style.width = 150
    moveBlueButton.style.height = 35

    local moveSpecButton = buttonFlow.add { type = "sprite-button", name = "move-spec", caption = { "move", { "spec" } } }
    moveSpecButton.style.font = "default-bold"
    moveSpecButton.style.font_color = {r = 0.55, g = 0.55, b = 0.55}
    moveSpecButton.style.width = 150
    moveSpecButton.style.height = 35

    local moveRedButton = buttonFlow.add { type = "sprite-button", name = "move-red-team", caption = { "move", { "right-team" } } }
    moveRedButton.style.font = "default-bold"
    moveRedButton.style.font_color = { r = 1, g = 0, b = 0 }
    moveRedButton.style.width = 150
    moveRedButton.style.height = 35
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.updateChangePlayerTeam(player, team, selectedPlayerName)
    if not player.gui.screen["change-player-team-frame"] then
        return
    end

    local team_ = "spec"
    if team == "blue" then
        team_ = "left-team"
    elseif team == "red" then
        team_ = "right-team"
    end

    player.gui.screen["change-player-team-frame"]["text_"].caption = { "change-player-team-label", selectedPlayerName, { team_ } }

    if team == "blue" then
        player.gui.screen["change-player-team-frame"]["button-flow"]["move-blue-team"].visible = false
    else
        player.gui.screen["change-player-team-frame"]["button-flow"]["move-blue-team"].visible = true
    end

    if team == "spec" then
        player.gui.screen["change-player-team-frame"]["button-flow"]["move-spec"].visible = false
    else
        player.gui.screen["change-player-team-frame"]["button-flow"]["move-spec"].visible = true
    end

    if team == "red" then
        player.gui.screen["change-player-team-frame"]["button-flow"]["move-red-team"].visible = false
    else
        player.gui.screen["change-player-team-frame"]["button-flow"]["move-red-team"].visible = true
    end

    player.gui.screen["change-player-team-frame"].force_auto_center()
end

---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
function Gui.destroyChangePlayerTeam(player)
    if player.gui.screen["change-player-team-frame"] then
        player.gui.screen["change-player-team-frame"].destroy()
    end
end

---changes given player's income repartition
---@param player LuaPlayer @https://lua-api.factorio.com/latest/classes/LuaPlayer.html
---@param resource "iron"|"copper"|"coal"|"stone"|"oil"
---@param newValue number
function Gui.changeIncomePercentage(player, resource, newValue)
    local team = Player.getTeamOfPlayer(player)

    local ironIncomeValue = 20
    local copperIncomeValue = 20
    local stoneIncomeValue = 20
    local coalIncomeValue = 20
    local oilIncomeValue = 20

    if not (Player.getTeamOfPlayer(player) == "spec") and global.isGameRunning then
        local incomePercentage = global.boxs[team .. "~" .. player.name].incomePercentage

        local dif = newValue / 100 - incomePercentage[resource]

        if resource == "iron" then
            local rep = Gui.rep(dif, incomePercentage["copper"], incomePercentage["stone"], incomePercentage["coal"], incomePercentage["oil"])

            global.boxs[team .. "~" .. player.name].incomePercentage["copper"] = rep[1]
            global.boxs[team .. "~" .. player.name].incomePercentage["stone"] = rep[2]
            global.boxs[team .. "~" .. player.name].incomePercentage["coal"] = rep[3]
            global.boxs[team .. "~" .. player.name].incomePercentage["oil"] = rep[4]
        end

        if resource == "copper" then
            local rep = Gui.rep(dif, incomePercentage["iron"], incomePercentage["stone"], incomePercentage["coal"], incomePercentage["oil"])

            global.boxs[team .. "~" .. player.name].incomePercentage["iron"] = rep[1]
            global.boxs[team .. "~" .. player.name].incomePercentage["stone"] = rep[2]
            global.boxs[team .. "~" .. player.name].incomePercentage["coal"] = rep[3]
            global.boxs[team .. "~" .. player.name].incomePercentage["oil"] = rep[4]
        end

        if resource == "stone" then
            local rep = Gui.rep(dif, incomePercentage["iron"], incomePercentage["copper"], incomePercentage["coal"], incomePercentage["oil"])

            global.boxs[team .. "~" .. player.name].incomePercentage["iron"] = rep[1]
            global.boxs[team .. "~" .. player.name].incomePercentage["copper"] = rep[2]
            global.boxs[team .. "~" .. player.name].incomePercentage["coal"] = rep[3]
            global.boxs[team .. "~" .. player.name].incomePercentage["oil"] = rep[4]
        end

        if resource == "coal" then
            local rep = Gui.rep(dif, incomePercentage["iron"], incomePercentage["copper"], incomePercentage["stone"], incomePercentage["oil"])

            global.boxs[team .. "~" .. player.name].incomePercentage["iron"] = rep[1]
            global.boxs[team .. "~" .. player.name].incomePercentage["copper"] = rep[2]
            global.boxs[team .. "~" .. player.name].incomePercentage["stone"] = rep[3]
            global.boxs[team .. "~" .. player.name].incomePercentage["oil"] = rep[4]
        end

        if resource == "oil" then
            local rep = Gui.rep(dif, incomePercentage["iron"], incomePercentage["copper"], incomePercentage["stone"], incomePercentage["coal"])

            global.boxs[team .. "~" .. player.name].incomePercentage["iron"] = rep[1]
            global.boxs[team .. "~" .. player.name].incomePercentage["copper"] = rep[2]
            global.boxs[team .. "~" .. player.name].incomePercentage["stone"] = rep[3]
            global.boxs[team .. "~" .. player.name].incomePercentage["coal"] = rep[4]
        end

        global.boxs[team .. "~" .. player.name].incomePercentage[resource] = newValue / 100

        ironIncomeValue = incomePercentage.iron * 100

        copperIncomeValue = incomePercentage.copper * 100

        stoneIncomeValue = incomePercentage.stone * 100

        coalIncomeValue = incomePercentage.coal * 100

        oilIncomeValue = incomePercentage.oil * 100
    end

    if not (resource == "iron") then
        player.gui.top["income-tab"]["iron-income2"].slider_value = Utils.ceilNthDecimal(ironIncomeValue, 2)
    end

    if not (resource == "copper") then
        player.gui.top["income-tab"]["copper-income2"].slider_value = Utils.ceilNthDecimal(copperIncomeValue, 2)
    end

    if not (resource == "stone") then
        player.gui.top["income-tab"]["stone-income2"].slider_value = Utils.ceilNthDecimal(stoneIncomeValue, 2)
    end

    if not (resource == "coal") then
        player.gui.top["income-tab"]["coal-income2"].slider_value = Utils.ceilNthDecimal(coalIncomeValue, 2)
    end

    if not (resource == "oil") then
        player.gui.top["income-tab"]["oil-income2"].slider_value = Utils.ceilNthDecimal(oilIncomeValue, 2)
    end

    local incomePercentage = global.boxs[team .. "~" .. player.name].incomePercentage
    local total = incomePercentage["iron"] + incomePercentage["copper"] + incomePercentage["stone"] +
    incomePercentage["coal"] + incomePercentage["oil"]
    if total < 1 - 10^(-5) then
        player.gui.top["income-tab"]["losing-r-alert"].visible = true
    else
        player.gui.top["income-tab"]["losing-r-alert"].visible = false
    end
end

function Gui.rep(a, firstR, secondR, thirdR, fourthR)
    local tot = firstR + secondR + thirdR + fourthR
    if tot == 0 then
        return { -a / 4, -a / 4, -a / 4, -a / 4 }
    end
    local quot1 = firstR / tot
    local quot2 = secondR / tot
    local quot3 = thirdR / tot
    local quot4 = fourthR / tot

    firstR = firstR - a * quot1
    secondR = secondR - a * quot2
    thirdR = thirdR - a * quot3
    fourthR = fourthR - a * quot4

    return {firstR, secondR, thirdR, fourthR}
end

---called when on_gui_click event
---@param event table @https://lua-api.factorio.com/latest/events.html#on_gui_click
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
        if not player.admin then
            player.print({"must-be-admin"})
            return
        end
        Game.start()
    end

    if elementName == "income-tab-button" then
        player.gui.top["income-tab"].visible = true
    end

    if elementName == "close-income-tab" then
        player.gui.top["income-tab"].visible = false
    end

    if elementName == "admin-tab-button" then
        if not player.admin then
            player.print({"must-be-admin"})
            return
        end
        player.gui.center["admin-tab"].visible = true
    end

    if elementName == "close-admin-tab" then
        player.gui.center["admin-tab"].visible = false
    end

    if elementName == "close-change-player-team" then
        player.gui.screen["change-player-team-frame"].visible = false
    end

    if elementName == "move-blue-team" then
        local playerName = player.gui.screen["change-player-team-frame"]["text_"].caption[2]
        Teams.changeTeam(game.players[playerName], "blue")
        player.gui.screen["change-player-team-frame"].visible = false
    end

    if elementName == "move-spec" then
        local playerName = player.gui.screen["change-player-team-frame"]["text_"].caption[2]
        Teams.changeTeam(game.players[playerName], "spec")
        player.gui.screen["change-player-team-frame"].visible = false
    end

    if elementName == "move-red-team" then
        local playerName = player.gui.screen["change-player-team-frame"]["text_"].caption[2]
        Teams.changeTeam(game.players[playerName], "red")
        player.gui.screen["change-player-team-frame"].visible = false
    end

    if elementName == "spy-button" then
        if not event.button == defines.mouse_button_type.left then
            return
        end

        local playerInventory = player.get_main_inventory()
        local playerFishAmount = playerInventory.get_item_count("raw-fish")
        local fishAmount = 1

        if event.shift then
            fishAmount = 10
        elseif event.control then
            fishAmount = playerFishAmount
        end

        if fishAmount > playerFishAmount then
            player.print({"not-enough-fish", playerFishAmount, fishAmount})
            return
        end

        if fishAmount == 0 then
            player.print({"no-fish"})
            return
        end

        playerInventory.remove({name = "raw-fish", count = fishAmount})
        local playerTeam = Player.getTeamOfPlayer(player)
        local t
        if playerTeam == "blue" then
            if global.blueSpyingEnd < game.tick then
                global.blueSpyingEnd = game.tick + 3600 * fishAmount
            else
                global.blueSpyingEnd = global.blueSpyingEnd + 3600 * fishAmount
            end
            t = global.blueSpyingEnd
        elseif playerTeam == "red" then
            if global.redSpyingEnd < game.tick then
                global.redSpyingEnd = game.tick + 3600 * fishAmount
            else
                global.redSpyingEnd = global.redSpyingEnd + 3600 * fishAmount
            end
            t = global.redSpyingEnd
        end

        if t then
            game.print({"spy-time-left-message", player.name, fishAmount, playerTeam, math.floor((t - game.tick) / 3600), math.floor(((t - game.tick) / 60) % 60)})
        end
    end

    Gui.updateGui(player)
end

---called when on_gui_value_changed event
---@param event table https://lua-api.factorio.com/latest/events.html#on_gui_value_changed
function Gui.onValueChanged(event)
    local element = event.element
    local elementName = element.name
    local player = game.players[event.player_index]

    if elementName == "iron-income2" then
        Gui.changeIncomePercentage(player, "iron", element.slider_value)
    end

    if elementName == "copper-income2" then
        Gui.changeIncomePercentage(player, "copper", element.slider_value)
    end

    if elementName == "stone-income2" then
        Gui.changeIncomePercentage(player, "stone", element.slider_value)
    end

    if elementName == "coal-income2" then
        Gui.changeIncomePercentage(player, "coal", element.slider_value)
    end

    if elementName == "oil-income2" then
        Gui.changeIncomePercentage(player, "oil", element.slider_value)
    end

    Gui.updateGui(player)
end

---called when on_gui_selection_state_changed event
---@param event table https://lua-api.factorio.com/latest/events.html#on_gui_selection_state_changed
function Gui.onSelectionStateChanged(event)
    local element = event.element
    local elementName = element.name
    local player = game.players[event.player_index]

    if elementName == "blue-player-list" then
        Gui.updateChangePlayerTeam(player, "blue", element.items[element.selected_index])
        player.gui.screen["change-player-team-frame"].visible = true
        element.selected_index = 0
    end

    if elementName == "spec-player-list" then
        Gui.updateChangePlayerTeam(player, "spec", element.items[element.selected_index])
        player.gui.screen["change-player-team-frame"].visible = true
        element.selected_index = 0
    end

    if elementName == "red-player-list" then
        Gui.updateChangePlayerTeam(player, "red", element.items[element.selected_index])
        player.gui.screen["change-player-team-frame"].visible = true
        element.selected_index = 0
    end
end

return Gui