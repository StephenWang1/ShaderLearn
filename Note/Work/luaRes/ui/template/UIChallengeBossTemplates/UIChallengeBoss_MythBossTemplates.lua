---@class UIChallengeBoss_MythBossTemplates:UIChallengeBoss_FinalBossBaseTemplate 神级boss单元模板
local UIChallengeBoss_MythBossTemplates = {}

setmetatable(UIChallengeBoss_MythBossTemplates, luaComponentTemplates.UIChallengeBoss_FinalBossBaseTemplate)

--region 刷新
---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBoss_MythBossTemplates:RefreshUI(data, ClipShader)
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    self:RefreshBossRoomNum()
end

--region  数据初始化
---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBoss_MythBossTemplates:InitData(data)
    self:RunBaseFunction("InitData",data)
    ---@type boolean boss是否解锁
    self.bossUnLock = false
    self.bossRoomNum = 0
    self.bossBackGroundSpriteName = ""
    if self.fieldBossInfo ~= nil then
        self.bossUnLock = self.fieldBossInfo.configId ~= nil and self.fieldBossInfo.configId > 0
    end
    if self.bossTable ~= nil then
        self.bossBackGroundSpriteName = self.bossTable:GetParameter()
    end
end

---显示模型
---@param bossTable TABLE.cfg_boss
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBoss_MythBossTemplates:ShowModel(bossTable, monsterTable, RootGO)
    if bossTable == nil or monsterTable == nil or self.fieldBossInfo == nil then
        return
    end
    if self.bossUnLock == true then
        self:RunBaseFunction("ShowModel",bossTable,monsterTable,RootGO)
        luaclass.UIRefresh:RefreshActive(self.BlackModel_UISprite,false)
    else
        ---如果当前boss未解锁，则显示剪影
        luaclass.UIRefresh:RefreshSprite(self.BlackModel_UISprite,self.bossBackGroundSpriteName)
        luaclass.UIRefresh:RefreshActive(self.BlackModel_UISprite,true)
    end
end

---显示boss模型信息
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBoss_MythBossTemplates:ShowModelInfo(monsterTable)
    if monsterTable == nil or self.bossTable == nil then
        return
    end
    if self.bossUnLock == true then
        self:RunBaseFunction("ShowModelInfo",monsterTable)
    else
        if self.bossTable ~= nil then
            self.name.text = self.bossTable:GetName()
        end
    end
end

---刷新密室房间人数
function UIChallengeBoss_MythBossTemplates:RefreshBossRoomNum()
    luaclass.UIRefresh:RefreshActive(self.BossRoomNum_UILabel,false)
    if self.bossTable == nil or self.fieldBossInfo == nil or self.bossRoomNum <= 0 or self.bossUnLock == false then
        return
    end
    luaclass.UIRefresh:RefreshActive(self.BossRoomNum_UILabel,true)
    luaclass.UIRefresh:RefreshLabel(self.BossRoomNum_UILabel,tostring(self.bossRoomNum))
end
--endregion

return UIChallengeBoss_MythBossTemplates