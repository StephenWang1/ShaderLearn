---@class UIContendRank_UnitDobusinessFeatureClass:UIContendRank_UnitNormalFeatureClass 夺榜 经商榜
local UIContendRank_UnitDobusinessFeatureClass = {}
setmetatable(UIContendRank_UnitDobusinessFeatureClass, luaclass.UIContendRank_UnitNormalFeatureClass)

function UIContendRank_UnitDobusinessFeatureClass:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetNormalText() ~= nil then
        self.unitTbl:GetNormalText().gameObject:SetActive(false)
        self.unitTbl:GetRankDealIngot().gameObject:SetActive(true)
        if self.rankData == nil then
            return
        end

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
    end
end

function UIContendRank_UnitDobusinessFeatureClass:TrySetPos()
    self:RunBaseFunction("TrySetPos")
    if self.unitTbl:GetRankDealIngot() ~= nil then
        local origionPos = self.unitTbl:GetRankDealIngot().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.normalStr, self.unitTbl.isMain)
        self.unitTbl:GetRankDealIngot().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

return UIContendRank_UnitDobusinessFeatureClass