---称号模板
local UITitleTemplate = {}

function UITitleTemplate:Init()
    self:InitComponents()
    self:BindMessage()
    self:InitParameters()
end

---初始化组件
function UITitleTemplate:InitComponents()
    --图片
    self.mIcon_UISprite = self:Get("TitleIcon", "UISprite")
    --动画
    self.mAnim_UISpriteAnimation = self:Get("TitleIcon", "UISpriteAnimation")
    --称号面板
    self.mTitlePanel = uimanager:GetPanel("UITitlePanel")
    --Toggle
    self.mToggle = CS.Utility_Lua.GetComponent(self.go, "UIToggle")
    --测试名字
    self.mTestName = self:Get("TestName", "UILabel")
end
---初始化参数
function UITitleTemplate:InitParameters()
    --ID
    self.mId = 0
    --Resources
    self.mModel = ""
end
---绑定消息
function UITitleTemplate:BindMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClick
end
---显示
function UITitleTemplate:Show(id, defaultToggle)
    self.mId = id
    local isFind, itemInfo = CS.Cfg_TitleTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        --self.mIcon_UISprite.spriteName = itemInfo.icon
        self.mModel = itemInfo.model
        self.mTestName.text = itemInfo.titleName
        local entity = self
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(self.mModel, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                local atlas = CS.Utility_Lua.GetComponent(res.MirrorObj, "UIAtlas")
                if atlas then
                    atlas.ResPath = res.Path
                    entity.mIcon_UISprite.atlas = atlas
                    entity.mAnim_UISpriteAnimation:RebuildSpriteList()
                    entity.mAnim_UISpriteAnimation:Play()
                end
            end
        end
        , CS.ResourceAssistType.UI)

    end
    if defaultToggle then
        self:OnClick()
    end
end
---点击
function UITitleTemplate:OnClick()
    if self.mId ~= 0 then
        self.mTitlePanel.RefreshAttribute(self.mId)
        self.mToggle.value = true
    end
end

return UITitleTemplate
