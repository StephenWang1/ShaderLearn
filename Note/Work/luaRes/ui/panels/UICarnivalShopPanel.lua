---限时活动,狂欢商店
---@class UICarnivalShopPanel:UIBase
local UICarnivalShopPanel={}

--region 数据
---@type TABLE.cfg_special_activity 特殊活动表数据
UICarnivalShopPanel.specialActivityTbl=nil
---@type activitiesV2.ResOneActivitiesInfo 服务器返回的通用数据
UICarnivalShopPanel.commonServerData=nil
---@type number 活动开始时间戳
UICarnivalShopPanel.startTimeStamp=0
---@type number 活动结束时间戳
UICarnivalShopPanel.endTimeStamp=0
---@type number 狂欢券物品ID
UICarnivalShopPanel.carnivalCouponItemID=8310001
---@type number 狂欢点物品ID
UICarnivalShopPanel.carnivalCountItemID=1000028
---@type number 活动id
UICarnivalShopPanel.activityEventID=18
---@type table<number, activitiesV2.OneActivitiesInfo> 服务器的当前活动数据
UICarnivalShopPanel.serverActivityData=nil
--endregion

--region 组件
---倒计时文本
---@return UICountdownLabel
function UICarnivalShopPanel:GetTimeCountLabel()
    if self.mTimeCountLabel == nil then
        self.mTimeCountLabel=self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCountLabel
end

---狂欢节券物品
---@return UnityEngine.GameObject
function UICarnivalShopPanel:GetCarnivalCouponGO()
    if self.mCarnivalCouponGO == nil then
        self.mCarnivalCouponGO=self:GetCurComp("WidgetRoot/view/CarnivalCoupon", "GameObject")
    end
    return self.mCarnivalCouponGO
end

---狂欢节券Icon
---@return UISprite
function UICarnivalShopPanel:GetCarnivalCouponIconSprite()
    if self.mCarnivalCouponIconSprite == nil then
        self.mCarnivalCouponIconSprite=self:GetCurComp("WidgetRoot/view/CarnivalCoupon/icon", "UISprite")
    end
    return self.mCarnivalCouponIconSprite
end

---狂欢节券数量文本
---@return UILabel
function UICarnivalShopPanel:GetCarnivalCouponAmountLabel()
    if self.mCarnivalCouponAmountLabel == nil then
        self.mCarnivalCouponAmountLabel=self:GetCurComp("WidgetRoot/view/CarnivalCoupon/count", "UILabel")
    end
    return self.mCarnivalCouponAmountLabel
end

---狂欢节点数物品
---@return UnityEngine.GameObject
function UICarnivalShopPanel:GetCarnivalCountGO()
    if self.mCarnivalCountGO == nil then
        self.mCarnivalCountGO=self:GetCurComp("WidgetRoot/view/CarnivalCount", "GameObject")
    end
    return self.mCarnivalCountGO
end

---狂欢节点数Icon
---@return UISprite
function UICarnivalShopPanel:GetCarnivalCountIconSprite()
    if self.mCarnivalCountIconSprite == nil then
        self.mCarnivalCountIconSprite=self:GetCurComp("WidgetRoot/view/CarnivalCount/icon", "UISprite")
    end
    return self.mCarnivalCountIconSprite
end

---狂欢节点数文本
---@return UILabel
function UICarnivalShopPanel:GetCarnivalCountAmountLabel()
    if self.mCarnivalCountAmountLabel == nil then
        self.mCarnivalCountAmountLabel=self:GetCurComp("WidgetRoot/view/CarnivalCount/count", "UILabel")
    end
    return self.mCarnivalCountAmountLabel
end

---狂欢商店循环组件
---@return UILoopScrollViewPlus
function UICarnivalShopPanel:GetCanivalShopLoopScrollViewPlus()
    if self.mCanivalShopScrollView == nil then
        self.mCanivalShopScrollView=self:GetCurComp("WidgetRoot/view/CanivalShop/scroll/type1", "UILoopScrollViewPlus")
    end
    return self.mCanivalShopScrollView
end

---新GridContainer
---@return UIGridContainer
function UICarnivalShopPanel:GetCanivalShopGridContainer()
    if self.mCanivalShopGridContainer == nil then
        self.mCanivalShopGridContainer=self:GetCurComp("WidgetRoot/view/CanivalShop/scroll/type2", "UIGridContainer")
    end
    return self.mCanivalShopGridContainer
end
--endregion

--region 初始化
function UICarnivalShopPanel:Init()
    self:BindUIEvents()
    self:BindNetEvents()
    if gameMgr:GetPlayerDataMgr() and gameMgr:GetPlayerDataMgr():GetSpecialActivityData()
            and gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetCarnivalShop() then
        ---打开狂欢商店界面时,如果上一次红点状态为true,那么将mIsRedPointDoNotShow置为true,表明狂欢商店的红点已经触发过一次了,不需要再次显示红点了
        gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetCarnivalShop():TryHideRedPoint()
    end
end

---@param data SpecialActivityPanelData 界面数据
function UICarnivalShopPanel:Show(data)
    self.specialActivityTbl=clientTableManager.cfg_special_activityManager:TryGetValue(data.mActivityID)
    self.commonServerData=gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(data.mEventID)
    self.activityEventID=data.mEventID
    self.startTimeStamp=data.mStartTime * 1000
    self.endTimeStamp=data.mFinishTime * 1000
    if self.commonServerData == nil then
        self:RefreshUIWithNoServerData()
        return
    end
    self.mIsNeedToJump=true
    self:RequestServerActivityData()
end
--endregion

--region 事件绑定
---绑定UI事件
---@private
function UICarnivalShopPanel:BindUIEvents()
    --self:GetCanivalShopLoopScrollViewPlus():Init(function(go, line)
    --    return self:OnScrollItemChecked(go, line)
    --end, function(topLine)
    --    self:OnTopLineReturn(topLine)
    --end)

    self:RefreshGridContainer()

    ---狂欢券物品点击事件
    CS.UIEventListener.Get(self:GetCarnivalCouponGO()).onClick=function()
        self:OnCoinItemClicked(self.carnivalCouponItemID)
    end
    ---狂欢点物品点击事件
    CS.UIEventListener.Get(self:GetCarnivalCountGO()).onClick=function()
        self:OnCoinItemClicked(self.carnivalCountItemID)
    end
end

---绑定服务器事件
---@private
function UICarnivalShopPanel:BindNetEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCarnivalCouponAmount()
        self:RefreshAllShopItemUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        --self:RefreshCarnivalCountAmount()
        self:RefreshAllShopItemUI()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneActivitiesInfoMessage, function(id, tblData)
        self:ResOneActivitiesInfoMessage(tblData)
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSubTypeActivitiesInfoMessage, function(id, tblData)
        self:ResSubTypeActivitiesInfoMessage(tblData)
    end)
end
--endregion

--region UI刷新
---刷新格子
---@private
function UICarnivalShopPanel:RefreshGridContainer()
    if self.serverActivityData == nil then
        self:GetCanivalShopGridContainer().MaxCount=0
        return
    end
    local activityCount=#self.serverActivityData
    self:GetCanivalShopGridContainer().MaxCount=activityCount
    local removeList = {}
    local List = {}
    for i = 1, activityCount do
        local award = clientTableManager.cfg_special_activityManager:TryGetValue(self.serverActivityData[i].configId)
        local remain = award:GetAwardType().list[2] - self.serverActivityData[i].dataParam
        if remain == 0 then
            table.insert(removeList, self.serverActivityData[i])
        else
            table.insert(List, self.serverActivityData[i])
        end
    end
    if #removeList > 0 then
        for i = 1, #removeList do
            table.insert(List, removeList[i])
        end
    end
    for i=1, #List do
        local go=self:GetCanivalShopGridContainer().controlList[i - 1]
        local template=self:GetCarnivalShopItemTemplate(go)
        template:Refresh(List[i])
    end

end

---正常刷新UI
---@public
function UICarnivalShopPanel:RefreshUI()
    self:GetTimeCountLabel().gameObject:SetActive(true)
    --self:GetCanivalShopLoopScrollViewPlus().gameObject:SetActive(true)
    self:RefreshCarnivalFinishTimeCount()
    self:RefreshCarnivalCouponAmount()
    self:RefreshGridContainer()
    --self:RefreshCarnivalCountAmount()
    --self:RefreshCarnivalShopScrollViewPlus()
end

---刷新活动倒计时
---@private
function UICarnivalShopPanel:RefreshCarnivalFinishTimeCount()
    --测试倒计时
    if self.endTimeStamp == nil or self.endTimeStamp == 0 then
        self:GetTimeCountLabel():StopCountDown()
        if CS.StaticUtility.IsNull(self:GetTimeCountLabel()._Label) == false then
            self:GetTimeCountLabel()._Label.text=""
        end
        return
    end
    self:GetTimeCountLabel():StartCountDown(100, 8, self.endTimeStamp, "活动倒计时  ", "", nil, nil)
end

---刷新狂欢券数量(为背包中的实体物品)
---@private
function UICarnivalShopPanel:RefreshCarnivalCouponAmount()
    local amountForCarnivalCoupon=gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.carnivalCouponItemID)
    amountForCarnivalCoupon=amountForCarnivalCoupon + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(8310002)
    self:GetCarnivalCouponAmountLabel().text=tostring(amountForCarnivalCoupon)
    local itemTblTemp=clientTableManager.cfg_itemsManager:TryGetValue(self.carnivalCouponItemID)
    if itemTblTemp then
        self:GetCarnivalCouponIconSprite().spriteName=itemTblTemp:GetIcon()
    else
        self:GetCarnivalCouponIconSprite().spriteName=""
    end
end

---刷新狂欢点数量(为货币)(调用暂时去掉了,该界面不再显示狂欢点)
---@private
function UICarnivalShopPanel:RefreshCarnivalCountAmount()
    local amountForCarnivalCount=gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self.carnivalCountItemID)
    self:GetCarnivalCountAmountLabel().text=tostring(amountForCarnivalCount)
    local itemTblTemp=clientTableManager.cfg_itemsManager:TryGetValue(self.carnivalCountItemID)
    if itemTblTemp then
        self:GetCarnivalCountIconSprite().spriteName=itemTblTemp:GetIcon()
    else
        self:GetCarnivalCountIconSprite().spriteName=""
    end
end

---排序商店物品
---@private
function UICarnivalShopPanel:SortShopItems()
    if self.serverActivityData == nil then
        return
    end
    if self.mSortFunction == nil then
        self.mSortFunction=function(left, right)
            return self:SortCompareFunction(left, right)
        end
    end
    table.sort(self.serverActivityData, self.mSortFunction)
end

---排序方法,按照specialactivity表中的smallID排序
---@private
---@param left activitiesV2.OneActivitiesInfo
---@param right activitiesV2.OneActivitiesInfo
function UICarnivalShopPanel:SortCompareFunction(left, right)
    if left.specialActivityConfigTbl == nil then
        left.specialActivityConfigTbl=clientTableManager.cfg_special_activityManager:TryGetValue(left.configId)
    end
    if right.specialActivityConfigTbl == nil then
        right.specialActivityConfigTbl=clientTableManager.cfg_special_activityManager:TryGetValue(right.configId)
    end
    local leftLastExchangeAmount=self:GetLastExchangeAmount(left)
    local rightLastExchangeAmount=self:GetLastExchangeAmount(right)
    if leftLastExchangeAmount ~= rightLastExchangeAmount then
        if leftLastExchangeAmount <= 0 then
            return false
        elseif rightLastExchangeAmount <= 0 then
            return true
        end
    end
    if left.specialActivityConfigTbl:GetSmallId() < right.specialActivityConfigTbl:GetSmallId() then
        return true
    else
        return left.specialActivityConfigTbl:GetId() < right.specialActivityConfigTbl:GetId()
    end
    return false
end

---获取剩余兑换数量
---@param activityData activitiesV2.OneActivitiesInfo
---@return number
function UICarnivalShopPanel:GetLastExchangeAmount(activityData)
    local specialActivityTbl=clientTableManager.cfg_special_activityManager:TryGetValue(activityData.configId)
    if specialActivityTbl ~= nil and specialActivityTbl:GetAwardType() ~= nil
            and specialActivityTbl:GetAwardType().list ~= nil
            and #specialActivityTbl:GetAwardType().list >= 2 then
        return specialActivityTbl:GetAwardType().list[2] - activityData.dataParam
    end
    return 0
end

-----刷新狂欢商城
-----@private
--function UICarnivalShopPanel:RefreshCarnivalShopScrollViewPlus()
--    if self.mCarnivalShopItemTemplates ~= nil then
--        for i, v in pairs(self.mCarnivalShopItemTemplates) do
--            v:ResetData()
--        end
--    end
--    self:SortShopItems()
--    ---刷新ScrollView页
--    self:GetCanivalShopLoopScrollViewPlus():RefreshCurrentPage()
--    local isNeedJumpToAvailableLine=self.mIsNeedToJump == nil or self.mIsNeedToJump == true
--    ---只有Show中打开时才跳到第一个可兑换行
--    if isNeedJumpToAvailableLine then
--        self.mIsNeedToJump=false
--        self:JumpToExchangeAbleLine()
--    end
--end

---跳转到可兑换的一行
---@private
function UICarnivalShopPanel:JumpToExchangeAbleLine()
    local bagMgr=gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    local targetIndex=0
    for i=1, #self.serverActivityData do
        ---@type activitiesV2.OneActivitiesInfo
        local activityData=self.serverActivityData[i]
        local tbl=clientTableManager.cfg_special_activityManager:TryGetValue(activityData.configId)
        if tbl ~= nil and tbl:GetGoal() ~= nil and tbl:GetGoal().list ~= nil and #tbl:GetGoal().list >= 2
                and tbl:GetAwardType() ~= nil and tbl:GetAwardType().list ~= nil and #tbl:GetAwardType().list >= 2 then
            local itemID=tbl:GetGoal().list[1]
            local needItemCount=tbl:GetGoal().list[2]
            local itemCountInBag=bagMgr:GetItemCount(itemID) + bagMgr:GetCoinAmount(itemID)
            local maxExchangeCount=tbl:GetAwardType().list[2]
            if itemCountInBag >= needItemCount and activityData.dataParam < maxExchangeCount then
                targetIndex=i
                break
            end
        end
    end
    ---获取将要跳转的行数
    local targetLine=math.ceil(targetIndex / 2) - 1
    ---获取本页最大行数
    local maxLine=math.ceil(#self.serverActivityData / 2)
    local lineOffset=maxLine - targetLine
    if lineOffset == 4 then
        targetLine=maxLine - 4
    elseif lineOffset <= 3 then
        targetLine=maxLine - 3.8
    end
    if targetLine < 0 then
        targetLine=0
    end
    --self:GetCanivalShopLoopScrollViewPlus():JumpToLineFloat(targetLine)
end

---ScrollView中的物品检查
---@private
---@param go UnityEngine.GameObject
---@param index number
function UICarnivalShopPanel:OnScrollItemChecked(go, index)
    if self.commonServerData == nil then
        return false
    end
    if self.serverActivityData == nil then
        return false
    end
    local activityCount=#self.serverActivityData
    if index < activityCount and index >= 0 then
        local template=self:GetCarnivalShopItemTemplate(go)
        template:Refresh(self.serverActivityData[index + 1])
        return true
    end
    return false
end

---ScrollView最上一行
---@private
---@param topLine number
function UICarnivalShopPanel:OnTopLineReturn(topLine)

end

---没有服务器数据时的UI刷新
---@private
function UICarnivalShopPanel:RefreshUIWithNoServerData()
    self:GetTimeCountLabel().gameObject:SetActive(false)
    self:RefreshCarnivalCouponAmount()
    --self:RefreshCarnivalCountAmount()
    --self:GetCanivalShopLoopScrollViewPlus().gameObject:SetActive(false)
end

---刷新所有商店物品的UI
---@private
function UICarnivalShopPanel:RefreshAllShopItemUI()
    if self.mCarnivalShopItemTemplates ~= nil then
        for i, v in pairs(self.mCarnivalShopItemTemplates) do
            v:RefreshUI()
        end
    end
end
--endregion

--region 商店中的物品模板
---获取商店物品模板
---@param go UnityEngine.GameObject
---@return UICarnivalShop_ItemTemplate
function UICarnivalShopPanel:GetCarnivalShopItemTemplate(go)
    if go == nil or CS.StaticUtility.IsNull(go) then
        return nil
    end
    if self.mCarnivalShopItemTemplates == nil then
        ---@type table<UnityEngine.GameObject, UICarnivalShop_ItemTemplate>
        self.mCarnivalShopItemTemplates={}
    end
    local template=self.mCarnivalShopItemTemplates[go]
    if template == nil then
        template=templatemanager.GetNewTemplate(go, luaComponentTemplates.UICarnivalShop_ItemTemplate, self)
        self.mCarnivalShopItemTemplates[go]=template
    end
    return template
end
--endregion

--region 货币tips
---物品点击事件
---@private
---@param itemID number
function UICarnivalShopPanel:OnCoinItemClicked(itemID)
    local itemTbl=clientTableManager.cfg_itemsManager:TryGetValue(itemID)
    if itemTbl == nil then
        return
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        itemID=itemID,
        itemInfo=itemTbl:CsTABLE(),
        showRight=true })
end
--endregion

--region 网络消息
---请求服务器活动数据
---@private
function UICarnivalShopPanel:RequestServerActivityData()
    if self.specialActivityTbl ~= nil then
        networkRequest.ReqGetOneActivitiesInfo(self.specialActivityTbl:GetId())
    else
        print("self.specialActivityTbl is null, can not request server data.")
    end
end

---返回活动数据
---@private
---@param tblData activitiesV2.ResOneActivitiesInfo
function UICarnivalShopPanel:ResOneActivitiesInfoMessage(tblData)
    if tblData == nil or tblData.type ~= self.activityEventID then
        return
    end
    self.serverActivityData=tblData.oneActivitiesInfo
    self:RefreshUI()
end

---单个活动数据更新
---@private
---@param tblData activitiesV2.ResAwardActivitiesInfo
function UICarnivalShopPanel:ResSubTypeActivitiesInfoMessage(tblData)
    if self.serverActivityData == nil then
        return
    end
    local isChanged=false
    for i=1, #self.serverActivityData do
        if self.serverActivityData[i].configId == tblData.configId then
            self.serverActivityData[i]=tblData
            isChanged=true
            break
        end
    end
    if isChanged then
        self:RefreshUI()
    end
end
--endregion

return UICarnivalShopPanel