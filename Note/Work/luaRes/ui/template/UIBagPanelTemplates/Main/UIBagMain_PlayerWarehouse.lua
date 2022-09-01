---@class UIBagMain_PlayerWarehouse:UIBagMain_Normal
local UIBagMain_PlayerWarehouse = {}

local Utility = Utility

setmetatable(UIBagMain_PlayerWarehouse, luaComponentTemplates.UIBagMainNormal)

--region 重写属性
---是否显示关闭按钮
function UIBagMain_PlayerWarehouse:IsShowCloseButton()
    return false
end

---是都显示扩展按钮
function UIBagMain_PlayerWarehouse:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_PlayerWarehouse:IsShowRecycleButton()
    return false
end

---是否可双击
function UIBagMain_PlayerWarehouse:IsItemDoubleClickedAvailable()
    return uimanager:GetPanel("UIPlayerWarehousePanel") ~= nil
end

---是否可拖拽
function UIBagMain_PlayerWarehouse:IsItemDragAvailable()
    return uimanager:GetPanel("UIPlayerWarehousePanel") ~= nil
end
--endregion

--region 重写方法
---初始化时,监听个人仓库关闭事件,关闭时也将关闭本背包
function UIBagMain_PlayerWarehouse:OnInit()
    self:RunBaseFunction("OnInit")
    self:GetBagPanel():GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function(id, panelName)
        if self:IsOn() and panelName == "UIPlayerWarehousePanel" then
            uimanager:ClosePanel("UIBagPanel")
        end
    end)
end

---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_PlayerWarehouse:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        if itemTbl.save == 1 then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, rightUpButtonsModule = luaComponentTemplates.UIWarehousePanel_UIItemInfoServantEquipRightUpOperate, showRight = true, showBind = true, showBind = true })
        else
            Utility.ShowPopoTips(bagGrid.go, nil, 116)
        end
    end
end

---双击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_PlayerWarehouse:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        if itemTbl.save == 1 then
            networkRequest.ReqStorageInItem(bagItemInfo.lid)
        else
            Utility.ShowPopoTips(bagGrid.go, nil, 116)
        end
    end
end

function UIBagMain_PlayerWarehouse:OnGridBeingDragged(bagGrid, bagItemInfo, itemTbl, position)
    if bagGrid and bagItemInfo and itemTbl and position then
        if itemTbl.save ~= 1 then
            Utility.ShowPopoTips(bagGrid.go, nil, 116)
        end
    end
end

---聚灵珠未存满时不可存入仓库
function UIBagMain_PlayerWarehouse:IsGridCanBeDragged(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        if itemTbl.save ~= 1 then
            Utility.ShowPopoTips(bagGrid.go, nil, 116)
            return false
        end
    end
    return true
end

function UIBagMain_PlayerWarehouse:OnGridEndBeingDragged(bagGrid, bagItemInfo, itemTbl, position, isDestroyed)
    luaEventManager.DoCallback(LuaCEvent.Storage_DropItemOnStoragePanel, { position = position, bagItemInfo = bagItemInfo })
end

---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_PlayerWarehouse:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if itemTbl.save ~= 1 then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end
--endregion

return UIBagMain_PlayerWarehouse