local UISmallHpWarning = {}
--region parameters
UISmallHpWarning.PanelLayerType = CS.UILayerType.TipsPlane

UISmallHpWarning.hpWarningEffect = nil
UISmallHpWarning.hpWarningEffectDefaultHigh = 740
UISmallHpWarning.hpWarningEffectDefaultWidth = 1330
--endregion

--region components
function UISmallHpWarning:Getsprite()
    if (self.sprite == nil) then
        self.sprite = self:GetCurComp("WidgetRoot/Sprite", "Transform")
    end
    return UISmallHpWarning.sprite
end

function UISmallHpWarning:Show()
    self:RunBaseFunction("Show")
    self:LoadeEffect()
end

function UISmallHpWarning:LoadeEffect()
    self:Getsprite().gameObject:SetActive(true)
    self:SetEffectScale()
end

function UISmallHpWarning:SetEffectScale()
    local effectScale_x = CS.CSGame.Sington.ContentSize.x / self.hpWarningEffectDefaultWidth
    local effectScale_y = CS.CSGame.Sington.ContentSize.y / self.hpWarningEffectDefaultHigh
    if self:Getsprite() ~= nil then
        self:Getsprite().transform.localScale = CS.UnityEngine.Vector3(effectScale_x,effectScale_y,0)
    end
end
--endregion

--region function
function start()
    --if (UISmallHpWarning:Getsprite() ~= nil) then
    --    if (UISmallHpWarning:Getsprite() ~= nil) then
    --        UISmallHpWarning:Getsprite():GetComponent("UISprite").width = CS.CSGame.Sington.ContentSize.x
    --        UISmallHpWarning:Getsprite():GetComponent("UISprite").height = CS.CSGame.Sington.ContentSize.y
    --    end
    --end
end
--endregion
return UISmallHpWarning