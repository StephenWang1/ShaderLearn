---@class UIRolePanel_GridTemplateMosaic:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateMosaic = {};
setmetatable(UIRolePanel_GridTemplateMosaic, luaComponentTemplates.UIRolePanel_GridTemplateBase);

UIRolePanel_GridTemplateMosaic.grayColor = CS.UnityEngine.Color(0, 0, 0, 128 / 255)

---重写刷新耐久度图片  (暂改为改变icon本身颜色  - by yh)
function UIRolePanel_GridTemplateMosaic:RefreshLastingFrame(state)
    if self:isMeetMosaic(self.equipIndex) then
        if self.mLastingFrame_UISprite then
            self.mLastingFrame_UISprite.spriteName = ""
        end
        if state == 0 then
            if self.limitingValue and self.bagItemInfo ~= nil then
                if self.bagItemInfo.currentLasting >= 0 and self.bagItemInfo.currentLasting <= self.limitingValue then
                    self:GetIcon_UISprite().color = CS.UnityEngine.Color(232 / 255, 80 / 255, 56 / 255, 1)
                else
                    self:GetIcon_UISprite().color = CS.UnityEngine.Color.white
                end
                -- self.mLastingFrame_UISprite.spriteName = ternary(self.bagItemInfo.currentLasting > 0 and self.bagItemInfo.currentLasting <= self.limitingValue, "red", "")
            else
                self:GetIcon_UISprite().color = CS.UnityEngine.Color.white
                --self.mLastingFrame_UISprite.spriteName = ""
            end
        else
            self:GetIcon_UISprite().color = CS.UnityEngine.Color.white
            -- self.mLastingFrame_UISprite.spriteName = ""
        end
    end
end

---重写刷新Icon显示
function UIRolePanel_GridTemplateMosaic:RefreshIconInfo()
    if self.equipIndex == nil then
        return
    end
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        self:GetIcon_UISprite().gameObject:SetActive(self.itemInfo ~= nil)
        self:GetIcon_UISprite().spriteName = self.itemInfo.icon
    end
    self:GetIcon_UISprite().color = self:isMeetMosaic(self.equipIndex) and CS.UnityEngine.Color.white or self.grayColor
end

---重写刷新加号状态
---@param state XLua.Cast.Int32 状态 0 显示道具 1 不显示道具
function UIRolePanel_GridTemplateMosaic:RefreshAddIcon(state)
    if not self:isMeetMosaic(self.equipIndex) then
        self:GetAdd_GameObject().gameObject:SetActive(false)
    else
        self:RunBaseFunction("RefreshAddIcon")
    end
end

function UIRolePanel_GridTemplateMosaic:isMeetMosaic(equipIndex)
    return equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL)
end

return UIRolePanel_GridTemplateMosaic