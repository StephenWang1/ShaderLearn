---@class UIBattleDreamlandPanel:UIBase 狼烟梦境活动面板
local UIBattleDreamlandPanel = {}

--region 局部变量
UIBattleDreamlandPanel.duplicateId = 0
UIBattleDreamlandPanel.descriptionId = 0
--UIBattleDreamlandPanel.limitLevel = 0
UIBattleDreamlandPanel.mDuplicateInfo = nil
UIBattleDreamlandPanel.fireworkID = 6100001
UIBattleDreamlandPanel.allShowLYMJDic = {}
UIBattleDreamlandPanel.curLYMJInfo = nil
---帮助按钮的表id
UIBattleDreamlandPanel.mHelpId = nil;
UIBattleDreamlandPanel.mdropList = {}
--endregion

--region 初始化

function UIBattleDreamlandPanel.GetBtnHelp_GameObject()
    if (UIBattleDreamlandPanel.mBtnHelp_GameObject == nil) then
        UIBattleDreamlandPanel.mBtnHelp_GameObject = UIBattleDreamlandPanel:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return UIBattleDreamlandPanel.mBtnHelp_GameObject;
end

function UIBattleDreamlandPanel:Init()
    self:AddCollider()
    self:InitComponents()
    UIBattleDreamlandPanel.BindUIEvents()
    UIBattleDreamlandPanel.BindNetMessage()
    uiStaticParameter.isHideFireworkPanel = false
    networkRequest.ReqWolfDreamTime()
end

function UIBattleDreamlandPanel:Show(duplicateId, descriptionId, helpId)

    if descriptionId == nil or descriptionId == nil then
        return
    end
    if (helpId ~= nil) then
        UIBattleDreamlandPanel.mHelpId = helpId;
    end
    --副本
    UIBattleDreamlandPanel.duplicateId = duplicateId
    UIBattleDreamlandPanel.descriptionId = descriptionId
    local isFind, item = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateId)
    if isFind then
        UIBattleDreamlandPanel.mDuplicateInfo = item
        --    --每日活动
        UIBattleDreamlandPanel.mDailyActivityTimeId = item.openTime
        --region 暂时废弃
        --    --战力限制
        --    if item.requireItems ~= nil then
        --        local itemId = item.requireItems.list[0].list[0]
        --        local count = item.requireItems.list[0].list[1]
        --        local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
        --        local maxcount = bagInfo:GetItemCountByItemId(itemId)
        --        local color = Utility.GetBBCode(maxcount >= count)
        --        UIActivityDuplicatePanel.eventcost.text = color .. maxcount .. '[-]/' .. count
        --        isFind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
        --        if isFind then
        --            UIActivityDuplicatePanel.eventcost.transform:Find('icon'):GetComponent('Top_UISprite').spriteName = item.icon
        --            UIActivityDuplicatePanel.mConditionItem = item
        --        end
        --        UIActivityDuplicatePanel.panelName = 'UIShopPanel'
        --    elseif item.recommendFightCap ~= nil and item.recommendFightCap ~= "" and CS.CSScene.MainPlayerInfo ~= nil then
        --        local color = Utility.GetBBCode(item.recommendFightCap >= CS.CSScene.MainPlayerInfo.FightPower)
        --        UIActivityDuplicatePanel.eventcost.text = color .. item.recommendFightCap .. '[-]/' .. CS.CSScene.MainPlayerInfo.FightPower
        --        UIActivityDuplicatePanel.eventcost.transform:Find('icon'):GetComponent('Top_UISprite').spriteName = '1000012'
        --        UIActivityDuplicatePanel.panelName = 'bianqiang'
        --    else
        --        UIActivityDuplicatePanel.eventcost.gameObject:SetActive(false)
        --    end
        --
        --    --时间
        --    if UIActivityDuplicatePanel.mDuplicate.openTime ~= 0 then
        --        isFind, item = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(UIActivityDuplicatePanel.mDuplicate.openTime)
        --        if isFind then
        --            local startTime, startTimey = math.modf(item.startTime / 60)
        --            local endTime, endTimey = math.modf(item.overTime / 60)
        --            startTimey = startTimey >= 10 and startTimey or startTimey .. '0'
        --            endTimey = endTimey >= 10 and endTimey or endTimey .. '0'
        --            --UIActivityDuplicatePanel.timeDes.text = string.format("%02.0f:%02.0f - %02.0f:%02.0f", startTime, startTimey, endTime, endTimey)
        --            self:AddConditionContent("活动时间",string.format("%02.0f:%02.0f - %02.0f:%02.0f", startTime, startTimey, endTime, endTimey),false)
        --        end
        --    end
        --
        --    --使用次数
        --    if UIActivityDuplicatePanel.mDuplicate.limitTimes ~= nil and UIActivityDuplicatePanel.mDuplicate.limitTimes.list ~= nil then
        --        if UIActivityDuplicatePanel.mDuplicate.id == 9501 then
        --            local openQuickGet = false
        --            if CS.CSScene.MainPlayerInfo.ShengyuSpaceUseNum == 0 then
        --                openQuickGet = true
        --            end
        --            self:AddConditionContent("剩余次数",tostring(CS.CSScene.MainPlayerInfo.ShengyuSpaceUseNum),openQuickGet)
        --        end
        --    end
        --    --特殊显示条件参数
        --    if UIActivityDuplicatePanel.mDuplicate.parame ~= nil and UIActivityDuplicatePanel.mDuplicate.parame.list ~= nil then
        --        for k,v in pairs(UIActivityDuplicatePanel.mDuplicate.parame.list) do
        --            if v == luaEnumAcitivityDuplicateSpecialConditionType.Warxun then
        --                local prefixId = CS.CSScene.MainPlayerInfo.PrefixId
        --                if prefixId == 0 then
        --                    self:AddConditionContent("可去层数","无",false)
        --                else
        --                    local prefixIsFind,prefixInfo = CS.Cfg_PrefixTableManager.Instance:TryGetValue(prefixId)
        --                    if prefixIsFind then
        --                        local maxStorey = (prefixInfo.group - 1)*10 + prefixInfo.classNumber
        --                        local minStorey
        --                        if maxStorey - 5 >= 0 then
        --                            minStorey = maxStorey - 5
        --                        else
        --                            minStorey = 0
        --                        end
        --                        self:AddConditionContent("可去层数",string.format("%d - %d",minStorey,maxStorey),false)
        --                    end
        --                end
        --            end
        --        end
        --    end
        --

        --endregion
    end
    UIBattleDreamlandPanel.InitUI()
    UIBattleDreamlandPanel.ShowReward()
end

--- 初始化组件
function UIBattleDreamlandPanel:InitComponents()
    ---@type Top_UILabel 标题
    UIBattleDreamlandPanel.title = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel")
    ---@type Top_UILabel 描述
    UIBattleDreamlandPanel.details = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel")
    ---@type Top_UILabel 活动时间限制
    -- UIBattleDreamlandPanel.timeDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/timeDes", "Top_UILabel")
    ---@type Top_UILabel 等级要求限制
    UIBattleDreamlandPanel.levelDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/levelDes", "Top_UILabel")
    ---@type Top_UIGridContainer 奖励物品
    UIBattleDreamlandPanel.Awards = self:GetCurComp("WidgetRoot/Awards", "Top_UIGridContainer")
    ---@type Top_UILabel 使用梦境时间/最大梦境时间
    -- UIBattleDreamlandPanel.timeOne = self:GetCurComp("WidgetRoot/eventcostTwo", "Top_UILabel")
    ---@type Top_UILabel 剩余梦境时间
    UIBattleDreamlandPanel.eventcost = self:GetCurComp("WidgetRoot/eventcost", "Top_UILabel")
    ---@type Top_UISlider
    --UIBattleDreamlandPanel.Slider = self:GetCurComp("WidgetRoot/Slider", "Top_UISlider")
    ---@type Top_UISprite 时间添加按钮
    UIBattleDreamlandPanel.btn_add = self:GetCurComp("WidgetRoot/eventcost/btn_add", "Top_UISprite")
    ---@type UnityEngine.GameObject 时间添加按钮 呼吸闪烁
    UIBattleDreamlandPanel.btn_addTweenAlpha = self:GetCurComp("WidgetRoot/eventcost/btn_add", "Top_TweenAlpha")
    ---@type UnityEngine.GameObject 关闭按钮
    UIBattleDreamlandPanel.CloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 进入活动按钮
    UIBattleDreamlandPanel.EnterBtn = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    ---@type Top_UIDropDown 下拉列表
    UIBattleDreamlandPanel.DropDown = self:GetCurComp("WidgetRoot/eventcostTwo/DropDown", "Top_UIDropDown")
end

function UIBattleDreamlandPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIBattleDreamlandPanel.CloseBtn).onClick = UIBattleDreamlandPanel.OnClickCloseBtn
    --点击进入活动事件
    CS.UIEventListener.Get(UIBattleDreamlandPanel.EnterBtn).onClick = UIBattleDreamlandPanel.OnClickEnterBtn
    --点击添加时间事件
    CS.UIEventListener.Get(UIBattleDreamlandPanel.btn_add.gameObject).onClick = UIBattleDreamlandPanel.OnClickbtn_add
    UIBattleDreamlandPanel.DropDown.OnValueChange:Add(UIBattleDreamlandPanel.OnChangeDropDown)

    CS.UIEventListener.Get(UIBattleDreamlandPanel.GetBtnHelp_GameObject()).onClick = function()
        if (UIBattleDreamlandPanel.mHelpId ~= nil) then
            local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(UIBattleDreamlandPanel.mHelpId)
            if isFind then
                uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
            end
        end
    end
end

function UIBattleDreamlandPanel.BindNetMessage()
    UIBattleDreamlandPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResWolfDreamTimeMessage, UIBattleDreamlandPanel.OnResWolfDreamTimeMessageCallBack)
    UIBattleDreamlandPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIBattleDreamlandPanel.OnMainPlayerBeginWalkCallBack)
end

--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIBattleDreamlandPanel')
end

--点击进入活动函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandPanel.OnClickEnterBtn(go)
    if CS.CSScene.MainPlayerInfo ~= nil then
        --if UIBattleDreamlandPanel.limitLevel > CS.CSScene.MainPlayerInfo.Level then
        --    UIBattleDreamlandPanel.ShowTips(go, 58)
        --    return
        --end
        if UIBattleDreamlandPanel.mDuplicateInfo == nil then
            return
        end
        ---判断等级
        local isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(UIBattleDreamlandPanel.mDuplicateInfo.condition)
        if not isMeet then
            Utility.ShowPopoTips(go.transform, nil, 321)
            return
        end
        --判断战勋
        if not UIBattleDreamlandPanel.curLYMJInfo.isCan then
            Utility.ShowPopoTips(go.transform, nil, 58)
            return
        end
        --判断物品
        if CS.CSScene.MainPlayerInfo.DuplicateV2 ~= nil then
            local duplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2
            if duplicateInfo.RemainTime <= 0 then
                local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIBattleDreamlandPanel.fireworkID)
                --背包内是否有烟花
                if count ~= 0 then
                    local isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(CS.Cfg_GlobalTableManager.Instance.ShowTipsConditionID)
                    --是否满足显示弹窗
                    if isMeet then
                        UIBattleDreamlandPanel.ShowDisposeOrePanel(count)
                        return
                    end
                end
                Utility.ShowPopoTips(go.transform, nil, 56)
                return
            end
            if duplicateInfo.UseTime >= duplicateInfo.MaxTime then
                Utility.ShowPopoTips(go.transform, nil, 57)
                return
            end
        end
    end

    local deliverInfoIsFind, deliverInfo = CS.Cfg_DeliverTableManager.Instance:TryGetValue(UIBattleDreamlandPanel.duplicateId)
    if deliverInfoIsFind then
        if deliverInfo.item == nil or deliverInfo.item == "" then
            Utility.ReqEnterDuplicate(UIBattleDreamlandPanel.duplicateId)
            uimanager:ClosePanel('UIBattleDreamlandPanel')
            uimanager:ClosePanel("UIMonsterHeadPanel")
        else
            local enterUseItem = string.Split(deliverInfo.item, '#')
            local enterUseItemId = enterUseItem[1]
            local enterUseItemCount = enterUseItem[2]
            local bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(enterUseItemId)
            if bagItemCount >= enterUseItemCount then
                Utility.ReqEnterDuplicate(UIBattleDreamlandPanel.duplicateId)
                uimanager:ClosePanel('UIBattleDreamlandPanel')
                uimanager:ClosePanel("UIMonsterHeadPanel")
            else
                ---使用道具不足
                Utility.ShowPopoTips(go.trans, nil, 60)
            end
        end
    else
        ---没有deliverid
        Utility.ShowPopoTips(go.trans, nil, 60)
    end
end

--点击添加时间函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandPanel.OnClickbtn_add(go)
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIBattleDreamlandPanel.fireworkID)
    if count == 0 then
        Utility.ShowItemGetWay(UIBattleDreamlandPanel.fireworkID, go, LuaEnumWayGetPanelArrowDirType.Down);
    else
        UIBattleDreamlandPanel.ShowDisposeOrePanel(count)
    end
end

function UIBattleDreamlandPanel.OnChangeDropDown(data)
    UIBattleDreamlandPanel.duplicateId = tonumber(data.ExtraData)
    UIBattleDreamlandPanel.curLYMJInfo = UIBattleDreamlandPanel.allShowLYMJDic[UIBattleDreamlandPanel.duplicateId]
end

--endregion

--region 网络消息处理
function UIBattleDreamlandPanel.OnResWolfDreamTimeMessageCallBack()
    UIBattleDreamlandPanel.RefreshTime()
end

function UIBattleDreamlandPanel.OnMainPlayerBeginWalkCallBack()
    uimanager:ClosePanel('UIBattleDreamlandPanel')
end
--endregion

--region UI

function UIBattleDreamlandPanel.InitUI()

    --[[    if UIBattleDreamlandPanel.mDuplicateInfo ~= nil then
            --等级
            --if UIBattleDreamlandPanel.mDuplicateInfo.condition ~= nil then
            --    local isFind, item = CS.Cfg_ConditionManager.Instance:TryGetValue(UIBattleDreamlandPanel.mDuplicateInfo.condition)
            --    if isFind then
            --        UIBattleDreamlandPanel.limitLevel = item.conditionParam.list[0]
            --        UIBattleDreamlandPanel.levelDes.text = UIBattleDreamlandPanel.limitLevel .. '级以上'
            --    end
            --end

            --军衔
            if UIBattleDreamlandPanel.mDuplicateInfo.condition ~= nil then
                local isFind, item = CS.Cfg_ConditionManager.Instance:TryGetValue(UIBattleDreamlandPanel.mDuplicateInfo.condition)
                if isFind then
                    UIBattleDreamlandPanel.limitPrefix = item.conditionParam.list[0]
                    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
                    local prefixStr = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(UIBattleDreamlandPanel.limitPrefix, career)
                    UIBattleDreamlandPanel.levelDes.text = '达到' .. prefixStr
                end
            end
            --标题
            local isFind, item = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(UIBattleDreamlandPanel.mDuplicateInfo.openTime)
            if isFind then
                if item.deliverId ~= nil then
                    UIBattleDreamlandPanel.mDailyActivityTime = item
                    UIBattleDreamlandPanel.mDeliverId = item.deliverId
                end
                UIBattleDreamlandPanel.title.text = item.name
            end
        end]]
    --活动介绍
    local isFind, item = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(UIBattleDreamlandPanel.descriptionId)
    if isFind then
        UIBattleDreamlandPanel.details.text = string.gsub(item.value, '\\n', '\n')
    end
    UIBattleDreamlandPanel.RefreshTime()
    UIBattleDreamlandPanel.InitDropDown()

end

---显示奖励
function UIBattleDreamlandPanel.ShowReward()
    if UIBattleDreamlandPanel.mDuplicateInfo == nil then
        return
    end
    local data = CS.Cfg_DuplicateTableManager.Instance:GetRewardItemIds(UIBattleDreamlandPanel.mDuplicateInfo)
    UIBattleDreamlandPanel.Awards.MaxCount = data.Count
    for i = 0, data.Count - 1 do
        local go = UIBattleDreamlandPanel.Awards.controlList[i]
        local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
        template:RefreshUI(data[i], nil)
    end
end

function UIBattleDreamlandPanel.RefreshTime()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local duplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    --已用
    local usedTime = duplicateInfo.UseTime
    --可用
    local uesrTime = duplicateInfo.MaxTime - usedTime
    --local fill = uesrTime / duplicateInfo.MaxTime
    --local color = duplicateInfo.UseTime / duplicateInfo.MaxTime >= 1 and luaEnumColorType.Red or luaEnumColorType.Green
    --UIBattleDreamlandPanel.Slider.value = fill
    --CS.UnityEditor.EditorApplication.isPaused = true
    --string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
    local isShowAlpha = true
    local hour, minute, second, decimal, str, str2
    if uesrTime == 0 then
        str = '今日上限耗尽'
        isShowAlpha = false
    else
        hour, minute, second = Utility.MillisecondToFormatTime(uesrTime)
        hour, decimal = math.modf(hour)
        minute, decimal = math.modf(minute)
        --second, decimal = math.modf(second)
        str = '今日剩余上限'
        minute = minute + hour * 60
        --str = hour == 0 and str or str .. hour .. '小时'
        str = minute == 0 and str or str .. minute .. '分钟'
    end
    if duplicateInfo.RemainTime ~= 0 then
        hour, minute, second = Utility.MillisecondToFormatTime(duplicateInfo.RemainTime)
        hour, decimal = math.modf(hour)
        minute, decimal = math.modf(minute)
        second, decimal = math.modf(second)
        str2 = ''
        str2 = hour == 0 and str2 or str2 .. hour .. '时'
        str2 = minute == 0 and str2 or str2 .. minute .. '分'
        str2 = second == 0 and str2 or str2 .. second .. '秒'
        isShowAlpha = false
    else
        str2 = '[e85038]无可用时间[-]'
    end
    UIBattleDreamlandPanel.btn_add.spriteName = isShowAlpha and 'add_small' or 'add_small2'
    UIBattleDreamlandPanel.btn_addTweenAlpha.enabled = isShowAlpha
    UIBattleDreamlandPanel.eventcost.text = luaEnumColorType.Green .. str2 .. '[-][878787](' .. str .. ')[-]'
end

---初始化下拉列表
function UIBattleDreamlandPanel.InitDropDown()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    ---@type  System.Collections.Generic.List1T<CS.LYMJDuplicateInfo> 狼烟梦境副本信息列表
    local meetList = CS.CSScene.MainPlayerInfo.DuplicateV2:GetMeetShowLYMJList()
    local namelist = {}
    local idList = {}
    local length = meetList.Count - 1
    local isCanEnter = false
    local selectDuplicateInfo = nil
    for i = length, 0, -1 do
        local nameStr = ''
        local prefixName = meetList[i].showStr == nil and '  ' or '  (' .. meetList[i].showStr .. ')'
        if meetList[i].isCan then
            nameStr = luaEnumColorType.Green .. meetList[i].mapName .. '[-][878787]' .. prefixName .. '[-]'
        else
            nameStr = luaEnumColorType.Gray2 .. meetList[i].mapName .. prefixName
        end
        table.insert(idList, meetList[i].duplicateId)
        table.insert(namelist, nameStr)
        UIBattleDreamlandPanel.allShowLYMJDic[meetList[i].duplicateId] = meetList[i]
        --记录可以进入的层数
        if meetList[i].isCan and not isCanEnter then
            isCanEnter = true
            if selectDuplicateInfo == nil then
                selectDuplicateInfo = {}
            end
            local lastPrefixName = meetList[i].showStr == nil and '  ' or '  (' .. meetList[i].showStr .. ')'
            selectDuplicateInfo.showStr = luaEnumColorType.Green .. meetList[i].mapName .. '[-][878787]' .. lastPrefixName .. '[-]'
            selectDuplicateInfo.info = meetList[i]
            selectDuplicateInfo.duplicateId = meetList[i].duplicateId
        end
    end

    if selectDuplicateInfo ~= nil then
        --如果有可进层，设置显示
        UIBattleDreamlandPanel.DropDown:SetCaptionLabel(selectDuplicateInfo.showStr, selectDuplicateInfo.duplicateId)
        UIBattleDreamlandPanel.duplicateId = selectDuplicateInfo.duplicateId
        UIBattleDreamlandPanel.curLYMJInfo = selectDuplicateInfo.info
    elseif selectDuplicateInfo == nil and meetList.Count ~= 0 then
        --如果无可进层，默认取第一个并置灰
        local showStr = ''
        local prefixName = meetList[0].showStr == nil and '  ' or '  (' .. meetList[0].showStr .. ')'
        showStr = luaEnumColorType.Gray2 .. meetList[0].mapName .. prefixName
        UIBattleDreamlandPanel.DropDown:SetCaptionLabel(showStr, meetList[0].duplicateId)

        UIBattleDreamlandPanel.duplicateId = meetList[0].duplicateId
        UIBattleDreamlandPanel.curLYMJInfo = meetList[0]
    end
    UIBattleDreamlandPanel.DropDown:SetOptions(namelist, idList)
end


--endregion

--region otherFunction

function UIBattleDreamlandPanel.ShowBattleTips()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20424)
    if isFind then
        local str = info.value
        str = string.Split(str, '#')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = function()
            UIBattleDreamlandPanel.TipsBtnCallBack()
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

---烟花tips点击回调
function UIBattleDreamlandPanel.TipsBtnCallBack()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandPanel.fireworkID)
    ----是否超出界限
    if CS.CSScene.MainPlayerInfo.DuplicateV2.IsOutOfBounds then
        local CallBack = function()
            UIBattleDreamlandPanel.UseFirworkItem(1, itemInfo.lid)
            uimanager:ClosePanel('UIPromptPanel')
        end
        UIBattleDreamlandPanel.ShowBattleSecondTips(CallBack)
    else
        UIBattleDreamlandPanel.UseFirworkItem(1, itemInfo.lid)
        uimanager:ClosePanel('UIPromptPanel')
    end
end

---显示使用烟花面板
function UIBattleDreamlandPanel.ShowDisposeOrePanel(count)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local duplicateinfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    local maxCount = duplicateinfo:SelectFireworkCount(count)
    local info = {}
    info.itemid = UIBattleDreamlandPanel.fireworkID
    info.price = 0
    info.minValue = 1
    info.maxValue = maxCount == 0 and 1 or maxCount
    info.curValue = maxCount == 0 and 1 or maxCount
    info.isDesprice = true
    info.IsShowItemTips = true
    info.rightBtnLabel = '使用'
    info.rightBtnCallBack = function(panel)
        if panel then
            if duplicateinfo.isBoundMaxDay then
                Utility.ShowPopoTips(panel.dispose.transform, nil, 85)
                return
            end
            if duplicateinfo:IsOutOfBoundsOfCount(panel.num) then
                local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandPanel.fireworkID)
                local callback = function()
                    UIBattleDreamlandPanel.UseFirworkItem(panel.num, itemInfo.lid)
                end
                UIBattleDreamlandPanel.ShowBattleSecondTips(callback)
                return
            end
            local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandPanel.fireworkID)
            UIBattleDreamlandPanel.UseFirworkItem(panel.num, itemInfo.lid)
        end
    end
    uimanager:CreatePanel("UIDisposeOrePanel", nil, info)
end

---尝试使用烟花
function UIBattleDreamlandPanel.TryUseFirworkItem(panel)
    if panel == nil then
        return
    end
    local duplicateinfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    --是否超过每日上限
    if duplicateinfo.isBoundMaxDay then
        Utility.ShowPopoTips(panel.dispose.transform, nil, 85)
        return
    end
    --是否超过界限（非每日上限）
    if duplicateinfo:IsOutOfBoundsOfCount(panel.num) then
        local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandPanel.fireworkID)
        local callback = function()
            UIBattleDreamlandPanel.UseFirworkItem(panel.num, itemInfo.lid)
        end
        UIBattleDreamlandPanel.ShowBattleSecondTips(callback)
        return
    end
    local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandPanel.fireworkID)
    UIBattleDreamlandPanel.UseFirworkItem(panel.num, itemInfo.lid)
end

---时间溢出tips
function UIBattleDreamlandPanel.ShowBattleSecondTips(callback)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20413)
    if isFind then
        local str = info.value
        str = string.Split(str, '#')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        --temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = callback
        local panel = uimanager:GetPanel('UIPromptPanel')
        if panel then
            panel:Show(temp)
        else
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    end
end

---使用烟花
function UIBattleDreamlandPanel.UseFirworkItem(count, lid)
    networkRequest.ReqUseItem(count, lid, 0)
    uiStaticParameter.isCanCallBackHide = true
    uiStaticParameter.isHideFireworkPanel = true
    --uimanager:CreatePanel("UIWindowPlaneMaskPanel", nil)
    uimanager:ClosePanel('UIBattleDreamlandPanel')
end

--endregion

--region ondestroy

function ondestroy()
    uimanager:ClosePanel('UIPromptPanel')
    uimanager:ClosePanel('UIDisposeOrePanel')
end

--endregion

return UIBattleDreamlandPanel