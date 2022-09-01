---其他玩家的藏品控制器
---@class UICollectionItemsController_OtherPlayer:UICollectionItemsController
local UICollectionItemsController_OtherPlayer = {}

setmetatable(UICollectionItemsController_OtherPlayer, luaComponentTemplates.UICollectionItemsController)

---藏品交互层
---@return UIBagTypeContainerInteraction
function UICollectionItemsController_OtherPlayer:GetCollectionInteraction()
    if self.mCollectionInteraction == nil then
        self.mCollectionInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UICollectionTypeContainerInteraction_OtherPlayer,
                self:GetOwnerPanel(),
                self:GetDraggableCollectionItem(),
                self:GetScrollView()
        )
    end
    return self.mCollectionInteraction
end

function UICollectionItemsController_OtherPlayer:CalculatePageCount()
    local collectionInfo = self:GetOwnerPanel():GetCollectionInfo()
    local pageCount = 0
    for i, v in pairs(collectionInfo:GetCollectionDic()) do
        pageCount = math.max(pageCount, v:GetPageIndex())
    end
    return pageCount
end

---执行单击
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param isLocked boolean 是否是被锁住的格子
function UICollectionItemsController_OtherPlayer:DoGridSingleClick(grid, mCollectionItem, isLocked)
    if mCollectionItem == nil or mCollectionItem:GetCollectionBagItem() == nil then
        return
    end
    local otherCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local roleId
    if gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo ~= nil then
        otherCareer = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo.career
        roleId = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo.roleId
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        bagItemInfo = mCollectionItem:GetCollectionBagItem(),
        showRight = false,
        showAssistPanel = false,
        career = otherCareer,
        showMoreAssistData = false,
        showTabBtns = false,
        showBind = true,
        showAction = false,
        roleId = roleId })
end

return UICollectionItemsController_OtherPlayer