local UIPanelConfig = {}

---初始化
function UIPanelConfig:Initialize()
    UIPanelConfig.RegisterAllInterceptUIPanels()
    UIPanelConfig.RegisterAllUIPanels()
    UIPanelConfig.InitializeAllMetatableAsUIBase()
    UIPanelConfig.ClearLifeCycleMethods()
end

--[[*******************************************************注册所有需要拦截CS中创建面板方法的函数*******************************************]]
---注册所有需要拦截CS中创建面板方法的函数
function UIPanelConfig.RegisterAllInterceptUIPanels()
    local csuimanager = CS.UIManager.Instance
    csuimanager:AddXLuaUIOpenEvent("UILogin", Utility.EnumToInt(CS.CEvent.V2_CreateXLuaPanel))
    csuimanager:AddXLuaUIOpenEvent("UIMainMenusPanel", Utility.EnumToInt(CS.CEvent.V2_CreateXLuaPanel))
    csuimanager:AddXLuaUIOpenEvent("UIMainSceneManager", Utility.EnumToInt(CS.CEvent.V2_CreateXLuaPanel))
end

---创建XLua界面事件回调
function UIPanelConfig.OnCreateXLuaPanelEventReceived(uiEvtID, ...)
    if ... == nil then
        return
    end
    local data = { ... }
    local dataLength = 0
    for i, v in pairs(data) do
        dataLength = math.max(dataLength, i)
    end
    local isOpenWithParams = dataLength == 1
    if isOpenWithParams then
        local panelName = data[1]
        --对UILogin界面做特殊处理,后面根据情况删除
        if panelName == "UILogin" then
            panelName = "UILoginPanel"
        end
        --对UIMainSceneManager界面做特殊处理,后面根据情况删除
        if panelName == "UIMainSceneManager" then
            panelName = "UIMainMenusPanel"
        end

        local transferId = tonumber(panelName);
        if(transferId ~= 0 and transferId ~= nil)then
            uiTransferManager:TransferToPanel(transferId);
        else
            uimanager:CreatePanel(panelName, nil)
        end
    else
        uimanager:CreatePanel(data[1], nil, table.unpack(data, 2, dataLength))
    end
end

---此处注册工程中所有的抽象界面的Lua脚本
function UIPanelConfig.RegisterAllUIPanels()
    ---Lua中面板模块列表,用于Lua中的继承
    luaPanelModules = {}
    ---弹窗
    luaPanelModules.UIDialog = require "luaRes.ui.panels.basic.UIDialog"
    ---数量界面
    luaPanelModules.UIItemCountPanel = require "luaRes.ui.panels.UIItemCountPanel"
    ---锻造右侧功能界面
    luaPanelModules.UIForgeRightPanelBase = require "luaRes.ui.panels.basic.UIForgeRightPanelBase"
    ---活动面板
    luaPanelModules.UIActivityDuplicatePanel = require "luaRes.ui.panels.UIActivityDuplicatePanel"
    ---物品信息面板
    luaPanelModules.UIItemInfoPanel = require "luaRes.ui.panels.UIItemInfoPanel"
    ---角色信息面板
    luaPanelModules.UIRolePanel = require "luaRes.ui.panels.UIRolePanel"
    ---活动大使进入活动面板
    luaPanelModules.UIActivityManEnterPanel = require "luaRes.ui.panels.basic.UIActivityManEnterPanel"
    ---活动排行榜
    luaPanelModules.UIActivityRankPanel = require "luaRes.ui.panels.UIActivityRankPanel"
    ---气泡
    luaPanelModules.UIBubbleTipsPanel = require "luaRes.ui.panels.UIBubbleTipsPanel"
    ---红包界面
    luaPanelModules.UIRedPacketPanel = require "luaRes.ui.panels.UIRedPacketPanel"
    ---活动排行榜详细
    luaPanelModules.UIActivityInformationPanel = require "luaRes.ui.panels.UIActivityInformationPanel"
    ---掠宝袋界面
    luaPanelModules.UITreasureBagPanel = require "luaRes.ui.panels.UITreasureBagPanel"
    ---行会背包
    luaPanelModules.UIGuildBagPanel = require "luaRes.ui.panels.UIGuildBagPanel"
    ---通用活动界面
    luaPanelModules.UIActivityCurrentBase = require "luaRes.ui.panels.basic.UIActivityCurrentBase"
    ---法宝面板
    luaPanelModules.UIRoleArtifactPanel = require "luaRes.ui.panels.UIRoleArtifactPanel"
    ---掠宝袋基础模板界面
    luaPanelModules.UITreasureBagPanelBase = require "luaRes.ui.panels.UITreasureBagPanelBase"
    ---NPC副本通用类
    luaPanelModules.UINPCDuplicateBase = require "luaRes.ui.panels.basic.UINPCDuplicateBase"
    ---镶嵌装备通用类
    luaPanelModules.UIInlayPanelBase = require "luaRes.ui.panels.basic.UIInlayPanelBase"
    ---boss技能面板
    luaPanelModules.UIBossSkillPanel = require "luaRes.ui.panels.UIBossSkillPanel"
    ---验证码面板
    luaPanelModules.UIPromptInviteCodePanelBase = require "luaRes.ui.panels.basic.UIPromptInviteCodePanelBase"
end

---清理全局生命周期函数
function UIPanelConfig.ClearLifeCycleMethods()
    awake = nil
    update = nil
    start = nil
    ondestroy = nil
end

---将所有UI界面模板的元表设置为uibase
function UIPanelConfig:InitializeAllMetatableAsUIBase()
    for k, v in pairs(luaPanelModules) do
        if getmetatable(v) == nil then
            --设置界面的元表为uibase
            setmetatable(v, uibase)
        end
        --设置界面的__index为自身
        v.__index = v
    end
end

return UIPanelConfig