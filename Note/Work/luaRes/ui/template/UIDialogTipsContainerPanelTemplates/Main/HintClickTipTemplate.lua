local HintClickTipTemplate = {}

--region 基础数据
HintClickTipTemplate.labelBaseWidth = 114
HintClickTipTemplate.labelBaseHigh = 46
HintClickTipTemplate.backGroundBaseWidth = 146
HintClickTipTemplate.backGroundBaseHigh = 66
HintClickTipTemplate.LightBaseWidth = 155
HintClickTipTemplate.LightBaseHigh = 52
--endregion

--region 初始化
function HintClickTipTemplate:Init()
    self:InitComponent()
    self:BindEvents()
end

function HintClickTipTemplate:InitComponent()
    self.tween_Position = self:Get("tipPanel","TweenPosition")
    self.content_UILabel = self:Get("tipPanel/lb_tips","UILabel")
    self.content_UIAnchor = self:Get("tipPanel/lb_tips","UIAnchor")
    self.content_BoxCollider = self:Get("tipPanel/lb_tips","BoxCollider")
    self.bg_UISprite = self:Get("tipPanel/bg","UISprite")
    self.followPoint = self:Get("","Top_FollowPoint")
    self.go_TweenAlpha = self:Get("","TweenAlpha")
    self.go_UIPanel = self:Get("","UIPanel")
    self.light_UISprite = self:Get("tipPanel/bg/light","UISprite")
end

function HintClickTipTemplate:BindEvents()
    CS.UIEventListener.Get(self.content_UILabel.gameObject).onClick = function(go)
        if self.clickCallBack ~= nil and self.isCanClick then
            self.clickCallBack(self)
            self.hintClickTipsManager:RemoveTips(self)
        end
    end
end
--endregion

--region 刷新
---刷新tip
function HintClickTipTemplate:RefreshTip(commonData)
    if self:AnalysisParams(commonData) == true then
        if self:GetPopState() ~= true then
            self:TweenAlpha()
        end
        self:RefreshPanel()
        self:SetTipPosition()
        self:AdaptiveBgSize()
        self:RefreshPopState()
        self:RefreshWidth()
        self:RefreshLabelPosition()
        self:RefreshDepth()
        self:RefreshLight()
        self:RefreshBoxColliderState()
        self:AddTimeEndToHide()
    end
end

---解析参数
function HintClickTipTemplate:AnalysisParams(commonData)
    self.hintClickTipsManager = commonData.hintClickTipsManager
    self.guidBubbleInfo = commonData.guidBubbleInfo
    ---@type TABLE.cfg_guide_bubble
    self.LuaGuidBubbleInfo = clientTableManager.cfg_guide_bubbleManager:TryGetValue(self.guidBubbleInfo.id)
    self.point = commonData.point
    self.clickCallBack = commonData.clickCallBack
    self.objectPoolTemplate = commonData.objectPoolTemplate
    if self.guidBubbleInfo == nil or self.point == nil then
        return false
    end
    self.timeEndCallBack = commonData.timeEndCallBack
    self.isCanClick = ternary(self.guidBubbleInfo.canClick == 1,true,false)
    self.durationTime = self.guidBubbleInfo.lastTime
    self.filp = self.guidBubbleInfo.flip
    self.prefixOffset = CS.Cfg_Guide_BubbleTableManager.Instance:GetLabelPixelOffset(self.guidBubbleInfo.id)
    self.popHintOffsetWidthAndHigh = {x = 0,y = 0}
    if type(self.LuaGuidBubbleInfo:GetBackGroundSize()) == 'table' and self.LuaGuidBubbleInfo:GetBackGroundSize().list ~= nil and Utility.GetLuaTableCount(self.LuaGuidBubbleInfo:GetBackGroundSize().list) > 1 then
        self.popHintOffsetWidthAndHigh.x = self.LuaGuidBubbleInfo:GetBackGroundSize().list[1]
        self.popHintOffsetWidthAndHigh.y = self.LuaGuidBubbleInfo:GetBackGroundSize().list[2]
    end
    self.backGroundSpriteName = ternary(CS.StaticUtility.IsNullOrEmpty(self.guidBubbleInfo.atlas) == true,"yindao",self.guidBubbleInfo.atlas)
    self.depth = ternary(commonData.depth == nil,0,commonData.depth)
    return true
end

---刷新面板
function HintClickTipTemplate:RefreshPanel()
    if CS.StaticUtility.IsNull(self.content_UILabel) == false then
        self.content_UILabel.text = string.gsub(self.guidBubbleInfo.content, '\\n', '\n')
    end
    if CS.StaticUtility.IsNull(self.bg_UISprite) == false then
        self.bg_UISprite.spriteName = self.backGroundSpriteName
        self.bg_UISprite.flip = self.filp
    end
end

---设置提示位置
function HintClickTipTemplate:SetTipPosition()
    if CS.StaticUtility.IsNull(self.followPoint) == false then
        self.followPoint.startIntervalPosition = CS.Cfg_Guide_BubbleTableManager.Instance:GetStartInterval(self.guidBubbleInfo.id)
        self.followPoint.tweenIntervalPosition = CS.Cfg_Guide_BubbleTableManager.Instance:GetEndInterval(self.guidBubbleInfo.id)
        self.followPoint:SetParams(self.point.transform)
    else
        self.followPoint:SetParams(nil)
        self:SetPopState(false)
    end
end

function HintClickTipTemplate:TweenAlpha()
    if CS.StaticUtility.IsNull(self.go_TweenAlpha) == false then
        self.go_TweenAlpha:PlayTween()
    end
end

---自适应背景图大小
function HintClickTipTemplate:AdaptiveBgSize()

end

---检测当前开启的面板中是否有需要屏蔽的面板
function HintClickTipTemplate:CheckHidePanelNameList()
    local hidePanelNameList = CS.Cfg_Guide_BubbleTableManager.Instance:GetHidePanelNameList(self.guidBubbleInfo.id)
    if hidePanelNameList ~= nil and hidePanelNameList.Count > 0 then
        local length = hidePanelNameList.Count - 1
        for k = 0,length do
            local panelName = hidePanelNameList[k]
            if uimanager:GetPanel(panelName) ~= nil then
                self:SetPopState(false)
                return
            end
        end
    end
    self:SetPopState(true)
end
--endregion

---添加点击次数
function HintClickTipTemplate:addClickNum()
    if self.guidBubbleInfo.times > 0 and self:GetPopState() == true then
        local saveClickKey = CS.Cfg_Guide_BubbleTableManager.Instance:GetClickNumType(self.guidBubbleInfo.id)
        if Utility.EnumToInt(saveClickKey) > 0 then
            local nowClickNum = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(saveClickKey)
            CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(saveClickKey,nowClickNum + 1)
        end
    end
end

---移除tip
function HintClickTipTemplate:RemoveTip()
    if self.objectPoolTemplate ~= nil then
        self.objectPoolTemplate:PushInCache(self.go)
    end
end

---刷新气泡状态
function HintClickTipTemplate:RefreshPopState(panelName)
    if self:SpecialPopControl() == true then
        return
    end
    if self.point.activeSelf == false then
        self:SetPopState(false)
        return
    end
    self:CheckHidePanelNameList()
end

---刷新气泡宽度
function HintClickTipTemplate:RefreshWidth()
    if CS.StaticUtility.IsNull(self.content_UILabel) == false and CS.StaticUtility.IsNull(self.bg_UISprite) == false then
        self.content_UILabel:SetDimensions(self.labelBaseWidth + self.popHintOffsetWidthAndHigh.x,self.labelBaseHigh + self.popHintOffsetWidthAndHigh.y)
        self.bg_UISprite:SetDimensions(self.backGroundBaseWidth + self.popHintOffsetWidthAndHigh.x,self.backGroundBaseHigh + self.popHintOffsetWidthAndHigh.y)
    end
end

---刷新气泡文本位置
function HintClickTipTemplate:RefreshLabelPosition()
    if self.prefixOffset ~= nil and self.prefixOffset ~= CS.UnityEngine.Vector2.zero and CS.StaticUtility.IsNull(self.content_UIAnchor) == false then
        self.content_UIAnchor.pixelOffset = self.prefixOffset
        self.content_UIAnchor.enabled = true
    end
end

---刷新气泡深度
function HintClickTipTemplate:RefreshDepth()
    if CS.StaticUtility.IsNull(self.go_UIPanel) == false and self.depth ~= nil then
        self.go_UIPanel.depth = self.depth
    end
end

---刷新碰撞体状态
function HintClickTipTemplate:RefreshBoxColliderState()
    if CS.StaticUtility.IsNull(self.content_BoxCollider) == false then
        self.content_BoxCollider.enabled = self.clickCallBack ~= nil and self.isCanClick
    end
end

---刷新高亮框
function HintClickTipTemplate:RefreshLight()
    if self.LuaGuidBubbleInfo == nil or CS.StaticUtility.IsNull(self.light_UISprite) then
        return
    end
    local showLight = CS.StaticUtility.IsNullOrEmpty(self.LuaGuidBubbleInfo:GetFrameLight()) == false
    if showLight == false then
        luaclass.UIRefresh:RefreshActive(self.light_UISprite,false)
        return
    end
    luaclass.UIRefresh:RefreshActive(self.light_UISprite,true)
    luaclass.UIRefresh:RefreshSprite(self.light_UISprite,self.LuaGuidBubbleInfo:GetFrameLight())
    local LightPosition = {x = 0,y = 0}
    if self.LuaGuidBubbleInfo:GetFrameLightPosition() ~= nil and self.LuaGuidBubbleInfo:GetFrameLightPosition().list ~= nil and Utility.GetLuaTableCount(self.LuaGuidBubbleInfo:GetFrameLightPosition().list ) > 1 then
        LightPosition.x = self.LuaGuidBubbleInfo:GetFrameLightPosition().list[1]
        LightPosition.y = self.LuaGuidBubbleInfo:GetFrameLightPosition().list[2]
    end
    self.light_UISprite.transform.localPosition = CS.UnityEngine.Vector3(LightPosition.x,LightPosition.y,0)
    local lightSize = {x = self.LightBaseWidth,y = self.LightBaseHigh}
    if self.LuaGuidBubbleInfo:GetFrameLightSize() ~= nil and self.LuaGuidBubbleInfo:GetFrameLightSize().list ~= nil and Utility.GetLuaTableCount(self.LuaGuidBubbleInfo:GetFrameLightSize().list) > 1 then
        lightSize.x = self.LuaGuidBubbleInfo:GetFrameLightSize().list[1]
        lightSize.y = self.LuaGuidBubbleInfo:GetFrameLightSize().list[2]
    end
    luaclass.UIRefresh:RefreshSize(self.light_UISprite,lightSize)
end

function HintClickTipTemplate:SpecialPopControl()
    if self.guidBubbleInfo.id == 2 then
        local dialogPanel = uimanager:GetPanel("UIDialogTipsContainerPanel")
        if dialogPanel ~= nil and dialogPanel.recycleHintIsOpen == true then
            self:SetPopState(false)
            return true
        end
        return false
    end
end

function HintClickTipTemplate:SetPopState(state)
    self.go:SetActive(state)
    self.showPop = state
end

function HintClickTipTemplate:GetPopState()
    return self.showPop
end

--region 自动隐藏
---添加事件到关闭气泡
function HintClickTipTemplate:AddTimeEndToHide()
    if self.guidBubbleInfo ~= nil and self.guidBubbleInfo.lastTime ~= nil and self.guidBubbleInfo.lastTime > 0 then
        self:RemoveTimeEndToHide()
        if self.delayToRemovePop == nil then
            self.delayToRemovePop = CS.CSListUpdateMgr.Add(self.guidBubbleInfo.lastTime * 1000, nil, function()
                self.hintClickTipsManager:RemoveTips(self)
                self:addClickNum()
                if self.timeEndCallBack ~= nil then
                    self.timeEndCallBack()
                end
            end, false)
        end
    end
end

function HintClickTipTemplate:RemoveTimeEndToHide()
    if self.delayToRemovePop ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayToRemovePop)
        self.delayToRemovePop:Reset()
        self.delayToRemovePop = nil
    end
end
--endregion

return HintClickTipTemplate