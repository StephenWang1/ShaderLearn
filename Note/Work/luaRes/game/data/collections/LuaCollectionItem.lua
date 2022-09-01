---藏品物品数据
---@class LuaCollectionItem:luaobject
local LuaCollectionItem = {}

--region 静态方法
---计算并填充坐标集合
---@public
---@param originCoord CollectionCoord 原点坐标
---@param sizeX number 宽度
---@param sizeY number 高度
---@param outputCoordList table<number, CollectionCoord> 输出的坐标集合,必须为一个table
function LuaCollectionItem.CalculateCoordListBySize(originCoord, sizeX, sizeY, outputCoordList)
    if outputCoordList == nil then
        return
    end
    for i = #outputCoordList, 1, -1 do
        outputCoordList[i] = nil
    end
    for x = 1, sizeX do
        for y = 1, sizeY do
            local coordX = x + originCoord.x - 1
            local coordY = y + originCoord.y - 1
            table.insert(outputCoordList, luaclass.LuaCollectionInfo.GetCollectionCoordinate(coordX, coordY))
        end
    end
end

---计算并填充坐标集合
---@public
---@param originCoord CollectionCoord 原点坐标
---@param relativeCoords table<number, CollectionCoord> 相对坐标集合
---@param outputCoordList table<number, CollectionCoord> 输出的坐标集合,必须为一个table
function LuaCollectionItem.CalculateCoordList(originCoord, relativeCoords, outputCoordList)
    if outputCoordList == nil then
        return
    end
    for i = #outputCoordList, 1, -1 do
        outputCoordList[i] = nil
    end
    for i = 1, #relativeCoords do
        local relativeCoordTemp = relativeCoords[i]
        local x = originCoord.x + relativeCoordTemp.x
        local y = originCoord.y + relativeCoordTemp.y
        local coord = luaclass.LuaCollectionInfo.GetCollectionCoordinate(x, y)
        table.insert(outputCoordList, coord)
    end
end
--endregion

--region 服务器数据
---获取藏品物品的背包物品数据结构
---@return bagV2.BagItemInfo
function LuaCollectionItem:GetCollectionBagItem()
    return self.mBagItem
end

---获取藏品物品的唯一ID,背包物品数据为空时返回0
---@return number
function LuaCollectionItem:GetCollectionLid()
    if self.mBagItem ~= nil then
        return self.mBagItem.lid
    end
    return 0
end

---返回服务器数据中的index (index = page * 10000 + x * 100 + y)
---@return number
function LuaCollectionItem:GetServerIndex()
    if self.mBagItem ~= nil and self.mBagItem.index ~= nil then
        return self.mBagItem.index
    end
    return 0
end

---归属的页索引(从1开始),如果背包物品数据为空则返回-1
---@return number
function LuaCollectionItem:GetPageIndex()
    if self.mBagItem ~= nil and self.mBagItem.index ~= nil then
        return math.floor(self.mBagItem.index / 10000)
    end
    return -1
end

---获取原点坐标(左上角坐标)
---@return CollectionCoord
function LuaCollectionItem:GetOriginCoordinate()
    return self.mOriginCoord
end
--endregion

--region 本地数据
---获取藏品表数据
---@return TABLE.cfg_collection
function LuaCollectionItem:GetCollectionTable()
    return self.mCollectionTbl
end

---获取坐标集合
---@return table<number, CollectionCoord>
function LuaCollectionItem:GetCoords()
    if self.mCoords == nil then
        self.mCoords = {}
    end
    return self.mCoords
end

---获取图集名
---@return string
function LuaCollectionItem:GetAtlasName()
    ---先写死,如果以后图集尺寸超过4096*4096,应当分图集并在表中配置藏品使用的图集名
    return "UI_Collection"
end

---获取精灵名
---@return string
function LuaCollectionItem:GetSpriteName()
    if self.mSpriteName == nil then
        self.mSpriteName = ""
    end
    return self.mSpriteName
end

---获取相对坐标集合(占用的格子数据)
---@return table<number, CollectionCoord>
function LuaCollectionItem:GetRelativeCoords()
    if self.mRelativeCoords == nil then
        self.mRelativeCoords = {}
    end
    return self.mRelativeCoords
end

---获取边界尺寸(单位为格子坐标)
---@return number,number
function LuaCollectionItem:GetBorderSize()
    return self.mBorderSizeX or 0, self.mBorderSizeY or 0
end

---获取模拟坐标
---@param simulateOriginCoordX number
---@param simulateOriginCoordY number
---@return table<number, CollectionCoord>
function LuaCollectionItem:GetSimulateCoords(simulateOriginCoordX, simulateOriginCoordY)
    if self.mSimulateCoords == nil then
        self.mSimulateCoords = {}
    end
    local simulateOriginCoord = luaclass.LuaCollectionInfo.GetCollectionCoordinate(simulateOriginCoordX, simulateOriginCoordY)
    LuaCollectionItem.CalculateCoordList(simulateOriginCoord, self:GetRelativeCoords(), self.mSimulateCoords)
    return self.mSimulateCoords
end
--endregion

--region 初始化
---初始化
---@param bagItem bagV2.BagItemInfo 背包物品数据结构
function LuaCollectionItem:Init(bagItem)
    self:RefreshBagItem(bagItem)
end
--endregion

--region 刷新数据
---刷新藏品对应的背包物品数据
---@public
---@param bagItem bagV2.BagItemInfo
function LuaCollectionItem:RefreshBagItem(bagItem)
    if bagItem == nil then
        return
    end
    self.mBagItem = bagItem
    self:InternalInitDatas()
end

---初始化数据
---@private
function LuaCollectionItem:InternalInitDatas()
    ---初始化原点坐标(左上角)
    if self.mBagItem ~= nil and self.mBagItem.index ~= nil then
        local x = math.floor((self.mBagItem.index % 10000) / 100)
        local y = math.floor(self.mBagItem.index % 100)
        self.mOriginCoord = luaclass.LuaCollectionInfo.GetCollectionCoordinate(x, y)
    else
        self.mOriginCoord = luaclass.LuaCollectionInfo.GetCollectionCoordinate(-100, -100)
    end
    ---初始化表数据
    if self.mBagItem then
        self.mCollectionTbl = clientTableManager.cfg_collectionManager:TryGetValue(self.mBagItem.itemId)
    else
        self.mCollectionTbl = nil
    end
    ---初始化相对坐标集合
    local coords = self:GetRelativeCoords()
    for i = #coords, 1, -1 do
        coords[i] = nil
    end
    if self.mCollectionTbl then
        for x = 1, self.mCollectionTbl:GetXSize() do
            for y = 1, self.mCollectionTbl:GetYSize() do
                ---相对坐标以左上角为原点,x轴向右,y轴向下
                table.insert(coords, luaclass.LuaCollectionInfo.GetCollectionCoordinate(x - 1, y - 1))
            end
        end
        self.mBorderSizeX = self.mCollectionTbl:GetXSize()
        self.mBorderSizeY = self.mCollectionTbl:GetYSize()
    else
        self.mBorderSizeX = 0
        self.mBorderSizeY = 0
    end
    ---刷新绝对坐标集合
    self:RefreshCoords()
    ---刷新精灵名
    self.mSpriteName = self.mCollectionTbl:GetBindingId()
end

---刷新藏品所占的格子坐标集合
---@public
function LuaCollectionItem:RefreshCoords()
    LuaCollectionItem.CalculateCoordList(self:GetOriginCoordinate(), self:GetRelativeCoords(), self:GetCoords())
end
--endregion

return LuaCollectionItem