---lua端场景中avatar的模型类
---@class LuaAvatarModel:luaobject
local LuaAvatarModel = {}

---@type CSAvater C#中的CSHead类
LuaAvatarModel._Avatar = nil

---得到CS的Avatar类
function LuaAvatarModel:GetCSAvatar()
    return self._Avatar
end

---得到CS的Avatar类
---@return LuaAvatar
function LuaAvatarModel:GetLuaAvatar()
    if(self._Avatar == nil) then
        return nil
    end
    return self._Avatar.LuaAvatar
end

---C#模型控制控制类
function LuaAvatarModel:GetCSModel()
    if(self._Avatar == nil) then
        return nil
    end
    return self._Avatar.Model;
end

---C#模型解析加载类
function LuaAvatarModel:GetCSModelLoad()
    if(self._Avatar == nil) then
        return nil
    end
    return self._Avatar.ModelLoad;
end

---@param csAvatar CSAvater C#中的CSHead类
function LuaAvatarModel:InitData(csAvatar)
    self._Avatar = csAvatar
end

---模型构造初始化
---@return boolean 是否继续C#模型初始
function LuaAvatarModel:OnAvatarStructInitEvent()
    return true
end

---模型换装解析
---@return boolean 是否继续C#模型初始
function LuaAvatarModel:OnAvatarModelAnalysisEvent()
    return true
end

return LuaAvatarModel