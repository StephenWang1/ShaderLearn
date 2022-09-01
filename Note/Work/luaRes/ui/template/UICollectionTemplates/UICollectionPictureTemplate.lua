---藏品图片模板
---@class UICollectionPictureTemplate:TemplateBase
local UICollectionPictureTemplate = {}

---Icon图片
---@return UISprite
function UICollectionPictureTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("icon", "UISprite")
    end
    return self.mIconSprite
end

---缩放动画组件
---@return TweenScale
function UICollectionPictureTemplate:GetScaleTweener()
    if self.mTweenScaler == nil then
        self.mTweenScaler = self:Get("icon", "TweenScale")
    end
    return self.mTweenScaler
end

---背景图片
---@return UISprite
function UICollectionPictureTemplate:GetBgSprite()
    if self.mBgSprite == nil then
        self.mBgSprite = self:Get("bg", "UISprite")
    end
    return self.mBgSprite
end

---@return UICollectionPagePictureDrawer
function UICollectionPictureTemplate:GetOwner()
    return self.mOwnerPage
end

---@param ownerPage UICollectionPagePictureDrawer
function UICollectionPictureTemplate:Init(ownerPage)
    self.mOwnerPage = ownerPage
end

---刷新UI
---@param atlasName string
---@param spriteName string
---@param isBeingDragged boolean
function UICollectionPictureTemplate:RefreshUI(atlasName, spriteName, isBeingDragged)
    if self.mAtlasName == atlasName and self.mSpriteName == spriteName then
        return
    end
    if self.mAtlasName ~= atlasName then
        if self:GetOwner() == nil
                or self:GetOwner():GetOwnerPage() == nil
                or self:GetOwner():GetOwnerPage():GetOwner() == nil
                or self:GetOwner():GetOwnerPage():GetOwner():GetOwnerPanel() == nil then
            self:GetIconSprite().atlas = nil
            return
        end
        local atlas = self:GetOwner():GetOwnerPage():GetOwner():GetOwnerPanel():GetUIAtlas(atlasName)
        if atlas == nil then
            return
        end
        self:GetIconSprite().atlas = atlas
        self.mAtlasName = atlasName
    end
    self:GetIconSprite().gameObject:SetActive(isBeingDragged == false)
    if self.mSpriteName ~= spriteName then
        self:GetIconSprite().spriteName = spriteName
    end
    self:GetIconSprite():MakePixelPerfect()
    self:GetBgSprite().height = self:GetIconSprite().height
    self:GetBgSprite().width = self:GetIconSprite().width
    if self:GetScaleTweener() ~= nil and CS.StaticUtility.IsNull(self:GetScaleTweener()) == false then
        self:GetScaleTweener().value = self:GetScaleTweener().from
        self:GetScaleTweener().enabled = false
    end
end

---设置缩放
---@param enlarge boolean 是否放大
function UICollectionPictureTemplate:SetScaleTween(enlarge)
    if self:GetScaleTweener() == nil or CS.StaticUtility.IsNull(self:GetScaleTweener()) then
        return
    end
    if self:GetScaleTweener().gameObject.activeInHierarchy then
        if enlarge then
            self:GetScaleTweener():PlayForward()
        else
            self:GetScaleTweener():PlayReverse()
        end
    else
        self:GetScaleTweener().enabled = false
        if enlarge then
            self:GetScaleTweener().value = self:GetScaleTweener().to
        else
            self:GetScaleTweener().value = self:GetScaleTweener().from
        end
    end
end

return UICollectionPictureTemplate