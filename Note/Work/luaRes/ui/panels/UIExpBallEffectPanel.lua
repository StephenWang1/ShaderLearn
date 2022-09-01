---@class UIExpBallEffectPanel:UIBase
local UIExpBallEffectPanel = { }

--region 数据
UIExpBallEffectPanel.earningTable = {}
---转圈回收特效文本间隔
UIExpBallEffectPanel.Interval = 0.8
UIExpBallEffectPanel.PanelLayerType = CS.UILayerType.TipsPlane
---正常背包回收特效移动偏差值
UIExpBallEffectPanel.normalBagPanelEffectInterval = -10
--endregion

--region 初始化
function UIExpBallEffectPanel:Init()
    self:InitComponent()
    self:InitParams()
    self:InitEvent()
    self:SaveEffectIdAndEffectPoint()
end

function UIExpBallEffectPanel:InitComponent()
    self.effectPoint = self:GetCurComp("effect", "Transform")
    self.effect_rotate = self:GetCurComp("effect/rotate", "GameObject")
    self.allLabel_UIGridContainer = self:GetCurComp("Attr", "UIGridContainer")
    self.controlTemplate_TweenAlpha = self:GetComp(self.allLabel_UIGridContainer.controlTemplate.transform, "AttrValue", "TweenAlpha")

    --region 复合型特效（用于互相组合）
    self.servantExpCompoundEffect_GameObject = self:GetCurComp("effect/expEffect", "GameObject")
    self.goldCompoundEffect_GameObject = self:GetCurComp("effect/goldEffect", "GameObject")
    self.ingotCompoundEffect_GameObject = self:GetCurComp("effect/IngotEffect", "GameObject")
    self.equipCoinCompoundEffect_GameObject = self:GetCurComp("effect/equipCoinEffect", "GameObject")
    self.diamondCompoundEffect_GameObject = self:GetCurComp("effect/diamondEffect", "GameObject")

    self.qishuEffect_GameObject = self:GetCurComp("effect/mountExpEffect", "GameObject")
    --endregion

    self.backGroundEffect_GameObject = self:GetCurComp("effect/backEffect", "GameObject")

    --region 单个特效
    self.servantExpEffect_GameObject = self:GetCurComp("effect/onlyExpEffect", "GameObject")
    self.goldEffect_GameObject = self:GetCurComp("effect/onlyGoldEffect", "GameObject")
    self.ingotEffect_GameObject = self:GetCurComp("effect/onlyIngotEffect ", "GameObject")
    self.equipCoinEffect_GameObject = self:GetCurComp("effect/onlyEquipCoinEffect", "GameObject")
    self.diamondEffect_GameObject = self:GetCurComp("effect/onlyDiamondEffect", "GameObject")
    self.cangPinEffect_GameObject = self:GetCurComp("effect/cangPinZhiEffect", "GameObject")
    --endregion
end

function UIExpBallEffectPanel:InitParams()
    self.effectDuration = self.controlTemplate_TweenAlpha.duration
    self.normalBagPanelEffectInterval = CS.Cfg_GlobalTableManager.Instance:GetRecycleEffectNormalInterval()
    self.IsSetPoint = self:SetPoint()
end

function UIExpBallEffectPanel:SetPoint()
    local uiBagPanel = uimanager:GetPanel("UIBagPanel")
    if uiBagPanel ~= nil and uiBagPanel.go ~= nil and self.go ~= nil and self.go.transform.parent ~= nil then
        self.go.transform.parent = uiBagPanel.go.transform
        self.go.transform.localPosition = CS.UnityEngine.Vector3.zero
        return true
    end
    return false
end

function UIExpBallEffectPanel:InitEvent()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, UIExpBallEffectPanel.Bag_BagPanelIsClose)
end

---回收物品itemId => 特效预设
function UIExpBallEffectPanel:SaveEffectIdAndEffectPoint()
    ---复合型特效
    self.effectIdAndCompoundEffectPoint = {}
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.Diamond] = self.diamondCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.Diamond1] = self.diamondCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.Diamond2] = self.diamondCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.Diamond3] = self.diamondCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.Diamond4] = self.diamondCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.ServantExp] = self.servantExpCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.JinBi] = self.goldCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.YuanBao] = self.ingotCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.BangYuan] = self.ingotCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.EquipCoin] = self.equipCoinCompoundEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.QiShuExp] = self.qishuEffect_GameObject
    self.effectIdAndCompoundEffectPoint[LuaEnumCoinType.ShouCangZhi] = self.cangPinEffect_GameObject

    ---单个特效
    self.effectIdAndEffectPoint = {}
    self.effectIdAndEffectPoint[LuaEnumCoinType.Diamond] = self.diamondEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.Diamond1] = self.diamondEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.Diamond2] = self.diamondEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.Diamond3] = self.diamondEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.Diamond4] = self.diamondEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.ServantExp] = self.servantExpEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.JinBi] = self.goldEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.YuanBao] = self.ingotEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.BangYuan] = self.ingotEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.EquipCoin] = self.equipCoinEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.QiShuExp] = self.qishuEffect_GameObject
    self.effectIdAndEffectPoint[LuaEnumCoinType.ShouCangZhi] = self.cangPinEffect_GameObject

end
--endregion

--region 刷新显示
---显示
---@alias CoinItemID number
---@alias CoinCount number
---@param earningTable System.Collections.Generic.Dictionary2TKeyTValue|table<CoinItemID,CoinCount>
function UIExpBallEffectPanel:Show(earningTable)
    self:ResetPoint()
    UIExpBallEffectPanel.earningTable = earningTable
    local earningItemIdTable = self:GetEarningItemIdTable(earningTable)
    self:ShowCoinEffect(earningItemIdTable)
end

function UIExpBallEffectPanel:ResetPoint()
    if self.IsSetPoint ~= true then
        self.IsSetPoint = self:SetPoint()
    end
end

---解析回收数据
function UIExpBallEffectPanel:GetEarningItemIdTable(earningTable)
    local mTable = {}
    if earningTable ~= nil then
        for k, v in pairs(earningTable) do
            table.insert(mTable, k)
        end
    end
    return mTable
end

---显示货币特效
function UIExpBallEffectPanel:ShowCoinEffect(earningTable)
    if earningTable ~= nil and type(earningTable) == 'table' then
        if #earningTable == 1 then
            if self.effectIdAndEffectPoint ~= nil and type(self.effectIdAndEffectPoint) == 'table' then
                local effectGo = self.effectIdAndEffectPoint[earningTable[1]]
                if effectGo ~= nil and not CS.StaticUtility.IsNull(effectGo) then
                    effectGo:SetActive(false)
                    effectGo:SetActive(true)
                end
            end
        elseif #earningTable > 1 then
            for k, v in pairs(earningTable) do
                ---回收收益itemId
                local recycleEarningItemId = v
                if self.effectIdAndCompoundEffectPoint ~= nil and type(self.effectIdAndCompoundEffectPoint) == 'table' then
                    local effect = self.effectIdAndCompoundEffectPoint[recycleEarningItemId]
                    if CS.StaticUtility.IsNull(effect) == false then
                        effect:SetActive(false)
                        effect:SetActive(true)
                    end
                end
            end
            self:PlayBackGroundEffect()
        end
    end
end

---播放背景特效
function UIExpBallEffectPanel:PlayBackGroundEffect()
    if CS.StaticUtility.IsNull(self.backGroundEffect_GameObject) == false then
        self.backGroundEffect_GameObject:SetActive(false)
        self.backGroundEffect_GameObject:SetActive(true)
    end
end
--endregion

--region 转圈加文本显示效果
---旧的转圈特效外加label
function UIExpBallEffectPanel:ShowRotateEffectAndAttr(earningTable)
    self.effect_rotate:SetActive(false)
    self.effect_rotate:SetActive(true)
    UIExpBallEffectPanel:InitAllLabel(earningTable)
end

function UIExpBallEffectPanel:InitAllLabel(earningTable)
    local labelListCount = 0
    local itemId = {}
    local num = {}
    for k, v in pairs(earningTable) do
        labelListCount = labelListCount + 1
        table.insert(itemId, k)
        table.insert(num, v)
    end

    ---自适应特效的持续时间
    local duration = self.effectDuration - self.effectDuration * (1 - UIExpBallEffectPanel.Interval) * labelListCount

    self.allLabel_UIGridContainer.MaxCount = labelListCount

    local index = labelListCount - 1
    local startDelay = 0
    for k, v in pairs(earningTable) do
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(k)
        if itemInfoIsFind then
            local nameContent = "获得" .. itemInfo.name
            local numContent = tostring(v)
            local temp = self.allLabel_UIGridContainer.controlList[index]
            local attrNum_UILabel = self:GetComp(temp.transform, "AttrValue", "UILabel")
            local attrNameValue_UILabel = self:GetComp(temp.transform, "AttrValue/Label", "UILabel")
            local attrValue_TweenPosition = self:GetComp(temp.transform, "AttrValue", "TweenPosition")
            local attrValue_TweenAlpha = self:GetComp(temp.transform, "AttrValue", "TweenAlpha")
            attrNameValue_UILabel.text = nameContent
            attrNum_UILabel.text = numContent
            attrValue_TweenPosition.duration = duration
            attrValue_TweenAlpha.duration = duration
            attrValue_TweenPosition.delay = startDelay
            attrValue_TweenAlpha.delay = startDelay
            startDelay = attrValue_TweenAlpha.duration + startDelay - attrValue_TweenAlpha.duration * UIExpBallEffectPanel.Interval
            attrValue_TweenPosition:PlayTween()
            attrValue_TweenAlpha:PlayTween()
        end
        index = index - 1
    end
end
--endregion

--region 背包相关
---背包关闭
function UIExpBallEffectPanel.Bag_BagPanelIsClose()
    uimanager:ClosePanel("UIExpBallEffectPanel")
end
--endregion

return UIExpBallEffectPanel