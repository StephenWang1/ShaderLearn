---@type Utility
local Utility = Utility

---获得星级显示
---@return string,string 星级描述，星星图片
function Utility.GetIntensifyShow(intensify)
    local data = Utility.GetIntensifyColor(intensify)
    if data and intensify > 0 then
        local num = intensify % 10
        if intensify % 10 == 0 and intensify >= 10 then
            num = 10
        end
        return data.color .. num, data.icon
    end
    return "",""
end

---老版星级显示
function Utility.GetIntensifyShowSpecial(intensify)
    local data = Utility.GetIntensifyColor(intensify)
    if data and intensify > 0 then
        local num = intensify % 10
        if intensify % 10 == 0 and intensify >= 10 then
            num = 10
        end
        return data.color .. "★" .. num
    end
    return ""
end

---@class IntensifyColorData
---@field min number 下限
---@field max number 上限
---@field color string 颜色
---@field icon string 星星图片
---@field floorIcon string 黑色星星图片

---@return IntensifyColorData 星级对应数据
function Utility.GetIntensifyColor(intensify)
    if Utility.IntensifyToColor == nil then
        Utility.IntensifyToColor = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22776)
        if data then
            local strs = string.Split(data.value, "&")
            for i = 1, #strs do
                local data = string.Split(strs[i], "#")
                if #data >= 5 then
                    local singleData = {}
                    singleData.min = tonumber(data[1])
                    singleData.max = tonumber(data[2])
                    singleData.color = data[3]
                    singleData.icon = data[4]
                    singleData.floorIcon = data[5]
                    table.insert(Utility.IntensifyToColor, singleData)
                end
            end
        end
    end
    for i = 1, #Utility.IntensifyToColor do
        local singleData = Utility.IntensifyToColor[i]
        if intensify >= singleData.min and intensify <= singleData.max then
            return singleData
        end
    end
end