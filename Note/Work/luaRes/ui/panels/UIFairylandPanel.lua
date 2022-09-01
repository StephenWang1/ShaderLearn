---幻境副本NPC面板
---@class UIFairylandPanel:UIBase
local UIFairylandPanel = {}

--region 局部变量
--下层副本id
UIFairylandPanel.DuplicateID = 0
UIFairylandPanel.consumeValue = 0
UIFairylandPanel.consumeMaxValue = 0
--endregion

--region 初始化

function UIFairylandPanel:Init()
    self:InitComponents()
    UIFairylandPanel.BindUIEvents()
    UIFairylandPanel.BindMessage()
end

function UIFairylandPanel:Show(id, avater)
    UIFairylandPanel.DuplicateID = id
    UIFairylandPanel.InitUI()
end

--- 初始化组件
function UIFairylandPanel:InitComponents()
    ---@type Top_UILabel
    UIFairylandPanel.title = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel")
    ---@type Top_UILabel 活动描述
    UIFairylandPanel.Label2 = self:GetCurComp("WidgetRoot/SecondPanel/Label2", "Top_UILabel")
    ---@type Top_UILabel 下层说明
    UIFairylandPanel.lb_next = self:GetCurComp("WidgetRoot/SecondPanel/lb_next", "Top_UILabel")
    ---@type Top_UILabel 通行证消耗
    UIFairylandPanel.lb_consume = self:GetCurComp("WidgetRoot/SecondPanel/lb_consume", "Top_UILabel")
    ---@type UnityEngine.GameObject
    UIFairylandPanel.btn_transfer = self:GetCurComp("WidgetRoot/SecondPanel/btn_transfer", "GameObject")
    ---@type UnityEngine.GameObject
    UIFairylandPanel.btn_close = self:GetCurComp("WidgetRoot/btn_close", "GameObject")
end

function UIFairylandPanel.BindUIEvents()
    CS.UIEventListener.Get(UIFairylandPanel.btn_transfer).onClick = UIFairylandPanel.OnClickbtn_transfer
    CS.UIEventListener.Get(UIFairylandPanel.btn_close).onClick = UIFairylandPanel.OnClickbtn_close
end

function UIFairylandPanel.BindMessage()
    UIFairylandPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEntryTokenItemMessage, UIFairylandPanel.OnResDuplicateItemMessage)
end
--endregion

--region 函数监听

--点击进入下层函数
---@param go UnityEngine.GameObject
function UIFairylandPanel.OnClickbtn_transfer(go)
    if UIFairylandPanel.consumeValue < UIFairylandPanel.consumeMaxValue then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 77
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        return
    end

    local isFind, activityInfo = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(UIFairylandPanel.DuplicateID)
    if isFind then
        --获取配置传送id
        local delidverID = CS.Cfg_DailyActivityTimeTableManager.Instance.dic[activityInfo.openTime].deliverId
        Utility.ReqEnterDuplicate(delidverID)
    end
    uimanager:ClosePanel('UIFairylandPanel')
end

--点击关闭页面函数
---@param go UnityEngine.GameObject
function UIFairylandPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIFairylandPanel')
end

--endregion


--region 网络消息处理
function UIFairylandPanel.OnResDuplicateItemMessage(id, data)
    if data then
        local mainPlayerId = CS.CSScene.MainPlayerInfo.ID
        if data.playerId == mainPlayerId then
            UIFairylandPanel.RefreshConsume()
        end
    end
end
--endregion

--region UI
function UIFairylandPanel.InitUI()
    -- UIFairylandPanel.Label2.text = '[c9b39c]' .. UIFairylandPanel.GetDescript(1001203) .. '[-]'
    --UIFairylandPanel.title.text = '[ffffff]幻境[-]'
    UIFairylandPanel.RefreshConsume()
    local descriptionStr = UIFairylandPanel.GetDescript(76)
    local boosName = UIFairylandPanel.GetBossName()
    local Itemstr = UIFairylandPanel.GetItemInfo()
    descriptionStr = string.format(descriptionStr, boosName, Itemstr)

    UIFairylandPanel.lb_next.text = '[c9b39c]' .. descriptionStr .. '[-]'


end

function UIFairylandPanel.RefreshConsume()

    if CS.CSScene.MainPlayerInfo.DuplicateV2.EntryTokenItem ~= nil then
        UIFairylandPanel.consumeValue = CS.CSScene.MainPlayerInfo.DuplicateV2.EntryTokenItem.count
    end
    UIFairylandPanel.consumeMaxValue = UIFairylandPanel.IsPass() and 0 or UIFairylandPanel.GetAccessOrderMaxValue();
    local color = UIFairylandPanel.consumeValue >= UIFairylandPanel.consumeMaxValue and luaEnumColorType.Green or luaEnumColorType.Red
    UIFairylandPanel.lb_consume.text = '[c9b39c]消耗通行证：[00ff00]' .. tostring(UIFairylandPanel.consumeMaxValue) .. ' [-]个（拥有' .. color .. tostring(UIFairylandPanel.consumeValue) .. '[-]个）'
end


--endregion

--region otherFunction

function UIFairylandPanel.GetAccessOrderMaxValue()
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(UIFairylandPanel.DuplicateID)
    if isFind then
        if info.requireItems ~= nil then
            return info.requireItems.list[0].list[1]
        end
    end
end

function UIFairylandPanel.GetDescript(id)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return string.gsub(info.value, '#', '\n')
    end
end

function UIFairylandPanel.GetBossName()
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(UIFairylandPanel.DuplicateID)
    if isFind then
        local id = info.bossId
        isFind, info = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(id)
        if isFind then
            return info.name
        end
    end
    return ''
end

function UIFairylandPanel.GetItemInfo()
    local itemInfoStr = ''
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(UIFairylandPanel.DuplicateID - 1)
    if isFind then
        for k, v in pairs(info.rewards.list) do
            isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v.list[0])
            if isFind then
                itemInfoStr = itemInfoStr ~= '' and itemInfoStr .. '、' or itemInfoStr
                itemInfoStr = itemInfoStr .. CS.Cfg_ItemsTableManager.Instance:GetItemName(v.list[0]) .. '*' .. v.list[1]
            end
        end
    end
    return itemInfoStr
end

--本层是否已通关
function UIFairylandPanel.IsPass()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo ~= nil then
        --历史最大层
        local maxFlorId = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.mapId
        --当前层
        local curFlorId = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.thisMapId
        if maxFlorId ~= nil and curFlorId ~= nil then
            if maxFlorId > curFlorId then
                return true
            end
        end
    end
    return false
end
--endregion

return UIFairylandPanel