--活動副本
---@class UIActivityDuplicatePanel:UIBase
local UIActivityDuplicatePanel = { }

UIActivityDuplicatePanel.panelName = ''
UIActivityDuplicatePanel.itemID = 1
UIActivityDuplicatePanel.limitLevel = 0
UIActivityDuplicatePanel.mHelpId = nil;
UIActivityDuplicatePanel.ChooseFloor = 1;

--region 组件
function UIActivityDuplicatePanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return self.mBtnHelp_GameObject;
end

--region 王者禁地组件
---@return UnityEngine.GameObject 王者禁地按钮节点
function UIActivityDuplicatePanel:GetWZJDComp_GO()
    if self.mWZJDCompGo == nil then
        self.mWZJDCompGo = self:GetCurComp("WidgetRoot/eventcostWZJD", "GameObject")
    end
    return self.mWZJDCompGo
end

---@return UnityEngine.GameObject 选择列表
function UIActivityDuplicatePanel:GetWZJDLocation_GO()
    if self.mWZJDLocationGo == nil then
        self.mWZJDLocationGo = self:GetCurComp("WidgetRoot/eventcostWZJD/Location", "GameObject")
    end
    return self.mWZJDLocationGo
end

---@return UIGridContainer container
function UIActivityDuplicatePanel:GetWZJDLocation_UIGridContainer()
    if self.mWZJDLocationContainer == nil then
        self.mWZJDLocationContainer = self:GetCurComp("WidgetRoot/eventcostWZJD/Location/LocationList/Grid", "UIGridContainer")
    end
    return self.mWZJDLocationContainer
end

---@return UISprite
function UIActivityDuplicatePanel:GetWZJDIcon_UISprite()
    if self.mWZJDIcon == nil then
        self.mWZJDIcon = self:GetCurComp("WidgetRoot/eventcostWZJD/icon", "UISprite")
    end
    return self.mWZJDIcon
end

---@return UnityEngine.GameObject 选择列表开启按钮
function UIActivityDuplicatePanel:GetWZJDOpenChooseListBtn_GO()
    if self.mWZJDOpenChooseListBtn == nil then
        self.mWZJDOpenChooseListBtn = self:GetCurComp("WidgetRoot/eventcostWZJD/btn_add", "GameObject")
    end
    return self.mWZJDOpenChooseListBtn
end

---@return UnityEngine.GameObject 选择列表关闭按钮
function UIActivityDuplicatePanel:GetWZJDCloseChooseListBtn_GO()
    if self.mWZJDCloseChooseListBtn == nil then
        self.mWZJDCloseChooseListBtn = self:GetCurComp("WidgetRoot/eventcostWZJD/Location/block", "GameObject")
    end
    return self.mWZJDCloseChooseListBtn
end

---@return UILabel
function UIActivityDuplicatePanel:GetShowChooseLb()
    if self.mShowChooseLb == nil then
        self.mShowChooseLb = self:GetCurComp("WidgetRoot/eventcostWZJD/label", "UILabel")
    end
    return self.mShowChooseLb
end

---@return UnityEngine.GameObject 进入副本消耗道具
function UIActivityDuplicatePanel:GetCostGo()
    if self.mCostGo == nil then
        self.mCostGo = self:GetCurComp("WidgetRoot/cost", "GameObject")
    end
    return self.mCostGo
end

---@return UISprite icon
function UIActivityDuplicatePanel:GetCostIcon_UISprite()
    if self.mCostIcon == nil then
        self.mCostIcon = self:GetCurComp("WidgetRoot/cost/icon", "UISprite")
    end
    return self.mCostIcon
end

---@return UILabel 花费文本
function UIActivityDuplicatePanel:GetCostNum_UILabel()
    if self.mCostLb == nil then
        self.mCostLb = self:GetCurComp("WidgetRoot/cost/num", "UILabel")
    end
    return self.mCostLb
end

---@type UnityEngine.GameObject 花费道具add
function UIActivityDuplicatePanel:GetCostAdd_GO()
    if self.mCostAddGo == nil then
        self.mCostAddGo = self:GetCurComp("WidgetRoot/cost/add", "GameObject")
    end
    return self.mCostAddGo
end

--endregion

--endregion

function UIActivityDuplicatePanel:Init()
    self:InitComponents()
    self:InitOther()
    self:BindEvents()
    self:BindMessage()
end

--通过工具生成 控件变量
function UIActivityDuplicatePanel:InitComponents()
    --活动名字
    self.mTitleName_UILabel = self:GetCurComp("WidgetRoot/window/title", "UILabel")
    --活动介绍
    self.mIntroduce_UILabel = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "UILabel")
    --活动奖励列表
    self.mAwardList_UIGrid = self:GetCurComp("WidgetRoot/Awards", "UIGridContainer")
    --关闭按钮
    self.mCloseBtn_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    --进入活动按钮
    self.mEnterBtn_GameObject = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    ---说明文本标题
    self.mIntroduceTitle_GameObject = self:GetCurComp("WidgetRoot/introduce/labelGroup/title", "GameObject")
    ---商会提示文本
    self.mCommerceTipsLabel = self:GetCurComp("WidgetRoot/introduce/labelGroup/commerce", "UILabel")
    ---商会入会按钮
    self.mCommerceButton = self:GetCurComp("WidgetRoot/introduce/labelGroup/commerce/entercommerceBtn", "GameObject")
    --活动时间
    --UIActivityDuplicatePanel.timeDes = UIActivityDuplicatePanel:GetCurComp("WidgetRoot/introduce/labelGroup/timeDes", "Top_UILabel")
    --等级要求
    --UIActivityDuplicatePanel.levelDes = UIActivityDuplicatePanel:GetCurComp("WidgetRoot/introduce/labelGroup/levelDes", "Top_UILabel")
    --物品限制
    self.eventcost = self:GetCurComp("WidgetRoot/eventcost", "Top_UILabel")
    self.eventcostOtherDesc = self:GetCurComp("WidgetRoot/eventcost/OtherDesc", "Top_UILabel")
    self.eventcost2OtherDesc = self:GetCurComp("WidgetRoot/eventcost2/OtherDesc", "Top_UILabel")

    self.eventcostChooseBG = self:GetCurComp("WidgetRoot/eventcost/choose", "Top_UISprite")
    self.eventcost2ChooseBG = self:GetCurComp("WidgetRoot/eventcost2/choose", "Top_UISprite")

    --Choose1
    self.eventcostChooseBtn = self:GetCurComp("WidgetRoot/eventcost/Sprite", "GameObject")
    --Choose2
    self.eventcost2ChooseBtn = self:GetCurComp("WidgetRoot/eventcost2/Sprite", "GameObject")

    --变强按钮、购买按钮
    self.btn_add = self:GetCurComp("WidgetRoot/eventcost/btn_add", "GameObject")
    self.btn_add2 = self:GetCurComp("WidgetRoot/eventcost2/btn_add", "GameObject")
    --icon
    self.icon_gameObject = self:GetCurComp("WidgetRoot/eventcost/icon", "GameObject")
    self.icon_uiSprite = self:GetCurComp("WidgetRoot/eventcost/icon", "UISprite")

    self.btn_block = self:GetCurComp("WidgetRoot/block", "GameObject")

    --进入条件
    self.enterConditon = self:GetCurComp("WidgetRoot/introduce/enterConditon", "GameObject")
    --条件内容grid
    --self.grid_UIGridContainer = self:GetCurComp("WidgetRoot/introduce/labelGroup/Grid", "UIGridContainer")
end

--初始化 变量 按钮点击 服务器消息事件等
function UIActivityDuplicatePanel:InitOther()
    ---是否为商会会员
    self.mIsCommerce = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce()
    --副本
    self.mDuplicateId = 0
    ---@type TABLE.CFG_DUPLICATE
    self.mDuplicate = nil
    --每日活动
    self.mDailyActivityTimeId = 0
    self.mDailyActivityTime = nil
    --传送
    self.mDeliverId = 0
    self.OnResBagChangeCallBack = function()
        self:RefreshItemCount()
    end

    CS.UIEventListener.Get(self.btn_add).onClick = function()
        self:OnClickUIActivityDuplicatePanel()
    end
    CS.UIEventListener.Get(self.mCloseBtn_GameObject).onClick = function()
        self:OnClickCloseBtn()
    end
    CS.UIEventListener.Get(self.mEnterBtn_GameObject).onClick = function(go)
        self:OnClickEnterBtn(go)
    end
    CS.UIEventListener.Get(self.eventcostChooseBtn).onClick = function(go)
        self:OnClickChoose1Btn(go)
    end
    if CS.StaticUtility.IsNull(self.eventcost2ChooseBtn) == false then
        CS.UIEventListener.Get(self.eventcost2ChooseBtn).onClick = function(go)
            self:OnClickChoose2Btn(go)
        end
    end

    self:BindBlock()
    CS.UIEventListener.Get(self.icon_gameObject).onClick = function()
        self:OnClickIcon()
    end

    if (self:GetBtnHelp_GameObject() ~= nil) then
        CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
            if (self.mHelpId ~= nil) then
                local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(self.mHelpId)
                if isFind then
                    uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
                end
            end
        end
    end

    luaclass.UIRefresh:BindClickCallBack(self:GetCostIcon_UISprite(),function()
        local dupTbl = self.mDuplicate
        local cost = dupTbl.requireItems
        local costInfo = cost.list[0]
        if costInfo.list and costInfo.list.Count >= 2 then
            local itemId = costInfo.list[0]
            local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
            if itemInfoIsFind then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo})
            end

        end
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.OnResBagChangeCallBack)

end

function UIActivityDuplicatePanel:BindEvents()
    CS.UIEventListener.Get(self:GetWZJDOpenChooseListBtn_GO()).onClick = function()
        self:SetChooseList(true)
    end

    CS.UIEventListener.Get(self:GetWZJDCloseChooseListBtn_GO()).onClick = function()
        self:SetChooseList(false)
    end
end

function UIActivityDuplicatePanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCostInfo()
    end)
end

---调整组件
function UIActivityDuplicatePanel:AdjustComponents(extraData)
    if self.mDuplicate ~= nil and self.mDuplicate.type == 4 then
        -----王者禁地副本界面
        self:RefreshComponentByWZJD(extraData)
    end
end

--region 王者禁地

---王者禁地npc界面刷新组件
function UIActivityDuplicatePanel:RefreshComponentByWZJD(extraData)
    self.eventcost.gameObject:SetActive(false)
    self.enterConditon.gameObject:SetActive(false)
    self:GetWZJDComp_GO():SetActive(true)
    self:RefreshChooseDuplicateList()
    --[[    CS.UIEventListener.Get(self.btn_add).onClick = function()
            uimanager:CreatePanel("UICommercePanel")
            uimanager:ClosePanel("UIActivityDuplicatePanel")
        end
        CS.UIEventListener.Get(self.btn_add2).onClick = function()
            Utility.TransferShopChooseItem(14010001)
        end

        if self.mIsCommerce == false then
            self.eventcostOtherDesc.text = "[e85038]王者禁地[-][878787](商会会员专属)[-]"
            self.eventcost2OtherDesc.text = "[e85038]禁地二层[-][878787](盟重商会专属)[-]"
            ---未入会时
        else
            --self.eventcostChooseBG.gameObject:SetActive(true)
            local mCardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(1)
            self.eventcostOtherDesc.text = "[00ff00]王者禁地[-]"
            if (mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.MENGZHONGCARD) or mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD)) then
                self.eventcost2OtherDesc.text = "[00ff00]禁地二层[-]"
                self.btn_add2.gameObject:SetActive(false)
            else
                self.eventcost2OtherDesc.text = "[e85038]禁地二层[-][878787](盟重商会专属)[-]"
            end

            self.btn_add.gameObject:SetActive(false)
            -----入会时
        end]]
    self:GetWZJDIcon_UISprite().spriteName = "king_icon1"
    self:ChooseFirstDup(extraData)
end

---刷新选择副本列表
function UIActivityDuplicatePanel:RefreshChooseDuplicateList()
    local showDuplicate = self:GetChooseDuplicateList()
    if showDuplicate then
        self:GetWZJDLocation_UIGridContainer().MaxCount = showDuplicate.Count
        for i = 0, self:GetWZJDLocation_UIGridContainer().controlList.Count - 1 do
            ---@type TABLE.CFG_DUPLICATE
            local dupTbl = showDuplicate[i]
            local go = self:GetWZJDLocation_UIGridContainer().controlList[i]
            ---@type UILabel
            local lb = CS.Utility_Lua.Get(go.transform, "lb_location", "UILabel")
            local show, success = self:GetWZJDChooseLbShow(dupTbl)
            local color = success and luaEnumColorType.Green or luaEnumColorType.Gray
            lb.text = color .. dupTbl.name .. "[-]" .. luaEnumColorType.Gray .. "(" .. show .. "会员专属 )"
            CS.UIEventListener.Get(go).onClick = function()
                self:SetChooseList(false)
                self:ChooseDuplicate(dupTbl)
            end
        end
    end
end

---设置副本默认选中
function UIActivityDuplicatePanel:ChooseFirstDup(extraData)
    if extraData then
        local res, dupInfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(extraData)
        if res then
            self:ChooseDuplicate(dupInfo)
            return
        end
    end
    local firstDup = self:GetChooseDuplicateList()
    if firstDup and firstDup.Count > 0 then
        local info = firstDup[0]
        self:ChooseDuplicate(info)
    end
end

---@class DuplicateCanEnter
---@field costID number 需要消耗的道具id
---@field costName string 需要消耗的道具名字
---@field success boolean 商会是否满足
---@field costEnough boolean 消耗道具是否足够

---@param dupTbl TABLE.CFG_DUPLICATE 需要选中的副本
function UIActivityDuplicatePanel:ChooseDuplicate(dupTbl)
    if dupTbl == nil then
        return
    end
    ---@type DuplicateCanEnter 当前是否可进入
    self.mCurrentChooseDuplicateInfo = {}

    self:ChangeCurrentDuplicateTbl(dupTbl)

    ---商会条件
    local show, success = self:GetWZJDChooseLbShow(dupTbl)
    local color = success and luaEnumColorType.Green or luaEnumColorType.Red
    self:GetShowChooseLb().text = color .. dupTbl.name .. "[-]" .. luaEnumColorType.Gray .. "(" .. show .. "会员专属 )"

    self.mCurrentChooseDuplicateInfo.success = success
    self:RefreshCostInfo()

    self.curcount = 0
    self.maxCount = 0
end

---刷新花费道具
function UIActivityDuplicatePanel:RefreshCostInfo()
    local dupTbl = self.mDuplicate
    if self.mCurrentChooseDuplicateInfo == nil then
        self.mCurrentChooseDuplicateInfo = {}
    end

    ---消耗道具
    local costId = 0
    local costName = ""
    local costCanEnter = true
    local cost = dupTbl.requireItems
    local hasCost = cost and cost.list and cost.list.Count > 0
    if hasCost then
        local costInfo = cost.list[0]
        if costInfo.list and costInfo.list.Count >= 2 then
            local itemId = costInfo.list[0]
            local num = costInfo.list[1]
            local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemId)
            costId = itemId
            costCanEnter = playerHas >= num
            local costColor = costCanEnter and luaEnumColorType.Green or luaEnumColorType.Red
            ---@type TABLE.CFG_ITEMS
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(costId)
            if res then
                self:GetCostIcon_UISprite().spriteName = itemInfo.icon
                costName = itemInfo.name
                CS.UIEventListener.Get(self:GetCostIcon_UISprite().gameObject).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
                end
            end

            self:GetCostNum_UILabel().text = Utility.CombineStringQuickly(costColor, playerHas, "[-]/", num)
            CS.UIEventListener.Get(self:GetCostAdd_GO()).onClick = function()
                Utility.ShowItemGetWay(costId, self:GetCostAdd_GO(), LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
            end
        end
    end

    self.mCurrentChooseDuplicateInfo.costEnough = costCanEnter
    self.mCurrentChooseDuplicateInfo.costName = costName
    self.mCurrentChooseDuplicateInfo.costID = costId

    self:GetCostGo():SetActive(hasCost)
end

---@return string,boolean 获取王者禁地选项文本,是否满足条件
function UIActivityDuplicatePanel:GetWZJDChooseLbShow(dupTbl)
    if dupTbl == nil then
        return "", false
    end
    local conditionId = dupTbl.condition
    ---@type LuaMatchConditionResult
    local full = Utility.IsMainPlayerMatchCondition(conditionId)
    if full ~= nil then

        local showInfo = full.mMothCardList
        local name = ""
        if showInfo then
            if showInfo.Count == 1 then
                name = showInfo[0] == 1 and "比奇" or "盟重"
            elseif showInfo.Count > 1 then
                name = "商会"
            end
        end
        return name, full.success
    end
    return "", false
end

---设置选项显示
function UIActivityDuplicatePanel:SetChooseList(isShow)
    self:GetWZJDLocation_GO():SetActive(isShow)
end

---@return table<number,TABLE.CFG_DUPLICATE> 副本信息
function UIActivityDuplicatePanel:GetChooseDuplicateList()
    if self.mDuplicateList == nil then
        self.mDuplicateList = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(4)
    end
    return self.mDuplicateList
end

--endregion

function UIActivityDuplicatePanel:BindBlock()
    CS.UIEventListener.Get(self.btn_block).onClick = function()
        self:OnClickCloseBtn()
    end
end

---显示
---@param duplicateId number 副本ID
---@param descriptionId number 描述id
---@param extraData number 额外参数/用于王者禁地判断凭证
function UIActivityDuplicatePanel:Show(duplicateId, descriptionId, helpId, extraData)
    if descriptionId == nil or descriptionId == nil then
        return
    end
    if (helpId ~= nil) then
        self.mHelpId = helpId;
    end
    self:InitParams()
    self:AddParams(duplicateId, descriptionId)
    self:AdjustComponents(extraData)
end

function UIActivityDuplicatePanel:AddParams(duplicateId, descriptionId)
    --副本
    self.mDuplicateId = duplicateId
    local isFind, item = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateId)
    if isFind then

        self:ChangeCurrentDuplicateTbl(item)
        --活动奖励
        local data = CS.Cfg_DuplicateTableManager.Instance:GetRewardItemIds(self.mDuplicate);
        self.mAwardList_UIGrid.MaxCount = data.Count
        for i = 0, self.mAwardList_UIGrid.controlList.Count - 1 do
            local template = templatemanager.GetNewTemplate(self.mAwardList_UIGrid.controlList[i], luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
            template:RefreshUI(data[i], nil)
        end
        --每日活动
        self.mDailyActivityTimeId = item.openTime

        --战力限制
        if item.requireItems ~= nil then


            self.itemId = item.requireItems.list[0].list[0]
            self.maxCount = item.requireItems.list[0].list[1]
            if item.requireItems.list[0].list.Count > 2 then
                self.itemIdTwo = item.requireItems.list[0].list[2]
            end
            self:RefreshItemCount()
            isFind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.itemId)
            if isFind then
                CS.Utility_Lua.GetComponent(self.eventcost.transform:Find('icon'), "Top_UISprite").spriteName = item.icon
                self.mConditionItem = item
            end
            self.panelName = 'UIShopPanel'
        elseif item.recommendFightCap ~= nil and item.recommendFightCap ~= "" and CS.CSScene.MainPlayerInfo ~= nil then
            self.eventcost.text = CS.Utility_Lua.SetProgressLabelColor(item.recommendFightCap, CS.CSScene.MainPlayerInfo.FightPower)
            CS.Utility_Lua.GetComponent(self.eventcost.transform:Find('icon'), "Top_UISprite").spriteName = '1000012'
            self.panelName = 'bianqiang'
        else
            self.eventcost.gameObject:SetActive(false)
            self.enterConditon.gameObject:SetActive(false)
        end

        --时间
        if self.mDuplicate.openTime ~= 0 then
            isFind, item = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self.mDuplicate.openTime)
            if isFind then
                --[[
                local startTime, startTimey = math.modf(item.startTime / 60)
                local endTime, endTimey = math.modf(item.overTime / 60)
                startTimey = startTimey >= 10 and startTimey or startTimey .. '0'
                endTimey = endTimey >= 10 and endTimey or endTimey .. '0'
                --local time =  string.format("%02.0f:%02.0f - %02.0f:%02.0f", startTime, startTimey, endTime, endTimey)
                --]]
                --UIActivityDuplicatePanel.timeDes.text = string.format("%02.0f:%02.0f - %02.0f:%02.0f", startTime, startTimey, endTime, endTimey)
                local startTimeHour = math.floor(item.startTime / 60)
                local startTimeMinutes = math.floor(item.startTime % 60)
                local endTimeHour = math.floor(item.overTime / 60)
                local endTimeMinutes = math.floor(item.overTime % 60)
                local time = string.format("%02s:%02s - %02s:%02s", startTimeHour, startTimeMinutes, endTimeHour, endTimeMinutes)
                self:AddConditionContent("活动时间", time, false)
            end
        end

        --使用次数
        if self.mDuplicate.limitTimes ~= nil and self.mDuplicate.limitTimes.list ~= nil then
            --圣域空间使用次数
            if self.mDuplicate.id == 9501 then
                local openQuickGet = false
                local callBack = nil
                if CS.CSScene.MainPlayerInfo.ShengyuSpaceUseNum == 0 then
                    openQuickGet = true
                    local goldInfo = CS.Cfg_GlobalTableManager.Instance:GetShengyuGoldInfo()
                    local goldItemid = 0
                    local singlePrice = 0
                    if goldInfo.Length >= 2 then
                        goldItemid = tonumber(goldInfo[0])
                        singlePrice = tonumber(goldInfo[1])
                    end
                    local goldItemInfoIsFind, goldItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(goldItemid)
                    local QuickGetCustomData = {
                        goldItemInfo = goldItemInfo,
                        singlePrice = singlePrice,
                        minBuyCount = 0,
                        maxBuyCount = 10,
                        ensureCallBack = function(buyNum)
                            networkRequest.ReqButSanctuaryCount(buyNum)
                        end
                    }
                    callBack = function()
                        uimanager:CreatePanel("UIItemNoiconCountPanel", nil, QuickGetCustomData)
                    end
                end
                self:AddConditionContent("剩余次数", tostring(CS.CSScene.MainPlayerInfo.ShengyuSpaceUseNum), openQuickGet, callBack)
            end
        end
        --特殊显示条件参数
        if self.mDuplicate.parame ~= nil and self.mDuplicate.parame.list ~= nil then
            for k, v in pairs(self.mDuplicate.parame.list) do
                if v == luaEnumAcitivityDuplicateSpecialConditionType.Warxun then
                    local prefixId = CS.CSScene.MainPlayerInfo.PrefixId
                    if prefixId == 0 then
                        self:AddConditionContent("可去层数", "无", false)
                    else
                        local prefixIsFind, prefixInfo = CS.Cfg_PrefixTableManager.Instance:TryGetValue(prefixId)
                        if prefixIsFind then
                            local maxStorey = (prefixInfo.group - 1) * 10 + prefixInfo.classNumber
                            local minStorey
                            if maxStorey - 4 >= 0 then
                                minStorey = maxStorey - 4
                            else
                                minStorey = 0
                            end
                            self:AddConditionContent("可去层数", string.format("%d - %d", minStorey, maxStorey), false)
                        end
                    end
                end
            end
        end

        --等级
        if item.condition ~= nil then
            isFind, item = CS.Cfg_ConditionManager.Instance:TryGetValue(self.mDuplicate.condition)
            if isFind then
                UIActivityDuplicatePanel.limitLevel = item.conditionParam.list[0]
                self:AddConditionContent("等级要求", UIActivityDuplicatePanel.limitLevel .. '级以上')
                --UIActivityDuplicatePanel.levelDes.text = item.conditionParam.list[0] .. '级以上'
                --UIActivityDuplicatePanel.levelDes.gameObject:SetActive(true)
            end
        end

        --传送
        isFind, item = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(descriptionId)
        if isFind then
            self.mIntroduce_UILabel.text = string.gsub(item.value, '\\n', '\n')
        end
        --self:ShowConditionContent()
    end
end

---改变当前副本数据
---@param dupTbl TABLE.CFG_DUPLICATE 副本数据
function UIActivityDuplicatePanel:ChangeCurrentDuplicateTbl(dupTbl)
    self.mDuplicate = dupTbl
    self:ChangeCurrentDeliverId()
end

---改变当前传送id数据
function UIActivityDuplicatePanel:ChangeCurrentDeliverId()
    if self.mDuplicate == nil then
        return
    end

    local isFind, item = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self.mDuplicate.openTime)
    if isFind then
        if item.deliverId ~= nil then
            self.mDailyActivityTime = item
            self.mDeliverId = item.deliverId
        end
        self.mTitleName_UILabel.text = item.name
    end
end

---获取当前传送id
function UIActivityDuplicatePanel:GetCurrentDeliverId()
    return self.mDeliverId
end

--endregion

function UIActivityDuplicatePanel:RefreshItemCount()
    if self.maxCount == nil then
        return
    end
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    self.curcount = bagInfo:GetItemCountByItemId(self.itemId)
    if self.itemIdTwo then
        self.curcount = bagInfo:GetItemCountByItemId(self.itemIdTwo) + self.curcount
    end
    local color = Utility.GetBBCode(tonumber(self.curcount) >= tonumber(self.maxCount))
    self.eventcost.text = color .. self.curcount .. '[-]/' .. self. maxCount
end

function UIActivityDuplicatePanel:InitParams()
    self.count = 0
    self.contentList = {}
end

---添加条件数据
function UIActivityDuplicatePanel:AddConditionContent(titleName, content, openquickGet, callBack)
    if titleName ~= nil and content ~= nil then
        self.count = self.count + 1
        local content = {
            titleName = titleName,
            content = content,
            openquickGet = openquickGet,
            callBack = callBack
        }
        table.insert(self.contentList, content)
    end
end

---通过标题名修改对应的内容
function UIActivityDuplicatePanel:ChangeContentByTitleName(titleName, content)
    for k, v in pairs(self.contentList) do
        if titleName == v.titleName then
            v.content = content
            --self:ShowConditionContent()
            return
        end
    end
end

--[[
--function UIActivityDuplicatePanel:ShowConditionContent()
--    self.grid_UIGridContainer.MaxCount = self.count
--    for i = 0, self.grid_UIGridContainer.controlList.Count - 1 do
--        local content_Transform = self.grid_UIGridContainer.controlList[i].transform
--        local content_UILabel = self:GetComp(content_Transform, "", "UILabel")
--        local title_UILabel = self:GetComp(content_Transform, "levleTitle", "UILabel")
--        local getPath = self:GetComp(content_Transform, "getpath", "GameObject")
--        local content = self.contentList[i + 1]
--        if content_UILabel ~= nil and title_UILabel ~= nil and getPath ~= nil and content ~= nil then
--            content_UILabel.text = content.content
--            title_UILabel.text = content.titleName
--            if content.openquickGet then
--                getPath:SetActive(true)
--                if content.callBack ~= nil then
--                    CS.UIEventListener.Get(getPath).onClick = content.callBack
--                end
--            else
--                getPath:SetActive(false)
--            end
--        end
--    end
--end
--]]

--region 函数监听

---关闭按钮
function UIActivityDuplicatePanel:OnClickCloseBtn()
    uimanager:ClosePanel("UIActivityDuplicatePanel")
    uimanager:ClosePanel("UISanctuaryPanel")
end

---icon点击
function UIActivityDuplicatePanel:OnClickIcon()
    if self.mConditionItem ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mConditionItem })
    end
end

function UIActivityDuplicatePanel:OnClickChoose1Btn(go)
    UIActivityDuplicatePanel.ChooseFloor = 1
    --self.eventcostChooseBG.gameObject:SetActive(true)
    self.eventcost2ChooseBG.gameObject:SetActive(false)
end

function UIActivityDuplicatePanel:OnClickChoose2Btn(go)
    UIActivityDuplicatePanel.ChooseFloor = 2
    self.eventcostChooseBG.gameObject:SetActive(false)
    self.eventcost2ChooseBG.gameObject:SetActive(true)
end
---进入按钮
function UIActivityDuplicatePanel:OnClickEnterBtn(go)
    ---王者禁地,检查是否为商会会员
    if self.mDuplicate ~= nil and self.mDuplicate.type == 4 then
        if self.mCurrentChooseDuplicateInfo then
            if not self.mCurrentChooseDuplicateInfo.success then
                uimanager:CreatePanel("UICommercePanel")
                uimanager:ClosePanel("UIActivityDuplicatePanel")
                return
            elseif not self.mCurrentChooseDuplicateInfo.costEnough then
                local str = Utility.CombineStringQuickly(self.mCurrentChooseDuplicateInfo.costName, "不足")
                self.ShowTips(go.transform, nil, 60)
                return
            end
        end
        --[[        if self.mIsCommerce then
                    ---王者禁地,需要商会身份才能进入
                    local deliverInfoIsFind, deliverInfo = CS.Cfg_DeliverTableManager.Instance:TryGetValue(self.mDeliverId)
                    if deliverInfoIsFind then
                        local mCardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(1)

                        if (UIActivityDuplicatePanel.ChooseFloor == 1) then
                            Utility.ReqEnterDuplicate(deliverInfo.toMapId)
                        else
                            if (mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.MENGZHONGCARD) or mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD)) then
                                Utility.ReqEnterDuplicate(9302)
                            else
                                self.ShowTips(go.transform, nil, 395)
                                return
                            end
                        end
                        uimanager:ClosePanel('UIActivityDuplicatePanel')
                        uimanager:ClosePanel("UIMonsterHeadPanel")
                        uimanager:ClosePanel("UISanctuaryPanel")
                        uimanager:ClosePanel("UICommercePanel")
                    end
                else
                    ---若没有商会身份,则弹出提示“请先加入商会”
                    Utility.ShowPopoTips(go, "请先加入商会", 290, "UIActivityDuplicatePanel")
                end
                return]]
    end
    --等级限制
    local level = CS.CSScene.MainPlayerInfo.Level
    if UIActivityDuplicatePanel.limitLevel > level then
        UIActivityDuplicatePanel.ShowBubbleTips(go.transform, 73)
        return
    end
    --神威狱入口时间判定
    if self.mDuplicate ~= nil and self.mDuplicate.type == 24 then
        if not UIActivityDuplicatePanel.CheckGodPrisonTime() then
            --显示气泡
            UIActivityDuplicatePanel.ShowBubbleTips(go.transform, 76)
            return
        end
    end
    --物品限制 91543 需求
    local deliverInfoIsFind, deliverInfo = CS.Cfg_DeliverTableManager.Instance:TryGetValue(self:GetCurrentDeliverId())
    if deliverInfoIsFind then
        if self.maxCount and self.curcount then
            if self.maxCount <= self.curcount then
                Utility.ReqEnterDuplicate(deliverInfo.toMapId)
                uimanager:ClosePanel('UIActivityDuplicatePanel')
                uimanager:ClosePanel("UIMonsterHeadPanel")
                uimanager:ClosePanel("UISanctuaryPanel")
                return
            end
        end
    end
    ---没有deliverid 或者物品不足
    self.ShowTips(go.transform, nil, 60)
end

---变强或者购买
function UIActivityDuplicatePanel:OnClickUIActivityDuplicatePanel(go)
    if self.panelName == 'bianqiang' then
        CS.Utility.ShowTips("变强功能未实现", 1.5, CS.ColorType.Red)
    else
        --uimanager:CreatePanel(self.panelName)
        Utility.ShowItemGetWay(self.mConditionItem.id, self.btn_add, LuaEnumWayGetPanelArrowDirType.Down)
    end
    --uimanager:ClosePanel('UIActivityDuplicatePanel')
end
---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIActivityDuplicatePanel.ShowTips(trans, str, id)
    local TipsInfo = {}
    if str ~= nil or str ~= '' then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIActivityDuplicatePanel";
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIActivityDuplicatePanel:RefreshDescIcon(iconName)
    if CS.StaticUtility.IsNull(self.icon_uiSprite) == false then
        if CS.StaticUtility.IsNullOrEmpty(iconName) == true then
            self.icon_uiSprite.gameObject:SetActive(false)
            return
        end
        self.icon_uiSprite.spriteName = iconName
        self.icon_uiSprite:MakePixelPerfect()
        self.icon_uiSprite.gameObject:SetActive(true)
    end
    if CS.StaticUtility.IsNull(self.eventcostOtherDesc) == false then
        local defaultLocalPosition = CS.UnityEngine.Vector3.right * -31
        if CS.StaticUtility.IsNullOrEmpty(iconName) == false then
            defaultLocalPosition = CS.UnityEngine.Vector3.zero
        end
        self.eventcostOtherDesc.transform.localPosition = defaultLocalPosition
    end
end

--region otherfunction

---检查神威狱入口时间
function UIActivityDuplicatePanel.CheckGodPrisonTime()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo == nil then
        return false
    end
    --入口结束时间
    local entryEndTime = CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo.entryTimeEnd
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    return entryEndTime > serverNowTime
end

function UIActivityDuplicatePanel.ShowBubbleTips(trans, id)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans;
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIActivityDuplicatePanel";
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
end

--endregion

return UIActivityDuplicatePanel