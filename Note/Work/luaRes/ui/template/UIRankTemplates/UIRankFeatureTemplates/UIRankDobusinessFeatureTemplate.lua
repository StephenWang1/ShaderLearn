---@class UIRankDobusinessFeatureTemplate:UIRankFeatureBaseTemplate 经商榜
local UIRankDobusinessFeatureTemplate = {}

setmetatable(UIRankDobusinessFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankDobusinessFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankDealIngot() ~= nil then
        local YuanBao = self.rankData.param
        local Diamond = self.rankData.extraParam
        local num = 0
        local data = {}
        if YuanBao and YuanBao > 0 then
            num = num + 1
            local coinInfo = {}
            coinInfo.itemId = LuaEnumCoinType.YuanBao
            coinInfo.num = YuanBao
            table.insert(data, coinInfo)
        end
        if Diamond and Diamond > 0 then
            local coinInfo = {}
            coinInfo.itemId = LuaEnumCoinType.Diamond
            coinInfo.num = Diamond
            table.insert(data, coinInfo)
        end
        self.unitTbl:GetRankDealIngot().MaxCount = #data
        for i = 0, self.unitTbl:GetRankDealIngot().controlList.Count - 1 do
            local go = self.unitTbl:GetRankDealIngot().controlList[i]
            if CS.StaticUtility.IsNull(go) == false then
                local icon = CS.Utility_Lua.Get(go.transform, "Sprite2", "UISprite")
                local num = CS.Utility_Lua.GetComponent(go.transform, "UILabel")
                local info = data[i + 1]
                if info and CS.StaticUtility.IsNull(icon) == false and CS.StaticUtility.IsNull(num) == false then
                    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(info.itemId)
                    if itemInfo then
                        icon.spriteName = itemInfo:GetIcon()
                    end
                    num.text = info.num
                end
            end
        end

        --self.unitTbl:GetRankDealIngot().text = tostring(self.rankData.param)
        self.unitTbl:GetRankDealIngot().gameObject:SetActive(self:IsShowCoinValue())
    end
end

function UIRankDobusinessFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox() ~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end
end

function UIRankDobusinessFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankDealIngot() ~= nil then
        local origionPos = self.unitTbl:GetRankDealIngot().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.dealIngot)
        self.unitTbl:GetRankDealIngot().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--region overrid

--是否显示元宝交易额13
function UIRankDobusinessFeatureTemplate:IsShowCoinValue()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.dealIngot, self.unitTbl:GetRankDealIngot().gameObject)
    return true
end

--是否需要显示宝箱按钮7
function UIRankDobusinessFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return true
end
--endregion

return UIRankDobusinessFeatureTemplate