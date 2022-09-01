---@class UICollectionPagePictureDrawer:TemplateBase
local UICollectionPagePictureDrawer = {}

---归属的页
---@return UICollectionPageTemplate
function UICollectionPagePictureDrawer:GetOwnerPage()
    return self.mOwnerPage
end

---当前渲染的图片列表,藏品lid => UICollectionPictureTemplate
---@return table<number, UICollectionPictureTemplate>
function UICollectionPagePictureDrawer:GetPictureDic()
    if self.mPictureDic == nil then
        self.mPictureDic = {}
    end
    return self.mPictureDic
end

---@param ownerPage UICollectionPageTemplate
function UICollectionPagePictureDrawer:Init(ownerPage)
    self.mOwnerPage = ownerPage
    ---每个格子宽度
    self.mCellWidth = self:GetOwnerPage():GetGridContainer().CellWidth
    ---每个格子高度
    self.mCellHeight = self:GetOwnerPage():GetGridContainer().CellHeight
    ---单页每行的格子数量
    self.gridCountPerXLine = luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine()
    ---单页每列的格子数量
    self.gridCountPerYLine = luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn()
end

---重建藏品图片
---@param collectionItemList table<number, LuaCollectionItem>
---@param currentDraggedItemLid number
function UICollectionPagePictureDrawer:RebuildPictures(collectionItemList, currentDraggedItemLid)
    ---将所有藏品图片压入池子中
    local pictureDic = self:GetPictureDic()
    for i, v in pairs(pictureDic) do
        self:PushPictureTemplateToPool(v)
        pictureDic[i] = nil
    end
    ---刷新所有藏品的位置,图片等
    if collectionItemList ~= nil then
        for i = 1, #collectionItemList do
            local collectionItem = collectionItemList[i]
            ---不显示正在被拖拽的藏品
            local pictureTemplate = self:GetPictureTemplateFromPool()
            pictureTemplate:RefreshUI(collectionItem:GetAtlasName(), collectionItem:GetSpriteName(),
                    collectionItem:GetCollectionLid() == currentDraggedItemLid)
            pictureTemplate.go.transform.localPosition = self:GetRelativePositionForCollectionItem(collectionItem)
            pictureDic[collectionItem:GetCollectionLid()] = pictureTemplate
        end
    end
end

---获取藏品在本页的相对坐标
---@param collectionItem LuaCollectionItem
---@return UnityEngine.Vector3
function UICollectionPagePictureDrawer:GetRelativePositionForCollectionItem(collectionItem)
    if collectionItem == nil then
        return CS.UnityEngine.Vector3.zero
    end
    local originCoord = collectionItem:GetOriginCoordinate()
    local borderSizeX, borderSizeY = collectionItem:GetBorderSize()
    local localPos = self:GetOwnerPage().go.transform.localPosition
    localPos.x = -1 * (self.gridCountPerXLine * 0.5 - originCoord.x - borderSizeX * 0.5) * self.mCellWidth
    localPos.y = (self.gridCountPerYLine * 0.5 - originCoord.y - borderSizeY * 0.5) * self.mCellHeight
    return localPos
end

---获取一个PictureTemplate
---@return UICollectionPictureTemplate
function UICollectionPagePictureDrawer:GetPictureTemplateFromPool()
    if self.mPool == nil then
        ---@type table<number, UICollectionPictureTemplate>
        self.mPool = {}
    end
    local summaryCount = #self.mPool
    if summaryCount > 0 then
        local temp = self.mPool[summaryCount]
        table.remove(self.mPool, summaryCount)
        temp.go:SetActive(true)
        return temp
    end
    local prefabGo = self:GetOwnerPage():GetOwner():GetCollectionTemplateGo()
    local goTemp = CS.Utility_Lua.CopyGO(prefabGo, self.go.transform)
    goTemp:SetActive(true)
    goTemp.transform:SetParent(self.go.transform)
    goTemp.transform.localScale = CS.UnityEngine.Vector3.one * 1.428571
    goTemp.transform.localRotation = CS.UnityEngine.Quaternion.identity
    local template = templatemanager.GetNewTemplate(goTemp, luaComponentTemplates.UICollectionPictureTemplate, self)
    return template
end

---压入对象池中
---@param template UICollectionPictureTemplate
function UICollectionPagePictureDrawer:PushPictureTemplateToPool(template)
    if template == nil then
        return
    end
    if self.mPool == nil then
        self.mPool = {}
    end
    template.go:SetActive(false)
    table.insert(self.mPool, template)
end

return UICollectionPagePictureDrawer