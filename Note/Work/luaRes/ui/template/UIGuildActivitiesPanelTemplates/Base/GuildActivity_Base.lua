---@class GuildActivity_Base:TemplateBase
local GuildActivity_Base = {}

--region 组件
---背景图
---@return CSUIEffectLoad
function GuildActivity_Base:GetBg_UIEffectLoad()
    if self.Bg_UIEffectLoad == nil then
        self.Bg_UIEffectLoad = self:Get("bg", "CSUIEffectLoad")
    end
    return self.Bg_UIEffectLoad
end

---活动信息
---@return UILabel
function GuildActivity_Base:GetBossPrompt_UILabel()
    if self.BossPrompt_UILabel == nil then
        self.BossPrompt_UILabel = self:Get("Bossprompt", "UILabel")
    end
    return self.BossPrompt_UILabel
end

---按钮
---@return UnityEngine.GameObject
function GuildActivity_Base:GetButton_GameObject()
    if self.Button_GameObject == nil then
        self.Button_GameObject = self:Get("btn_get", "GameObject")
    end
    return self.Button_GameObject
end

---按钮文本
---@return UILabel
function GuildActivity_Base:GetButton_UILabel()
    if self.Button_UILabel == nil then
        self.Button_UILabel = self:Get("btn_get/Label", "UILabel")
    end
    return self.Button_UILabel
end

---按钮特效
---@return UnityEngine.GameObject
function GuildActivity_Base:GetButtonEffect_GameObject()
    if self.ButtonEffect_GameObject == nil then
        self.ButtonEffect_GameObject = self:Get("btn_get/effect", "GameObject")
    end
    return self.ButtonEffect_GameObject
end

---@return UISprite 背景图片
function GuildActivity_Base:GetBtnBG_UISprite()
    if self.BtnBG == nil then
        self.BtnBG = self:Get("btn_get", "UISprite")
    end
    return self.BtnBG
end

---当前进度
---@return UILabel
function GuildActivity_Base:GetNum_UILabel()
    if self.Num_UILabel == nil then
        self.Num_UILabel = self:Get("num", "UILabel")
    end
    return self.Num_UILabel
end

---当前进度背景图
---@return UISprite
function GuildActivity_Base:GetBg1_UISprite()
    if self.Bg1_UISprite == nil then
        self.Bg1_UISprite = self:Get("bg1", "UISprite")
    end
    return self.Bg1_UISprite
end

---标题图片
---@return UISprite
function GuildActivity_Base:GetTitle_UISprite()
    if self.Title_UISprite == nil then
        self.Title_UISprite = self:Get("name", "UISprite")
    end
    return self.Title_UISprite
end

---特效挂载节点
---@return UnityEngine.GameObject
function GuildActivity_Base:GetEffectPoint_GameObject()
    if CS.StaticUtility.IsNull(self.EffectPoint_GameObject) then
        self.EffectPoint_GameObject = self:Get("effect", "GameObject")
    end
    return self.EffectPoint_GameObject
end

---特效模板
---@return UnityEngine.GameObject
function GuildActivity_Base:GetEffectModel_GameObject()
    if CS.StaticUtility.IsNull(self.EffectModel_GameObject) then
        self.EffectModel_GameObject = self:Get("effect/bgEffect", "GameObject")
    end
    return self.EffectModel_GameObject
end
--endregion

--region 初始化
function GuildActivity_Base:Init()
    self:BindEvents()
    self:InitParams()
end

function GuildActivity_Base:BindEvents()
    self:BindClickCallBack(self:GetButton_GameObject(), function(go)
        self:EnterBtnOnClick(go)
    end)
    self:BindClickCallBack(self:GetBg1_UISprite(), function(go)
        self:Bg1BtnOnClick(go)
    end)
    CS.UIEventListener.Get(self.go).onClick = function(go)
        self:OnActivityBGClicked(go)
    end
end

function GuildActivity_Base:InitParams()
    if self.effectTable == nil then
        self.effectTable = {}
    end
end
--endregion

--region 刷新
---有参刷新 { activityId = activityInfo.ActivityId, activityInfo = activityInfo }
function GuildActivity_Base:RefreshPanel(commonData)
    self.analysisParamsSuccess = self:AnalysisParams(commonData)
    if self.analysisParamsSuccess == false then
        return
    end
    self:DefaultHideRefresh()
    self:DefaultShowRefresh()
end

---无参刷新
function GuildActivity_Base:RefreshPanelNoParams()

end

---解析数据
---@param commonData any 通用数据
---@return boolean 是否解析成功
function GuildActivity_Base:AnalysisParams(commonData)
    if commonData == nil or commonData.activityId == nil or commonData.activityInfo == nil then
        return false
    end
    ---@type number
    self.activityId = commonData.activityId
    self.activityInfo = commonData.activityInfo
    ---@type TABLE.CFG_UNION_ACTIVITY
    self.UnionActivityTableInfo = self.activityInfo.UnionActivityTable
    return true
end

---默认隐藏刷新
function GuildActivity_Base:DefaultHideRefresh()
    self:RefreshActive(self:GetBg1_UISprite(), false)
    self:RefreshActive(self:GetBossPrompt_UILabel(), false)
    self:RefreshActive(self:GetButton_GameObject(), false)
    self:RefreshActive(self:GetNum_UILabel(), false)
end

---默认显示刷新
function GuildActivity_Base:DefaultShowRefresh()
    if self.UnionActivityTableInfo ~= nil then
        self:RefreshSprite(self:GetTitle_UISprite(), self.UnionActivityTableInfo.title)
        self:RefreshCSUIEffectLoad(self:GetBg_UIEffectLoad(), self.UnionActivityTableInfo.backGround)
        if self.activityInfo ~= nil and self.activityInfo.BtnNameList ~= nil and self.activityInfo.BtnNameList.Count > 0 then
            self:RefreshLabel(self:GetButton_UILabel(), self.activityInfo.BtnNameList[0])
        end
        ---加载配置的常驻特效
        if self.activityInfo ~= nil and self.activityInfo.EffectList ~= nil and self.activityInfo.EffectList.Count > 0 then
            local length = self.activityInfo.EffectList.Count - 1
            for k = 0, length do
                local activityEffectInfo = self.activityInfo.EffectList[k]
                if activityEffectInfo ~= nil and CS.StaticUtility.IsNullOrEmpty(activityEffectInfo.EffectName) == false and activityEffectInfo.localPosition ~= nil then
                    self:RefreshCSUIEffectLoadByPath(activityEffectInfo.EffectName, activityEffectInfo.localPosition, 1)
                end
            end
        end
    end
end
--endregion

--region 点击事件
---当前只显示一个按钮（后期如果要显示多个按钮，则修改预设进行后处理）
function GuildActivity_Base:EnterBtnOnClick(go)

end

---背景点击事件
function GuildActivity_Base:Bg1BtnOnClick(go)

end

---活动背景点击事件
---@protected
---@overload
---@param go UnityEngine.GameObject
function GuildActivity_Base:OnActivityBGClicked(go)
    if self.UnionActivityTableInfo == nil then
        return
    end
    local luaTbl = clientTableManager.cfg_union_activityManager:TryGetValue(self.UnionActivityTableInfo.id)
    if luaTbl == nil then
        return
    end
    if luaTbl:GetRule() ~= nil and luaTbl:GetRule() ~= "" then
        uimanager:CreatePanel("UIUnionActivitiesDesPanel", nil, {
            title = luaTbl:GetButtonLabel(),
            description = luaTbl:GetRule(),
        })
    end
end
--endregion

--region UI刷新
---控制显示
function GuildActivity_Base:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function GuildActivity_Base:RefreshSprite(obj, spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
function GuildActivity_Base:RefreshLabel(obj, text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置特效
function GuildActivity_Base:RefreshCSUIEffectLoad(obj, effectName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.CSUIEffectLoad)) then
            obj:ChangeEffect(effectName)
        else
            local curCSUIEffectLoad = self:GetCurComp(obj, "", "CSUIEffectLoad")
            if curCSUIEffectLoad ~= nil then
                curCSUIEffectLoad:ChangeEffect(effectName)
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置特效深度
function GuildActivity_Base:RefreshSpriteDepth(obj, Depth)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_UISprite)) then
            obj.depth = Depth
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.depth = Depth
            end
        end
    end
end

---通过路径设置对应特效
---@return UnityEngine.GameObject effect
function GuildActivity_Base:RefreshCSUIEffectLoadByPath(effectName, localPosition, depth)
    if CS.StaticUtility.IsNullOrEmpty(effectName) == false and localPosition ~= nil and Utility.IsContainsKey(self.effectTable, effectName) == false then
        local effect = CS.Utility_Lua.CopyGO(self:GetEffectModel_GameObject(), self:GetEffectPoint_GameObject().transform)
        if effect ~= nil then
            effect.transform.localPosition = localPosition
            effect.name = effectName
            self:RefreshSpriteDepth(effect, depth)
            self.effectTable[effectName] = effect
        end
    end
    local effect = self.effectTable[effectName]
    if CS.StaticUtility.IsNull(effect) == false then
        self:RefreshCSUIEffectLoad(effect, effectName)
    end
end

---绑定点击事件
function GuildActivity_Base:BindClickCallBack(obj, action)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
    end
end

---通过特效名字播放特效（如果缓存了第一个的特效，则直接播放特效）
function GuildActivity_Base:TryPlayEffect(effectName, localPosition, depth)
    local effect = self.effectTable[effectName]
    if effect ~= nil then
        self:PlayEffect(effect)
    else
        self:RefreshCSUIEffectLoadByPath(effectName, localPosition, depth)
    end
end

---播放特效
function GuildActivity_Base:PlayEffect(obj)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.CSUIEffectLoad)) then
            self:RefreshActive(obj, false)
            self:RefreshActive(obj, true)
        else
            local curCSUIEffectLoad = self:GetCurComp(obj, "", "CSUIEffectLoad")
            if curCSUIEffectLoad ~= nil then
                self:RefreshActive(obj, false)
                self:RefreshActive(obj, true)
            end
        end
    end
end

---尝试隐藏特效
function GuildActivity_Base:TryHideEffect(effectName)
    if self.effectTable ~= nil then
        local effect = self.effectTable[effectName]
        if effect ~= nil then
            effect:SetActive(false)
        end
    end
end
--endregion

return GuildActivity_Base