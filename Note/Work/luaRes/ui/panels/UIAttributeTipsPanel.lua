---@class UIAttributeTipsPanel:UIBase
local UIAttributeTipsPanel = {}

---@type UIAttributeTipsPanel
local this = nil;

UIAttributeTipsPanel.PanelLayerType = CS.UILayerType.AisstPlane

UIAttributeTipsPanel.IsInitialLoad = true

--region Components

function UIAttributeTipsPanel:GetAttributeChangeViewTemplate()
    if (this.mAttributeChangeViewTemplate == nil) then
        this.mAttributeChangeViewTemplate = templatemanager.GetNewTemplate(this:GetCurComp("WidgetRoot", "GameObject"), luaComponentTemplates.UIAttributeChangeViewTemplate, self);
    end
    return this.mAttributeChangeViewTemplate;
end

--endregion

--region Method

--region CallFunction
function UIAttributeTipsPanel:OnResPlayerAttributeChangeMessage(msgId, data)
    if UIAttributeTipsPanel.mAttrChangedData == nil then
        UIAttributeTipsPanel.mAttrChangedData = {}
    end
    table.insert(UIAttributeTipsPanel.mAttrChangedData, { DATA = data, ISSERVANT = false, CALLBACK = this.CheckNeedShowEffect })
    --this:GetAttributeChangeViewTemplate():AttributeChange(data, false, this.CheckNeedShowEffect);
end

function UIAttributeTipsPanel:OnResServantAttributeChangeMessage(data)
    if UIAttributeTipsPanel.mAttrChangedData == nil then
        UIAttributeTipsPanel.mAttrChangedData = {}
    end
    local tbl = { changeAttr = data }
    table.insert(UIAttributeTipsPanel.mAttrChangedData, { DATA = tbl, ISSERVANT = true, CALLBACK = nil })
end
--endregion

--region update
function update()
    if UIAttributeTipsPanel.mAttrChangedData ~= nil then
        for i = 1, #UIAttributeTipsPanel.mAttrChangedData do
            local data = UIAttributeTipsPanel.mAttrChangedData[i]
            this:GetAttributeChangeViewTemplate():AttributeChange(data.DATA, data.ISSERVANT, data.CALLBACK);
        end
        UIAttributeTipsPanel.mAttrChangedData = nil
    end
end
--endregion

--region Public

--endregion

--region Private

function UIAttributeTipsPanel.InitEvents()
    UIAttributeTipsPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerAttributeChangeMessage, UIAttributeTipsPanel.OnResPlayerAttributeChangeMessage)
    UIAttributeTipsPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Servant_AttributeChange, UIAttributeTipsPanel.OnResServantAttributeChangeMessage)
end
--endregion


--endregion


--region 特效

function UIAttributeTipsPanel.GetLimitLevel()
    if this.limitLevel == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20296)
        if isFind then
            this.limitLevel = tonumber(info.value)
        end
    end
    return this.limitLevel
end

UIAttributeTipsPanel.streamEffect = nil
UIAttributeTipsPanel.streamEffect_Path = ''
UIAttributeTipsPanel.streamEffectTween = nil
--检测是否需要显示流光特效 （70级后不显示）
function UIAttributeTipsPanel.CheckNeedShowEffect(isShowEffect)

    UIAttributeTipsPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_ChangeFightPowerUI)

    --local levle = CS.CSScene.MainPlayerInfo.Level
    --if levle > UIAttributeTipsPanel.GetLimitLevel() or isShowEffect == nil or not isShowEffect then
    --    CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event):SendEvent(CS.CEvent.V2_ChangeFightPowerUI)
    --    return
    --else
    --    this.LoadeEffectStreamer()
    --end
end

--加载流光特效
function UIAttributeTipsPanel.LoadeEffectStreamer()

    if this.streamEffect ~= nil and this.streamEffectTween ~= nil then
        this.streamEffectTween:PlayTween()
        this.streamEffect.gameObject:SetActive(true)
        return
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete('700051', CS.ResourceType.UIEffect, function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            if this.go == nil or CS.StaticUtility.IsNull(this.go) then
                return
            end
            this.streamEffect = res:GetObjInst()
            this.streamEffect_Path = res.path
            this.streamEffect.transform.parent = this:GetCurComp("WidgetRoot/effectform", "Transform")
            this.streamEffect.transform.localPosition = CS.UnityEngine.Vector3.zero
            this.streamEffect.transform.localScale = CS.UnityEngine.Vector3.one

            local headPanel = uimanager:GetPanel('UIRoleHeadPanel')
            if headPanel ~= nil then
                this.streamEffectTween = UIAttributeTipsPanel.streamEffect.gameObject:AddComponent(typeof(CS.Top_TweenTransform))
                this.streamEffectTween.duration = 1.3
                this.streamEffectTween.method = CS.Top_TweenTransform.Method.EaseOut
                this.streamEffectTween.from = this:GetCurComp("WidgetRoot/effectform", "Transform").transform
                this.streamEffectTween.to = headPanel:GetRoleFight_UILabel().transform
                this.streamEffectTween:SetOnFinished(function()
                    UIAttributeTipsPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_ChangeFightPowerUI)
                    this.streamEffect.gameObject:SetActive(false)
                end)
                this.streamEffectTween:PlayTween()
            end
        end
    end, CS.ResourceAssistType.UI)
end

--endregion

function UIAttributeTipsPanel:Init()
    this = self;

    this:InitEvents()
end

function UIAttributeTipsPanel:Show()

end

return UIAttributeTipsPanel