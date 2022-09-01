---@class UINPCDuplicateBase:UIBase NPC副本基类
local UINPCDuplicateBase = {}

local CheckNullFunction = CS.StaticUtility.IsNull

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UINPCDuplicateBase:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject 进入按钮
function UINPCDuplicateBase:GetEnterBtn_Go()
    if self.mEnterBtn == nil then
        self.mEnterBtn = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return self.mEnterBtn
end

---@return UILabel 描述文本
function UINPCDuplicateBase:GetDescription_UILabel()
    if self.mDesLb == nil then
        self.mDesLb = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "UILabel")
    end
    return self.mDesLb
end

---@return UIGridContainer 奖励container
function UINPCDuplicateBase:GetRewardGrid_UIGridContainer()
    if self.mRewardContainer == nil then
        self.mRewardContainer = self:GetCurComp("WidgetRoot/Awards", "UIGridContainer")
    end
    return self.mRewardContainer
end

---@return UnityEngine.GameObject 开启选项按钮
function UINPCDuplicateBase:OpenChooseBtn_Go()
    if self.mOpenChooseBtn == nil then
        self.mOpenChooseBtn = self:GetCurComp("WidgetRoot/eventcost/btn_add", "GameObject")
    end
    return self.mOpenChooseBtn
end

---@return UnityEngine.GameObject 关闭选项按钮
function UINPCDuplicateBase:CloseChooseBtn_Go()
    if self.mCloseChooseBtn == nil then
        self.mCloseChooseBtn = self:GetCurComp("WidgetRoot/eventcost/Location/block", "GameObject")
    end
    return self.mCloseChooseBtn
end

---@return UnityEngine.GameObject 选项列表
function UINPCDuplicateBase:GetChooseList_Go()
    if self.mChooseListGo == nil then
        self.mChooseListGo = self:GetCurComp("WidgetRoot/eventcost/Location", "GameObject")
    end
    return self.mChooseListGo
end

---@return UILabel 选中文本
function UINPCDuplicateBase:GetShowChoose_UILabel()
    if self.mShowChooseLb == nil then
        self.mShowChooseLb = self:GetCurComp("WidgetRoot/eventcost/label", "UILabel")
    end
    return self.mShowChooseLb
end

---@return UIGridContainer
function UINPCDuplicateBase:GetDuplicateChoose_UIGridContainer()
    if self.mChooseDupContainer == nil then
        self.mChooseDupContainer = self:GetCurComp("WidgetRoot/eventcost/Location/LocationList/Grid", "UIGridContainer")
    end
    return self.mChooseDupContainer
end

---@return UnityEngine.GameObject 进入副本消耗道具
function UINPCDuplicateBase:GetCostGo()
    if self.mCostGo == nil then
        self.mCostGo = self:GetCurComp("WidgetRoot/cost", "GameObject")
    end
    return self.mCostGo
end

---@return UISprite icon
function UINPCDuplicateBase:GetCostIcon_UISprite()
    if self.mCostIcon == nil then
        self.mCostIcon = self:GetCurComp("WidgetRoot/cost/icon", "UISprite")
    end
    return self.mCostIcon
end

---@return UILabel 花费文本
function UINPCDuplicateBase:GetCostNum_UILabel()
    if self.mCostLb == nil then
        self.mCostLb = self:GetCurComp("WidgetRoot/cost/num", "UILabel")
    end
    return self.mCostLb
end

---@type UnityEngine.GameObject 花费道具add
function UINPCDuplicateBase:GetCostAdd_GO()
    if self.mCostAddGo == nil then
        self.mCostAddGo = self:GetCurComp("WidgetRoot/cost/add", "GameObject")
    end
    return self.mCostAddGo
end

---@return UIScrollView
function UINPCDuplicateBase:GetChooseScrollView_UIScrollView()
    if self.mChooseScrollView == nil then
        self.mChooseScrollView = self:GetCurComp("WidgetRoot/eventcost/Location/LocationList", "UIScrollView")
    end
    return self.mChooseScrollView
end

---@return UIPanel 控制SV
function UINPCDuplicateBase:GetChooseScrollView_UIPanel()
    if self.mLocationPanel == nil then
        self.mLocationPanel = self:GetCurComp("WidgetRoot/eventcost/Location/LocationList", "UIPanel")
    end
    return self.mLocationPanel
end
--endregion

--region 数据
---在子类赋值，副本类型，对应副本表type字段
UINPCDuplicateBase.mDuplicateType = nil
function UINPCDuplicateBase:GetDuplicateType()
    return self.mDuplicateType
end

UINPCDuplicateBase.mDescriptionId = nil
function UINPCDuplicateBase:GetDescriptionId()
    return self.mDescriptionId
end

---设置当前选中副本
---@param dupTbl TABLE.CFG_DUPLICATE
function UINPCDuplicateBase:SetCurrentDuplicateInfo(dupTbl)
    self.mCurrentChooseDupTbl = dupTbl
    self:ChangeCurrentDeliverId()
end

---@return TABLE.CFG_DUPLICATE
function UINPCDuplicateBase:GetCurrentDuplicateInfo()
    return self.mCurrentChooseDupTbl
end

---改变当前传送id数据
function UINPCDuplicateBase:ChangeCurrentDeliverId()
    if self:GetCurrentDuplicateInfo() == nil then
        return
    end

    local isFind, item = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self:GetCurrentDuplicateInfo().openTime)
    if isFind then
        if item.deliverId ~= nil then
            self.mDeliverId = item.deliverId
        end
    end
end

---获取当前传送id
function UINPCDuplicateBase:GetCurrentDeliverId()
    return self.mDeliverId
end

---@return table<number,TABLE.CFG_DUPLICATE> list类型副本数据
function UINPCDuplicateBase:GetAllDuplicate()
    if self.mAllDuplicateInfo == nil and self:GetDuplicateType() then
        self.mAllDuplicateInfo = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(self:GetDuplicateType())
    end
    return self.mAllDuplicateInfo
end


--endregion

--region 初始化
function UINPCDuplicateBase:Init()
    self:BindEvents()
    self:BindMessage()
end

function UINPCDuplicateBase:Show()
    self:ChooseFirstDuplicate()
    self:RefreshDetails()
    self:RefreshRewardShow()
    self:RefreshDropDown()
end

function UINPCDuplicateBase:BindEvents()
    if CheckNullFunction(self:GetCloseBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
            self:ClosePanel()
        end
    end

    if CheckNullFunction(self:GetEnterBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetEnterBtn_Go()).onClick = function(go)
            self:OnEnterBtnClicked(go)
        end
    end

    if CheckNullFunction(self:OpenChooseBtn_Go()) == false then
        CS.UIEventListener.Get(self:OpenChooseBtn_Go()).onClick = function()
            self:SetChooseListShow(true)
        end
    end

    if CheckNullFunction(self:CloseChooseBtn_Go()) == false then
        CS.UIEventListener.Get(self:CloseChooseBtn_Go()).onClick = function()
            self:SetChooseListShow(false)
        end
    end

    luaclass.UIRefresh:BindClickCallBack(self:GetCostIcon_UISprite(),function()
        local dupTbl = self:GetCurrentDuplicateInfo()
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
end

function UINPCDuplicateBase:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCostShow()
    end)
end

--endregion

--region  设置默认副本选中
---设置默认副本选中
function UINPCDuplicateBase:ChooseFirstDuplicate()
    local allDuplicateList = self:GetAllDuplicate()
    if allDuplicateList and allDuplicateList.Count > 0 then
        for i = 0, allDuplicateList.Count - 1 do
            local dup = allDuplicateList[i]
            local full, add = self:GetAddShow(dup)
            if full then
                self:ChooseDuplicate(dup)
                return
            end
        end
        self:ChooseDuplicate(allDuplicateList[0])
    end
end
--endregion

--region 刷新下拉列表显示
---刷新下拉框
function UINPCDuplicateBase:RefreshDropDown()
    local allList = self:GetAllDuplicate()
    if allList == nil then
        return
    end
    self.mDupIdToLine = {}
    self:GetDuplicateChoose_UIGridContainer().MaxCount = allList.Count
    for i = 0, self:GetDuplicateChoose_UIGridContainer().controlList.Count - 1 do
        ---@type TABLE.CFG_DUPLICATE
        local info = allList[i]
        self.mDupIdToLine[info.id] = i
        local go = self:GetDuplicateChoose_UIGridContainer().controlList[i]
        local lb = CS.Utility_Lua.Get(go.transform, "lb_location", "UILabel")
        local full, add = self:GetAddShow(info)
        local color = full and luaEnumColorType.Green or luaEnumColorType.Gray
        lb.text = Utility.CombineStringQuickly(color, info.name, "[-]", luaEnumColorType.Gray, add)
        CS.UIEventListener.Get(go).onClick = function()
            self:ChooseDuplicate(info)
            self:SetChooseListShow(false)
        end
    end
end

function UINPCDuplicateBase:SetChooseListShow(isShow)
    self:GetChooseList_Go():SetActive(isShow)
end

---@param  dupTbl TABLE.CFG_DUPLICATE 副本数据
function UINPCDuplicateBase:ChooseDuplicate(dupTbl)
    self:SetCurrentDuplicateInfo(dupTbl)
    local full, add = self:GetAddShow(dupTbl)
    local color = full and luaEnumColorType.Green or luaEnumColorType.Red
    self:GetShowChoose_UILabel().text = Utility.CombineStringQuickly(color, dupTbl.name, "[-]", luaEnumColorType.Gray, add)
    self:ChangeConditionState(full)
    self:RefreshCostShow()
end

---刷新花费
function UINPCDuplicateBase:RefreshCostShow()
    local dupTbl = self:GetCurrentDuplicateInfo()

    ---消耗道具
    local costId = 0
    local costName = ""
    local costCanEnter = false
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
    else
        costCanEnter = true
    end

    self:GetCostGo():SetActive(hasCost)
    self:ChangeCostFullState(costCanEnter)
end

---存储进入副本状态
function UINPCDuplicateBase:ChangeConditionState(conditionFull)
end

function UINPCDuplicateBase:ChangeCostFullState(state)

end

---@return boolean,string 是否满足条件,文本后缀
function UINPCDuplicateBase:GetAddShow(dupTbl)
    return false, ""
end
--endregion

--region 刷新界面描述
function UINPCDuplicateBase:RefreshDetails()
    if self:GetDescriptionId() then
        local res, desInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(self:GetDescriptionId())
        if res then
            self:GetDescription_UILabel().text = string.gsub(desInfo.value, '\\n', '\n')
            return
        end
    end
    self:GetDescription_UILabel().text = ""
end

--endregion

--region 刷新奖励显示
---刷新奖励显示
function UINPCDuplicateBase:RefreshRewardShow()
    if self:GetCurrentDuplicateInfo() == nil then
        return
    end
    if CheckNullFunction(self:GetRewardGrid_UIGridContainer()) then
        return
    end
    local data = CS.Cfg_DuplicateTableManager.Instance:GetRewardItemIds(self:GetCurrentDuplicateInfo())
    self:GetRewardGrid_UIGridContainer().MaxCount = data.Count
    for i = 0, self:GetRewardGrid_UIGridContainer().controlList.Count - 1 do
        local go = self:GetRewardGrid_UIGridContainer().controlList[i]
        local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
        template:RefreshUI(data[i], nil)
    end
end
--endregion

--region 进入副本
function UINPCDuplicateBase:OnEnterBtnClicked(go)
end

---进入副本
function UINPCDuplicateBase:EnterDuplicate()
    if self:GetCurrentDeliverId() == nil then
        return
    end

    local deliverInfoIsFind, deliverInfo = CS.Cfg_DeliverTableManager.Instance:TryGetValue(self:GetCurrentDeliverId())
    if deliverInfoIsFind then
        Utility.ReqEnterDuplicate(deliverInfo.toMapId)
        self:ClosePanel()
    end
end
--endregion

--region 跳转适配
function UINPCDuplicateBase:JumpToLine()
    if self.mDupIdToLine and self:GetCurrentDuplicateInfo() then
        local line = self.mDupIdToLine[self:GetCurrentDuplicateInfo().id]
        if line then
            self:GetChooseScrollView_UIScrollView():ResetPosition()
            local jumpLine = line - 3
            if jumpLine < 0 then
                jumpLine = 0
            end
            local pos = self:GetChooseScrollView_UIScrollView().transform.localPosition
            local originClip = self:GetChooseScrollView_UIPanel().clipOffset
            local height = self:GetDuplicateChoose_UIGridContainer().CellHeight
            local offset = height * jumpLine
            pos.y = pos.y + offset
            originClip.y = originClip.y - offset
            self:GetChooseScrollView_UIPanel().clipOffset = originClip
            self:GetChooseScrollView_UIScrollView().transform.localPosition = pos
        end
    end
end
--endregion

return UINPCDuplicateBase