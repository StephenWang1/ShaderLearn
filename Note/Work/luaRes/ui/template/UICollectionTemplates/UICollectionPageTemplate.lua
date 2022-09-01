---藏品页模板
---@class UICollectionPageTemplate:TemplateBase
local UICollectionPageTemplate = {}

---获取归属的藏品物品控制器
---@return UICollectionItemsController
function UICollectionPageTemplate:GetOwner()
    return self.mCollectionItemsController
end

---格子容器
---@return UIGridContainer
function UICollectionPageTemplate:GetGridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:Get("", "UIGridContainer")
    end
    return self.mGridContainer
end

---藏品页图片绘制
---@return UICollectionPagePictureDrawer
function UICollectionPageTemplate:GetPagePictureDrawer()
    if self.mPagePictureDrawer == nil then
        local go = self:Get("collections", "GameObject")
        self.mPagePictureDrawer = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICollectionPagePictureDrawer, self)
    end
    return self.mPagePictureDrawer
end

---@param collectionItemController UICollectionItemsController
function UICollectionPageTemplate:Init(collectionItemController)
    self.mCollectionItemsController = collectionItemController
end

---@param collectionInfo LuaCollectionInfo
---@param pageIndex number 从1开始的页索引
function UICollectionPageTemplate:RefreshPage(collectionInfo, pageIndex)
    ---准备数据
    local gridCountPerPage = luaclass.LuaCollectionInfo.GetCollectionGridCountPerPage()
    if gridCountPerPage ~= self.gridCountPerPage then
        ---格子索引到藏品的映射,一般会出现多个格子映射到同一个藏品的情况,每页格子数量改变时将充值该映射关系表,index从1开始,
        ---如果为bool值,表示该格子是否已解锁
        ---如果为LuaCollectionItem,表示该格子所归属的藏品物品
        ---@type table<number, LuaCollectionItem|boolean>
        self.mGridToCollection = {}
        self.gridCountPerPage = gridCountPerPage
    end
    ---清空格子到藏品的映射,清空实质上是将映射集合中所有值设置为格子是否被解锁的状态
    for i = 1, gridCountPerPage do
        local gridIndex = i
        ---从0开始的格子横坐标
        local coordX = (gridIndex - 1) % luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine()
        ---从0开始的格子纵坐标
        local coordY = math.floor((gridIndex - 1) / luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine())
        self.mGridToCollection[i] = collectionInfo:IsCoordUnlocked(pageIndex, coordX, coordY)
    end
    ---@return table<number, LuaCollectionItem>
    local collectionItems = collectionInfo:GetCollectionPageList()[pageIndex]
    if collectionItems then
        for i = 1, #collectionItems do
            local collectionItemTemp = collectionItems[i]
            local coords = collectionItemTemp:GetCoords()
            if coords ~= nil then
                for j = 1, #coords do
                    local collectionCoordTemp = coords[j]
                    local gridIndex = collectionCoordTemp.y * (luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine()) + collectionCoordTemp.x + 1
                    self.mGridToCollection[gridIndex] = collectionItemTemp
                end
            end
        end
    end
    ---使用上面格子到藏品的映射来刷新各个格子
    self:GetGridContainer().MaxCount = gridCountPerPage
    for i = 1, gridCountPerPage do
        local gridIndex = i
        ---@type LuaCollectionItem|nil
        local state = self.mGridToCollection[gridIndex]
        local go = self:GetGridContainer().controlList[gridIndex - 1]
        local gridTemplate = self:GetCollectionGridTemplateForGo(go)
        ---从0开始的格子横坐标
        local coordX = (gridIndex - 1) % luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine()
        ---从0开始的格子纵坐标
        local coordY = math.floor((gridIndex - 1) / luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine())
        if state == true then
            ---已解锁的格子
            gridTemplate:RefreshWithInfo(coordX, coordY, nil, false)
        elseif state == false then
            ---未解锁的格子
            gridTemplate:RefreshWithInfo(coordX, coordY, nil, true)
        else
            ---有藏品映射的格子
            gridTemplate:RefreshWithInfo(coordX, coordY, state, false)
        end
    end
    ---重新刷新藏品图片
    local currentDraggedItemLid = self:GetOwner():GetCurrentDraggedCollectionItemLid()
    self:GetPagePictureDrawer():RebuildPictures(collectionItems, currentDraggedItemLid)
end

---获取GameObject对应的藏品格子模板
---@param go UnityEngine.GameObject
---@return UICollectionItemGrid
function UICollectionPageTemplate:GetCollectionGridTemplateForGo(go)
    if self.mCollectionGridTemplateForGo == nil then
        self.mCollectionGridTemplateForGo = {}
    end
    local template = self.mCollectionGridTemplateForGo[go]
    if template == nil then
        if self.mFetchCompGoFunction == nil then
            self.mFetchCompGoFunction = function(compName)
                return self:GetOwner():FetchPrefabForGrid(compName)
            end
        end
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICollectionItemGrid, self:GetOwner():GetOwnerPanel(),
                self:GetOwner():GetCollectionInteraction(), self.mFetchCompGoFunction)
        self.mCollectionGridTemplateForGo[go] = template
    end
    return template
end

---计算widget遮住的格子坐标集合和遮住的核心格子坐标集合
---@param widget UIWidget
---@return table<number, CollectionCoord>,table<number, CollectionCoord> 第一个table表示该widget遮住的格子,第二个table表示该widget遮住的核心格子
function UICollectionPageTemplate:CalculateWidgetCoveredGrids(widget)
    ---遮住的格子列表
    if self.mWidgetCoveredCoords == nil then
        self.mWidgetCoveredCoords = {}
    else
        Utility.ClearTable(self.mWidgetCoveredCoords)
    end
    ---遮住的核心格子列表
    if self.mWidgetCoveredCoreCoords == nil then
        self.mWidgetCoveredCoreCoords = {}
    else
        Utility.ClearTable(self.mWidgetCoveredCoreCoords)
    end
    if widget == nil or CS.StaticUtility.IsNull(widget) then
        return self.mWidgetCoveredCoords, self.mWidgetCoveredCoreCoords
    end
    ---计算出widget的左下角和右上角所处的格子,它们所围成的矩形范围经过剔除后,就是widget所遮住的格子
    local widgetCorners = widget.worldCorners
    local leftBottomPos = widgetCorners[0]
    local rightTopPos = widgetCorners[2]
    ---左下角和右上角点的相对坐标
    local localLBPos = self.go.transform:InverseTransformPoint(leftBottomPos)
    local localRTPos = self.go.transform:InverseTransformPoint(rightTopPos)
    ---左下角和右上角点的格子坐标(未归整)
    local lbCoordX, lbCoordY = self:ConvertLocalPositionToCoordXY(localLBPos)
    local rtCoordX, rtCoordY = self:ConvertLocalPositionToCoordXY(localRTPos)
    ---左下角和右上角的归整坐标(向下取整,相当于取到左下角和右上角所在的格子的坐标(格子坐标实质上等同于格子左上角的点的坐标))
    local lbX = math.floor(lbCoordX)
    local lbY = math.floor(lbCoordY)
    local rtX = math.floor(rtCoordX)
    local rtY = math.floor(rtCoordY)
    ---每页的行数和列数
    local gridCountPerPageX = luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine()
    local gridCountPerPageY = luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn()
    local halfCoordGridX = ((rtCoordX - lbCoordX) % 1) * 0.5
    local halfCoordGridY = ((lbCoordY - rtCoordY) % 1) * 0.5
    --以左下角未归整的坐标点到其所在各自的左上角点的坐标差来计算出核心格子在所有遮住的格子中的分布
    ---获取遮住的格子列表
    --[[
    print("Half Coord Grid X:", halfCoordGridX, "Half Coord Grid Y:", halfCoordGridY, "lbX", lbX, "lbY", lbY, "rtX", rtX, "rtY", rtY)
    print("lbCoordX", lbCoordX, "lbCoordY", lbCoordY, "rtCoordX", rtCoordX, "rtCoordY", rtCoordY)
    --]]
    if lbX <= rtX and lbY >= rtY then
        for x = lbX, rtX do
            for y = rtY, lbY do
                --if x >= 0 and x < gridCountPerPageX and y >= 0 and y < gridCountPerPageY then
                local coordTemp = luaclass.LuaCollectionInfo.GetCollectionCoordinate(x, y)
                table.insert(self.mWidgetCoveredCoords, coordTemp)
                ---计算该格子是否是遮住的核心格子列表,依据是该格子横向和纵向与widget边界重叠部分是否都超过了格子一半宽度
                local isCore = true
                if math.min(x + 1, rtCoordX) - math.max(x, lbCoordX) < halfCoordGridX then
                    isCore = false
                elseif math.min(y + 1, lbCoordY) - math.max(y, rtCoordY) < halfCoordGridY then
                    isCore = false
                end
                --[[
                print(tostring(coordTemp), "core:", isCore, "math.min(x, rtCoordX) - math.max(x - 1, lbCoordX) < halfCoordGridX",
                        math.min(x, rtCoordX) - math.max(x - 1, lbCoordX),
                        "math.min(y, lbCoordY) - math.max(y - 1, rtCoordY) < halfCoordGridY",
                        math.min(y, lbCoordY) - math.max(y - 1, rtCoordY))
                --]]
                if isCore then
                    table.insert(self.mWidgetCoveredCoreCoords, coordTemp)
                end
                --end
            end
        end
    end
    return self.mWidgetCoveredCoords, self.mWidgetCoveredCoreCoords
end

---将LocalPosition转化为坐标的xy,格子坐标系的原点在左上角,x向右,y向下
---@param localPosition UnityEngine.Vector3
---@return number,number
function UICollectionPageTemplate:ConvertLocalPositionToCoordXY(localPosition)
    local width = self:GetGridContainer().CellWidth
    local height = self:GetGridContainer().CellHeight
    local gridCountPerPageX = luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine()
    local gridCountPerPageY = luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn()
    return (localPosition.x / width + gridCountPerPageX * 0.5), (gridCountPerPageY * 0.5 - localPosition.y / height)
end

return UICollectionPageTemplate