---主场景
---@class LuaMainScene:luaobject
local LuaMainScene = {}

local gameMgr = gameMgr

--region 场景生命周期函数
---初始化(从切换地图后或者从登陆界面进入场景均会执行)
---@private
---@param csScene CSSceneExt
function LuaMainScene:Init(csScene)
    --print("Init", csScene)
    self.mCSScene = csScene
    if CS.CSScene.MainPlayerInfo ~= nil then
        self.mMainPlayerID = CS.CSScene.MainPlayerInfo.ID
    else
        self.mMainPlayerID = nil
    end
end

---帧Update
---@private
function LuaMainScene:Update()
    for i, v in pairs(self:GetLuaAvatarDic()) do
        if v:GetID() ~= 0 then
            v:Update()
        end
    end
end

---主场景销毁(切换地图前或者返回登录界面均会执行)
---@private
function LuaMainScene:OnDestroy()
    self.mCSScene = nil
end
--endregion

--region 场景事件

---场景单位进入事件
---当CSAvater进行初始化的时候进行
---@param csAvatar CSAvater C#中的avater类
---@param data System.Object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
---@param paramData System.Object[] 附带的额外参数,不一定有什么东西
function LuaMainScene:OnSceneUnitEnter(csAvatar, data, paramData)
    local lid = gameMgr:GetLuaAvatarFactory():GetAvatarID(csAvatar.AvatarTypeNumber, data)
    ---@type LuaAvatar
    local luaAvatar = self:GetLuaAvatarDic()[lid]

    local avatar = gameMgr:GetLuaAvatarFactory():OnAvatarInit(luaAvatar, csAvatar, data, paramData)
    local avatarList = self:GetLuaAvatars(avatar:GetAvatarType())
    if avatarList then
        avatarList[avatar:GetID()] = avatar
        self:GetLuaAvatarDic()[avatar:GetID()] = avatar
    end
end

---当CSAvaterInfo进行初始化的时候进行
---@param csAvatarInfo CSAvaterInfo C#中的CSAvaterInfo类
---@param data System.Object 单位在初始化的时候服务器传入的数据,基本就是mapV2.RoundXXXXXXXX
function LuaMainScene:OnAvatarInfoInit(csAvatarInfo, data)
    if(csAvatarInfo.Owner == nil) then
        return;
    end
    local lid = gameMgr:GetLuaAvatarFactory():GetAvatarID(csAvatarInfo.Owner.AvatarTypeNumber, data)
    ---@type LuaAvatar
    local luaAvatar = self:GetLuaAvatarDic()[lid]
    if(luaAvatar == nil) then
        return
    end
    gameMgr:GetLuaAvatarFactory():OnAvatarInfoInit(luaAvatar, data)
end

---@param csHead CSHead C#中的CSHead类
function LuaMainScene:OnAvatarHeadInit(csHead)
    local lid = csHead.Avatar.ID
    ---@type LuaAvatar
    local luaAvatar = self:GetLuaAvatarDic()[lid]
    if(luaAvatar == nil) then
        return
    end
    gameMgr:GetLuaAvatarFactory():OnAvatarHeadInit(csHead, luaAvatar)
end


function LuaMainScene:OnAvatarModelInit(csAvatar)
    local lid = csAvatar.ID
    ---@type LuaAvatar
    local luaAvatar = self:GetLuaAvatarDic()[lid]
    if(luaAvatar == nil) then
        return
    end
    gameMgr:GetLuaAvatarFactory():OnAvatarModelInit(csAvatar, luaAvatar)
end


---场景单位销毁事件
---@private
---@param id number
---@param type number
function LuaMainScene:OnSceneUnitDestroyed(id, type)
    self:DestroyAvatarByID(id, type)
end

---根据id销毁LuaAvatar
---@private
---@param id number
---@param type number
function LuaMainScene:DestroyAvatarByID(id, type)
    if id == nil or type == nil or self:GetLuaAvatarDic()[id] == nil then
        return
    end
    local avatarList = self:GetLuaAvatars(type)
    if avatarList then
        local luaAvatar = avatarList[id]
        if luaAvatar ~= nil then
            avatarList[id] = nil
            luaAvatar:Destroy()
            gameMgr:GetLuaAvatarFactory():PushAvatar(luaAvatar:GetAvatarType(), luaAvatar)
        end
    end
    self:GetLuaAvatarDic()[id] = nil
end
--endregion

--region 获取对象
---获取LuaAvatar列表
---@param type LuaEnumAvatarType
---@return table<number,LuaAvatar> ID-LuaAvatar字典
function LuaMainScene:GetLuaAvatars(type)
    if self.mLuaAvatars == nil then
        self.mLuaAvatars = {}
    end
    if type ~= LuaEnumAvatarType.None and type ~= LuaEnumAvatarType.MainPlayer then
        local avatarList = self.mLuaAvatars[type]
        if avatarList == nil then
            avatarList = {}
            self.mLuaAvatars[type] = avatarList
        end
        return avatarList
    end
    return nil
end

---获取LuaAvatar字典
---@return table<number,LuaAvatar> ID-LuaAvatar字典
function LuaMainScene:GetLuaAvatarDic()
    if self.mAvatarDic == nil then
        self.mAvatarDic = {}
    end
    return self.mAvatarDic
end

---获取对应的C#中的场景
---@return CSSceneExt
function LuaMainScene:GetCSScene()
    return self.mCSScene
end

---获取主角的luaAvatar
---@return LuaMainPlayer
function LuaMainScene:GetLuaMainPlayer()
    return self.mLuaMainPlayer
end

---获取C#的Avatar对应的LuaAvatar
---@param csAvatar CSAvater
function LuaMainScene:GetLuaAvatar(csAvatar)
    if csAvatar == nil then
        return nil
    end
    local id = csAvatar.ID
    if id == nil then
        id = csAvatar.itemId
    end
    if id == nil or id == 0 then
        return nil
    end
    if id == self.mMainPlayerID then
        return self:GetLuaMainPlayer()
    end
    local luaAvatar = self:GetLuaAvatarDic()[id]
    return luaAvatar
end

---根据ID获取LuaAvatar
---@param id number
function LuaMainScene:GetLuaAvatarByID(id)
    if id == nil or id == 0 then
        return
    end
    if id == self.mMainPlayerID then
        return self:GetLuaMainPlayer()
    end
    local scene = CS.CSScene.Sington
    if scene == nil then
        return nil
    end
    local avatar = scene:getAvatar(id)
    if avatar == nil then
        avatar = scene:getItem(id)
    end
    if avatar == nil then
        return nil
    end
    ---在lua中为对应的物品或者avatar创建luaAvatar
    return self:GetLuaAvatar(avatar)
end

---获取Lua中主角数据管理器
---@return PlayerDataManager
function LuaMainScene:GetLuaMainPlayerData()
    return gameMgr:GetPlayerDataMgr()
end

---通过NpcId获取avatar
---@param npcId number
---@return LuaNPC
function LuaMainScene:GetLuaAvatarByNpcId(npcId)
    local npcAvatarList = CS.CSSceneExt.Sington:GetAvaterList(CS.EAvatarType.NPC)
    if npcAvatarList == nil then
        return
    end
    local length = npcAvatarList.Count
    for k = 0,length - 1 do
        ---@type LuaNPC
        local npcAvatar = npcAvatarList[k]
        if npcAvatar ~= nil and npcAvatar.Cfg_NPCTbl ~= nil and npcAvatar.Cfg_NPCTbl.id == npcId then
            return npcAvatar
        end
    end
end

---@param id number 获取CSAvatar
---@return CSAvater
function LuaMainScene:GetCSAvatar(id)
    return CS.CSScene.Sington:getAvatar(id)
end
--endregion

return LuaMainScene