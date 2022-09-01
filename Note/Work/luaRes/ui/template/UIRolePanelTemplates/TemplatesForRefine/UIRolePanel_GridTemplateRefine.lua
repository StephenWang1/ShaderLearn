local UIRolePanel_GridTemplateRefine = {}
setmetatable(UIRolePanel_GridTemplateRefine, luaComponentTemplates.UIRolePanel_GridTemplateBase)

UIRolePanel_GridTemplateRefine.mIsChoose = false;

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateRefine:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateRefine:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

---重写刷新Icon显示
function UIRolePanel_GridTemplateRefine:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        if (self.itemInfo ~= nil) then
            self:GetIcon_UISprite().spriteName = self.itemInfo.icon
            local refinePanel = uimanager:GetPanel("UIRefinePanel");
            local canRefine = false;
            if (refinePanel ~= nil and refinePanel:GetMainChooseBagItemInfo() ~= nil) then
                local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(refinePanel:GetMainChooseBagItemInfo().lid);
                if (equipInfo ~= nil) then
                    if (self.bagItemInfo == nil or self.bagItemInfo.lid ~= refinePanel:GetMainChooseBagItemInfo().lid) then
                        canRefine = false;
                    else
                        local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(refinePanel:GetMainChooseBagItemInfo().itemId);
                        if (self.itemInfo.id == refinePanel:GetMainChooseBagItemInfo().itemId) then
                            canRefine = true;
                        elseif (self.itemInfo.id == replaceItemId) then
                            canRefine = true;
                        else
                            canRefine = false;
                        end
                    end
                else
                    canRefine = self.itemInfo.id == refinePanel:GetMainChooseBagItemInfo().itemId;
                end
            else
                canRefine = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(self.itemInfo.id)
            end
            self:GetIcon_UISprite().color = canRefine and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
        end
        self:GetIcon_UISprite().gameObject:SetActive(true)
    end
end

---重写隐藏其他界面调用Icon
function UIRolePanel_GridTemplateRefine:SetOtherIcon()
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
function UIRolePanel_GridTemplateRefine:ChooseItem(isShow)
    self.mIsChoose = isShow;
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isShow)
    end
end

return UIRolePanel_GridTemplateRefine