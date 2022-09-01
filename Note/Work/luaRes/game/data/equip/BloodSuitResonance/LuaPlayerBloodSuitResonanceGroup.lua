---@class LuaPlayerBloodSuitResonanceGroup 血继共鸣组
local LuaPlayerBloodSuitResonanceGroup = {}

--region 数据初始化
---@param gropId number  血继共鸣组ID
function LuaPlayerBloodSuitResonanceGroup:RefreShData(gropId)
    self.gropId = gropId
    self:SetGroupInfo()
end
---设置共鸣组信息
function LuaPlayerBloodSuitResonanceGroup:SetGroupInfo()
    ---@type table<number,LuaPlayerBloodSuitResonanceItem> key:道具ID  当前血继共鸣组信息
    self.ResonanceGroupInfoDic = {}
    if self.gropId == nil then
        return
    end
    ---@type table<number,table<number,TABLE.cfg_bloodsuit_resonance>> 血继共鸣组 初始数据字典
    local tempBloodGroupDic = clientTableManager.cfg_bloodsuit_resonanceManager:GetBloodGroupDic()
    if tempBloodGroupDic == nil then
        return
    end
    ---@type table<number,TABLE.cfg_bloodsuit_resonance>
    local tempBloodGroup = tempBloodGroupDic[self.gropId]
    if tempBloodGroup == nil then
        return
    end
    for i, v in pairs(tempBloodGroup) do
        local itemID = v:GetItemid()
        if self.ResonanceGroupInfoDic[itemID] == nil then
            self.ResonanceGroupInfoDic[itemID] = luaclass.LuaPlayerBloodSuitResonanceItem:New()
        end
        self.ResonanceGroupInfoDic[itemID]:Init(v)
    end
end
--endregion

---得到共鸣组字典
---@type table<number,LuaPlayerBloodSuitResonanceItem> key:道具ID  当前血继共鸣组信息
function LuaPlayerBloodSuitResonanceGroup:GetResonanceGroupInfoDic()
    if self.ResonanceGroupInfoDic == nil then
        self:SetGroupInfo()
    end
    return self.ResonanceGroupInfoDic
end

---得到共鸣组ID
function LuaPlayerBloodSuitResonanceGroup:GetGroupID()
    return self.gropId
end

---得到共鸣组名称(类型描述)
---@return string
function LuaPlayerBloodSuitResonanceGroup:GetGroupName()
    if self:GetResonanceGroupInfoDic() == nil then
        return ""
    end
    for i, v in pairs(self:GetResonanceGroupInfoDic()) do
        ---@type LuaPlayerBloodSuitResonanceItem
        local temp = v
        if temp ~= nil and temp:GetBloodsuitResonanceTable() ~= nil then
            return tostring(temp:GetBloodsuitResonanceTable():GetGroupName())
        end
    end
    return ""
end

---得到共鸣组名称描述
---@return string 共鸣组名称描述
function LuaPlayerBloodSuitResonanceGroup:GetGroupDes(openColor, closeColor)
    if openColor == nil or closeColor == nil then
        return ""
    end
    if self:GetResonanceGroupInfoDic() == nil then
        return ""
    end
    local des = ""
    for i, v in pairs(self:GetResonanceGroupInfoDic()) do
        ---@type LuaPlayerBloodSuitResonanceItem
        local temp = v
        if temp ~= nil and temp:GetBloodsuitResonanceTable() ~= nil then
            if des ~= "" then
                des = des .. " "
            end
            if temp:IsWear() then
                des =des .. tostring(openColor) .. temp:GetItemTableName()
            else
                des =des .. tostring(closeColor) .. temp:GetItemTableName()
            end
        end
    end
    return des
end

---得到共鸣组效果描述
---@return  string 共鸣组效果描述
function LuaPlayerBloodSuitResonanceGroup:GetGroupResultDes(openColor, closeColor)
    if self:GetResonanceGroupInfoDic() == nil then
        return ""
    end
    local isAllOpen = true
    local des = ""
    for i, v in pairs(self:GetResonanceGroupInfoDic()) do
        ---@type LuaPlayerBloodSuitResonanceItem
        local temp = v
        if temp ~= nil and temp:GetResonance_AttributeTableDic() ~= nil then
            if des == "" then
                for i, v in pairs(temp:GetResonance_AttributeTableDic()) do
                    des = des .. "\r\n" .. tostring(v:GetTips())
                end
            end
            if temp:IsWear() == false then
                isAllOpen = false
            end
        end
    end
    if isAllOpen then
        return tostring(openColor) .. des
    else
        return tostring(closeColor) .. des
    end
    return ""
end

---得到单个共鸣数据
---@param ItemID number 道具ID
---@return  LuaPlayerBloodSuitResonanceItem
function LuaPlayerBloodSuitResonanceGroup:GetLuaPlayerBloodSuitResonanceItem(ItemID)
    if self:GetResonanceGroupInfoDic() == nil then
        return ""
    end
    return self:GetResonanceGroupInfoDic()[ItemID]
end

---该组是否包含指定道具
---@param ItemID number 道具ID
---@return boolean
function LuaPlayerBloodSuitResonanceGroup:IsContainsTargetItem(ItemID)
    if self:GetResonanceGroupInfoDic() == nil then
        return false
    end
    if self:GetResonanceGroupInfoDic()[ItemID] == nil then
        return false
    end
    return true
end

return LuaPlayerBloodSuitResonanceGroup