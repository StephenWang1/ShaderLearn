---@class UIBagMain_Smelt:UIBagMain_Normal 熔炼背包
local UIBagMain_Smelt = {}
setmetatable(UIBagMain_Smelt, luaComponentTemplates.UIBagMainNormal)

--region 局部变量
UIBagMain_Smelt.curSmeltEarning = {}

---@return CSMainPlayerInfo
function UIBagMain_Smelt:GetCSMainPlayerInfo()
    if self.csMainPlayerInfo == nil then
        self.csMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.csMainPlayerInfo
end

---@return CSBagInfoV2
function UIBagMain_Smelt:GetCSBagInfo()
    if self.mCSBagInfo == nil then
        local mainPlayerInfo = self:GetCSMainPlayerInfo()
        self.mCSBagInfo = mainPlayerInfo.BagInfo
    end
    return self.mCSBagInfo
end

---@return Cfg_ItemsTableManager
function UIBagMain_Smelt:GetCSItemsTable()
    if self.mCSItemsTable == nil then
        self.mCSItemsTable = CS.Cfg_ItemsTableManager.Instance
    end
    return self.mCSItemsTable
end

--endregion

--region 属性
---当前可熔炼的物品列表,number为lid,boolean值为true的表示需要被回收
---@return table<number,boolean>
function UIBagMain_Smelt:GetSmeltBagItemsStateDic()
    if self.mSmeltBagItemsStateDic == nil then
        self.mSmeltBagItemsStateDic = {}
    end
    return self.mSmeltBagItemsStateDic
end

---记录当前选中熔炼物品的可获得稀有物品列表及个数
---@return table<number,number>  <itemid,itemCount>
function UIBagMain_Smelt:GetCurCanGetSmeltItemDic()
    if self.mCurCanGetSmeltItemDic == nil then
        self.mCurCanGetSmeltItemDic = {}
    end
    return self.mCurCanGetSmeltItemDic
end

---记录当前选中熔炼物品的可获得稀有物品列表
---@return table<number,number> <itemid,itemCount>
function UIBagMain_Smelt:GetSmeltEarningItemDic()
    if self.mSmeltEarningItemDic == nil then
        self.mSmeltEarningItemDic = {}
    end
    return self.mSmeltEarningItemDic
end

---记录当前选中熔炼物品需要消耗物品字典
---@return table<number,number> <itemid,itemCount>
function UIBagMain_Smelt:GetSmeltConsumeItemDic()
    if self.mSmeltConsumeItemDic == nil then
        self.mSmeltConsumeItemDic = {}
    end
    return self.mSmeltConsumeItemDic
end

--endregion

--region 组件
---熔炼视图节点
---@return UnityEngine.GameObject
function UIBagMain_Smelt:GetSmeltRoot()
    if self.mSmeltGo == nil then
        self.mSmeltGo = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/smelt", "GameObject")
    end
    return self.mSmeltGo
end

---熔炼togglCheckMark
---@return UnityEngine.GameObject
function UIBagMain_Smelt:GetSmeltToggleCheck_GameObject()
    if self.mSmeltToggleCheck_GO == nil then
        self.mSmeltToggleCheck_GO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/events/SmeltToggle/check", "GameObject")
    end
    return self.mSmeltToggleCheck_GO
end

---熔炼按钮
---@return UnityEngine.GameObject
function UIBagMain_Smelt:GetSmeltButtonGO()
    if self.mSmeltButtonGO == nil then
        self.mSmeltButtonGO = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/smelt/events/Btn_Smelt", "GameObject")
    end
    return self.mSmeltButtonGO
end

---熔炼收益预览
---@return Top_UILabel
function UIBagMain_Smelt:GetSmeltEarning_Grid()
    if self.mSmeltEarning_Grid == nil then
        self.mSmeltEarning_Grid = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/smelt/view/smeltEarningGrid", "UIGridContainer")
    end
    return self.mSmeltEarning_Grid
end

---熔炼奖励预览
---@return UIGridContainer
function UIBagMain_Smelt:GetSmeltRewardPreview_Grid()
    if self.mSmeltRewardPreview_Grid == nil then
        self.mSmeltRewardPreview_Grid = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/smelt/ScrollView/GridContainer", "UIGridContainer")
    end
    return self.mSmeltRewardPreview_Grid
end

---熔炼奖励预览
---@return UIScrollView
function UIBagMain_Smelt:GetSmeltRewardPreview_ScrollView()
    if self.mSmeltRewardPreview_ScrollView == nil then
        self.mSmeltRewardPreview_ScrollView = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot/view/smelt/ScrollView", "UIScrollView")
    end
    return self.mSmeltRewardPreview_ScrollView
end

--endregion

--region 背包相关(overrid)

--region 重写属性
---回收界面展开背包
---@return boolean
function UIBagMain_Smelt:IsExpandBagPanel()
    return true
end

---使用服务器顺序
---@return boolean
function UIBagMain_Smelt:IsUseServerOrder()
    return true
end

---禁用双击交互
---@return boolean
function UIBagMain_Smelt:IsItemDoubleClickedAvailable()
    return false
end

---不显示整理按钮
---@return boolean
function UIBagMain_Smelt:IsShowTrimButton()
    return false
end

---背包信息是否过时
function UIBagMain_Smelt:IsBagInfoDirty()
    if self.mDelayRefreshBagTime ~= nil then
        return false
    end
    return self:RunBaseFunction("IsBagInfoDirty")
end

--endregion

---重写初始化方法
function UIBagMain_Smelt:OnInit()
    self:RunBaseFunction("OnInit")
    ---熔炼按钮点击事件
    ---@type function
    self.mOnSmeltBtnClickCallBack = function(go)
        self:OnSmeltBtnClickCallBack(go)
    end
    self.OnResSmeltMessage = function()
        self:OnResSmeltMessageCallBack()
    end
end

--region 重写生命周期方法
function UIBagMain_Smelt:OnEnable()
    self:RunBaseFunction("OnEnable")
    self:GetSmeltRoot():SetActive(true)
    self:GetSmeltToggleCheck_GameObject():SetActive(true)
    CS.UIEventListener.Get(self:GetSmeltButtonGO()).onClick = self.mOnSmeltBtnClickCallBack
    self:GetBagPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSmeltMessage, self.OnResSmeltMessage)
    self:RefreshSmeltView()
end

function UIBagMain_Smelt:OnDisable()
    self:RunBaseFunction("OnDisable")
    self:GetSmeltRoot():SetActive(false)
    self:GetSmeltToggleCheck_GameObject():SetActive(false)
    CS.UIEventListener.Get(self:GetSmeltButtonGO()).onClick = nil
    self:GetBagPanel():GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSmeltMessage, self.OnResSmeltMessage)
    self:ClearSmeltData()
end
--endregion

---重写物品筛选方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIBagMain_Smelt:BagItemFilterFunction(bagItemInfo, itemInfo)
    return true
end

--region 重写格子刷新方法

--- 重写格子刷新方法
function UIBagMain_Smelt:RefreshGrids()
    self:RunBaseFunction("RefreshGrids")
    -- self:RefreshSmeltView()
end

---重写最基础的格子刷新
function UIBagMain_Smelt:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if self:IsAvailableForSemelt(bagItemInfo) then
        local isChoose = self:GetBagItemSelectState(bagItemInfo)
        ---显示CheckBox
        bagGrid:SetCompActive(bagGrid.Components.Check1, true)
        ---切换CheckBox的显示状态
        bagGrid:SetCompSpriteName(bagGrid.Components.Check1, isChoose and "check" or "")
        ---切换Choose的显示状态
        --bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, self:GetBestBagItemState(bagItemInfo) == false and isChoose)
        self:RefreshEquipDurabilityIsLess(bagGrid, bagItemInfo, itemTbl)
    else
        ---置灰显示
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

---重写格子点击
function UIBagMain_Smelt:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if self:IsAvailableForSemelt(bagItemInfo) then
        local isChangedReward, isChangedEarning, isChangedConsume = self:RefreshCurSmeltData(bagItemInfo)
        if isChangedReward then
            self:RefreshSmeltRewardPreview()
        else
            self:GetSmeltRewardPreview_ScrollView():ResetPosition()
        end
        if isChangedEarning then
            self:RefreshSmeltEarning()
        end
        if isChangedConsume then
            self:RefreshSmeltConsume()
        end
        bagGrid:RefreshSingleGrid(bagItemInfo, bagItemInfo.ItemTABLE)
    else
        Utility.ShowPopoTips(bagGrid.go.transform, nil, 358, "UIBagPanel")
    end
end

--endregion

--endregion

--region 熔炼相关

--region view


function UIBagMain_Smelt:InitRewardList()
    ---刷新默认预览
    local defaultReward = LuaGlobalTableDeal.GetSmeltDefaultRewardPreview()
    if defaultReward == nil then
        return
    end
    self:GetSmeltRewardPreview_Grid().MaxCount = Utility.GetTableCount(defaultReward)
    for i = 1, Utility.GetTableCount(defaultReward) do
        local go = self:GetSmeltRewardPreview_Grid().controlList[i - 1]
        self:RefreshItemTemplate(go, { id = tonumber(defaultReward[i]), isShowEffect = false })
    end
end

---刷新熔炼视图
---@private
function UIBagMain_Smelt:RefreshSmeltView()
    self:RefreshSmeltRewardPreview()
    self:RefreshSmeltEarning()
    self:RefreshSmeltConsume()
end

---刷新收益预览
---@private
function UIBagMain_Smelt:RefreshSmeltEarning()
    local count = 0
    self:GetSmeltEarning_Grid().MaxCount = 0
    for k, v in pairs(self:GetSmeltEarningItemDic()) do
        if v ~= 0 then
            count = count + 1
            self:GetSmeltEarning_Grid().MaxCount = count
            local go = self:GetSmeltEarning_Grid().controlList[count - 1]
            if go and not CS.StaticUtility.IsNull(go) then
                local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")
                local label = CS.Utility_Lua.GetComponent(go, "Top_UILabel")
                if icon and not CS.StaticUtility.IsNull(icon) then
                    local isFind, itemInfo = self:GetCSItemsTable():TryGetValue(k)
                    if isFind then
                        icon.spriteName = itemInfo.icon
                    end
                end
                if label and not CS.StaticUtility.IsNull(label) then
                    label.text = tostring(v)
                end
            end
        end
    end
end

---刷新消耗预览
function UIBagMain_Smelt:RefreshSmeltConsume()
    local count = 0
    self:GetSmeltEarning_Grid().MaxCount = 0
    for k, v in pairs(self:GetSmeltConsumeItemDic()) do
        if v ~= 0 then
            count = count + 1
            self:GetSmeltEarning_Grid().MaxCount = count
            local go = self:GetSmeltEarning_Grid().controlList[count - 1]
            if go and not CS.StaticUtility.IsNull(go) then
                local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")
                local label = CS.Utility_Lua.GetComponent(go, "Top_UILabel")
                if icon and not CS.StaticUtility.IsNull(icon) then
                    local isFind, itemInfo = self:GetCSItemsTable():TryGetValue(k)
                    if isFind then
                        icon.spriteName = itemInfo.icon
                    end
                end
                if label and not CS.StaticUtility.IsNull(label) then
                    label.text = tostring(v)
                end
            end
        end
    end
end

---刷新奖励预览
---@private
function UIBagMain_Smelt:RefreshSmeltRewardPreview()
    local count = 0
    self:GetSmeltRewardPreview_ScrollView():ResetPosition()
    self:GetSmeltRewardPreview_Grid().MaxCount = 0
    ---优先刷新当前概率获得的物品列表
    for k, v in pairs(self:GetCurCanGetSmeltItemDic()) do
        if v ~= 0 then
            count = count + 1
            self:GetSmeltRewardPreview_Grid().MaxCount = count
            local go = self:GetSmeltRewardPreview_Grid().controlList[count - 1]
            self:RefreshItemTemplate(go, { id = k, isShowEffect = true })
        end
    end

    ---刷新默认预览
    if LuaGlobalTableDeal.GetSmeltDefaultRewardPreview() == nil then
        return
    end
    for i, v in pairs(LuaGlobalTableDeal.GetSmeltDefaultRewardPreview()) do
        ---避免重复
        if self:GetCurCanGetSmeltItemInfo(tonumber(v)) == 0 then
            count = count + 1
            self:GetSmeltRewardPreview_Grid().MaxCount = count
            local go = self:GetSmeltRewardPreview_Grid().controlList[count - 1]
            self:RefreshItemTemplate(go, { id = tonumber(v), isShowEffect = false })
        end
    end
end

---@private
---@param go UnityEngine.GameObject
---@param value table
function UIBagMain_Smelt:RefreshItemTemplate(go, value)
    if go == nil or value == nil then
        return
    end
    local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")
    local effect = CS.Utility_Lua.GetComponent(go.transform:Find("effect"), "GameObject")
    local isFind, itemInfo = self:GetCSItemsTable():TryGetValue(value.id)
    if icon and not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = not isFind and '' or itemInfo.icon
    end
    if effect and not CS.StaticUtility.IsNull(effect) then
        effect:SetActive(value.isShowEffect)
    end
    if isFind then
        CS.UIEventListener.Get(go).LuaEventTable = self
        CS.UIEventListener.Get(go).OnClickLuaDelegate = nil
        CS.UIEventListener.Get(go).OnClickLuaDelegate = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
end

--endregion

--region UIEvent

---点击熔炼按钮
function UIBagMain_Smelt:OnSmeltBtnClickCallBack(go)
    local luaBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    ---查看消耗品是否足够
    for k, v in pairs(self:GetSmeltConsumeItemDic()) do
        local curCount = luaBagMgr:GetCoinAmount(k)
        if curCount < v then
            Utility.ShowPopoTips(go, nil, 159, "UIBagPanel")
            return
        end
    end

    local smeltList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    for k, v in pairs(self:GetSmeltBagItemsStateDic()) do
        if v then
            smeltList:Add(k)
        end
    end
    if smeltList.Count > 0 then
        networkRequest.ReqSmelt(smeltList)
    end
end

--endregion

--region NetEvent

---熔炼回包
function UIBagMain_Smelt:OnResSmeltMessageCallBack()
    self:ClearSmeltData()
    self:RefreshSmeltView()
end

--endregion

--endregion

--region otherFunc

--region 数据刷新

---获取背包物品的选中状态
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function UIBagMain_Smelt:GetBagItemSelectState(bagItemInfo)
    return self:GetSmeltBagItemsStateDic()[bagItemInfo.lid] == true
end

---设置背包物品的选中状态
---@param bagItemInfo bagV2.BagItemInfo
---@param isSelected boolean
function UIBagMain_Smelt:SetBagItemSelectState(bagItemInfo, isSelected)
    self:GetSmeltBagItemsStateDic()[bagItemInfo.lid] = isSelected
end

---获取熔炼物品的状态
---@param itemID number
---@return boolean
function UIBagMain_Smelt:GetCurCanGetSmeltItemInfo(itemID)
    return self:GetCurCanGetSmeltItemDic()[itemID] == nil and 0 or self:GetCurCanGetSmeltItemDic()[itemID]
end

---设置熔炼物品的状态
---@param num number
function UIBagMain_Smelt:SetCurCanGetSmeltItemState(itemID, num)
    if self:GetCurCanGetSmeltItemDic()[itemID] == nil then
        self:GetCurCanGetSmeltItemDic()[itemID] = num < 0 and 0 or num
    else
        local curNum = self:GetCurCanGetSmeltItemDic()[itemID]
        curNum = curNum + num < 0 and 0 or curNum + num
        self:GetCurCanGetSmeltItemDic()[itemID] = curNum
    end
end

---获取熔炼收益
---@param itemID number
---@return boolean
function UIBagMain_Smelt:GetSmeltEarningItemInfo(itemID)
    return self:GetSmeltEarningItemDic()[itemID] == nil and 0 or self:GetSmeltEarningItemDic()[itemID]
end

---设置熔炼收益
---@param num number
function UIBagMain_Smelt:SetSmeltEarningItemInfo(itemID, num)
    if self:GetSmeltEarningItemDic()[itemID] == nil then
        self:GetSmeltEarningItemDic()[itemID] = num < 0 and 0 or num
    else
        local curNum = self:GetSmeltEarningItemDic()[itemID]
        curNum = curNum + num < 0 and 0 or curNum + num
        self:GetSmeltEarningItemDic()[itemID] = curNum
    end
end

---获取熔炼消耗
---@param itemID number
---@return boolean
function UIBagMain_Smelt:GetSmeltConsumeItemInfo(itemID)
    return self:GetSmeltConsumeItemDic()[itemID] == nil and 0 or self:GetSmeltConsumeItemDic()[itemID]
end

---设置熔炼消耗
---@param num number
function UIBagMain_Smelt:SetSmeltConsumeItemInfo(itemID, num)
    if self:GetSmeltConsumeItemDic()[itemID] == nil then
        self:GetSmeltConsumeItemDic()[itemID] = num < 0 and 0 or num
    else
        local curNum = self:GetSmeltConsumeItemDic()[itemID]
        curNum = curNum + num < 0 and 0 or curNum + num
        self:GetSmeltConsumeItemDic()[itemID] = curNum
    end
end

---刷新当前熔炼信息及状态
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 是否需要刷新奖励预览
---@return boolean 是否需要刷新收益预览
function UIBagMain_Smelt:RefreshCurSmeltData(bagItemInfo)
    local isSelect = not (self:GetBagItemSelectState(bagItemInfo))
    self:SetBagItemSelectState(bagItemInfo, isSelect)
    if bagItemInfo.ItemTABLE == nil then
        return false, false
    end
    local isRewardChange, isSmeltEarningChange, isSmeltConsumeChange = false

    if bagItemInfo.ItemTABLE.smelt ~= nil and bagItemInfo.ItemTABLE.smelt.list ~= nil then
        for i = 0, bagItemInfo.ItemTABLE.smelt.list.Count - 1 do
            local smeltInfoList = bagItemInfo.ItemTABLE.smelt.list[i]
            if smeltInfoList.list ~= nil and smeltInfoList.list.Count > 1 then
                local origionNum = self:GetSmeltEarningItemInfo(smeltInfoList.list[0])
                ---获取格子所有数量的收益
                local allNum = smeltInfoList.list[1] * bagItemInfo.count
                self:SetSmeltEarningItemInfo(smeltInfoList.list[0], isSelect and allNum or allNum * -1)
                local num = self:GetSmeltEarningItemInfo(smeltInfoList.list[0])
                if origionNum ~= num then
                    isSmeltEarningChange = true
                end
            end
        end
    end

    if bagItemInfo.ItemTABLE.smeltExtra ~= nil and bagItemInfo.ItemTABLE.smeltExtra.list ~= nil then
        for i = 0, bagItemInfo.ItemTABLE.smeltExtra.list.Count - 1 do
            local smeltInfoList = bagItemInfo.ItemTABLE.smeltExtra.list[i]
            if smeltInfoList ~= nil and smeltInfoList.list.Count > 0 then
                local origionNum = self:GetCurCanGetSmeltItemInfo(smeltInfoList.list[0])
                self:SetCurCanGetSmeltItemState(smeltInfoList.list[0], isSelect and 1 or -1)
                local num = self:GetCurCanGetSmeltItemInfo(smeltInfoList.list[0])
                if (origionNum == 0 and num ~= 0) or (origionNum ~= 0 and num == 0) then
                    isRewardChange = true
                end
            end
        end
    end

    local consumeInfo = LuaGlobalTableDeal.GetSmeltConsumeItemInfo()

    if consumeInfo then
        local origionNum = self:GetSmeltConsumeItemInfo(consumeInfo.itemId)
        ---获取格子所有数量的收益
        local allNum = consumeInfo.count * bagItemInfo.count
        self:SetSmeltConsumeItemInfo(consumeInfo.itemId, isSelect and allNum or allNum * -1)
        local num = self:GetSmeltConsumeItemInfo(consumeInfo.itemId)
        isSmeltConsumeChange = origionNum ~= num
    end

    return false, false, isSmeltConsumeChange
end

function UIBagMain_Smelt:ClearSmeltData()
    self.DefaultItems = {}
    self.mSmeltBagItemsStateDic = {}
    self.mSmeltEarningItemDic = {}
    self.mCurCanGetSmeltItemDic = {}
    self.mSmeltConsumeItemDic = {}
end

--endregion

---判断是否符合熔炼
---@private
function UIBagMain_Smelt:IsAvailableForSemelt(bagItemInfo)
    return bagItemInfo.ItemTABLE ~= nil and
            bagItemInfo.ItemTABLE.smelt ~= nil and
            bagItemInfo.ItemTABLE.smelt.list ~= nil and
            bagItemInfo.ItemTABLE.smelt.list.Count > 0
end

function UIBagMain_Smelt:OnDestroy()
    if uiStaticParameter.mUnionSmeltBagItemInfoLid ~= 0 then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Guild_Smelt)
        uiStaticParameter.mUnionSmeltBagItemInfoLid = 0
    end
end
--endregion

return UIBagMain_Smelt
