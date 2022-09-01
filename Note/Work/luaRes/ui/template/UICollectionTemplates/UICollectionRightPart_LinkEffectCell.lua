---藏品界面右侧的连锁属性单元
---@class UICollectionRightPart_LinkEffectCell:TemplateBase
local UICollectionRightPart_LinkEffectCell = {}

---获取icon
---@return UISprite
function UICollectionRightPart_LinkEffectCell:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("icon", "UISprite")
    end
    return self.mIconSprite
end

---选中图片
---@return UISprite
function UICollectionRightPart_LinkEffectCell:GetChooseSprite()
    if self.mChooseSprite == nil then
        self.mChooseSprite = self:Get("choose", "UISprite")
    end
    return self.mChooseSprite
end

---@param rightPart UICollectionRightPart
---@param clickCallBack fun(linkEffectTbl:TABLE.cfg_linkeffect,go:UnityEngine.GameObject)
function UICollectionRightPart_LinkEffectCell:Init(rightPart, clickCallBack)
    self.mOwner = rightPart
    self.mClickCallBack = clickCallBack
    CS.UIEventListener.Get(self.go).onClick = function(go)
        self:OnCellClicked(go)
    end
end

function UICollectionRightPart_LinkEffectCell:Refresh(linkEffectTbl)
    self.linkEffectTbl = linkEffectTbl
    if self.linkEffectTbl then
        self:GetIconSprite().spriteName = self.linkEffectTbl:GetIcon()
    else
        self:GetIconSprite().spriteName = ""
    end
end

function UICollectionRightPart_LinkEffectCell:OnCellClicked(go)
    if self.mClickCallBack ~= nil and self.linkEffectTbl ~= nil then
        self.mClickCallBack(self, self.linkEffectTbl, go)
    end
end

---设置被选中状态
---@param isChosen boolean
function UICollectionRightPart_LinkEffectCell:SetChosenState(isChosen)
    self:GetChooseSprite().gameObject:SetActive(isChosen == true)
end

return UICollectionRightPart_LinkEffectCell