local UIRolePanel_GridTemplateFurnace = {}
setmetatable(UIRolePanel_GridTemplateFurnace, luaComponentTemplates.UIRolePanel_GridTemplateBase)

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateFurnace:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateFurnace:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateFurnace:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if(self.itemInfo ~= nil) then
            self:GetIcon_UISprite().spriteName = self.itemInfo.icon
        end
        self:GetIcon_UISprite().gameObject:SetActive(true)
    end
end

---重写隐藏其他界面调用Icon
function UIRolePanel_GridTemplateFurnace:SetOtherIcon()
    --元素
    if self:GetElementAdd_UISprite().gameObject and CS.StaticUtility.IsNull(self:GetElementAdd_UISprite().gameObject) == false then
        self:GetElementAdd_UISprite().gameObject:SetActive(false)
    end
    --特效
    if self:GetEffect_GameObject() and CS.StaticUtility.IsNull(self:GetEffect_GameObject()) then
        self:GetEffect_GameObject():SetActive(false)
    end
    --印记
    if self:GetYinJi_GameObject() and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self:GetYinJi_GameObject():SetActive(false)
    end
    if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite().gameObject) == false then
        self:GetOverlayIcon2_UISprite().spriteName = ""
    end
    --维修
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(false)
    end
end

---重写选中特效
function UIRolePanel_GridTemplateFurnace:ChooseItem(isShow)
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isShow)
        self:GetIcon_UISprite().color = self:GetChoose_GameObject().activeSelf and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;

        if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite()) == false then
            self:GetOverlayIcon2_UISprite().color = self:GetChoose_GameObject().activeSelf and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        end
        if self:GetOverlayIcon1_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon1_UISprite()) == false then
            self:GetOverlayIcon1_UISprite().color = self:GetChoose_GameObject().activeSelf and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        end
    end
end

function UIRolePanel_GridTemplateFurnace:UpdateIconColor()
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetIcon_UISprite().color = self:GetChoose_GameObject().activeSelf and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite()) == false then
            self:GetOverlayIcon2_UISprite().color = self:GetChoose_GameObject().activeSelf and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        end
        if self:GetOverlayIcon1_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon1_UISprite()) == false then
            self:GetOverlayIcon1_UISprite().color = self:GetChoose_GameObject().activeSelf and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        end
    end
end

return UIRolePanel_GridTemplateFurnace