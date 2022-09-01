---@class UIChatPanel_BagPanel:TemplateBase 聊天背包模板
local UIChatPanel_BagPanel = {}

UIChatPanel_BagPanel.mBookMark = {
    [true] = "scrlight",
    [false] = "scrbg",
}

--region 信息
---@return CSPlayerInfo 玩家信息
function UIChatPanel_BagPanel:GetPlayerInfo()
    if self.playerInfo == nil then
        self.playerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.playerInfo
end

---@return CSBagInfoV2 背包信息
function UIChatPanel_BagPanel:GetBagInfo()
    if self.mBagInfo == nil then
        if self:GetPlayerInfo() then
            self.mBagInfo = self:GetPlayerInfo().BagInfo
        end
    end
    return self.mBagInfo
end

---@return CSEquipInfoV2 身上装备信息
function UIChatPanel_BagPanel:GetEquipInfo()
    if self.mEquipInfo == nil then
        if self:GetPlayerInfo() then
            self.mEquipInfo = self:GetPlayerInfo().EquipInfo
        end
    end
    return self.mEquipInfo
end
--endregion

--region 组件
---@return UIPageRecyclingContainer1T 背包控制器
function UIChatPanel_BagPanel:GetBagRecycle_UIPageRecyclingContainerForGameObject()
    if self.mRecycleGp == nil then
        self.mRecycleGp = self:Get("Scroll View", "UIPageRecyclingContainerForGameObject")
    end
    return self.mRecycleGp
end

---@return UIGridContainer 页签
function UIChatPanel_BagPanel:GetBookMark_UIGridContainer()
    if self.mBookMarkContainer == nil then
        self.mBookMarkContainer = self:Get("grid", "UIGridContainer")
    end
    return self.mBookMarkContainer
end

--endregion

function UIChatPanel_BagPanel:Init()

end

--region 背包
function UIChatPanel_BagPanel:SwitchToBagState()
    self:InitBagBookMark()
    self:InitRecycleBagData()
end

---初始/重置循环背包数据
function UIChatPanel_BagPanel:InitRecycleBagData()
    self:GetBagRecycle_UIPageRecyclingContainerForGameObject():Initialize(self:GetBagMaxPageCount(), function(pageObj, pageIndex)
        self:OnPageEnterView(pageObj, pageIndex)
    end, nil, function(page)
        self:OnCenterPageIndexChanged(page)
    end, 0)
end

---@return number 每页格子数
function UIChatPanel_BagPanel:GetPerPageGridNum()
    return 12
end

---@return number 背包最大格子数
function UIChatPanel_BagPanel:GetBagMaxGridCount()
    return self:GetBagInfo().MaxGridCount
end

---获取背包最大页数
function UIChatPanel_BagPanel:GetBagMaxPageCount()
    local pageCount = 0
    if self:GetPerPageGridNum() ~= 0 then
        pageCount = math.ceil(self:GetBagMaxGridCount() / self:GetPerPageGridNum())
    end
    if pageCount <= 0 then
        pageCount = 1
    end
    return pageCount
end

---背包页进入视野
function UIChatPanel_BagPanel:OnPageEnterView(pageObj, pageIndex)
    --- System.Collections.Generic.List1bagV2.BagItemInfo
    local bagItemList = self:GetBagInfo():GetBagItemList()
    local container = CS.Utility_Lua.GetComponent(pageObj.transform:Find("UIGridItem"), "UIGridContainer")
    container.MaxCount = self:GetPerPageGridNum()
    for i = 0, container.controlList.Count - 1 do
        local gp = container.controlList[i]
        ---@type UIChatPanel_BagPanelGridTemplate
        local template = self:GetGridTemplate(gp)
        local index = self:GetPerPageGridNum() * pageIndex + i
        if index < bagItemList.Count then
            local bagItemInfo = bagItemList[index]
            local itemInfo
            if bagItemInfo and bagItemInfo.ItemTABLE then
                itemInfo = bagItemInfo.ItemTABLE
            end
            template:RefreshWithInfo(bagItemInfo, itemInfo, false)
        else
            template:RefreshWithInfo(nil, nil, false)
        end
    end
end

---这里逻辑是原来聊天的逻辑，有问题找于金洋
function UIChatPanel_BagPanel:GetShowBagList()
    local tempList = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
    local templist1 = self:GetBagInfo():GetBagItemInfoExceptForCollection()
    local templist2 = self:GetBagInfo():GetBagItemInfoOnlyCollection()
    tempList:AddRange(templist2)
    tempList:AddRange(templist1)

    local tempList2 = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
    for i = 0, tempList.Count - 1 do
        ---@type bagV2.BagItemInfo
        local bagItem = tempList[i]
        local tbl = bagItem.ItemTABLE
        if tbl ~= nil then
            tempList2:Add(bagItem)
        end
    end
    return tempList2
end

---获取背包格子模板
---@param go UnityEngine.GameObject 背包格子
---@return UIChatPanel_BagPanelGridTemplate
function UIChatPanel_BagPanel:GetGridTemplate(go)
    if CS.StaticUtility.IsNull(go) then
        return nil
    end
    if self.mBagGridToTemplate == nil then
        self.mBagGridToTemplate = {}
    end
    local gridTemplate = self.mBagGridToTemplate[go]
    if gridTemplate == nil then
        ---@type UIChatPanel_BagPanelGridTemplate
        gridTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIChatPanel_BagPanelGridTemplate, nil, self:GetChatBagInteraction(), function(name)
            return self:FetchComponent(name)
        end)
        self.mBagGridToTemplate[go] = gridTemplate
    end
    return gridTemplate
end

---刷新中心页
function UIChatPanel_BagPanel:OnCenterPageIndexChanged(page)
    self:ChooseCurrentPage(page)
end

---初始页签
function UIChatPanel_BagPanel:InitBagBookMark()
    self:GetBookMark_UIGridContainer().MaxCount = self:GetBagMaxPageCount()
    if self:GetBookMark_UIGridContainer().controlList then
        for i = 0, self:GetBookMark_UIGridContainer().controlList.Count - 1 do
            local go = self:GetBookMark_UIGridContainer().controlList[i]
            self:RefreshPage(go, false)
        end
    end
    self:ChooseCurrentPage(0)
end
--endregion

--region 身上装备
function UIChatPanel_BagPanel:SwitchToBodyState()
    self:InitBodyBookMark()
    self:InitRecycleBodyData()
end

---初始/重置循环背包数据
function UIChatPanel_BagPanel:InitRecycleBodyData()
    self:GetBagRecycle_UIPageRecyclingContainerForGameObject():Initialize(self:GetBodyMaxPageCount(), function(pageObj, pageIndex)
        self:OnBodyPageEnterView(pageObj, pageIndex)
    end, nil, function(page)
        self:OnBodyCenterPageIndexChanged(page)
    end, 0)
end

---@return number 身上最大格子数
function UIChatPanel_BagPanel:GetBodyMaxGridCount()
    return 15
end

---获取身上最大页数
function UIChatPanel_BagPanel:GetBodyMaxPageCount()
    local pageCount = 0
    if self:GetPerPageGridNum() ~= 0 then
        pageCount = math.ceil(self:GetBodyMaxGridCount() / self:GetPerPageGridNum())
    end
    if pageCount <= 0 then
        pageCount = 1
    end
    return pageCount
end

---背包页进入视野
function UIChatPanel_BagPanel:OnBodyPageEnterView(pageObj, pageIndex)
    --- System.Collections.Generic.List1bagV2.BagItemInfo
    local bagItemList = self:GetBodyShowBagList()
    local container = CS.Utility_Lua.GetComponent(pageObj.transform:Find("UIGridItem"), "UIGridContainer")
    container.MaxCount = self:GetPerPageGridNum()
    for i = 0, container.controlList.Count - 1 do
        local gp = container.controlList[i]
        local template = self:GetGridTemplate(gp)
        local index = self:GetPerPageGridNum() * pageIndex + i
        if index < bagItemList.Count then
            local bagItemInfo = bagItemList[index]
            local itemInfo
            if bagItemInfo and bagItemInfo.ItemTABLE then
                itemInfo = bagItemInfo.ItemTABLE
            end
            template:RefreshWithInfo(bagItemInfo, itemInfo, false)
        else
            template:RefreshWithInfo(nil, nil, false)
        end
    end
end

---这里逻辑是原来聊天的逻辑，有问题找于金洋
function UIChatPanel_BagPanel:GetBodyShowBagList()
    local tempList2 = CS.System.Collections.Generic["List`1[bagV2.BagItemInfo]"]()
    local list = self:GetEquipInfo():GetBodyEquipsList()
    for i = 0, list.Count - 1 do
        ---@type bagV2.BagItemInfo
        local equipData = list[i]
        if equipData ~= nil then
            tempList2:Add(equipData)
        end
    end
    return tempList2
end

---刷新中心页
function UIChatPanel_BagPanel:OnBodyCenterPageIndexChanged(page)
    self:ChooseCurrentPage(page)
end

---初始页签
function UIChatPanel_BagPanel:InitBodyBookMark()
    self:GetBookMark_UIGridContainer().MaxCount = self:GetBodyMaxPageCount()
    for i = 0, self:GetBookMark_UIGridContainer().controlList.Count - 1 do
        local go = self:GetBookMark_UIGridContainer().controlList[i]
        self:RefreshPage(go, false)
    end
    self:ChooseCurrentPage(0)
end
--endregion

--region 通用
---@return UnityEngine.GameObject 背包复制用格子
function UIChatPanel_BagPanel:GetBagPrefab()
    if self.mCopyGo == nil then
        self.mCopyGo = self:Get("itemTemplateComponents", "GameObject")
    end
    return self.mCopyGo
end

---交互
---@return UIChatPanel_BagPanel_Interaction
function UIChatPanel_BagPanel:GetChatBagInteraction()
    if self.mInteraction == nil then
        self.mInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIChatPanel_BagPanel_Interaction, self, nil, nil)
    end
    return self.mInteraction
end

---获取背包格子模板组件
---@param name string 组件名字
---@return UnityEngine.GameObject 组件
function UIChatPanel_BagPanel:FetchComponent(name)
    if self.NameToGo == nil then
        self.NameToGo = {}
    end
    local go = self.NameToGo[name]
    if CS.StaticUtility.IsNull(go) and self:GetBagPrefab() then
        go = CS.Utility_Lua.Get(self:GetBagPrefab().transform, name, "GameObject")
    end
    return go
end

---刷新页签显示
function UIChatPanel_BagPanel:RefreshPage(go, isChoose)
    if CS.StaticUtility.IsNull(go) or isChoose == nil then
        return
    end
    if self.mGoToSprite == nil then
        self.mGoToSprite = {}
    end
    ---@type UISprite
    local sprite = self.mGoToSprite[go]
    if sprite == nil then
        sprite = CS.Utility_Lua.GetComponent(go.transform, "UISprite")
    end
    sprite.spriteName = self.mBookMark[isChoose]
end

---选中某页页签
function UIChatPanel_BagPanel:ChooseCurrentPage(pageIndex)
    if self:GetBookMark_UIGridContainer().controlList then
        if self.mCurrentPage and self.mCurrentPage < self:GetBookMark_UIGridContainer().controlList.Count then
            local lastGo = self:GetBookMark_UIGridContainer().controlList[self.mCurrentPage]
            self:RefreshPage(lastGo, false)
        end
        if pageIndex and pageIndex < self:GetBookMark_UIGridContainer().controlList.Count then
            local go = self:GetBookMark_UIGridContainer().controlList[pageIndex]
            self:RefreshPage(go, true)
            self.mCurrentPage = pageIndex
        end
    end
end

--endregion

return UIChatPanel_BagPanel