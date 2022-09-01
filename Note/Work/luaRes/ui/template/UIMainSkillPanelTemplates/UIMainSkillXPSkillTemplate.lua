---主界面xp技能的控制模板
---@class UIMainSkillXPSkillTemplate:TemplateBase
local UIMainSkillXPSkillTemplate = {}

---icon
---@return UISprite
function UIMainSkillXPSkillTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("skillicon", "UISprite")
    end
    return self.mIconSprite
end

---归属者
---@return UIMainSkillXPSkills
function UIMainSkillXPSkillTemplate:GetOwner()
    return self.mOwner
end

---获取对应的技能表数据,隐藏时表数据可能为nil
---@return TABLE.CFG_SKILLS|nil
function UIMainSkillXPSkillTemplate:GetSkillTable()
    return self.mSkillData
end

---是否正在显示
---@return boolean
function UIMainSkillXPSkillTemplate:IsShowing()
    return self.mCurrentShowState
end

---初始化
---@param owner UIMainSkillXPSkills
function UIMainSkillXPSkillTemplate:Init(owner)
    self.mOwner = owner
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClicked()
    end
end

---绑定点击事件
---@param clickEvent fun<clickEvent:TABLE.CFG_SKILLS>
function UIMainSkillXPSkillTemplate:BindClickEvent(clickEvent)
    self.mClickEvent = clickEvent
end

---刷新
---@param skillData {tbl:TABLE.CFG_SKILLS,level:number}
function UIMainSkillXPSkillTemplate:Refresh(skillData)
    if self.mSkillData == skillData then
        return
    end
    self.mSkillData = skillData
    if skillData.tbl then
        self:GetIconSprite().spriteName = skillData.tbl.icon
    else
        self:GetIconSprite().spriteName = ""
    end
end

function UIMainSkillXPSkillTemplate:OnClicked()
    if self.mSkillData == nil then
        return
    end
    if self.mClickEvent ~= nil then
        self.mClickEvent(self.mSkillData)
    end
end

---设置当前的显示状态
---@public
---@param needShow boolean
function UIMainSkillXPSkillTemplate:SetShowState(needShow, isWithEffect)

    if self.mCurrentShowState == needShow then
        return
    end
    needShow = needShow == true
    self.mCurrentShowState = needShow
    if self.mCurrentShowState then
        self:PlayShowEffect(function()
            if self.mCurrentShowState and CS.StaticUtility.IsNull(self.go) == false then
                self.nowActive = true
                self.go:SetActive(true)
            end
        end)
    else
        if self.mPlayingEffect ~= nil then
            self.mPlayingEffect:Destroy()
            self.mPlayingEffect = nil
        end
        self.nowActive = false
        self.go:SetActive(false)
    end
    self:MapChangeRefreSh()
end

function UIMainSkillXPSkillTemplate:MapChangeRefreSh()
    local mapTable = clientTableManager.cfg_mapManager:TryGetValue(CS.CSScene.getMapID())
    if mapTable ~= nil and mapTable:GetXp() == 1 then
        self.go:SetActive(false)
        return
    else
        if self.nowActive~=nil then
            self.go:SetActive(self.nowActive)
        end
    end
end

---播放显示特效
---@private
---@param finishAction function
function UIMainSkillXPSkillTemplate:PlayShowEffect(finishAction)
    if self.mPlayingEffect ~= nil then
        self.mPlayingEffect:Destroy()
        self.mPlayingEffect = nil
    end
    self.mPlayingEffect = CS.UILocalScreenEffectLoader.Instance:CreateNewEffect()
    self.mPlayingEffect.OnEffectPlayFinished = function()
        self.mPlayingEffect = nil
    end
    if finishAction ~= nil then
        finishAction()
    end
    --if CS.CSListUpdateMgr.Instance ~= nil then
    --    if self.mListUpdateItem ~= nil then
    --        CS.CSListUpdateMgr.Instance:Remove(self.mListUpdateItem)
    --    end
    --    self.mListUpdateItem = CS.ListUpdateItem(750, self, function()
    --        self.mListUpdateItem = nil
    --        if finishAction ~= nil then
    --            finishAction()
    --        end
    --    end, false)
    --    CS.CSListUpdateMgr.Instance:Add(self.mListUpdateItem)
    --else
    --    if finishAction ~= nil then
    --        finishAction()
    --    end
    --end
    local selfTrans = self.go.transform
    self.mPlayingEffect:AddTimeLineData("700259", CS.UILayerType.AisstPlane, nil,
            { transform = selfTrans, timePoint = 0 },
            { transform = selfTrans, timePoint = 1.5 })
    self.mPlayingEffect:Play()
end

function UIMainSkillXPSkillTemplate:OnDestroy()
    if self.mPlayingEffect ~= nil then
        self.mPlayingEffect:Destroy()
        self.mPlayingEffect = nil
    end
    if self.mListUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.mListUpdateItem)
        self.mListUpdateItem = nil
    end
end

return UIMainSkillXPSkillTemplate