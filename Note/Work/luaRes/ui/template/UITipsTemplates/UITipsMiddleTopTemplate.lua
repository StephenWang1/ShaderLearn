local UITipsMiddleTopTemplate = {}
setmetatable(UITipsMiddleTopTemplate,luaComponentTemplates.UITipsTemplate)

--region 初始化
--通过工具生成 控件变量
function UITipsMiddleTopTemplate:InitComponents()
    self.mPositionTween_TweenPosition = CS.Utility_Lua.GetComponent(self.go,"TweenPosition")
    self.mAlphaTween_TweenAlpha = CS.Utility_Lua.GetComponent(self.go,"TweenAlpha")
    self.mTips_UIPanel = CS.Utility_Lua.GetComponent(self.go,"UIPanel")
    self.mTips_UILabel = self:Get("GameObject/GameObject/TipsLb", "UILabel")
    self.mTips_Icon = self:Get("GameObject/GameObject/icon", "UISprite")
    self.name_UILabel = self:Get("GameObject/GameObject/name", "UILabel")
    self.icon2_UISprite = self:Get("GameObject/GameObject/icon2", "UISprite")
    self.backGround_UISprite = self:Get("GameObject/Sprite", "UISprite")
    self.icon_Widget = self:Get("GameObject/GameObject","UIWidget")
    self.tips_UITable = self:Get("GameObject/GameObject","UITable")
    self.icon2_TweenScale = self:Get("GameObject/GameObject/icon2", "TweenScale")
end
--endregion

--region 刷新
function UITipsMiddleTopTemplate:AnalysisParams(panel,commonData)
    if commonData == nil or commonData.tipsType ~= LuaEnumTextTipsType.MiddleTopTips or commonData.firstStr == nil then
        if panel ~= nil then
            panel:RemoveTips(self)
        end
        return false
    end
    self.mPanel = panel
    self.commonData = commonData
    self.firstStr = commonData.firstStr
    self.secondStr = commonData.secondStr
    self.firstIconName = commonData.firstIconName
    self.secondIconName = commonData.secondIconName
    self.itemId = commonData.itemId
    self.canPlayTween = commonData.canPlayTween

    if self.secondStr ~= nil and self.itemId ~= nil and CS.Cfg_GlobalTableManager.Instance.SpecialItemColorDic:TryGetValue(self.itemId) then
        local color = CS.Cfg_GlobalTableManager.Instance.SpecialItemColorDic[self.itemId]
        self.secondStr = "[" .. color .. "]" .. self.secondStr
    end
    return true
end

function UITipsMiddleTopTemplate:RefreshTips()
    self:RefreshLabel()
    self:RefreshIcon()
    self:RefreshSecondLabel()
    self:RefreshSecondSprite()
    self:TryTween()
end

function UITipsMiddleTopTemplate:RefreshSecondLabel()
    if self.name_UILabel ~= nil then
        if CS.StaticUtility.IsNullOrEmpty(self.commonData.secondStr) == false then
            self.name_UILabel.text = self.commonData.secondStr
            self.backGroundWidth = self.backGroundWidth + self.name_UILabel.localSize.x
        end
        self.name_UILabel.gameObject:SetActive(CS.StaticUtility.IsNullOrEmpty(self.commonData.secondStr) == false)
    end
end

function UITipsMiddleTopTemplate:RefreshSecondSprite()
    if self.icon2_UISprite ~= nil then
        if CS.StaticUtility.IsNullOrEmpty(self.commonData.secondIconName) == false then
            self.icon2_UISprite.spriteName = self.commonData.secondIconName
            self.backGroundWidth = self.backGroundWidth + self.icon2_UISprite.localSize.x
            self.icon2_UISprite:MakePixelPerfect()
        end
        self.icon2_UISprite.gameObject:SetActive(CS.StaticUtility.IsNullOrEmpty(self.commonData.secondIconName) == false)
    end
end

function UITipsMiddleTopTemplate:TryTween()
    if self.icon2_TweenScale ~= nil then
        if self.canPlayTween == true and CS.StaticUtility.IsNullOrEmpty(self.secondIconName) == false then
            self.icon2_TweenScale:PlayTween()
        end
    end
end
--endregion

--region 自适应
---背景图自适应
function UITipsMiddleTopTemplate:ChangeBackGroundSizeByLabel()
    if self.tips_UITable ~= nil then
        self.tips_UITable.enabled = true
    end
    if self.mTips_UILabel ~= nil and self.backGround_UISprite ~= nil and self.mTips_Icon ~= nil and self.name_UILabel ~= nil and self.icon2_UISprite ~= nil then
        self.backGround_UISprite:SetDimensions(self.backGroundWidth + 10,self.backGround_UISprite.localSize.y)
    end
end
--endregion
return UITipsMiddleTopTemplate