local UIRolePanel_GridTemplateOtherPlayer = {}
setmetatable(UIRolePanel_GridTemplateOtherPlayer, luaComponentTemplates.UIRolePanel_GridTemplateBase)

--region 重写
---重写加号显示
function UIRolePanel_GridTemplateOtherPlayer:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---重写耐久度显示
function UIRolePanel_GridTemplateOtherPlayer:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
end
--endregion

function UIRolePanel_GridTemplateOtherPlayer:UpdateSoulEquipSign()
    local baseMapSpriteName,effectName,inlayEffectTbl = gameMgr:GetOtherPlayerDataMgr():GetLuaSoulEquipData():GetEquipIndexEffectNameAndBaseMap(self.equipIndex)
    local effectTblParamsType,AnyParams
    if inlayEffectTbl ~= nil then
        effectTblParamsType,AnyParams = clientTableManager.cfg_inlay_effectManager:GetInlayEffectParticleParams(inlayEffectTbl:GetId())
    end
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquip_GameObject(),true)
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquipQuality_UISprite(),CS.StaticUtility.IsNullOrEmpty(baseMapSpriteName) == false)
    luaclass.UIRefresh:RefreshSprite(self:GetSoulEquipQuality_UISprite(),baseMapSpriteName)
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquipEffect_CSUIEffectLoad(),CS.StaticUtility.IsNullOrEmpty(effectName) == false)
    if self.soulEquipEffect == nil then
        luaclass.UIRefresh:RefreshEffect(self:GetSoulEquipEffect_CSUIEffectLoad(),effectName,function(effectObj)
            if CS.StaticUtility.IsNull(effectObj) == false and effectTblParamsType == LuaEnumInlayEffectTblParamsType.EffectColor and AnyParams ~= nil then
                self.soulEquipEffect = effectObj
                effectObj:SetActive(false)
                Utility.SetParticleColor(effectObj,AnyParams)
                CS.CSListUpdateMgr.Add(100, nil, function()
                    effectObj:SetActive(true)
                end, false)
            end
        end)
    end

    --local gobj = self:GetSoulEquip_GameObject();
    ----local soulEquipIcon = self:GetSoulEquipIcon_UISprite();
    --
    --if gobj and CS.StaticUtility.IsNull(gobj) == false then
    --    local soulEquip = gameMgr:GetOtherPlayerDataMgr():GetLuaSoulEquipData():GetSoulEquipToEquipIndex(self.equipIndex);
    --    gobj:SetActive(soulEquip ~= nil);
    --    if(soulEquip ~= nil) then
    --        ---@type TABLE.cfg_items
    --        local tbl = clientTableManager.cfg_itemsManager:TryGetValue(soulEquip.itemId);
    --        if(tbl ~= nil) then
    --            --soulEquipIcon.spriteName = tbl:GetIcon();
    --            self:GetSoulEquipQuality_UISprite().spriteName = "SoulEquip_"..tbl:GetGroup()
    --        end
    --    end
    --end
end

return UIRolePanel_GridTemplateOtherPlayer