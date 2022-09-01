---@class UIRankBattleDamageFeatureTemplate:UIRankFeatureBaseTemplate 战损榜
local UIRankBattleDamageFeatureTemplate = {}

setmetatable(UIRankBattleDamageFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankBattleDamageFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetQuiteDropGrid() ~= nil then
        if self.unitTbl.damageItemRankInfo and self.unitTbl.damageItemRankInfo.infos and self.unitTbl.damageItemRankInfo.infos.infos then
            self:SetDamageItemInfo(self.unitTbl.damageItemRankInfo.infos.infos)
        end
        self.unitTbl:GetQuiteDropGrid().gameObject:SetActive(self:IsShowDropItemList())
    end

--[[    if self.unitTbl:GetRankGuild() ~= nil then
        self.unitTbl:GetRankGuild().text = self.rankData.unionName
        self.unitTbl:GetRankGuild().gameObject:SetActive(self:IsShowUnionName())
    end]]

    if self.unitTbl:GetDetailsBtn() ~= nil then
        self.unitTbl:GetDetailsBtn().gameObject:SetActive(self:IsShowDetailBtn())
    end

end

function UIRankBattleDamageFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetQuiteDropGrid() ~= nil then
        local origionPos = self.unitTbl:GetQuiteDropGrid().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.quiteDrop)
        self.unitTbl:GetQuiteDropGrid().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

--[[    if self.unitTbl:GetRankGuild() ~= nil then
        local origionPos = self.unitTbl:GetRankGuild().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.guild)
        self.unitTbl:GetRankGuild().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end]]

    if self.unitTbl:GetDetailsBtn() ~= nil then
        local origionPos = self.unitTbl:GetDetailsBtn().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.details)
        self.unitTbl:GetDetailsBtn().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

function UIRankBattleDamageFeatureTemplate:BindEvent()
    if self.unitTbl:GetDetailsBtn() ~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetDetailsBtn().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetDetailsBtn().gameObject).OnClickLuaDelegate = self.unitTbl.OnDetailsBtnClick
    end
end

function UIRankBattleDamageFeatureTemplate:SetDamageItemInfo(list)
    local count = #list > 3 and 3 or #list
    self.unitTbl.quiteDropGrid.MaxCount = count
    for i = 1, count do
        local info = list[i]
        local go = CS.Utility_Lua.GetComponent(self.unitTbl.quiteDropGrid.controlList[i - 1], "GameObject")
        if go then
            local icon = CS.Utility_Lua.GetComponent(go.transform:Find("Item/icon"), "UISprite")
            local countLabel = CS.Utility_Lua.GetComponent(go.transform:Find("Item/count"), "UILabel")
            if countLabel ~= nil and not CS.StaticUtility.IsNull(countLabel) then
                countLabel.text = info.count ~= 1 and tostring(info.count) or ""
            end
            if icon ~= nil and not CS.StaticUtility.IsNull(icon) then
                local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.itemId)
                if isFind then
                    icon.spriteName = itemInfo.icon
                end
            end
            CS.UIEventListener.Get(go).onClick = nil
            CS.UIEventListener.Get(go).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = info, showRight = false })
            end
        end
    end
end

--region overrid

--是否需要显示物品列表
function UIRankBattleDamageFeatureTemplate:IsShowDropItemList()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.quiteDrop, self.unitTbl:GetQuiteDropGrid().gameObject)
    return true
end

--是否需要显示详情按钮
function UIRankBattleDamageFeatureTemplate:IsShowDetailBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.details, self.unitTbl:GetDetailsBtn().gameObject)
    return self.unitTbl ~= nil and self.unitTbl.damageItemRankInfo ~= nil and
            self.unitTbl.damageItemRankInfo.infos ~= nil and
            self.unitTbl.damageItemRankInfo.infos.infos ~= nil and
            #self.unitTbl.damageItemRankInfo.infos.infos > 3
end

--是否显示行会名14
--[[function UIRankBattleDamageFeatureTemplate:IsShowUnionName()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.guild, self.unitTbl:GetRankGuild().gameObject)
    return false
end]]

--是否需要显示宝箱按钮7
function UIRankBattleDamageFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return true
end

function UIRankBattleDamageFeatureTemplate:OnDetailsBtnClick()
    if self.unitTbl ~= nil then
        networkRequest.ReqRankDetail(self.unitTbl.rankConfigId, self.unitTbl.rid)
    end
end

function UIRankBattleDamageFeatureTemplate:onDestroy()
    self:RunBaseFunction("onDestroy")
end

--endregion

return UIRankBattleDamageFeatureTemplate