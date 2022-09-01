---幻境
---@class UIGodPrisonTipPanel:UIBase
local UIGodPrisonTipPanel = {}

UIGodPrisonTipPanel.showTips_bool = true
UIGodPrisonTipPanel.originalV3 = CS.UnityEngine.Vector3(80, -54, 0)
UIGodPrisonTipPanel.changeV3 = CS.UnityEngine.Vector3(140, -54, 0)
UIGodPrisonTipPanel.duplicateinfo = nil
UIGodPrisonTipPanel.refreshTimeIenum = nil
--是否为副本关闭时间
UIGodPrisonTipPanel.refreshEndTime = false

UIGodPrisonTipPanel.isInit = true
--region 初始化

function UIGodPrisonTipPanel:Init()
    self:InitComponents()
    UIGodPrisonTipPanel.InitPanel()
    UIGodPrisonTipPanel.BindUIEvents()
    UIGodPrisonTipPanel.BindNetMessage()
    UIGodPrisonTipPanel.RefreshUI()
    UIGodPrisonTipPanel.RefreshAccessOrderCount()
end

function UIGodPrisonTipPanel:InitComponents()
    ---@type Top_UILabel            当前位置
    UIGodPrisonTipPanel.lb_name = self:GetCurComp("WidgetRoot/Tween/view/lb_name", "Top_UILabel")
    ---@type Top_UILabel            通行证进度
    UIGodPrisonTipPanel.lb_tongxingzheng = self:GetCurComp("WidgetRoot/Tween/view/lb_detail/lb_tongxingzheng", "Top_UILabel")
    ---@type UnityEngine.GameObject 下层奖励
    UIGodPrisonTipPanel.item = self:GetCurComp("WidgetRoot/Tween/view/item", "GameObject")
    ---@type UnityEngine.GameObject  退出按钮
    UIGodPrisonTipPanel.btn_quit = self:GetCurComp("WidgetRoot/Tween/btn_quit", "GameObject")
    ---@type UnityEngine.GameObject  前往下层按钮
    UIGodPrisonTipPanel.btn_transfer = self:GetCurComp("WidgetRoot/Tween/btn_transfer", "GameObject")
    ---@type UnityEngine.GameObject  Hide按钮
    UIGodPrisonTipPanel.BtnHide = self:GetCurComp("WidgetRoot/Tween/BtnHide", "GameObject")
    ---@type UnityEngine.GameObject  帮助按钮
    UIGodPrisonTipPanel.helpBtn = self:GetCurComp("WidgetRoot/Tween/helpBtn", "GameObject")
    ---@type Top_TweenPosition
    UIGodPrisonTipPanel.tween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")
    ---@type Top_UIGridContainer     下层奖励
    UIGodPrisonTipPanel.RewardItemList = self:GetCurComp("WidgetRoot/Tween/view/RewardItemList", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject   时间tips
    -- UIGodPrisonTipPanel.lb_time = self:GetCurComp("WidgetRoot/Tween/view/time/lb_time", "Top_UILabel")
    ---@type UnityEngine.GameObject   已通关提示
    UIGodPrisonTipPanel.lb_txt = self:GetCurComp("WidgetRoot/Tween/view/lb_txt", "GameObject")
    ---@type UnityEngine.GameObject   此层已通关提示
    UIGodPrisonTipPanel.lb_txt2 = self:GetCurComp("WidgetRoot/Tween/view/lb_txt2", "GameObject")
    ---@type UnityEngine.GameObject  下阶奖励文本
    UIGodPrisonTipPanel.lb_next = self:GetCurComp("WidgetRoot/Tween/window/lb_next", "GameObject")
    ---@type Top_UILabel  通行证文本
    UIGodPrisonTipPanel.lb_detail = self:GetCurComp("WidgetRoot/Tween/view/lb_detail", "Top_UILabel")
    ---@type UnityEngine.GameObject 闪光特效
    UIGodPrisonTipPanel.Sprite = self:GetCurComp("WidgetRoot/Tween/btn_transfer/Sprite", "GameObject")
    ---@type Top_UILabel boss
    UIGodPrisonTipPanel.lb_boss = self:GetCurComp("WidgetRoot/Tween/view/lb_boss", "Top_UILabel")
    ---@type Top_UILabel boss名称
    UIGodPrisonTipPanel.lb_kill = self:GetCurComp("WidgetRoot/Tween/view/lb_boss/lb_kill", "Top_UILabel")
    ---@type Top_UILabel boss已击杀
    UIGodPrisonTipPanel.lb_kill2 = self:GetCurComp("WidgetRoot/Tween/view/lb_boss/lb_kill2", "Top_UILabel")
end

function UIGodPrisonTipPanel.BindUIEvents()
    --点击退出事件
    CS.UIEventListener.Get(UIGodPrisonTipPanel.btn_quit).onClick = UIGodPrisonTipPanel.OnClickbtn_quit
    --点击进入下层事件
    CS.UIEventListener.Get(UIGodPrisonTipPanel.btn_transfer).onClick = UIGodPrisonTipPanel.OnClickbtn_transfer
    --点击帮助事件
    CS.UIEventListener.Get(UIGodPrisonTipPanel.helpBtn).onClick = UIGodPrisonTipPanel.OnClickhelpBtn
    --点击Hide事件
    CS.UIEventListener.Get(UIGodPrisonTipPanel.BtnHide).onClick = UIGodPrisonTipPanel.OnClickBtnHide
    --点击Hide事件
    CS.UIEventListener.Get(UIGodPrisonTipPanel.lb_kill.gameObject).onClick = UIGodPrisonTipPanel.OnClicklb_kill
end

function UIGodPrisonTipPanel.BindNetMessage()
    UIGodPrisonTipPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGodPowerMessage, UIGodPrisonTipPanel.OnResGodPowerMessage)
    UIGodPrisonTipPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEntryTokenItemMessage, UIGodPrisonTipPanel.OnResDuplicateItemMessage)
end

function UIGodPrisonTipPanel.InitPanel()
    local menuPanel = uimanager:GetPanel('UIMainMenusPanel')
    if menuPanel then
        menuPanel:AddMainMenuModule("UIPvePlaceTimePanel", menuPanel:GetTopRightDynamicNode(), function(panel)
            UIGodPrisonTipPanel.PveTimePanel = panel
            UIGodPrisonTipPanel.InitTime()
        end)
    end
end

--endregion


--region 函数监听

---点击退出函数
function UIGodPrisonTipPanel.OnClickbtn_quit(go)
    UIGodPrisonTipPanel.ShowQuitTips()
end

---点击进入下层函数
function UIGodPrisonTipPanel.OnClickbtn_transfer(go)
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo == nil then
        return
    end
    local duplicateID = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.thisMapId
    if duplicateID ~= nil then
        local isFind, info = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(duplicateID)
        if isFind then
            if info.toNpcId ~= 0 or info.toNpcId ~= nil then
                local temp = {}
                local dic = CS.Cfg_MapNpcTableManager.Instance.dic
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
                local isfind = CS.CSPathFinderManager.Instance:SetFixedDestination(duplicateID, temp, CS.EAutoPathFindSourceSystemType.Duplicate, CS.EAutoPathFindType.Duplicate_FindNPC, 2, 0, info.bindNpcId)
                if not isfind then
                    if isOpenLog then
                        luaDebug.LogError("寻路失败请查询")
                    end
                end
            end
        end
    end
end

---点击帮助函数
function UIGodPrisonTipPanel.OnClickhelpBtn(go)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(74)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---点击Hide函数
function UIGodPrisonTipPanel.OnClickBtnHide(go)
    UIGodPrisonTipPanel.tween:SetOnFinished(UIGodPrisonTipPanel.ClinkHideBtnCallBack)
    if UIGodPrisonTipPanel.showTips_bool then
        UIGodPrisonTipPanel.tween:PlayForward()
        UIGodPrisonTipPanel.showTips_bool = false
    else
        UIGodPrisonTipPanel.tween:PlayReverse()
        UIGodPrisonTipPanel.showTips_bool = true
    end
end

---点击boss点击函数
function UIGodPrisonTipPanel.OnClicklb_kill(go)
    if UIGodPrisonTipPanel.dupliceInfo == nil then
        return
    end
    local x = UIGodPrisonTipPanel.dupliceInfo.BossPos.list[0]
    local y = UIGodPrisonTipPanel.dupliceInfo.BossPos.list[1]
    local temp = CS.SFMiscBase.Dot2(x, y)
    CS.CSTouchEvent.touchInfo = nil
    local isfind = CS.CSPathFinderManager.Instance:SetFixedDestination(UIGodPrisonTipPanel.dupliceInfo.id, temp, CS.EAutoPathFindSourceSystemType.Duplicate, CS.EAutoPathFindType.Duplicate_MoveToBoss)
    if not isfind then
        --CS.Utility.ShowTips("寻路失败请查询", 1.5, CS.ColorType.Red)
        if isOpenLog then
            luaDebug.LogError("寻路失败请查询")
        end
    end
end

--endregion

--region 网络消息处理

function UIGodPrisonTipPanel.OnResGodPowerMessage(data)
    UIGodPrisonTipPanel.RefreshUI()
    if UIGodPrisonTipPanel.isInit then
        UIGodPrisonTipPanel.isInit = false
        UIGodPrisonTipPanel.InitTime()
    end
end

---刷新通行证
function UIGodPrisonTipPanel.OnResDuplicateItemMessage(id, data)
    if data then
        UIGodPrisonTipPanel.RefreshAccessOrderCount()
    end
end

--endregion

--region UI

function UIGodPrisonTipPanel.RefreshUI()
    UIGodPrisonTipPanel.GetNextDupliceInfo()
    if UIGodPrisonTipPanel.dupliceInfo == nil then
        return
    end
    UIGodPrisonTipPanel.SetUITips()
    UIGodPrisonTipPanel.lb_name.text = '[fbd671]' .. UIGodPrisonTipPanel.dupliceInfo .name .. '[-]'
    if UIGodPrisonTipPanel.dupliceInfo.rewards ~= nil then
        UIGodPrisonTipPanel.RewardItemList.MaxCount = UIGodPrisonTipPanel.dupliceInfo.rewards.list.Count
        for k, v in pairs(UIGodPrisonTipPanel.dupliceInfo.rewards.list) do
            local go = UIGodPrisonTipPanel.RewardItemList.controlList[k]
            local isFind, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v.list[0])
            if isFind then
                local temp = templatemanager.GetNewTemplate(UIGodPrisonTipPanel.RewardItemList.controlList[k], luaComponentTemplates.UIItem)
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
    UIGodPrisonTipPanel.RefreshBossStatu()
end

---boss击杀状态刷新
function UIGodPrisonTipPanel.RefreshBossStatu()
    local duplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo
    local bossIsKill = duplicateInfo ~= nil and duplicateInfo.bossSurvival or false
    if not bossIsKill then
        local id = UIGodPrisonTipPanel.dupliceInfo.bossId
        local isFind, info = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(id)
        local str = ''
        if isFind then
            str = info.name
        end
        UIGodPrisonTipPanel.lb_kill.text = str
    end
    UIGodPrisonTipPanel.lb_kill.gameObject:SetActive(not bossIsKill)
    UIGodPrisonTipPanel.lb_kill2.gameObject:SetActive(bossIsKill)
end

---设置tips结构
function UIGodPrisonTipPanel.SetUITips()

    local isMax = UIGodPrisonTipPanel.IsMax()
    local ispass = UIGodPrisonTipPanel.IsPass()
    --最大层tips
    UIGodPrisonTipPanel.lb_txt.gameObject:SetActive(isMax)
    --此层通关提示
    UIGodPrisonTipPanel.lb_txt2.gameObject:SetActive(ispass and not isMax)
    --通行证文本
    UIGodPrisonTipPanel.lb_detail.gameObject:SetActive(not isMax and not ispass)
    --下层奖励文本
    UIGodPrisonTipPanel.lb_next.gameObject:SetActive(not ispass and not isMax)
    --下层奖励
    UIGodPrisonTipPanel.RewardItemList.gameObject:SetActive(not ispass and not isMax)
    --前往下层按钮
    UIGodPrisonTipPanel.btn_transfer.gameObject:SetActive(not isMax)
    --设置退出按钮位置
    UIGodPrisonTipPanel.btn_quit.transform.localPosition = isMax and UIGodPrisonTipPanel.changeV3 or UIGodPrisonTipPanel.originalV3

end

---刷新道具个数
function UIGodPrisonTipPanel.RefreshAccessOrderCount()
    local count = 0
    if CS.CSScene.MainPlayerInfo.DuplicateV2.EntryTokenItem ~= nil then
        count = CS.CSScene.MainPlayerInfo.DuplicateV2.EntryTokenItem.count
    end
    local maxCount = UIGodPrisonTipPanel.GetAccessOrderMaxValue()
    local color = '[ff0000ff]'
    if maxCount ~= nil then
        if count >= maxCount then
            color = '[00FF00FF]'
        end
    end
    UIGodPrisonTipPanel.lb_tongxingzheng.text = color .. tostring(count) .. ' / ' .. tostring(maxCount) .. '[-] '
    UIGodPrisonTipPanel.Sprite.gameObject:SetActive(maxCount ~= nil and maxCount ~= 0 and maxCount == count)
end

function UIGodPrisonTipPanel.InitTime()
    if UIGodPrisonTipPanel.refreshTimeIenum ~= nil then
        StopCoroutine(UIGodPrisonTipPanel.refreshTimeIenum)
        UIGodPrisonTipPanel.refreshTimeIenum = nil
    end
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo == nil then
        if UIGodPrisonTipPanel.PveTimePanel ~= nil then
            UIGodPrisonTipPanel.PveTimePanel.RefreshText('')
        end
        return
    end
    --入口结束时间
    local entryEndTime = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.entryTimeEnd
    local endTime = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.endTime
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond

    if entryEndTime > serverNowTime then
        UIGodPrisonTipPanel.refreshEndTime = false
        -- UIGodPrisonTipPanel.lb_time.gameObject:SetActive(true)
        UIGodPrisonTipPanel.refreshTimeIenum = StartCoroutine(UIGodPrisonTipPanel.IEnumTimeCount, entryEndTime - serverNowTime)
    elseif endTime > serverNowTime then
        UIGodPrisonTipPanel.refreshEndTime = true
        -- UIGodPrisonTipPanel.lb_time.gameObject:SetActive(true)
        UIGodPrisonTipPanel.refreshTimeIenum = StartCoroutine(UIGodPrisonTipPanel.IEnumTimeCount, endTime - serverNowTime)
    else
        if UIGodPrisonTipPanel.PveTimePanel ~= nil then
            UIGodPrisonTipPanel.PveTimePanel.RefreshText('')
        end
    end
end

--endregion

--region otherFunc

--毫秒
function UIGodPrisonTipPanel.IEnumTimeCount(time)
    local meetTime = true
    local totalTime = time
    local str = UIGodPrisonTipPanel.refreshEndTime and '活动时间 %02.0f:%02.0f:%02.0f' or '入口时间 %02.0f:%02.0f:%02.0f'
    UIGodPrisonTipPanel. pvePlaceTimePanel = uimanager:GetPanel('UIPvePlaceTimePanel')
    while meetTime do

        if totalTime <= 0 then
            meetTime = false
            if UIGodPrisonTipPanel.PveTimePanel ~= nil then
                UIGodPrisonTipPanel.PveTimePanel.RefreshText(string.format(str, 0, 0, 0))
            end
            --当前刷新为入口时间
            if not UIGodPrisonTipPanel.refreshEndTime then
                if UIGodPrisonTipPanel.refreshTimeIenum ~= nil then
                    StopCoroutine(UIGodPrisonTipPanel.refreshTimeIenum)
                    UIGodPrisonTipPanel.refreshTimeIenum = nil
                    local endTime = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.endTime
                    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
                    UIGodPrisonTipPanel.refreshEndTime = true
                    UIGodPrisonTipPanel.refreshTimeIenum = StartCoroutine(UIGodPrisonTipPanel.IEnumTimeCount, endTime - serverNowTime)

                end
            else
                networkRequest.ReqExitDuplicate(0)
                uimanager:ClosePanel('UIGodPrisonTipPanel')
            end
        else
            local hour, minute, second = Utility.MillisecondToFormatTime(totalTime)
            if UIGodPrisonTipPanel.PveTimePanel ~= nil then
                UIGodPrisonTipPanel.PveTimePanel.RefreshText(string.format(str, hour, minute, second))
            end
        end
        totalTime = totalTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end
---点击箭头回调
function UIGodPrisonTipPanel.ClinkHideBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIGodPrisonTipPanel.showTips_bool then
        v3.z = 180
    end
    UIGodPrisonTipPanel.BtnHide.transform.localEulerAngles = v3
end

function UIGodPrisonTipPanel.IsMax()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo == nil then
        return false
    end
    local id = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.thisMapId
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(id + 1)
    if isFind then
        return false
    else
        return true
    end
end
--本层是否已通关
function UIGodPrisonTipPanel.IsPass()
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

---获得副本信息
function UIGodPrisonTipPanel.GetNextDupliceInfo()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo == nil then
        UIGodPrisonTipPanel.dupliceInfo = nil
        return
    end
    local duplicateID = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.thisMapId
    if duplicateID == 0 then
        UIGodPrisonTipPanel.dupliceInfo = nil
        return
    end
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(duplicateID)
    if isFind then
        UIGodPrisonTipPanel.dupliceInfo = info
    end
end

---获得需要道具的最大值
function UIGodPrisonTipPanel.GetAccessOrderMaxValue()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo == nil then
        return 0
    end
    local duplicateID = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.thisMapId
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(duplicateID + 1)
    if isFind then
        if info.requireItems ~= nil then
            return info.requireItems.list[0].list[1]
        end
    end
end

function UIGodPrisonTipPanel.ShowQuitTips()
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(21)
    if isFind then
        local temp = {}
        temp.Content = info.des
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = 21
        temp.CallBack = function()
            --发送通行证为0指令
            --Utility.ReqExitDuplicate()
            networkRequest.ReqExitDuplicate(0)
            uimanager:ClosePanel('UIGodPrisonTipPanel')
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

--endregion

function ondestroy()
    uimanager:ClosePanel('UIPvePlaceTimePanel')

    if UIGodPrisonTipPanel.refreshTimeIenum ~= nil then
        StopCoroutine(UIGodPrisonTipPanel.refreshTimeIenum)
        UIGodPrisonTipPanel.refreshTimeIenum = nil
    end
end

return UIGodPrisonTipPanel
