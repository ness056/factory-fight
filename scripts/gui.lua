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
    local leftTeamPlayer_ = frame.add { type = "label", name = "info-tab-left-team-player", caption = { "info-player-list", #global.bluePlayers,
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
    local rightTeamPlayer_ = frame.add { type = "label", name = "info-tab-right-team-player", caption = { "info-player-list", #global.redPlayers,
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
    player.gui.top["info-tab-frame"]["info-tab-left-team-player"].caption = { "info-player-list", #global.bluePlayers,
        leftTeamPlayer }

    if team == "blue" or (not global.isGameRunning and global.winner ~= "") then
        player.gui.top["info-tab-frame"]["join-blue-team"].visible = false
    else
        player.gui.top["info-tab-frame"]["join-blue-team"].visible = true
    end

    local rightTeamPlayer = table.concat(global.redPlayers, ", ")
    player.gui.top["info-tab-frame"]["info-tab-right-team-player"].caption = { "info-player-list", #global.redPlayers,
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

    local incomeFlow = frame.add{type = "flow", name = "income-flow", column_count = 3}
    incomeFlow.add{ type = "label", name = "total-income", caption = { "total-income", totalIncome } }
    local infoButton = incomeFlow.add{ type = "sprite-button", name = "info-income-tab", style = "frame_action_button", sprite = "info_no_border", tooltip = {"info"} }
    infoButton.style.left_margin = 20
    infoButton.style.width = 25
    infoButton.style.height = 25
    local closeButton = incomeFlow.add{ type = "sprite-button", name = "close-income-tab", style = "frame_action_button", sprite = "utility/close_white", clicked_sprite = "utility/close_black", tooltip = {"close"} }
    closeButton.style.width = 25
    closeButton.style.height = 25
    frame.add{ type = "line", direction = "horizontal" }

    local ironFlow1 = frame.add { type = "flow", name = "iron-flow1", direction = "horizontal" }
    ironFlow1.style.vertical_align = "center"
    ironFlow1.add { type = "sprite", sprite = "item/iron-plate" }
    ironFlow1.add { type = "label", name = "iron-label", caption = { "income", "Iron plate", ironIncome, ironIncomeValue } }
    local ironFlow2 = frame.add { type = "flow", name = "iron-flow2", direction = "horizontal" }
    ironFlow2.style.vertical_align = "center"
    ironFlow2.add { type = "slider", name = "iron-slider", minimum_value = 0, maximum_value = 100, value = ironIncomeValue }
    local ironTextfield = ironFlow2.add { type = "textfield", name = "iron-income-textfield", numeric = true }
    ironTextfield.style.height = 18
    ironTextfield.style.width = 36
    ironFlow2.add { type = "label", caption = "%" }

    local copperFlow1 = frame.add { type = "flow", name = "copper-flow1", direction = "horizontal" }
    copperFlow1.style.vertical_align = "center"
    copperFlow1.add { type = "sprite", sprite = "item/copper-plate" }
    copperFlow1.add { type = "label", name = "copper-label", caption = { "income", "Copper plate", copperIncome, copperIncomeValue } }
    local copperFlow2 = frame.add { type = "flow", name = "copper-flow2", direction = "horizontal" }
    copperFlow2.style.vertical_align = "center"
    copperFlow2.add { type = "slider", name = "copper-slider", minimum_value = 0, maximum_value = 100, value = copperIncomeValue }
    local copperTextfield = copperFlow2.add { type = "textfield", name = "copper-income-textfield", numeric = true }
    copperTextfield.style.height = 18
    copperTextfield.style.width = 36
    copperFlow2.add { type = "label", caption = "%" }

    local stoneFlow1 = frame.add { type = "flow", name = "stone-flow1", direction = "horizontal" }
    stoneFlow1.style.vertical_align = "center"
    stoneFlow1.add { type = "sprite", sprite = "item/stone" }
    stoneFlow1.add { type = "label", name = "stone-label", caption = { "income", "Stone", stoneIncome, stoneIncomeValue } }
    local stoneFlow2 = frame.add { type = "flow", name = "stone-flow2", direction = "horizontal" }
    stoneFlow2.style.vertical_align = "center"
    stoneFlow2.add { type = "slider", name = "stone-slider", minimum_value = 0, maximum_value = 100, value = stoneIncomeValue }
    local stoneTextfield = stoneFlow2.add { type = "textfield", name = "stone-income-textfield", numeric = true }
    stoneTextfield.style.height = 18
    stoneTextfield.style.width = 36
    stoneFlow2.add { type = "label", caption = "%" }

    local coalFlow1 = frame.add { type = "flow", name = "coal-flow1", direction = "horizontal" }
    coalFlow1.style.vertical_align = "center"
    coalFlow1.add { type = "sprite", sprite = "item/coal" }
    coalFlow1.add { type = "label", name = "coal-label", caption = { "income", "Coal", coalIncome, coalIncomeValue } }
    local coalFlow2 = frame.add { type = "flow", name = "coal-flow2", direction = "horizontal" }
    coalFlow2.style.vertical_align = "center"
    coalFlow2.add { type = "slider", name = "coal-slider", minimum_value = 0, maximum_value = 100, value = coalIncomeValue }
    local coalTextfield = coalFlow2.add { type = "textfield", name = "coal-income-textfield", numeric = true }
    coalTextfield.style.height = 18
    coalTextfield.style.width = 36
    coalFlow2.add { type = "label", caption = "%" }

    local oilFlow1 = frame.add { type = "flow", name = "oil-flow1", direction = "horizontal" }
    oilFlow1.style.vertical_align = "center"
    oilFlow1.add { type = "sprite", sprite = "fluid/crude-oil" }
    oilFlow1.add { type = "label", name = "oil-label", caption = { "income", "Crude oil", oilIncome, oilIncomeValue } }
    local oilFlow2 = frame.add { type = "flow", name = "oil-flow2", direction = "horizontal" }
    oilFlow2.style.vertical_align = "center"
    oilFlow2.add { type = "slider", name = "oil-slider", minimum_value = 0, maximum_value = 100, value = oilIncomeValue }
    local oilTextfield = oilFlow2.add { type = "textfield", name = "oil-income-textfield", numeric = true }
    oilTextfield.style.height = 18
    oilTextfield.style.width = 36
    oilFlow2.add { type = "label", caption = "%" }

    local confirmButton = frame.add { type = "sprite-button", name = "custom-rep-confirm-button", sprite = "virtual-signal/signal-check" }
    confirmButton.style.size = 24
    confirmButton.style.left_margin = 170

    local alert = frame.add{type = "label", name = "losing-r-alert", caption = {"losing-resources-alert"}, visible = false}
    alert.style.font_color = {1, 0, 0, 1}

    frame.add{ type = "line", direction = "horizontal" }

    local spyFlow = frame.add{ type = "flow", direction = "horizontal" }
    spyFlow.add{ type = "sprite-button", name = "spy-button", sprite = "item/radar", tooltip = {"spy-tooltip"} }
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

    player.gui.top["income-tab"]["income-flow"]["total-income"].caption = { "total-income", totalIncome }

    player.gui.top["income-tab"]["iron-flow1"]["iron-label"].caption = { "income", "Iron plate", ironIncome, ironIncomeValue }

    player.gui.top["income-tab"]["copper-flow1"]["copper-label"].caption = { "income", "Copper plate", copperIncome, copperIncomeValue }

    player.gui.top["income-tab"]["stone-flow1"]["stone-label"].caption = { "income", "Stone", stoneIncome, stoneIncomeValue }

    player.gui.top["income-tab"]["coal-flow1"]["coal-label"].caption = { "income", "Coal", coalIncome, coalIncomeValue }

    player.gui.top["income-tab"]["oil-flow1"]["oil-label"].caption = { "income", "Oil", oilIncome, oilIncomeValue }
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
    local configManagerFlow = tabbedPane.add{ type = "flow", direction = "horizontal" }
    tabbedPane.add_tab(config, configManagerFlow)

    local leftTable = configManagerFlow.add{ type = "table", style = "bordered_table", column_count = 1 }
    leftTable.style.width = 266
    local rightTable = configManagerFlow.add{ type = "table", style = "bordered_table", column_count = 1 }
    rightTable.style.width = 266

    local gameSettings = leftTable.add{ type = "flow", direction = "vertical" }

    gameSettings.add{ type = "label", caption = {"game"}, style = "caption_label" }

    gameSettings.add{ type = "checkbox", state = false, caption = {"auto-game-restart"} }

    local bitersSettings = rightTable.add{ type = "flow", direction = "vertical" }

    bitersSettings.add{ type = "label", caption = {"biters"}, style = "caption_label" }

    local playerList = tabbedPane.add{ type = "tab", caption = {"config-player-list"} }
    local playerListFlow = tabbedPane.add{ type = "flow", direction = "vertical" }
    tabbedPane.add_tab(playerList, playerListFlow)



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
---@param resourcesNewValues table[key iron|copper|stone|coal|oil, value number]
---@param isSliderUsed boolean
function Gui.changeIncomePercentage(player, resourcesNewValues, isSliderUsed)
    local team = Player.getTeamOfPlayer(player)

    if team == "spec" or global.isGameRunning == false then
        return
    end

    local total = 0
    local resourcesNewValuesLenght = 0
    for k, v in pairs(resourcesNewValues) do
        resourcesNewValuesLenght = resourcesNewValuesLenght + 1
    end

    if resourcesNewValuesLenght == 5 then
        for k, v in pairs(resourcesNewValues) do
            total = total + v
        end

        for k, v in pairs(resourcesNewValues) do
            resourcesNewValues[k] = v + (100 - total) * (v / total)
        end
    end

    local ironIncomeValue = 20
    local copperIncomeValue = 20
    local stoneIncomeValue = 20
    local coalIncomeValue = 20
    local oilIncomeValue = 20

    local iron_ = Utils.isKeyDefined(resourcesNewValues, "iron")
    local copper_ = Utils.isKeyDefined(resourcesNewValues, "copper")
    local stone_ = Utils.isKeyDefined(resourcesNewValues, "stone")
    local coal_ = Utils.isKeyDefined(resourcesNewValues, "coal")
    local oil_ = Utils.isKeyDefined(resourcesNewValues, "oil")

    local incomePercentage = global.boxs[team .. "~" .. player.name].incomePercentage

    local dif = 0
    for k, v in pairs(resourcesNewValues) do
        dif = dif + v / 100 - incomePercentage[k]
        incomePercentage[k] = v / 100
    end

    local r = {}

    if iron_ == false then
        r[#r+1] = incomePercentage["iron"]
    end

    if copper_ == false then
        r[#r+1] = incomePercentage["copper"]
    end

    if stone_ == false then
        r[#r+1] = incomePercentage["stone"]
    end

    if coal_ == false then
        r[#r+1] = incomePercentage["coal"]
    end

    if oil_ == false then
        r[#r+1] = incomePercentage["oil"]
    end

    local distribution = Gui.distribution(dif, r)
    local i = 1

    if iron_ == false then
        incomePercentage["iron"] = distribution[i]
        i = i + 1
    end

    if copper_ == false then
        incomePercentage["copper"] = distribution[i]
        i = i + 1
    end

    if stone_ == false then
        incomePercentage["stone"] = distribution[i]
        i = i + 1
    end

    if coal_ == false then
        incomePercentage["coal"] = distribution[i]
        i = i + 1
    end

    if oil_ == false then
        incomePercentage["oil"] = distribution[i]
        i = i + 1
    end

    ironIncomeValue = incomePercentage.iron * 100
    copperIncomeValue = incomePercentage.copper * 100
    stoneIncomeValue = incomePercentage.stone * 100
    coalIncomeValue = incomePercentage.coal * 100
    oilIncomeValue = incomePercentage.oil * 100

    if iron_ == false or isSliderUsed == false then
        player.gui.top["income-tab"]["iron-flow2"]["iron-slider"].slider_value = Utils.ceilNthDecimal(ironIncomeValue, 2)
    end

    if copper_ == false or isSliderUsed == false then
        player.gui.top["income-tab"]["copper-flow2"]["copper-slider"].slider_value = Utils.ceilNthDecimal(copperIncomeValue, 2)
    end

    if stone_ == false or isSliderUsed == false then
        player.gui.top["income-tab"]["stone-flow2"]["stone-slider"].slider_value = Utils.ceilNthDecimal(stoneIncomeValue, 2)
    end

    if coal_ == false or isSliderUsed == false then
        player.gui.top["income-tab"]["coal-flow2"]["coal-slider"].slider_value = Utils.ceilNthDecimal(coalIncomeValue, 2)
    end

    if oil_ == false or isSliderUsed == false then
        player.gui.top["income-tab"]["oil-flow2"]["oil-slider"].slider_value = Utils.ceilNthDecimal(oilIncomeValue, 2)
    end
end

---distributes the change value to all inputs
---@param change number
---@param inputs table[number]
---@return table[number]
function Gui.distribution(change, inputs)
    local output = {}
    local total = 0
    for k, input in pairs(inputs) do
        total = total + input
    end

    if total == 0 then
        for k, input in pairs(inputs) do
            output[#output+1] = -change / #inputs
        end
        return output
    end

    for k, input in pairs(inputs) do
        output[#output+1] = input - change * (input / total)
    end

    return output
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
        local playerRadarAmount = playerInventory.get_item_count("radar")
        local radarAmount = 1

        if event.shift then
            radarAmount = 10
        elseif event.control then
            radarAmount = playerRadarAmount
        end

        if playerRadarAmount == 0 then
            player.print({"no-radar"})
            return
        end

        if radarAmount > playerRadarAmount then
            player.print({"not-enough-radar", playerRadarAmount, radarAmount})
            return
        end

        playerInventory.remove({name = "radar", count = radarAmount})
        local playerTeam = Player.getTeamOfPlayer(player)
        local t
        if playerTeam == "blue" then
            if global.blueSpyingEnd < game.tick then
                global.blueSpyingEnd = game.tick + 3600 * radarAmount
            else
                global.blueSpyingEnd = global.blueSpyingEnd + 3600 * radarAmount
            end
            t = global.blueSpyingEnd
        elseif playerTeam == "red" then
            if global.redSpyingEnd < game.tick then
                global.redSpyingEnd = game.tick + 3600 * radarAmount
            else
                global.redSpyingEnd = global.redSpyingEnd + 3600 * radarAmount
            end
            t = global.redSpyingEnd
        end

        if t then
            player.force.print({"spy-time-left-message", player.name, radarAmount, playerTeam, math.floor((t - game.tick) / 3600), math.floor(((t - game.tick) / 60) % 60)})
        end
    end

    if elementName == "custom-rep-confirm-button" then
        local r = {}
        r["iron"] = tonumber(player.gui.top["income-tab"]["iron-flow2"]["iron-income-textfield"].text)
        r["copper"] = tonumber(player.gui.top["income-tab"]["copper-flow2"]["copper-income-textfield"].text)
        r["stone"] = tonumber(player.gui.top["income-tab"]["stone-flow2"]["stone-income-textfield"].text)
        r["coal"] = tonumber(player.gui.top["income-tab"]["coal-flow2"]["coal-income-textfield"].text)
        r["oil"] = tonumber(player.gui.top["income-tab"]["oil-flow2"]["oil-income-textfield"].text)
        local total = 0

        for k, v in pairs(r) do
            total = total + v
        end

        if total > 100 then
            player.print({"~sum-above-100"})
        end

        Gui.changeIncomePercentage(player, r, false)
    end

    Gui.updateGui(player)
end

---called when on_gui_value_changed event
---@param event table https://lua-api.factorio.com/latest/events.html#on_gui_value_changed
function Gui.onValueChanged(event)
    local element = event.element
    local elementName = element.name
    local player = game.players[event.player_index]

    if elementName == "iron-slider" then
        local r = {}; r["iron"] = element.slider_value
        Gui.changeIncomePercentage(player, r, true)
    end

    if elementName == "copper-slider" then
        local r = {}; r["copper"] = element.slider_value
        Gui.changeIncomePercentage(player, r, true)
    end

    if elementName == "stone-slider" then
        local r = {}; r["stone"] = element.slider_value
        Gui.changeIncomePercentage(player, r, true)
    end

    if elementName == "coal-slider" then
        local r = {}; r["coal"] = element.slider_value
        Gui.changeIncomePercentage(player, r, true)
    end

    if elementName == "oil-slider" then
        local r = {}; r["oil"] = element.slider_value
        Gui.changeIncomePercentage(player, r, true)
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