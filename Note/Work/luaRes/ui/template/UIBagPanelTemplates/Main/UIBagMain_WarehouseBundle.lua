---仓库打捆
---@class UIBagMain_WarehouseBundle:UIBagMain_Normal
local UIBagMain_WarehouseBundle = {}

setmetatable(UIBagMain_WarehouseBundle, luaComponentTemplates.UIBagMainNormal)

function UIBagMain_WarehouseBundle:IsShowCloseButton()
    return false
end

function UIBagMain_WarehouseBundle:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_WarehouseBundle:IsShowRecycleButton()
    return false
end

function UIBagMain_WarehouseBundle:OnInit()
    self.mCustomData.chosenBagItemIDs = nil
    self.mOnBundlingPitchCallback = function(msgID, lidList)
        self:SetSelectLid(lidList)
    end
end

function UIBagMain_WarehouseBundle:OnEnable()
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.BundlingPitch, self.mOnBundlingPitchCallback)
    self:RunBaseFunction("OnEnable")
end

function UIBagMain_WarehouseBundle:OnDisable()
    self:RunBaseFunction("OnDisable")
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.BundlingPitch, self.mOnBundlingPitchCallback)
end

function UIBagMain_WarehouseBundle:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    ---刷新仓库格子新物品特效
    self:RefreshBundleBagGridNewEffect(bagGrid, bagItemInfo, itemTbl)
end

function UIBagMain_WarehouseBundle:RefreshGrids()
    self:RunBaseFunction("RefreshGrids")
end

---根据lid找到背包格子并设置选中
function UIBagMain_WarehouseBundle:SetSelectLid(lidList)
    self.selectLidList = lidList
    if lidList ~= nil and #lidList > 0 then
        local itemLid = lidList[1]
        if itemLid and CS.CSScene.MainPlayerInfo ~= nil then
            local bagItem
            ___, bagItem = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(itemLid)
            if bagItem ~= nil then
                local pageIndex = self:GetPageIndexOfBagItem(bagItem);
                if pageIndex ~= nil and pageIndex ~= -1 then
                    self:SwitchToPage(pageIndex, true)
                end
            end
        end
    end
end

---刷新仓库格子新物品特效
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_WarehouseBundle:RefreshBundleBagGridNewEffect(bagGrid, bagItemInfo, itemTbl)
    if self.selectLidList ~= nil then
        for i = 1, #self.selectLidList do
            local v = self.selectLidList[i]
            if v == bagItemInfo.lid then
                bagGrid:SetCompActive(bagGrid.Components.NewBagItemEffect, true)
                table.remove(self.selectLidList, i)
                break
            end
        end
        if #self.selectLidList == 0 then
            self.selectLidList = nil
        end
    end
end

return UIBagMain_WarehouseBundle