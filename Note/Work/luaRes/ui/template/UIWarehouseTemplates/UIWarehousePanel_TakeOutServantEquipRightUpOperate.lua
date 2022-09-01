---仓库取出物品Tips右上按钮模板
---@class UIWarehousePanel_TakeOutServantEquipRightUpOperate:UIWarehousePanel_UIItemInfoServantEquipRightUpOperate
local UIWarehousePanel_TakeOutServantEquipRightUpOperate = {}

setmetatable(UIWarehousePanel_TakeOutServantEquipRightUpOperate, luaComponentTemplates.UIWarehousePanel_UIItemInfoServantEquipRightUpOperate)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIWarehousePanel_TakeOutServantEquipRightUpOperate:RefreshWithInfo(commonData)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    if self.mBagItemInfo and self.mItemInfo then
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = 1
            local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
            --local buttonGOQuit = self:GetBtns_UIGridContainer().controlList[1]
            self:SetButtonShow(buttonGO, LuaEnumStorageTipsType.TakeOut)
            --self:SetButtonShow(buttonGOQuit, LuaEnumStorageTipsType.Quit)
            ---右上角按钮展开收起自适应
            --self:AdaptButton()
            self:GetShowClose_GameObject():SetActive(false)
            self:BGSelfAdaptaion()
        end
    end
end

return UIWarehousePanel_TakeOutServantEquipRightUpOperate