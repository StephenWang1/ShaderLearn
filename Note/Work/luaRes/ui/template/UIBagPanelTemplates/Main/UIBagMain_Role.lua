---与角色界面组合的背包界面,不筛选,被推荐的装备显示高亮,第一次打开时翻页到提示所触发的物品所在的页
---@class UIBagMain_Role:UIBagMain_Normal
local UIBagMain_Role = {}

setmetatable(UIBagMain_Role, luaComponentTemplates.UIBagMainNormal)

---@return CSBagItemHint
function UIBagMain_Role:GetBagItemHint()
    if self.mBagItemHint == nil then
        self.mBagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    end
    return self.mBagItemHint
end

--region 重写属性
---角色界面与背包界面的组合可以拖拽
---@return boolean
function UIBagMain_Role:IsItemDragAvailable()
    return true
end

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMain_Role:IsShowExpandButton()
    return CS.CSMissionManager.Instance:IsCompletedAssignMainTask(Utility.GetOpenBagPanelShowRecycleBtnTaskId()) and LuaGlobalTableDeal:IsShowQuickRecycle()
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Role:IsShowRecycleButton()
    return CS.CSMissionManager.Instance:IsCompletedAssignMainTask(Utility.GetOpenBagPanelShowRecycleBtnTaskId())
end
--endregion

--region 重写刷新方法
---刷新所有格子之前,获取推荐的装备队列
function UIBagMain_Role:BeforeRefreshAllGrids()
    self.mList = self:GetBagItemHint():GetHintList(LuaEnumMainHint_BetterBagItemType.BetterEquip)
    local betterRoleMagicEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBetterBagItemInfoLidList(LuaEnumMainHint_BetterBagItemType.RoleMagicEquip)
    if type(betterRoleMagicEquip) == 'table' and Utility.GetLuaTableCount(betterRoleMagicEquip) > 0 then
        for k,v in pairs(betterRoleMagicEquip) do
            self.mList:Add(v)
        end
    end
end

---刷新单个格子时,高亮显示提示的装备
function UIBagMain_Role:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if self.mList ~= nil then
        for i = 0, self.mList.Count - 1 do
            local temp = self.mList[i]
            if temp and bagItemInfo.lid == temp and (CS.CSScene.MainPlayerInfo.EquipInfo:IsBetterThanEquip(bagItemInfo, true) or gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckMagicEquipBetterThanBody(bagItemInfo)) then
                bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
                break
            end
        end
    end
    self:RefreshEquipDurabilityIsLess(bagGrid, bagItemInfo, itemTbl)
end
--endregion

--region 重写交互方法
---格子结束被拖拽
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@param position UnityEngine.Vector3
---@param isDestroyed boolean 是否因被销毁导致的格子拖拽结束
function UIBagMain_Role:OnGridEndBeingDragged(bagGrid, bagItemInfo, itemTbl, position, isDestroyed)
    if isDestroyed == false and self:IsPlayerEquip(itemTbl) then
        self.mPositionTemp = position
        self:TryEquipBagItem(bagGrid, bagItemInfo, itemTbl)
    end
end
--endregion

--region 重写销毁方法
function UIBagMain_Role:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    if self:GetBagPanel() and self:GetBagPanel():GetPanelOpenSourceType() == LuaEnumPanelOpenSourceType.ByItemHint
            or self:GetBagPanel():GetPanelOpenSourceType() == LuaEnumPanelOpenSourceType.ByTaskUseEquip then
        ---若由物品推荐打开的背包,则关闭的同时关闭角色界面
        if uimanager:GetPanel("UIRolePanel") ~= nil then
            uimanager:ClosePanel("UIRolePanel")
        end
    end
end
--endregion

---向服务器发送请求装备物品消息
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Role:TrySendRequestEquipPlayerItemToServer(bagGrid, bagItemInfo, itemTbl)
    if self.mPositionTemp ~= nil then
        local position = self.mPositionTemp
        self.mPositionTemp = nil
        luaEventManager.DoCallback(LuaCEvent.Role_DropBagItemOnRolePanel, { type = LuaEnumDropBagItemOnRolePanelType.ByBagPanel, position = position, bagItemInfo = bagItemInfo })
    else
        self:RunBaseFunction("TrySendRequestEquipPlayerItemToServer", bagGrid, bagItemInfo, itemTbl)
    end
end

---判断物品是否是玩家装备
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Role:IsPlayerEquip(itemTbl)
    local mainPlayerServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    if itemTbl.type ~= luaEnumItemType.Equip then
        return false
    end
    if CS.CSServantInfoV2.IsServantJustEquip(itemTbl) or CS.CSServantInfoV2.IsServantBody(itemTbl) then
        return false
    end
    return true
end

return UIBagMain_Role