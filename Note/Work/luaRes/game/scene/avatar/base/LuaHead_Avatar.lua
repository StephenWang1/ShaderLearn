---lua端场景中avatar的头顶基类
---PS: 此处不允许绑定事件
---@class LuaHead_Avatar:luaobject
local LuaHead_Avatar = {}

---获取绑定的avatar的CSHead
---@return CSHead|nil
function LuaHead_Avatar:GetCSHead()
    return self.mCSHead
end

---获取绑定的Head的Gameobject
---@return UnityEngine.GameObject|nil
function LuaHead_Avatar:GetHeadGo()
    if self:GetCSHead() ~= nil then
        return self:GetCSHead().CacheTrans
    end
    return nil
end

---获取绑定的Head的Root Gameobject (组件父物体)
---@return UnityEngine.GameObject|nil
function LuaHead_Avatar:GetParentRoot()
    if self.mParentRoot == nil and self:GetCSHead() ~= nil then
        self.mParentRoot = self:GetCSHead().RootTrans
    end
    return self.mParentRoot
end

---获取绑定的Head的C#中的avatar
---@return CSAvatar|nil
function LuaHead_Avatar:GetCSAvatar()
    return self.mCSAvatar
end

---获取绑定的Head的Lua中的avatar
---@return LuaAvatar|nil
function LuaHead_Avatar:GetLuaAvatar()
    return self.mCSLuaAvatar
end

---获取绑定的Head的名字的位置
---@return UnityEngine.Vector3
function LuaHead_Avatar:GetNamePos()
    if self.mNamePos == nil then
        self.mNamePos = CS.UnityEngine.Vector3.zero
        if self:GetCSHead() ~= nil then
            if self:GetCSHead().ActorName ~= nil and not CS.StaticUtility.IsNull(self:GetCSHead().ActorName.gameObject) then
                self.mNamePos = self:GetCSHead().ActorName.transform.localPosition
            end
        end
    end
    return self.mNamePos
end

---获取avatarID
---@return number
function LuaHead_Avatar:GetAvatarID()
    if self:GetCSAvatar() ~= nil and self:GetCSAvatar().BaseInfo ~= nil then
        return self:GetCSAvatar().BaseInfo.ID
    end
    return 0
end

---初始化
---@public
function LuaHead_Avatar:Init(luaAvatar)
    if luaAvatar ~= nil then
        self.mCSLuaAvatar = luaAvatar
        self.mCSAvatar = luaAvatar:GetCSAvatar()
        if luaAvatar:GetCSAvatar() ~= nil then
            self.mCSHead = luaAvatar:GetCSAvatar().Head
        end
    end
    self:InitData()
    self:InitView()
end

---初始化头顶数据
---@protected
function LuaHead_Avatar:InitData()
    ---@type number 头顶当前所有组件预设最高处
    self.curOffsetPos = CS.UnityEngine.Vector3.zero
end

---初始化显示
---@protected
function LuaHead_Avatar:InitView()

end

---帧更新
---@private
function LuaHead_Avatar:Update()

end

---排序Head组件
---@protected
function LuaHead_Avatar:SortHead()
    if self:GetCSHead() ~= nil then
        self.curOffsetPos = self:GetCSHead():SortHeadComponent()
    end
end

---死亡回调
---@public
function LuaHead_Avatar:AvatarDeadCallBack()

end

---@public
function LuaHead_Avatar:Destroy()
    self.mCSLuaAvatar = nil
    self.mCSAvatar = nil
    self.mCSHead = nil
    self.curOffsetPos = nil
end

return LuaHead_Avatar
