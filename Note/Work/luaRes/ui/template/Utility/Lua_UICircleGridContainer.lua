---lua内的一个组件 用来创建以及管理圆圈格子的创建
---@class Lua_UICircleGridContainer
local Lua_UICircleGridContainer = {}

---里面的cell组件的最大个数(实际的创建个数会受到层级限定)
---@type number
Lua_UICircleGridContainer.MaxCount = nil

---克隆的控件
---@type GameObject
Lua_UICircleGridContainer.controlTemplate = nil

---当前显示的组件
---@type table<GameObject>
Lua_UICircleGridContainer.ControlList = nil

---之前创建了,但是后来被隐藏移除的组件
---@type table<GameObject>
Lua_UICircleGridContainer.RestoreList = nil

---每层最大的存在个数
---@type table<number>
Lua_UICircleGridContainer.LayerItemMaxCountList = nil

---每层距离上层的宽度(如果没有设置 统一使用LayerWidth的宽度)
---@type table<number>
Lua_UICircleGridContainer.LayerWidthList = nil

function Lua_UICircleGridContainer:Init()

end

function Lua_UICircleGridContainer:InitControlTemplate(obj)
    self.controlTemplate = obj
end

---设置克隆的组件的最大个数
---@param data table<number>
function Lua_UICircleGridContainer:SetMaxCount(count)
    if (self.MaxCount == count) then
        return ;
    end
    self.MaxCount = count
    self:RebuildCells()
end

---设置每层的最大存在个数
---@param data table<number>
function Lua_UICircleGridContainer:SetLayItemMaxCount(data)
    self.LayerItemMaxCountList = data
    self:RebuildCells()
end

---设置每层的最大存在个数
---@param data table<number>
function Lua_UICircleGridContainer:SetLayerWidthList(data)
    self.LayerWidthList = data
    self:RebuildCells()
end

---重新创建/隐藏格子
function Lua_UICircleGridContainer:RebuildCells()
    if (self.LayerWidthList == nil or self.LayerItemMaxCountList == nil) then
        return
    end
    if (self.MaxCount == nil) then
        self.MaxCount = 0
    end
    local layer = 1
    local lastCount = 0
    if (self.ControlList == nil) then
        self.ControlList = {}
    end
    if (self.ControlList ~= nil) then
        lastCount = #self.ControlList
    end
    --当前层的创建下标
    local layerIndex = 0
    for i = 1, self.MaxCount do
        local obj = self.ControlList[i]
        if (obj == nil) then
            if (self.RestoreList ~= nil and #self.RestoreList > 0) then
                local maxRestoreCount = #self.RestoreList
                local obj = self.RestoreList[maxRestoreCount]
                table.remove(self.RestoreList, maxRestoreCount)
                self.ControlList[i] = obj
            else
                self.ControlList[i] = CS.UnityEngine.GameObject.Instantiate(self.controlTemplate)
                obj = self.ControlList[i]
            end
        end

        local layerCount = self.LayerItemMaxCountList[layer]
        print("layer:" .. tostring(layer) .. "       layerCount:" .. tostring(layerCount))

        --没有设置下一层的个数了
        if (layerCount ~= nil) then
            obj:SetActive(true)
            if (layerCount > layerIndex) then
                self:SetTempItemPos(obj, layer, layerIndex)
                layerIndex = layerIndex + 1
            end
            ---这一层已经占满了,可以进入下一层了
            if (layerCount == layerIndex) then
                layer = layer + 1
                layerIndex = 0
            end
        else
            obj:SetActive(false)
        end
    end

    for i = lastCount, self.MaxCount, -1 do
        local obj = self.ControlList[i]
        if (obj ~= nil) then
            obj:SetActive(false)
            table.remove(self.ControlList, i)
            if (self.RestoreList == nil) then
                self.RestoreList = {}
            end
            table.insert(self.RestoreList, obj)
        end
    end
end

---设置每个格子的位置
---@param obj GameObject
---@param layer 在第几层
---@param layerIndex 在这层的第几个
function Lua_UICircleGridContainer:SetTempItemPos(obj, layer, layerIndex)
    if (obj == nil) then
        return ;
    end
    local LayerItemMaxCount = self.LayerItemMaxCountList[layer]
    local halfWidth = self.LayerWidthList[layer]

    if (layerIndex % 2 == 1) then
        layerIndex = LayerItemMaxCount - math.floor(layerIndex / 2) - 1
    else
        layerIndex = math.floor(layerIndex / 2)
    end

    local angle = 360 * layerIndex / LayerItemMaxCount
    local x, y = self:CalculatePos(halfWidth, angle)
    obj.transform.parent = self.go.transform
    obj.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    obj.transform.localPosition = CS.UnityEngine.Vector3(x, y, 0)
end

---计算坐标
---@param halfWidth number 半径
---@param angle number 角度
---@return number, number xy坐标
function Lua_UICircleGridContainer:CalculatePos(halfWidth, angle)
    --弧度
    local pi = angle * 2 * math.pi / 360
    local x = math.sin(pi) * halfWidth
    local y = math.cos(pi) * halfWidth
    return x, y
end

return Lua_UICircleGridContainer