---主界面xp技能滑动条
---@class UIMainSkillXPSlider:TemplateBase
local UIMainSkillXPSlider = {}

---归属界面
---@return UIMainSkillPanel
function UIMainSkillXPSlider:GetOwnerPanel()
    return self.mOwnerPanel
end

---获取爆炸特效跟随点
---@private
---@return UnityEngine.GameObject
function UIMainSkillXPSlider:GetExplodeEffectFollowPoint()
    if self.mExplodeEffectGO == nil then
        self.mExplodeEffectGO = self:Get("effectPos", "GameObject")
    end
    return self.mExplodeEffectGO
end

---slider
---@private
---@return UISprite
function UIMainSkillXPSlider:GetSliderUISprite()
    if self.mSliderSprite == nil then
        self.mSliderSprite = self:Get("slider", "UISprite")
    end
    return self.mSliderSprite
end

---lasteffect
---@private
---@return UISprite
function UIMainSkillXPSlider:GetLastEffectSprite()
    if self.mLastEffectSprite == nil then
        self.mLastEffectSprite = self:Get("lasteffect", "UISprite")
    end
    return self.mLastEffectSprite
end

---初始化
---@param ownerPanel UIMainSkillPanel
function UIMainSkillXPSlider:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
end

---初始化
---@private
function UIMainSkillXPSlider:Initialize()
    ---初始化时隐藏xp技能进度条
    self:SetPercentage(0, true)
    self:RefreshXPSlider()
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.XPSkillEnergyChanged, function(id)
        self:RefreshXPSlider()
    end)
    self:GetOwnerPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.XPSkillChanged, function()
        self:RefreshXPSlider()
    end)
    self:GetOwnerPanel():GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdateSkillCool, function(id, skillID, cdTime)
        --cdTime = 20000
        self:OnSkillCoolUpdate(skillID, cdTime)
    end)
    self:GetOwnerPanel():GetClientEventHandler():AddEvent(CS.CEvent.V2_XPSkillContinuousStateReseted, function()
        self:ResetXPCooling()
    end)
end

---刷新技能冷却时间
---@param skillID number 技能ID
---@param cdTime number CD时间(毫秒)
function UIMainSkillXPSlider:OnSkillCoolUpdate(skillID, cdTime)
    --print("OnSkillCoolUpdate")
    if skillID == nil or cdTime == nil or self.mIsCDCooling then
        return
    end
    local skillInfo = gameMgr:GetPlayerDataMgr():GetXPSkillInfo()
    if skillInfo == nil then
        return
    end
    local xpSkills = skillInfo:GetXPSkills()
    if #xpSkills == 0 then
        return
    end
    local isXPSkill = false
    for i = 1, #xpSkills do
        if xpSkills[i].tbl ~= nil and xpSkills[i].tbl.id == skillID then
            isXPSkill = true
            break
        end
    end
    if isXPSkill == false then
        return
    end
    self.mIsCDCooling = true
    self.mCDTimeInterval = cdTime * 0.001
    self.mCDCoolFinishTime = CS.UnityEngine.Time.time + self.mCDTimeInterval
    luaEventManager.DoCallback(LuaCEvent.XPSkillSliderIsInCD)
    --print("luaEventManager.DoCallback(LuaCEvent.XPSkillSliderIsInCD)")
end

---xp技能能量变化事件
---@private
function UIMainSkillXPSlider:RefreshXPSlider()
    if gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    local skillInfo = gameMgr:GetPlayerDataMgr():GetXPSkillInfo()
    if skillInfo == nil then
        return
    end
    if #skillInfo:GetXPSkills() == 0 then
        self:SetPercentage(0, true)
        return
    end
    local currentEnergy = skillInfo:GetXPSkillEnergy()
    local maxEnergy = skillInfo:GetXPSkillMaxEnergy()
    if currentEnergy and maxEnergy then
        if maxEnergy <= 0 then
            self:SetPercentage(0)
        else
            self:SetPercentage(currentEnergy / maxEnergy)
        end
        if currentEnergy == maxEnergy and self.mIsCDCooling == false then
            self:PlayExplodeEffect()
        end
    end
end

---播放能量点飞行爆炸特效
---@private
---@boolean 是否启动播放成功
function UIMainSkillXPSlider:PlayExplodeEffect()
    --if energySourceCoord == nil or energySourceCoord.x == nil or energySourceCoord.y == nil
    --        or CS.CSScene.Sington == nil or CS.UICamera.mainCamera == nil or CS.UILocalScreenEffectLoader.Instance == nil then
    --    return false
    --end
    --local cell = CS.CSScene.Sington.Mesh:getCell(energySourceCoord.x, energySourceCoord.y)
    --if cell == nil then
    --    return false
    --end
    --local worldPosition = cell.WorldPosition
    --local screenPosition = CS.CSSceneExt.Sington.Camera:WorldToScreenPoint(worldPosition)
    --local effectStartWorldPosition = CS.UICamera.mainCamera:ScreenToWorldPoint(screenPosition)
    --effectStartWorldPosition.z = self.go.transform.position.z
    if self.mEffectList == nil then
        ---@type table<number,UILocalScreenEffectLoaderEffectLoadPort>
        self.mEffectList = {}
    end
    ---@type UILocalScreenEffectLoaderEffectLoadPort
    local mPlayingEffect = CS.UILocalScreenEffectLoader.Instance:CreateNewEffect()
    -----飞行特效
    --mPlayingEffect:AddTimeLineData("700257", CS.UILayerType.AisstPlane, nil,
    --        { position = effectStartWorldPosition, timePoint = 0.25 },
    --        { transform = self.go.transform, timePoint = 1 })
    ---爆炸特效
    mPlayingEffect:AddTimeLineData("700255", CS.UILayerType.AisstPlane,
            function()
                if self.mEffectList ~= nil then
                    for i = 1, #self.mEffectList do
                        if self.mEffectList[i] == mPlayingEffect then
                            table.remove(self.mEffectList, i)
                            break
                        end
                    end
                end
            end,
            { transform = self:GetExplodeEffectFollowPoint().transform, timePoint = 0 },
            { transform = self:GetExplodeEffectFollowPoint().transform, timePoint = 1.5 }
    )
    table.insert(self.mEffectList, mPlayingEffect)
    mPlayingEffect:Play()
    return true
end

---设置xp经验百分比
---@public
---@param percentage number
---@param directly boolean
function UIMainSkillXPSlider:SetPercentage(percentage, directly)
    --print("SetPercentage", percentage, CS.UnityEngine.Time.frameCount)
    if percentage == nil then
        return
    end
    percentage = math.clamp01(percentage)
    if directly then
        ---如果需要直接设置过去,则重置当前的实际百分比和参数
        self.mPercentageList = {}
        self.mRealPercentage = nil
        self.mTargetPercentage = nil
    end
    if self.mPercentageList == nil then
        self.mPercentageList = {}
    end
    if #self.mPercentageList > 0 then
        if self.mPercentageList[#self.mPercentageList] == percentage then
            --若百分比是列表最后一个,则不用再加了
            return
        end
    end
    table.insert(self.mPercentageList, percentage)
end

---设置xp经验百分比
---@private
---@param realPercentage number
function UIMainSkillXPSlider:SetPercentageInternal(realPercentage)
    if realPercentage == nil then
        return
    end
    realPercentage = math.clamp01(realPercentage)
    if self.mLastRealEffectSprite == realPercentage then
        return
    end
    self.mLastRealEffectSprite = realPercentage
    self:GetSliderUISprite().fillAmount = realPercentage
    --local eulerAngle = self:GetLastEffectSprite().transform.localEulerAngles
    --eulerAngle.z = 90 - 360 * realPercentage
    --self:GetLastEffectSprite().transform.localEulerAngles = eulerAngle
    --self:GetLastEffectSprite().fillAmount = math.clamp01(0.75 + realPercentage)
end

---逐帧Update
---@public
function UIMainSkillXPSlider:OnUpdate()
    if self.mIsCDCooling and self.mCDCoolFinishTime ~= nil and self.mCDTimeInterval ~= nil then
        self:UpdateCDCool()
    else
        self:UpdatePercentage()
    end

    --if CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.Space) then
    --    self:GetOwnerPanel():GetClientEventHandler():SendEvent(CS.CEvent.V2_XPSkillContinuousStateReseted)
    --end
end

---重置xp技能冷却
---@private
function UIMainSkillXPSlider:ResetXPCooling()
    if self.mIsCDCooling then
        if self.mCDCoolFinishTime == nil then
            return
        end
        local currentTime = CS.UnityEngine.Time.time
        if currentTime > self.mCDCoolFinishTime then
            return
        end
        if self.mCDTimeInterval == nil or self.mCDTimeInterval == 0 then
            return
        end
        local minusedTime = (self.mCDCoolFinishTime - currentTime) * 0.98
        local currentPercentage = (self.mCDCoolFinishTime - currentTime) / self.mCDTimeInterval
        if currentPercentage == 0 then
            return
        end
        self.mCDCoolFinishTime = self.mCDCoolFinishTime - minusedTime
        self.mCDTimeInterval = (self.mCDCoolFinishTime - currentTime) / currentPercentage
    end
end

---更新CD冷却
---@private
function UIMainSkillXPSlider:UpdateCDCool()
    if self.mIsCDCooling == false and self.mCDCoolFinishTime == nil then
        return
    end
    local currentTime = CS.UnityEngine.Time.time
    if currentTime > self.mCDCoolFinishTime or self.mCDTimeInterval == nil or self.mCDTimeInterval <= 0 then
        self.mIsNeedResetCoolingImmediately = false
        ---CD结束,应当将目标列表整理下,并刷新一次xp能量
        self.mIsCDCooling = false
        if self.mPercentageList ~= nil and #self.mPercentageList > 0 then
            self.mPercentageList = {}
            self.mTargetPercentage = nil
            self.mRealPercentage = 0
            self:RefreshXPSlider()
        end
        luaEventManager.DoCallback(LuaCEvent.XPSkillSliderCDFinished)
        --print("luaEventManager.DoCallback(LuaCEvent.XPSkillSliderCDFinished)")
    else
        ---按照CD更新进度条
        local cdPercentage = (self.mCDCoolFinishTime - currentTime) / self.mCDTimeInterval
        self:SetPercentageInternal(cdPercentage)
    end
end

---刷新当前百分比
---@private
function UIMainSkillXPSlider:UpdatePercentage()
    if (self.mPercentageList == nil or #self.mPercentageList == 0) and (self.mTargetPercentage == nil) then
        ---若目标列表和当前目标都没有的话,就返回
        return
    end
    if self.mTargetPercentage == nil then
        ---若目标百分比不存在,则从百分比列表中弹出下一个百分比
        self.mTargetPercentage = self.mPercentageList[1]
        table.remove(self.mPercentageList, 1)
        if #self.mPercentageList == 0 then
            self.mPercentageList = nil
        end
    end
    if self.mRealPercentage == nil then
        ---若真正的百分比不存在,则直接设置过去
        self.mRealPercentage = self.mTargetPercentage
    else
        local percentageDiff = self.mTargetPercentage - self.mRealPercentage
        if math.abs(percentageDiff) < 0.02 then
            ---如果与最终百分比差的非常小,则直接设置过去,并清空当前目标百分比,以便结束或者取下个点
            self.mRealPercentage = self.mTargetPercentage
            self.mTargetPercentage = nil
        else
            ---如果与最终百分比差的比较大,则插值移动过去
            local moveSpeed = 1.5
            local percentageTemp = self.mRealPercentage + CS.UnityEngine.Time.deltaTime * moveSpeed * (percentageDiff > 0 and 1 or -1)
            if percentageDiff > 0 then
                if percentageTemp > self.mTargetPercentage then
                    percentageTemp = self.mTargetPercentage
                    self.mTargetPercentage = nil
                end
            else
                if percentageTemp < self.mTargetPercentage then
                    percentageTemp = self.mTargetPercentage
                    self.mTargetPercentage = nil
                end
            end
            self.mRealPercentage = percentageTemp
        end
    end
    ---设置最终百分比
    if self.mRealPercentage then
        self:SetPercentageInternal(self.mRealPercentage)
    end
end

function UIMainSkillXPSlider:OnDestroy()
    if self.mEffectList ~= nil then
        for i = 1, #self.mEffectList do
            self.mEffectList[i]:Destroy()
        end
        self.mEffectList = nil
    end
end

return UIMainSkillXPSlider