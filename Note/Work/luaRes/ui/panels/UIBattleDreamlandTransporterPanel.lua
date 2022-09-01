---@class UIBattleDreamlandTransporterPanel 梦境传送员面板
local UIBattleDreamlandTransporterPanel = {}

--region 局部变量
UIBattleDreamlandTransporterPanel.id = 0
--endregion

--region 初始化

function UIBattleDreamlandTransporterPanel:Init()
    self:InitComponents()
    UIBattleDreamlandTransporterPanel.InitData()
    UIBattleDreamlandTransporterPanel.BindUIEvents()
    UIBattleDreamlandTransporterPanel.BindNetMessage()
    UIBattleDreamlandTransporterPanel.ShowUI()
end

--- 初始化组件
function UIBattleDreamlandTransporterPanel:InitComponents()
    ---@type Top_UIGridContainer
    UIBattleDreamlandTransporterPanel.btnList = self:GetCurComp("WidgetRoot/event/btnList", "Top_UIGridContainer")
    ---@type Top_UILabel
    UIBattleDreamlandTransporterPanel.lb_condition = self:GetCurComp("WidgetRoot/view/lb_condition", "Top_UILabel")
    ---@type UnityEngine.GameObject
    UIBattleDreamlandTransporterPanel.btn_close = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
end

function UIBattleDreamlandTransporterPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIBattleDreamlandTransporterPanel.btn_close).onClick = UIBattleDreamlandTransporterPanel.OnClickbtn_close
end

function UIBattleDreamlandTransporterPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
    UIBattleDreamlandTransporterPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIBattleDreamlandTransporterPanel.OnMainPlayerBeginWalkCallBack)
end

function UIBattleDreamlandTransporterPanel.InitData()
    UIBattleDreamlandTransporterPanel.maxFloor = uiStaticParameter.GetBattleDreamlandMaxFloor() ~= nil and uiStaticParameter.GetBattleDreamlandMaxFloor() or 9625
    UIBattleDreamlandTransporterPanel.minFloor = uiStaticParameter.GetBattleDreamlandMinFloor() ~= nil and uiStaticParameter.GetBattleDreamlandMinFloor() or 9601
end

--endregion

--region 函数监听
--点击函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandTransporterPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIBattleDreamlandTransporterPanel')
end
--endregion


--region 网络消息处理

function UIBattleDreamlandTransporterPanel.OnMainPlayerBeginWalkCallBack()
    uimanager:ClosePanel('UIBattleDreamlandTransporterPanel')
end

--endregion

--region UI
function UIBattleDreamlandTransporterPanel.ShowUI()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil or CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo == nil then
        return
    end
    UIBattleDreamlandTransporterPanel.id = CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo.cfgId
    if UIBattleDreamlandTransporterPanel.id == UIBattleDreamlandTransporterPanel.maxFloor then
        UIBattleDreamlandTransporterPanel.lb_condition.text = '[878787]已到达最高层[-]'
    else
        local isMeet, typeStr, conditionNum = CS.CSScene.MainPlayerInfo.DuplicateV2:CheckisMeetCondition(UIBattleDreamlandTransporterPanel.id + 1)
        local showStr = tostring(conditionNum) .. typeStr
        local color = not isMeet and luaEnumColorType.Red or luaEnumColorType.White
        --if finishCode == 1 then
        --    --战勋足够
        --    --local isFind, item = CS.Cfg_PrefixTableManager.Instance.dic:TryGetValue(showPrefixID)
        --    --if isFind then
        --    --color = '[' .. item.color .. ']'
        --    --end
        --
        --else
        --    --战勋不足
        --    UIBattleDreamlandTransporterPanel.lb_condition.text = '[878787]下层等级要求[-] ' .. color .. showStr .. '[-]'
        --end
        UIBattleDreamlandTransporterPanel.lb_condition.text = '[878787]下层等级要求[-] ' .. color .. showStr .. '[-]'
    end

    UIBattleDreamlandTransporterPanel.InitGrid()
end

function UIBattleDreamlandTransporterPanel.InitGrid()

    local isFind, Info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20517)
    if isFind then
        local infos = string.Split(Info.value, '#')
        local count = 0
        local index = 0
        for i, v in pairs(infos) do
            local limitMin = UIBattleDreamlandTransporterPanel.id ~= UIBattleDreamlandTransporterPanel.maxFloor and i == 2
            local limitMax = UIBattleDreamlandTransporterPanel.id ~= UIBattleDreamlandTransporterPanel.minFloor and i == 1
            index = index + 1
            if limitMin or limitMax then
                count = count + 1
                UIBattleDreamlandTransporterPanel.btnList.MaxCount = count
                local go = UIBattleDreamlandTransporterPanel.btnList.controlList[count - 1]
                if go == nil then
                    return
                end
                local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('label'), "Top_UILabel")
                if btnLabel then
                    btnLabel.text = v
                end

                CS.UIEventListener.Get(go).onClick = nil
                --绑定委托
                if index == 1 then
                    CS.UIEventListener.Get(go).onClick = function(go)
                        UIBattleDreamlandTransporterPanel.JumpFloor(go, UIBattleDreamlandTransporterPanel.id - 1, true)
                    end
                else
                    CS.UIEventListener.Get(go).onClick = function(go)
                        UIBattleDreamlandTransporterPanel.JumpFloor(go, UIBattleDreamlandTransporterPanel.id + 1, false)
                    end
                end
            end
        end
    end
end

--endregion

--region otherFunction

function UIBattleDreamlandTransporterPanel.JumpFloor(go, id, isUp)
    local isFind, activityInfo = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(id)
    local deliverID = 0
    if isFind then
        --获取配置传送id
        deliverID = CS.Cfg_DailyActivityTimeTableManager.Instance.dic[activityInfo.openTime].deliverId
    end

    local isMeet = CS.CSScene.MainPlayerInfo.DuplicateV2:CheckisMeetCondition(id)

    if not isMeet then
        local tipsId = isUp and 253 or 105
        Utility.ShowPopoTips(go, nil, tipsId, "UIBattleDreamlandTransporterPanel")
        --local isFind, BubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(tipsId)
        --if isFind then
        --    local career = CS.CSScene.MainPlayerInfo.Career
        --    local prefixStr = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(showPrefixID, career)
        --    local TipsInfo = {}
        --    --TipsInfo[LuaEnumTipConfigType.Describe] = string.format(BubbleInfo.content, prefixStr)
        --    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
        --    TipsInfo[LuaEnumTipConfigType.ConfigID] = tipsId
        --    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIBattleDreamlandTransporterPanel"
        --    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        --
        --end
        return
    end
    Utility.ReqEnterDuplicate(deliverID)
    uimanager:ClosePanel('UIBattleDreamlandTransporterPanel')
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIBattleDreamlandTransporterPanel