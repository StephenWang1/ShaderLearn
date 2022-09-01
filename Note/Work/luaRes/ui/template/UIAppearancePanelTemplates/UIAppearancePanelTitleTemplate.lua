---@class UIAppearancePanelTitleTemplate:TemplateBase
local UIAppearancePanelTitleTemplate = {}
--local poolItem
---获取称号名图片
---@return UISprite
function UIAppearancePanelTitleTemplate:GetTitleNameSprite()
    if self.mTitleNameSprite == nil then
        self.mTitleNameSprite = self:Get("TitleName", "UISprite")
    end
    return self.mTitleNameSprite
end

---获取称号动画组件
---@return UISpriteAnimation
function UIAppearancePanelTitleTemplate:GetTitleNameSpriteAnimation()
    if self.mTitleNameSpriteAnimation == nil then
        self.mTitleNameSpriteAnimation = self:Get("TitleName", "UISpriteAnimation")
    end
    return self.mTitleNameSpriteAnimation
end

---被选中标识
---@return UnityEngine.GameObject
function UIAppearancePanelTitleTemplate:GetSelectedSign()
    if self.mSelectedSign == nil then
        self.mSelectedSign = self:Get("selectSign", "GameObject")
    end
    return self.mSelectedSign
end

---启用标识
---@return UnityEngine.GameObject
function UIAppearancePanelTitleTemplate:GetEnabledSign()
    if self.mEnabledSign == nil then
        self.mEnabledSign = self:Get("UsingSign/choose", "GameObject")
    end
    return self.mEnabledSign
end

---使用称号刷新
---@param titleInfo titleV2.TitleInfo
function UIAppearancePanelTitleTemplate:Refresh(titleInfo, isSelected)
    self.mTitleInfo = titleInfo
    if titleInfo == nil then
        self:GetTitleNameSprite().gameObject:SetActive(false)
        self:GetEnabledSign().gameObject:SetActive(false)
    else
        self:GetTitleNameSprite().gameObject:SetActive(true)
        self:GetEnabledSign().gameObject:SetActive(CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleId == titleInfo.titleId)
        self:LoadEffect(titleInfo)
    end
    self:GetSelectedSign():SetActive(isSelected)
end

function UIAppearancePanelTitleTemplate:Destroy()
    --if CS.CSObjectPoolMgr.Instance ~= nil then
    --    CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(poolItem)
    --end
    --poolItem = nil
end

---加载特效
---@param titleInfo titleV2.TitleInfo
function UIAppearancePanelTitleTemplate:LoadEffect(titleInfo)
    if titleInfo == nil then
        return
    end
    ---@type TABLE.CFG_TITLE
    local titleTbl
    ___, titleTbl = CS.Cfg_TitleTableManager.Instance:TryGetValue(titleInfo.titleId)
    if titleTbl == nil then
        return
    end
    self:GetTitleNameSprite().atlas = nil
    if self.mLoadResourceCallBack == nil then
        self.mLoadResourceCallBack = function(csresource)
            self:OnResourceLoaded(csresource)
        end
    end
    CS.CSResourceManager.Instance:AddQueueCannotDelete(titleTbl.model, CS.ResourceType.Effect, self.mLoadResourceCallBack, CS.ResourceAssistType.UI, false, 0, titleInfo)
end

---资源加载完毕事件
---@param csresource CSResource
function UIAppearancePanelTitleTemplate:OnResourceLoaded(csresource)
    if CS.StaticUtility.IsNull(self.go) or csresource == nil or CS.StaticUtility.IsNull(csresource.MirrorObj) or self.mTitleInfo ~= csresource.Param then
        return
    end
    csresource.Param = nil
    local go = csresource.MirrorObj
    ---@type UIAtlas
    local atlas = self:GetCurComp(go, "", "UIAtlas")
    if atlas ~= nil then
        local spriteCount = atlas.spriteList.Count
        atlas.ResPath = csresource.Path
        --if CS.CSObjectPoolMgr.Instance ~= nil then
        --    CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(poolItem)
        --end
        --poolItem = nil
        --poolItem = csresource:GetUIPoolItem(CS.EPoolType.Resource)
        self:GetTitleNameSprite().atlas = atlas
        if spriteCount > 0 then
            if spriteCount == 1 then
                ---单张精灵
                self:GetTitleNameSpriteAnimation().enabled = false
                self:GetTitleNameSprite().spriteName = atlas.spriteList[0].name
                self:GetTitleNameSprite():MakePixelPerfect()
            else
                ---帧动画
                self:GetTitleNameSpriteAnimation().enabled = true
                self:GetTitleNameSpriteAnimation():RebuildSpriteList()
                self:GetTitleNameSpriteAnimation():Play()
            end
        end
        self:GetTitleNameSprite():CreatePanel()
    end
end

return UIAppearancePanelTitleTemplate