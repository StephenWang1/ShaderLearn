---@class UIBagMain_JianDing:UIBagMain_Normal
local UIBagMain_JianDing = {}

setmetatable(UIBagMain_JianDing, luaComponentTemplates.UIBagMainNormal)

---当前选中格子id
UIBagMain_JianDing.mCurrentChooseItemId = nil
---当前选中格子
UIBagMain_JianDing.mCurrentChooseGrid = nil

--region 属性
---获取背包信息
function UIBagMain_JianDing:GetBagInfoV2()
    if self.mBagInfoV2 == nil then
        self.mBagInfoV2 = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfoV2
end
--endregion

--region重写属性
---是否使用服务器排序
function UIBagMain_JianDing:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_JianDing:IsShowCloseButton()
    return false
end

---是否显示扩展按钮
function UIBagMain_JianDing:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_JianDing:IsShowRecycleButton()
    return false
end

function UIBagMain_JianDing:IsItemDoubleClickedAvailable()
    return false
end
--endregion

--region重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_JianDing:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        local canJianDing = self:GetJianDingTable(bagItemInfo)
        if canJianDing then
            luaEventManager.DoCallback(LuaCEvent.JianDingClick, bagItemInfo)
        else
            CS.Utility.ShowTips("此装备无法被鉴定", 1)
        end
    end
end

---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_JianDing:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if self:GetJianDingTable(bagItemInfo) == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

--endregion

function UIBagMain_JianDing:GetJianDingTable(bagItemInfo)
    local Lua_jianDingTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if  Lua_jianDingTABLE:GetJianDing() == 1 then
        return true
    else
        return false
    end
end

return UIBagMain_JianDing