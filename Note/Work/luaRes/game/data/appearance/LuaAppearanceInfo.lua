---@class LuaAppearanceInfo:luaobject
local LuaAppearanceInfo = {}

function LuaAppearanceInfo:GetOwner()
    return self.mOwner
end

---外观红点列表
---@return table<number, boolean>
function LuaAppearanceInfo:GetAppearanceRedPointList()
    if self.mAppearanceRedPointList == nil then
        self.mAppearanceRedPointList = {}
    end
    return self.mAppearanceRedPointList
end

---是否是新藏品
---@param appearanceId number
---@return boolean
function LuaAppearanceInfo:IsNewAppearance(appearanceId)
    return self:GetAppearanceRedPointList()[appearanceId] == true
end

---尝试获取一个新外观的itemID
---@return number
function LuaAppearanceInfo:TryGetNewAppearanceItemID()
    local list = self:GetAppearanceRedPointList()
    for i, v in pairs(list) do
        if v then
            return i
        end
    end
    return nil
end

---@param playerDataMgr PlayerDataManager
function LuaAppearanceInfo:Init(playerDataMgr)
    self.mOwner = playerDataMgr
end

---增加外观红点
---@param appearanceRedPoint appearanceV2.ResAppearanceRedPoint
function LuaAppearanceInfo:AddAppearanceRedPoint(appearanceRedPoint)
    if appearanceRedPoint == nil then
        return
    end
    local list = self:GetAppearanceRedPointList()
    list[appearanceRedPoint.id] = true
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.NewAppearance))
end

---点击并尝试移除红点
---@param clickedAppearanceId number
function LuaAppearanceInfo:ClickAndTryRemoveRedPoint(clickedAppearanceId)
    local previous = self:IsRedPointShouldShow()
    self:GetAppearanceRedPointList()[clickedAppearanceId] = false
    local now = self:IsRedPointShouldShow()
    if previous ~= now then
        gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.NewAppearance))
    end
end

---是否显示红点
---@return boolean
function LuaAppearanceInfo:IsRedPointShouldShow()
    for i, v in pairs(self:GetAppearanceRedPointList()) do
        if v then
            return true
        end
    end
    return false
end

return LuaAppearanceInfo