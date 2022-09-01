---@class UITipsTemplate 提示模板
local UITipsTemplate = {  }

--region 初始化
function UITipsTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

--通过工具生成 控件变量
function UITipsTemplate:InitComponents()
    self.mPositionTween_TweenPosition = CS.Utility_Lua.GetComponent(self.go, "TweenPosition")
    self.mAlphaTween_TweenAlpha = CS.Utility_Lua.GetComponent(self.go, "TweenAlpha")
    self.mTips_UIPanel = CS.Utility_Lua.GetComponent(self.go, "UIPanel")
    self.mTips_UILabel = self:Get("GameObject/TipsLb", "UILabel")
    self.mTips_Icon = self:Get("GameObject/GameObject/icon", "UISprite")
    self.backGround_UISprite = self:Get("GameObject/Sprite", "UISprite")
    self.icon_Widget = self:Get("GameObject/GameObject", "UIWidget")
end
--初始化 变量 按钮点击 服务器消息事件等
function UITipsTemplate:InitOther()
    self.mPanel = nil
    self.Coroutine = nil
    self.backGroundWidth = 0
end
--endregion

--region 刷新
function UITipsTemplate:Show(panel, commonData)
    if self:AnalysisParams(panel, commonData) == false then
        return
    end
    self:Reset()
    self.backGroundWidth = 0
    self:RefreshTips()
    self:ChangeBackGroundSizeByLabel()
    self.Coroutine = StartCoroutine(UITipsTemplate.StartCoroutine, self)
end

---解析参数
function UITipsTemplate:AnalysisParams(panel, commonData)
    if commonData == nil or commonData.firstStr == nil then
        if panel ~= nil then
            panel:RemoveTips(self)
        end
        return false
    end
    self.mPanel = panel
    self.commonData = commonData
    return true
end

function UITipsTemplate:RefreshTips()
    self:RefreshLabel()
    self:RefreshIcon()
end

---延迟刷新widget（uiwidget会延迟一帧刷新）
function UITipsTemplate:ShowTips(panel)
    if panel.mTips_Icon ~= nil and panel.iconName ~= nil then
        panel:RefreshWidget()
        panel.mTips_Icon.gameObject:SetActive(true)
    elseif panel.mTips_Icon ~= nil then
        panel.mTips_Icon.gameObject:SetActive(false)
    end
end

function UITipsTemplate:Play(from, to)
    if (self.mPositionTween_TweenPosition ~= nil) then
        self.mPositionTween_TweenPosition.from = from
        self.mPositionTween_TweenPosition.to = to
        self.mPositionTween_TweenPosition:ResetToBeginning()
        self.mPositionTween_TweenPosition:PlayForward()
    end
end
---开始协程
function UITipsTemplate.StartCoroutine(entity)
    coroutine.yield(nil)
    --entity:ShowTips(entity)
    entity.mTips_UIPanel.alpha = 1
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1.2))
    entity.mAlphaTween_TweenAlpha.from = 1
    entity.mAlphaTween_TweenAlpha.to = 0
    entity.mAlphaTween_TweenAlpha:ResetToBeginning()
    entity.mAlphaTween_TweenAlpha:PlayForward()
    local time = entity.mAlphaTween_TweenAlpha.duration
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(time))
    entity.mPanel:RemoveTips(entity)
end
--endregion

--region 对应数据刷新
---刷新文本
function UITipsTemplate:RefreshLabel()
    if self.mTips_UILabel ~= nil then
        if CS.StaticUtility.IsNullOrEmpty(self.commonData.firstStr) == false then
            self.mTips_UILabel.text = self.commonData.firstStr
            self.backGroundWidth = self.backGroundWidth + self.mTips_UILabel.localSize.x
        end
        self.mTips_UILabel.gameObject:SetActive(CS.StaticUtility.IsNullOrEmpty(self.commonData.firstStr) == false)
    end
end

---刷新icon
function UITipsTemplate:RefreshIcon()
    if self.mTips_Icon ~= nil then
        if CS.StaticUtility.IsNullOrEmpty(self.commonData.firstIconName) == false then
            self.mTips_Icon.spriteName = self.commonData.firstIconName
            self.backGroundWidth = self.backGroundWidth + self.mTips_Icon.localSize.x
        end
        self.mTips_Icon.gameObject:SetActive(CS.StaticUtility.IsNullOrEmpty(self.commonData.firstIconName) == false)
    end
end
--endregion

--region 重写
function UITipsTemplate:OnDisable()
    self:Reset()
end

function UITipsTemplate:OnDestroy()
    self:Reset()
end

function UITipsTemplate:Reset()
    if self.Coroutine ~= nil then
        self.mAlphaTween_TweenAlpha.enabled = false
        StopCoroutine(self.Coroutine)
    end
end
--endregion

--region 自适应
---背景图自适应
function UITipsTemplate:ChangeBackGroundSizeByLabel()
    if self.mTips_UILabel ~= nil and self.backGround_UISprite ~= nil then
        self.backGround_UISprite:SetDimensions(self.mTips_UILabel.localSize.x + 10, self.backGround_UISprite.localSize.y)
    end
end

---位置自适应
function UITipsTemplate:RefreshWidget()
    if self.mTips_UILabel ~= nil and self.icon_Widget ~= nil and not CS.StaticUtility.IsNullOrEmpty(self.mTips_UILabel.text) then
        self.icon_Widget:UpdateAnchors()
    end
end
--endregion



return UITipsTemplate