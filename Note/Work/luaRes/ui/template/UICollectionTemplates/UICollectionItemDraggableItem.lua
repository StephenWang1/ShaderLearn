---@class UICollectionItemDraggableItem:UIBagTypeDraggableItem
local UICollectionItemDraggableItem = {}

setmetatable(UICollectionItemDraggableItem, luaComponentTemplates.UIBagType_DraggableItem)

---获取依赖界面,拖拽时层级设置在依赖界面所在层的最高层
---@public
---@return UICollectionPanel
function UICollectionItemDraggableItem:GetRelyPanel()
    return self.mRelyPanel
end

---获取自身的界面
---@return UIPanel
function UICollectionItemDraggableItem:GetSelfPanel()
    if self.mSelfPanel == nil then
        self.mSelfPanel = self:Get("", "UIPanel")
    end
    return self.mSelfPanel
end

---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param position UnityEngine.Vector3 拖拽起始的世界坐标
function UICollectionItemDraggableItem:Refresh(grid, mCollectionItem, position)
    if mCollectionItem and self:GetRelyPanel() and CS.StaticUtility.IsNull(self:GetIconSprite()) == false then
        ---设置图片
        if self.mAtlasNameCache ~= mCollectionItem:GetAtlasName() then
            self.mAtlas = self:GetRelyPanel():GetUIAtlas(mCollectionItem:GetAtlasName())
            self.mAtlasNameCache = mCollectionItem:GetAtlasName()
            self:GetIconSprite().atlas = self.mAtlas
        end
        self:GetIconSprite().spriteName = mCollectionItem:GetSpriteName()
        self:GetIconSprite():MakePixelPerfect()
        self:GetIconSprite().gameObject:SetActive(true)
        ---设置层级为ScrollView上面一层或者bagPanel上几层
        if self:GetRelyPanel() ~= nil and self:GetRelyPanel():GetCollectionItemsController() ~= nil then
            local depth = self:GetRelyPanel():GetCollectionItemsController():GetScrollView().panel.depth + 1
            local bagPanel = uimanager:GetPanel("UIBagPanel")
            if bagPanel ~= nil then
                local bagDepth = bagPanel:GetPanelDepth()
                if bagDepth then
                    depth = math.max(depth, bagDepth + 10)
                end
            end
            self:GetSelfPanel().depth = depth
        end
        ---坐标偏移初始化
        self.mWorldPosOffset = nil
        if self:GetRelyPanel() ~= nil and self:GetRelyPanel():GetCollectionItemsController() ~= nil then
            local pageTemplate = self:GetRelyPanel():GetCollectionItemsController():GetCenterPageTemplate()
            if pageTemplate ~= nil and pageTemplate:GetPagePictureDrawer() ~= nil then
                local pictureOfDraggedCollectionItem = pageTemplate:GetPagePictureDrawer():GetPictureDic()[mCollectionItem:GetCollectionLid()]
                if pictureOfDraggedCollectionItem ~= nil then
                    self.mWorldPosOffset = pictureOfDraggedCollectionItem.go.transform.position - position
                end
            end
        end
    end
end

---设置世界坐标
---@public
---@param worldPosition UnityEngine.Vector3
---@param isStartDrag boolean 是否为开始拖拽时刻的调用
function UICollectionItemDraggableItem:SetUIRootWorldPosition(worldPosition, isStartDrag)
    if CS.StaticUtility.IsNull(self.go) == false then
        if self.mWorldPosOffset ~= nil then
            self.go.transform.position = worldPosition + self.mWorldPosOffset
        else
            self.go.transform.position = worldPosition
        end
    end
end

---拖拽结束
---@public
function UICollectionItemDraggableItem:OnDragStopped()
    if CS.StaticUtility.IsNull(self.go) == false then
        self.go:SetActive(false)
    end
end

return UICollectionItemDraggableItem