---@class UIBagMain_Mosaic:UIBagMain_Normal 背包与融合面板组合时
local UIBagMain_Mosaic = {}

setmetatable(UIBagMain_Mosaic, luaComponentTemplates.UIBagMainNormal)

UIBagMain_Mosaic.lastLightGridID = nil

UIBagMain_Mosaic.curEquipInfo = nil

---本背包主界面控制器生效时触发
---@protected
function UIBagMain_Mosaic:OnInit()
    self:RunBaseFunction('OnInit')
    self.curEquipInfo = self.mCustomData.medalInlayBagInfo
    self.lastLightGridID = self.mCustomData.medalInlayBagInfo == nil and 0 or self.mCustomData.medalInlayBagInfo.lid
end

function UIBagMain_Mosaic:OnEnable()
    self:RunBaseFunction('OnEnable')
    self.medalInlayClickCallBack = function(msgID, bagItemInfo)
        self:OnMedalInlayClick(msgID, bagItemInfo)
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.MedalInlay_SelectOfBag, self.medalInlayClickCallBack)
end


---点击物品格子
---@privateUIAppearancePanelAppellationInfoTemplate
function UIBagMain_Mosaic:OnMedalInlayClick(msgID, bagItemInfo)
    if self.curEquipInfo ~= nil and bagItemInfo ~= nil then
        if self.curEquipInfo.lid == bagItemInfo.lid then
            return
        end
    end
    self.curEquipInfo = bagItemInfo
    local lastBagGrid = self:GetBagPanel():GetBagGrid(self.lastLightGridID)
    if lastBagGrid then
        lastBagGrid:Refresh()
    end
    self.lastLightGridID = bagItemInfo == nil and 0 or bagItemInfo.lid
    if bagItemInfo then
        local bagGrid = self:GetBagPanel():GetBagGrid(bagItemInfo.lid)
        if bagGrid then
            bagGrid:Refresh()
        end
    end
end


--region 重写属性
function UIBagMain_Mosaic:IsUseServerOrder()
    return false
end
--endregion

---格子被单击
---@protected
---@param bagGrid UIBagGrid 被点击的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMain_Mosaic:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if itemTbl.type == luaEnumItemType.Equip and (itemTbl.subType == LuaEnumEquiptype.DoubleMedal or itemTbl.subType == LuaEnumEquiptype.Medal) then
        ---如果勋章不可装备return
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo ~= nil then
            if itemTbl ~= nil and not CS.CSScene.MainPlayerInfo.EquipInfo:MedalIsCanEquiped(itemTbl) then
                Utility.ShowPopoTips(bagGrid.go.transform, nil, 209)
                return
            end
        end
        if luaEventManager.HasCallback(LuaCEvent.Bag_GridSingleClicked) then
            luaEventManager.DoCallback(LuaCEvent.Bag_GridSingleClicked, bagItemInfo)
        end
        self.curEquipInfo = bagItemInfo
        local lastBagGrid = self:GetBagPanel():GetBagGrid(self.lastLightGridID)
        if lastBagGrid then
            lastBagGrid:Refresh()
        end
        self.lastLightGridID = bagItemInfo.lid
        bagGrid:Refresh()

    end
end


---双击点击时,尝试使用物品
function UIBagMain_Mosaic:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    self:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
end

---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_Mosaic:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMain_Mosaic:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Mosaic:IsShowRecycleButton()
    return false
end

function UIBagMain_Mosaic:OnDisable()
    self:RunBaseFunction('OnDisable')
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.MedalInlay_SelectOfBag, self.medalInlayClickCallBack)
end

--region 重写刷新格子方法
---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Mosaic:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction('RefreshSingleGrid', bagGrid, bagItemInfo, itemTbl)
    --置灰其他的
    if self:FilterLightBagItem(bagItemInfo, itemTbl) == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
    if bagItemInfo then
        if self.curEquipInfo == nil then
            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, false)
        else
            if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo ~= nil then
                if itemTbl ~= nil and not CS.CSScene.MainPlayerInfo.EquipInfo:MedalIsCanEquiped(itemTbl) then
                    return
                end
            end
            if bagItemInfo.lid == self.curEquipInfo.lid then
                if luaEventManager.HasCallback(LuaCEvent.MedalInlay_Select) then
                    luaEventManager.DoCallback(LuaCEvent.MedalInlay_Select, bagItemInfo)
                end
            end
            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, bagItemInfo.lid == self.curEquipInfo.lid)
        end
    end
end

---刷新输入的背包格子选中状态
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Mosaic:RefreshInputChosenBagGridState(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction('RefreshSingleGrid', bagGrid, bagItemInfo, itemTbl)
    --if bagItemInfo and bagGrid:GetCompActive(bagGrid.Components.ChosenEffect) == false then
    --    if self:GetGoodEquip() ~= nil then
    --        if self:GetGoodEquip().lid == bagItemInfo.lid then
    --            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
    --            self.lastLightGridID = bagItemInfo.lid

    --        end
    --    end
    --end
end


--[[--region 重写格子筛选方法
---只筛选出相同子类的材料(勋章、双倍勋章)
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Mosaic:BagItemFilterFunction(bagItemInfo, itemInfo)
    if itemInfo then
        if itemInfo.type == luaEnumItemType.Equip and (itemInfo.subType == LuaEnumEquiptype.DoubleMedal or itemInfo.subType == LuaEnumEquiptype.Medal) then
            return true
        end
    end
    return false
end]]

---筛选出亮的物品(正常显示的物品,否则灰色显示该物品)
function UIBagMain_Mosaic:FilterLightBagItem(bagItemInfo, itemTbl)
    if itemTbl then
        if itemTbl.type == luaEnumItemType.Equip and (itemTbl.subType == LuaEnumEquiptype.DoubleMedal or itemTbl.subType == LuaEnumEquiptype.Medal) then
            return true
        end
    end
    return false
end

--endregion

return UIBagMain_Mosaic