---lua端场景中avatar的基类
---@class LuaAvatar:luaobject
local LuaAvatar = {}


--region 基础属性

---lua的AvatarInfo信息
---@type LuaAvatarInfo
LuaAvatar.LuaAvatarInfo = nil

---lua的LuaHead_Avatar信息
---@type LuaHead_Avatar
LuaAvatar.LuaHead_Avatar = nil

---lua的LuaHead_Avatar信息
---@type LuaAvatarModel
LuaAvatar.LuaAvatarModel = nil

---获取avatar的ID
---@return number
function LuaAvatar:GetID()
    return self.mID or 0
end

---获取Avatar的类型
---@return LuaEnumAvatarType
function LuaAvatar:GetAvatarType()
    return self.mAvatarType or LuaEnumAvatarType.None
end

---获取绑定的C#中的avatar
---@return CSAvater|nil
function LuaAvatar:GetCSAvatar()
    if self.mCSAvatar == nil then
        self.mCSAvatar = gameMgr:GetMainScene():GetCSAvatar(self:GetID())
    end
    return self.mCSAvatar
end

---获取绑定的C#中的CSAvaterInfo
---@return CSAvaterInfo/nil
function LuaAvatar:GetCSAvatarInfo()
    if self.mCSAvatarInfo == nil then
        if self:GetCSAvatar() ~= nil then
            self.mCSAvatarInfo = self:GetCSAvatar().BaseInfo
        end
    end
    return self.mCSAvatarInfo
end

--endregion

---获取绑定的avatar的LuaAvatarHead
---@return LuaHead_Avatar|nil
function LuaAvatar:GetLuaAvatarHead()
    return self.mLuaAvatarHead
end
--endregion

--region 初始化
---初始化
---@public
---@param csAvatar CSAvater C#中的avater类
---@param data object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
---@param paramData object[] 附带的额外参数,不一定有什么东西
function LuaAvatar:InitAvatar(csAvatar, data, paramData)
    self:BindCSAvatar(csAvatar, data)
    self:OnInitialized()
end

---绑定C#中的avatar
---@param csAvatar CSAvater
---@param data object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
function LuaAvatar:BindCSAvatar(csAvatar, data)
    if csAvatar == nil then
        self.mID = nil
        self.mAvatarType = nil
        self.mCSAvatar = nil
        return
    end
    self.mCSAvatar = csAvatar
    self.mAvatarType = csAvatar.AvatarTypeNumber
    self:InitAvatarData(data)
end

---初始化Avatar数据,这个方法在每个上层上需要去重写
function LuaAvatar:InitAvatarData(data)
    self.mID = 0
end

--endregion

--region 销毁
---销毁
---@public
function LuaAvatar:Destroy()
    self:OnDestroy()
    self.mID = nil
    self.mAvatarType = nil
    self.mCSAvatar = nil
    if self:GetLuaAvatarHead() ~= nil then
        self:GetLuaAvatarHead():Destroy()
        self.mLuaAvatarHead = nil
    end
end
--endregion

--region 事件重写
---avatar初始化事件
---@protected
function LuaAvatar:OnInitialized()

end

---avatar销毁事件
---@protected
function LuaAvatar:OnDestroy()

end
--endregion

--region 帧Update
---每帧执行的Update
function LuaAvatar:Update()
    if self:GetLuaAvatarHead() ~= nil then
        self:GetLuaAvatarHead():Update()
    end
end
--endregion

return LuaAvatar