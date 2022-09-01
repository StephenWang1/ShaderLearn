---物品信息界面的UIItem
---@class UIItem_UIItemInfoPanel:UIItem
local UIItem_UIItemInfoPanel = {}

setmetatable(UIItem_UIItemInfoPanel, luaComponentTemplates.UIItem)

--region 信息显示组件
---品质特效图片
function UIItem_UIItemInfoPanel:GetQualityEffect_UISprite()
    if self.mQualityEffect_UISprite == nil then
        self.mQualityEffect_UISprite = self:Get("qualityeffect", "UISprite")
    end
    return self.mQualityEffect_UISprite
end
--endregion

function UIItem_UIItemInfoPanel:GetSoulEquipQuality_UISprite()
    if(self.mSoulEquipQuality_UISprite == nil) then
        self.mSoulEquipQuality_UISprite = self:Get("soulEquipQuality","UISprite");
    end
    return self.mSoulEquipQuality_UISprite;
end


---@return CSUIEffectLoad
function UIItem_UIItemInfoPanel:GetSoulEquipEffect_CSUIEffectLoad()
    if(self.mSoulEquipEffect_CSUIEffectLoad == nil) then
        self.mSoulEquipEffect_CSUIEffectLoad = self:Get("soulEffect","CSUIEffectLoad");
    end
    return self.mSoulEquipEffect_CSUIEffectLoad
end

function UIItem_UIItemInfoPanel:Init()
    self:RunBaseFunction("Init")
end

function UIItem_UIItemInfoPanel:SetIsMainPlayer(isMainPlayer)
    self.mIsMainPlayer = isMainPlayer;
end

---使用背包物品信息刷新UI
---@param bagItemInfo bagV2.BagItemInfo
function UIItem_UIItemInfoPanel:RefreshUIWithBagItemInfo(bagItemInfo)
    local isFind = false
    local itemInfo
    isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
    if isFind then
        self.bagItemInfo = bagItemInfo
        self.ItemInfo = itemInfo
        self:RefreshUIWithItemInfo(itemInfo, 1, 1, bagItemInfo)
        self:UpdateInlayEquip(bagItemInfo, itemInfo)
        self:RefreshGemIcon(bagItemInfo)
        self:RefreshItemIcon(bagItemInfo)
        --if CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid) then
        --
        --end
    end
end

--region （镶嵌装备） 魂装，神器，法装
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIItem_UIItemInfoPanel:UpdateInlayEquip(bagItemInfo, itemInfo)
    if(bagItemInfo ~= nil and bagItemInfo.index > 0) then
        ---@type LuaSoulEquipMgr
        local luaSoulEquipClass = nil
        if(self.mIsMainPlayer) then
            luaSoulEquipClass = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr()
        else
            luaSoulEquipClass = gameMgr:GetOtherPlayerDataMgr():GetLuaSoulEquipData()
        end
        local itemName = luaSoulEquipClass:GetInlayItemName(itemInfo.id,bagItemInfo.index)
        self:RefreshName(itemName)
        local baseMapSpriteName,effectName,inlayEffectTbl = luaSoulEquipClass:GetEquipIndexEffectNameAndBaseMap(bagItemInfo.index)
        local effectTblParamsType,AnyParams
        if inlayEffectTbl ~= nil then
            effectTblParamsType,AnyParams = clientTableManager.cfg_inlay_effectManager:GetInlayEffectParticleParams(inlayEffectTbl:GetId())
        end
        luaclass.UIRefresh:RefreshActive(self:GetSoulEquipQuality_UISprite(),CS.StaticUtility.IsNullOrEmpty(baseMapSpriteName) == false)
        luaclass.UIRefresh:RefreshSprite(self:GetSoulEquipQuality_UISprite(),baseMapSpriteName)
        luaclass.UIRefresh:RefreshActive(self:GetSoulEquipEffect_CSUIEffectLoad(),CS.StaticUtility.IsNullOrEmpty(effectName) == false)
        luaclass.UIRefresh:RefreshEffect(self:GetSoulEquipEffect_CSUIEffectLoad(),effectName,function(effectObj)
            if CS.StaticUtility.IsNull(effectObj) == false and effectTblParamsType == LuaEnumInlayEffectTblParamsType.EffectColor and AnyParams ~= nil then
                effectObj:SetActive(false)
                Utility.SetParticleColor(effectObj,AnyParams)
                ---隐藏特效颜色修改后的渐变的过程
                CS.CSListUpdateMgr.Add(100, nil, function()
                    effectObj:SetActive(true)
                end, false)
            end
        end)
    end
end
--endregion

return UIItem_UIItemInfoPanel