---LuaAvatar工厂,不负责MainPlayer和None类型
---@class LuaAvatarFactory:luaobject
local LuaAvatarFactory = {}

local luaclass = luaclass
local LuaEnumAvatarType = LuaEnumAvatarType

--region 第一部分,Avatar单位类
---当CSAvater进行初始化的时候进行
---@param luaAvatar LuaAvatar
---@param csAvatar CSAvater C#中的avater类
---@param data System.Object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
---@param paramData System.Object[] 附带的额外参数,不一定有什么东西
function LuaAvatarFactory:OnAvatarInit(luaAvatar, csAvatar, data, paramData)
    if(luaAvatar == nil) then
        luaAvatar = self:PopAvatar(csAvatar.AvatarTypeNumber)
    end
    if(luaAvatar == nil) then
        luaAvatar = self:CreateNewLuaAvatarForAvatar(csAvatar)
    end
    luaAvatar:InitAvatar(csAvatar, data, paramData)
    return luaAvatar;
end

---根据服务器的协议解析对应的id
---@param data System.Object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
function LuaAvatarFactory:GetAvatarID(type, data)
    if type == LuaEnumAvatarType.MainPlayer then

    elseif type == LuaEnumAvatarType.Player then

    elseif type == LuaEnumAvatarType.Monster then
        ---@type mapV2.RoundMonsterInfo
        local monster = data
        return monster.lid

    elseif type == LuaEnumAvatarType.NPC then

    elseif type == LuaEnumAvatarType.Booth then

    elseif type == LuaEnumAvatarType.Pet then

    elseif type == LuaEnumAvatarType.Servant then

    else
    end
    return 0
end

---为C#的Avatar创建LuaAvatar
---@private
---@param csAvatar CSAvater
---@return LuaAvatar
function LuaAvatarFactory:CreateNewLuaAvatarForAvatar(csAvatar)
    if csAvatar == nil then
        return nil
    end
    ---@type LuaEnumAvatarType
    local avatarType = csAvatar.AvatarTypeNumber
    if avatarType == nil or avatarType == LuaEnumAvatarType.MainPlayer or avatarType == LuaEnumAvatarType.None then
        ---不处理mainplayer和none
        return nil
    end
    local luaAvatar
    if avatarType == LuaEnumAvatarType.MainPlayer then
        luaAvatar = luaclass.LuaMainPlayer:New()

    elseif avatarType == LuaEnumAvatarType.Player then
        luaAvatar = luaclass.LuaPlayer:New()

    elseif avatarType == LuaEnumAvatarType.Monster then
        luaAvatar = luaclass.LuaMonster:New()

    elseif avatarType == LuaEnumAvatarType.NPC then
        luaAvatar = luaclass.LuaNPC:New()

    elseif avatarType == LuaEnumAvatarType.Booth then
        luaAvatar = luaclass.LuaBooth:New()

    elseif avatarType == LuaEnumAvatarType.Pet then
        luaAvatar = luaclass.LuaPet:New()

    elseif avatarType == LuaEnumAvatarType.Servant then
        luaAvatar = luaclass.LuaServant:New()

    else
        luaAvatar = luaclass.LuaAvatar:New()
    end
    return luaAvatar
end
--endregion

--region 第二部分 AvatarInfo信息
---当CSAvaterInfo进行初始化的时候进行
---@param luaAvatar LuaAvatar
---@param data System.Object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
function LuaAvatarFactory:OnAvatarInfoInit(luaAvatar, data)
    if(luaAvatar == nil) then
        return;
    end
    if(luaAvatar.LuaAvatarInfo == nil) then
        luaAvatar.LuaAvatarInfo = self:CreateNewLuaAvatarInfoForAvatar(luaAvatar:GetCSAvatar())
    end
    luaAvatar.LuaAvatarInfo:InitData(data)
end

---@param csAvatar CSAvater
---@return LuaAvatarInfo 可能为其他的类,但是返回的类一定是继承与LuaAvatarInfo的
function LuaAvatarFactory:CreateNewLuaAvatarInfoForAvatar(csAvatar)
    ---@type LuaEnumAvatarType
    local avatarType = csAvatar.AvatarTypeNumber

    local luaAvatar
    if avatarType == LuaEnumAvatarType.MainPlayer then
        return luaclass.LuaAvatarInfo_MainPlayer:New()

    elseif avatarType == LuaEnumAvatarType.Player then
        luaAvatar = luaclass.LuaAvatarInfo_Player:New()

    elseif avatarType == LuaEnumAvatarType.Monster then
        luaAvatar = luaclass.LuaAvatarInfo_Monster:New()

    elseif avatarType == LuaEnumAvatarType.NPC then
        luaAvatar = luaclass.LuaAvatarInfo_Npc:New()

    elseif avatarType == LuaEnumAvatarType.Booth then
        luaAvatar = luaclass.LuaAvatarInfo_Booth:New()

    elseif avatarType == LuaEnumAvatarType.Pet then
        luaAvatar = luaclass.LuaAvatarInfo_Pet:New()

    elseif avatarType == LuaEnumAvatarType.Servant then
        luaAvatar = luaclass.LuaAvatarInfo_Servant:New()
    else
        luaAvatar = luaclass.LuaAvatarInfo:New()
    end
    return luaAvatar
end

--endregion

--region 第三部分 头顶CSHead组件
---@param csHead CSHead C#中的CSHead类
---@param luaAvatar LuaAvatar
function LuaAvatarFactory:OnAvatarHeadInit(csHead, luaAvatar)
    if(luaAvatar == nil) then
        return;
    end
    if(luaAvatar.LuaHead_Avatar == nil) then
        luaAvatar.LuaHead_Avatar = self:CreateNewLuaAvatarHeadForAvatar(luaAvatar:GetCSAvatar())
    end
    luaAvatar.LuaHead_Avatar:InitData(csHead)
end

---@param csAvatar CSAvater
---@return LuaAvatarInfo 可能为其他的类,但是返回的类一定是继承与LuaAvatarInfo的
function LuaAvatarFactory:CreateNewLuaAvatarHeadForAvatar(csAvatar)
    ---@type LuaEnumAvatarType
    local avatarType = csAvatar.AvatarTypeNumber

    local luaAvatar
    if avatarType == LuaEnumAvatarType.MainPlayer then
        return luaclass.LuaHead_MainPlayer:New()

    elseif avatarType == LuaEnumAvatarType.Player then
        luaAvatar = luaclass.LuaHead_Player:New()

    elseif avatarType == LuaEnumAvatarType.Monster then
        luaAvatar = luaclass.LuaHead_Monster:New()

    elseif avatarType == LuaEnumAvatarType.NPC then
        luaAvatar = luaclass.LuaHead_Npc:New()

    elseif avatarType == LuaEnumAvatarType.Booth then
        luaAvatar = luaclass.LuaHead_Booth:New()

    elseif avatarType == LuaEnumAvatarType.Pet then
        luaAvatar = luaclass.LuaHead_Pet:New()

    elseif avatarType == LuaEnumAvatarType.Servant then
        luaAvatar = luaclass.LuaHead_Servant:New()

    else
        luaAvatar = luaclass.LuaHead_Avatar:New()
    end
    return luaAvatar
end
--endregion

--region 第四部分 model模型加载
---@param csAvatar CSAvater C#中的CSHead类
---@param luaAvatar LuaAvatar
function LuaAvatarFactory:OnAvatarModelInit(csAvatar, luaAvatar)
    if(luaAvatar == nil) then
        return;
    end
    if(luaAvatar.LuaAvatarModel == nil) then
        luaAvatar.LuaAvatarModel = self:CreateNewLuaAvatarModelForAvatar(csAvatar)
    end
    luaAvatar.LuaAvatarModel:InitData(csAvatar)
end

---@param csAvatar CSAvater
---@return LuaAvatarInfo 可能为其他的类,但是返回的类一定是继承与LuaAvatarInfo的
function LuaAvatarFactory:CreateNewLuaAvatarModelForAvatar(csAvatar)
    ---@type LuaEnumAvatarType
    local avatarType = csAvatar.AvatarTypeNumber

    local luaAvatar
    if avatarType == LuaEnumAvatarType.MainPlayer then
        return luaclass.LuaAvatarModel_MainPlayer:New()

    elseif avatarType == LuaEnumAvatarType.Player then
        luaAvatar = luaclass.LuaAvatarModel_Player:New()

    elseif avatarType == LuaEnumAvatarType.Monster then
        luaAvatar = luaclass.LuaAvatarModel_Monster:New()

    elseif avatarType == LuaEnumAvatarType.NPC then
        luaAvatar = luaclass.LuaAvatarModel_Npc:New()

    elseif avatarType == LuaEnumAvatarType.Booth then
        luaAvatar = luaclass.LuaAvatarModel_Booth:New()

    elseif avatarType == LuaEnumAvatarType.Pet then
        luaAvatar = luaclass.LuaAvatarModel_Pet:New()

    elseif avatarType == LuaEnumAvatarType.Servant then
        luaAvatar = luaclass.LuaAvatarModel_Servant:New()
    else
        luaAvatar = luaclass.LuaAvatarModel:New()
    end
    return luaAvatar
end
--endregion

LuaAvatarFactory.AvatarStackClass = nil

function LuaAvatarFactory:PushAvatar(type, avatar)
    if(self.AvatarStackClass == nil) then
        self.AvatarStackClass = {}
    end
    if(self.AvatarStackClass[type] == nil) then
        self.AvatarStackClass[type] = {}
    end
    table.insert(self.AvatarStackClass, avatar);
end

function LuaAvatarFactory:PopAvatar(type)
    if(self.AvatarStackClass == nil or self.AvatarStackClass[type] == nil or #self.AvatarStackClass[type] == 0) then
        return nil
    end
    local class = self.AvatarStackClass[type][1]
    table.remove(self.AvatarStackClass[type], 1)

    return class;
end


return LuaAvatarFactory