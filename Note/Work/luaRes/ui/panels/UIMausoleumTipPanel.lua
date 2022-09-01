---陵墓古玩左侧tips
local UIMausoleumTipPanel = {}

--region 局部变量
UIMausoleumTipPanel.showTips_bool = true
UIMausoleumTipPanel.originalV3 = CS.UnityEngine.Vector3(102, -52, 0)
UIMausoleumTipPanel.changeV3 = CS.UnityEngine.Vector3(152, -52, 0)
--endregion

--region 初始化

function UIMausoleumTipPanel:Init()
    self:InitComponents()
    UIMausoleumTipPanel.BindUIEvents()
    UIMausoleumTipPanel.BindMessage()
    UIMausoleumTipPanel.SetUITips()
    UIMausoleumTipPanel.RefreshUI()
    UIMausoleumTipPanel.RefreshAccessOrderCount()
end

--- 初始化组件
function UIMausoleumTipPanel:InitComponents()
    ---@type Top_UILabel            当前位置
    UIMausoleumTipPanel.lb_name = self:GetCurComp("WidgetRoot/Tween/view/lb_name", "Top_UILabel")
    ---@type Top_UILabel            通行证进度
    UIMausoleumTipPanel.lb_kill = self:GetCurComp("WidgetRoot/Tween/view/lb_tongxingzheng", "Top_UILabel")
    ---@type UnityEngine.GameObject 下层奖励
    UIMausoleumTipPanel.item = self:GetCurComp("WidgetRoot/Tween/view/item", "GameObject")
    ---@type UnityEngine.GameObject  退出按钮
    UIMausoleumTipPanel.btn_quit = self:GetCurComp("WidgetRoot/Tween/btn_quit", "GameObject")
    ---@type UnityEngine.GameObject  前往下层按钮
    UIMausoleumTipPanel.btn_transfer = self:GetCurComp("WidgetRoot/Tween/btn_transfer", "GameObject")
    ---@type UnityEngine.GameObject  Hide按钮
    UIMausoleumTipPanel.BtnHide = self:GetCurComp("WidgetRoot/Tween/BtnHide", "GameObject")
    ---@type UnityEngine.GameObject  帮助按钮
    UIMausoleumTipPanel.helpBtn = self:GetCurComp("WidgetRoot/Tween/helpBtn", "GameObject")
    ---@type Top_TweenPosition
    UIMausoleumTipPanel.tween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")
    ---@type Top_UIGridContainer     下层奖励
    UIMausoleumTipPanel.RewardItemList = self:GetCurComp("WidgetRoot/Tween/view/RewardItemList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject    已通关信息tips
    UIMausoleumTipPanel.lb_time = self:GetCurComp("WidgetRoot/Tween/view/lb_time", "GameObject")
    ---@type UnityEngine.GameObject   已通关提示
    UIMausoleumTipPanel.lb_txt = self:GetCurComp("WidgetRoot/Tween/view/lb_txt", "GameObject")
    ---@type UnityEngine.GameObject   此层已通关提示
    UIMausoleumTipPanel.lb_txt2 = self:GetCurComp("WidgetRoot/Tween/view/lb_txt2", "GameObject")
    ---@type UnityEngine.GameObject  下阶奖励文本
    UIMausoleumTipPanel.lb_next = self:GetCurComp("WidgetRoot/Tween/window/lb_next", "GameObject")
    ---@type UnityEngine.GameObject  通行证文本
    UIMausoleumTipPanel.lb_detail = self:GetCurComp("WidgetRoot/Tween/view/lb_detail", "GameObject")


end

function UIMausoleumTipPanel.BindUIEvents()
    --点击退出事件
    CS.UIEventListener.Get(UIMausoleumTipPanel.btn_quit).onClick = UIMausoleumTipPanel.OnClickbtn_quit
    --点击进入下层事件
    CS.UIEventListener.Get(UIMausoleumTipPanel.btn_transfer).onClick = UIMausoleumTipPanel.OnClickbtn_transfer
    --点击帮助事件
    CS.UIEventListener.Get(UIMausoleumTipPanel.helpBtn).onClick = UIMausoleumTipPanel.OnClickhelpBtn
    --点击Hide事件
    CS.UIEventListener.Get(UIMausoleumTipPanel.BtnHide).onClick = UIMausoleumTipPanel.OnClickBtnHide

end

function UIMausoleumTipPanel.BindMessage()
    UIMausoleumTipPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateInfoMessage, UIMausoleumTipPanel.OnResDuplicateInfoMessage)
    UIMausoleumTipPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateItemMessage, UIMausoleumTipPanel.OnResDuplicateItemMessage)
end
--endregion

--region 函数监听

--点击退出函数
---@param go UnityEngine.GameObject
function UIMausoleumTipPanel.OnClickbtn_quit(go)
    networkRequest.ReqExitDuplicate(0)
    --发送通行证为0指令
    uimanager:ClosePanel('UIMausoleumTipPanel')
end

--点击进入下层函数
---@param go UnityEngine.GameObject
function UIMausoleumTipPanel.OnClickbtn_transfer(go)
    --自动寻路至NPC
    if CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo == nil then
        return
    end
    local duplicateID = CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo.duplicateId
    if duplicateID ~= nil then
        local isFind, info = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(duplicateID)
        if isFind then
            if info.toNpcId ~= 0 or info.toNpcId ~= nil then
                local temp = {}
                local dic = S.Cfg_MapNpcTableManager.Instance.dic
                dic:Begin()
                while dic:Next() do
                    if dic.Value.npcid == info.toNpcId then
                        temp = CS.SFMiscBase.Dot2(dic.Value.x, dic.Value.y)
                        break
                    end
                end
                -- for i, v in pairs(CS.Cfg_MapNpcTableManager.Instance.dic) do
                --     if v.npcid == info.toNpcId then
                --         temp = CS.SFMiscBase.Dot2(v.x, v.y)
                --         break
                --     end
                -- end
                CS.CSTouchEvent.touchInfo = CS.CSTouchEvent.TouchInfo(CS.TouchType.TouchNPC, nil)
                local isfind = CS.CSPathFinderManager.Instance:SetFixedDestination(duplicateID, temp, CS.EAutoPathFindSourceSystemType.Duplicate, CS.EAutoPathFindType.Duplicate_FindNPC)
                if not isfind then
                    --CS.Utility.ShowTips("寻路失败请查询", 1.5, CS.ColorType.Red)
                    if isOpenLog then
                        luaDebug.LogError("寻路失败请查询")
                    end
                end
            end


        end
    end

end

--点击帮助函数
---@param go UnityEngine.GameObject
function UIMausoleumTipPanel.OnClickhelpBtn(go)
    local dic = CS.Cfg_DescriptionTableManager.Instance.dic
    dic:Begin()
    while dic:Next() do
        if dic.Value.subType == 1001202 then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, dic.Value)
        end
    end
    -- for i, v in pairs(CS.Cfg_DescriptionTableManager.Instance.dic) do
    --     if v.subType == 1001202 then
    --         uimanager:CreatePanel("UIHelpTipsPanel", nil, v)
    --     end
    -- end
end

--点击Hide函数
---@param go UnityEngine.GameObject
function UIMausoleumTipPanel.OnClickBtnHide(go)
    UIMausoleumTipPanel.tween:SetOnFinished(UIMausoleumTipPanel.ClinkHideBtnCallBack)
    if UIMausoleumTipPanel.showTips_bool then
        UIMausoleumTipPanel.tween:PlayForward()
        UIMausoleumTipPanel.showTips_bool = false
    else
        UIMausoleumTipPanel.tween:PlayReverse()
        UIMausoleumTipPanel.showTips_bool = true
    end
end

--endregion


--region 网络消息处理
function UIMausoleumTipPanel.OnResDuplicateInfoMessage(id, data)
    if data then
        UIMausoleumTipPanel.SetUITips()
        UIMausoleumTipPanel.RefreshUI()
    end
end
function UIMausoleumTipPanel.OnResDuplicateItemMessage(id, data)
    if data then
        local mainPlayerId = CS.CSScene.MainPlayerInfo.ID
        if data.playerId == mainPlayerId then
            UIMausoleumTipPanel.RefreshAccessOrderCount()
        end
    end
end
--endregion

--region UI

function UIMausoleumTipPanel.RefreshUI()
    local info = UIMausoleumTipPanel.GetNextDupliceInfo()
    if info == nil then
        return
    end
    UIMausoleumTipPanel.lb_name.text = '[fbd671]' .. info.name .. '[-]'
    UIMausoleumTipPanel.RewardItemList.MaxCount = info.rewards.list.Count
    for k, v in pairs(info.rewards.list) do
        local go = UIMausoleumTipPanel.RewardItemList.controlList[k]
        local isFind, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v.list[0])
        if isFind then
            local temp = templatemanager.GetNewTemplate(UIMausoleumTipPanel.RewardItemList.controlList[k], luaComponentTemplates.UIItem)
            temp:RefreshUIWithItemInfo(iteminfo, v.list[1])
            CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                if temp.ItemInfo ~= nil then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = temp.ItemInfo})
                end
            end
        else
            go.gameObject:SetActive(false)
        end
    end
end

---刷新道具个数
function UIMausoleumTipPanel.RefreshAccessOrderCount()
    local count = 0
    if CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem ~= nil then
        count = CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem.count
    end
    local maxCount = UIMausoleumTipPanel.GetAccessOrderMaxValue()
    local color = '[ff0000ff]'
    if maxCount ~= nil then
        if count >= maxCount then
            color = '[00FF00FF]'
        end
    end
    UIMausoleumTipPanel.lb_kill.text = color .. tostring(count) .. ' / ' .. tostring(maxCount) .. '[-] '
end

---设置tips结构
function UIMausoleumTipPanel.SetUITips()
    local isMax = UIMausoleumTipPanel.IsMax()
    local ispass = UIMausoleumTipPanel.IsPass()
    --最大层tips
    UIMausoleumTipPanel.lb_txt.gameObject:SetActive(isMax)
    --此层通关提示
    UIMausoleumTipPanel.lb_txt2.gameObject:SetActive(ispass)
    --通行证文本
    UIMausoleumTipPanel.lb_detail.gameObject:SetActive(not isMax and not ispass)
    --下层奖励文本
    UIMausoleumTipPanel.lb_next.gameObject:SetActive(not ispass)
    --下层奖励
    UIMausoleumTipPanel.RewardItemList.gameObject:SetActive(not ispass)
    --前往下层按钮
    UIMausoleumTipPanel.btn_transfer.gameObject:SetActive(not isMax)
    --设置退出按钮位置
    UIMausoleumTipPanel.btn_quit.transform.localPosition = isMax and UIMausoleumTipPanel.changeV3 or UIMausoleumTipPanel.originalV3
end

--endregion

--region otherFunction
---Twen 动画回调
function UIMausoleumTipPanel.ClinkHideBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIMausoleumTipPanel.showTips_bool then
        v3.z = 180
    end
    UIMausoleumTipPanel.BtnHide.transform.localEulerAngles = v3
end

---获得奖励及通行令
function UIMausoleumTipPanel.GetNextDupliceInfo()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo == nil then
        return nil
    end
    local duplicateID = CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo.duplicateId
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(duplicateID)
    if isFind then
        return info
    end
end
---获得需要道具的最大值
function UIMausoleumTipPanel.GetAccessOrderMaxValue()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo == nil then
        return 0
    end
    local duplicateID = CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo.duplicateId
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(duplicateID + 1)
    if isFind then
        if info.requireItems ~= nil then
            return info.requireItems.list[0].list[1]
        end
    end
end

function UIMausoleumTipPanel.IsMax()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo == nil then
        return false
    end
    local id = CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo.duplicateId
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(id + 1)
    if isFind then
        return false
    else
        return true
    end
end

--本层是否已通关
function UIMausoleumTipPanel.IsPass()

    if CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo ~= nil then
        --历史最大层
        local maxFlorId = CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo.maxFloorId
        --当前层
        local curFlorId = CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo.duplicateId
        if maxFlorId ~= nil and curFlorId ~= nil then
            if maxFlorId > curFlorId then
                return true
            end
        end
    end
    return false
end


--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDuplicateInfoMessage, UIMausoleumTipPanel.OnResDuplicateInfoMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDuplicateItemMessage, UIMausoleumTipPanel.OnResDuplicateItemMessage)
    --  local temp = nil
    --  temp.playerId = CS.CSScene.MainPlayerInfo.ID
    --  temp.passCount = 0
    -- CS.CSScene.Sington:getAvatar(temp.playerId).BaseInfo.DuplicateInfo:ResduplicateToken(temp)
end

--endregion

return UIMausoleumTipPanel