local UIGMPanel_BagItemLid = {}

--region 参数
function UIGMPanel_BagItemLid:GetBtn_Refresh()
    if self.mBtn_Refresh == nil then
        self.mBtn_Refresh = self:Get("Top/Events/Btn_Refresh", "GameObject")
    end
    return self.mBtn_Refresh
end

function UIGMPanel_BagItemLid:GetUIGridItem()
    if self.mUIGridItem == nil then
        self.mUIGridItem = self:Get("Middle/GridList/Item", "UIGridContainer")
    end
    return self.mUIGridItem
end

--endregion

function UIGMPanel_BagItemLid:Init(panel)
    self:InitParams()
    self:BindEvent()
    self:RefreshBagItems()
end

function UIGMPanel_BagItemLid:InitParams()
    self.allGrid = {}
end

function UIGMPanel_BagItemLid:BindEvent()
    CS.UIEventListener.Get(self:GetBtn_Refresh()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_Refresh()).OnClickLuaDelegate = self.RefreshBagItems
end

function UIGMPanel_BagItemLid:Show(pos)
    self.go:SetActive(true)
end

function UIGMPanel_BagItemLid:Hide()
    self.go:SetActive(false)
end

function UIGMPanel_BagItemLid:RefreshBagItems()
    if self:GetUIGridItem() == nil then
        return
    end
    self.allGrid = {}
    local bagItemList = self:GetBagItems()
    if bagItemList then
        self:GetUIGridItem().MaxCount = bagItemList.Count
        local length = bagItemList.Count - 1
        for k = 0, length do
            local bagItemInfo = bagItemList[k]
            local grid = self:GetUIGridItem().controlList[k]
            local gridTemplate = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIGMItemTemplate_BagItemLid)
            gridTemplate:ReFreshUI(bagItemInfo)
            self.allGrid[grid] = gridTemplate
        end
    end
end

---获取背包物品
function UIGMPanel_BagItemLid:GetBagItems()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BagInfo ~= nil then
        return CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemList()
    end
    return nil
end
return UIGMPanel_BagItemLid