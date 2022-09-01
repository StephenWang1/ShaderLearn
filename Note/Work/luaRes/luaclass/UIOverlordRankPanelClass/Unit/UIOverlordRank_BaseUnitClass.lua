---@class UIOverlordRank_BaseUnitClass:UIRankFeatureBaseTemplate       行会之争单元
local UIOverlordRank_BaseUnitClass = {}
setmetatable(UIOverlordRank_BaseUnitClass, luaclass.UIRankFeatureBaseTemplate)

function UIOverlordRank_BaseUnitClass:OnGetRewardBtnClick()
    ---请求领取奖励
end

function UIOverlordRank_BaseUnitClass:GetRewardList()
    return self.rankData ~= nil and self.rankData.rewardList or nil
end

function UIOverlordRank_BaseUnitClass:SetTemplate()
    self:SetRankView()
end

function UIOverlordRank_BaseUnitClass:SetRankView()

end

function UIOverlordRank_BaseUnitClass:SetBgSize()

end

function UIOverlordRank_BaseUnitClass:RefreshRewardState()
    if self.unitTbl.rewardInfoTemplateList == nil then
        return
    end
    for i, v in pairs(self.unitTbl.rewardInfoTemplateList) do
        if v ~= nil then
            local get = CS.Utility_Lua.GetComponent(v.transform:Find("btn_get"), "GameObject")
            local recived = CS.Utility_Lua.GetComponent(v.transform:Find("geted"), "GameObject")
            get.gameObject:SetActive(self:IsShowGetRewardBtn())
            recived.gameObject:SetActive(self:IsShowReceivedReward())
            CS.UIEventListener.Get(get).LuaEventTable = self.unitTbl
            CS.UIEventListener.Get(get).OnClickLuaDelegate = nil
            CS.UIEventListener.Get(get).OnClickLuaDelegate = self.OnGetRewardBtnClick
        end
    end
end

function UIOverlordRank_BaseUnitClass:ShowRewardList()
    if self.unitTbl:GetRewardGrid() ~= nil then
        self.unitTbl:GetRewardGrid().transform.localScale = { x = 1, y = 1, z = 1 }
        self.unitTbl.rewardInfoTemplateList = {}
        local list = self:GetRewardList()
        self.unitTbl:GetRewardGrid().MaxCount = list == nuil and 0 or list.Count
        if list ~= nil then
            for i = 0, list.Count - 1 do
                local info = list[i]
                if info ~= nil then
                    local go = CS.Utility_Lua.GetComponent(self.unitTbl:GetRewardGrid().controlList[i], "GameObject")
                    if go then
                        local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "UISprite")
                        local count = CS.Utility_Lua.GetComponent(go.transform:Find("count"), "UILabel")
                        if count ~= nil and not CS.StaticUtility.IsNull(count) then
                            count.text = info.count > 1 and tostring(info.count) or ""
                        end

                        local isFind, itemTblInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.rewardId)
                        if isFind then
                            if icon ~= nil and not CS.StaticUtility.IsNull(icon) then
                                icon.spriteName = itemTblInfo.icon
                            end
                            CS.UIEventListener.Get(go).onClick = nil
                            CS.UIEventListener.Get(go).onClick = function()
                                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTblInfo, showRight = false })
                            end
                        end
                        table.insert(self.unitTbl.rewardInfoTemplateList, go)
                    end
                end
            end
        end
    end
    self.unitTbl:GetRewardGrid().gameObject:SetActive(true)
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.UnionReward, self.unitTbl:GetRewardGrid().gameObject)
end

function UIOverlordRank_BaseUnitClass:SetBgWidght(size)
    self.unitTbl.bg.height = size
    self.unitTbl.goWidght.height = size
    local boxSize = self.unitTbl.goBox.size
    self.unitTbl.goBox.size = { x = boxSize.x, y = size }
end

---是否显示行会排行
function UIOverlordRank_BaseUnitClass:IsShowUnionRank()
    return false
end
---是否显示繁荣度
function UIOverlordRank_BaseUnitClass:IsShowProsperity()
    return false
end
---是否显示奖励预览
function UIOverlordRank_BaseUnitClass:IsShowUnionReward()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.UnionReward, self.unitTbl:GetRewardGrid().gameObject)
    return true
end
---是否显示职位
function UIOverlordRank_BaseUnitClass:IsShowUnionPosition()
    return false
end
---是否显示玩家姓名
function UIOverlordRank_BaseUnitClass:IsShowPlayerName()
    return false
end
---是否显示贡献度
function UIOverlordRank_BaseUnitClass:IsShowContribution()
    return false
end
---是否显示玩家排名
function UIOverlordRank_BaseUnitClass:IsShowPlayerRank()
    return false
end
---是否显示领取按钮
function UIOverlordRank_BaseUnitClass:IsShowGetRewardBtn()
    return false
end
---是否显示排行图片
function UIOverlordRank_BaseUnitClass:IsShowRankSprite()
    return false
end
---是否显示特殊文本
function UIOverlordRank_BaseUnitClass:IsShowOverlordText()
    return false
end
---是否显示特殊时间
function UIOverlordRank_BaseUnitClass:IsShowOverlordTime()
    return false
end
---是否显示称号
function UIOverlordRank_BaseUnitClass:IsShowTitle()
    return false
end

---是否显示玩家姓名(特殊)
function UIOverlordRank_BaseUnitClass:IsShowSecondPlayerName()
    return false
end
---是否显示贡献度 (特殊)
function UIOverlordRank_BaseUnitClass:IsShowSecondContribution()
    return false
end

---是否显示特殊文本 (特殊)
function UIOverlordRank_BaseUnitClass:IsShowSecondOverlordText()
    return false
end
---是否显示已领取
function UIOverlordRank_BaseUnitClass:IsShowReceivedReward()
    return false
end

---是否显示竞技按钮
function UIOverlordRank_BaseUnitClass:IsShowCompetitionBtn()
    return false
end

---根据id处理显示逻辑
function UIOverlordRank_BaseUnitClass:GetIsShowOfId(id)
    if id == LuaEnumOverlordComponentType.UnionRank then
        return self:IsShowUnionRank()
    elseif id == LuaEnumOverlordComponentType.UnionName then
        return self:IsShowUnionName()
    elseif id == LuaEnumOverlordComponentType.Prosperity then
        return self:IsShowProsperity()
    elseif id == LuaEnumOverlordComponentType.UnionReward then
        return self:IsShowUnionReward()
    elseif id == LuaEnumOverlordComponentType.UnionPosition then
        return self:IsShowUnionPosition()
    elseif id == LuaEnumOverlordComponentType.PlayerName then
        return self:IsShowPlayerName()
    elseif id == LuaEnumOverlordComponentType.Contribution then
        return self:IsShowContribution()
    elseif id == LuaEnumOverlordComponentType.PlayerRank then
        return self:IsShowPlayerRank()
    elseif id == LuaEnumOverlordComponentType.GetRewardBtn then
        return self:IsShowGetRewardBtn()
    elseif id == LuaEnumOverlordComponentType.RankSprite then
        return self:IsShowRankSprite()
    elseif id == LuaEnumOverlordComponentType.OverlordText then
        return self:IsShowOverlordText()
    elseif id == LuaEnumOverlordComponentType.OverlordTime then
        return self:IsShowOverlordTime()
    elseif id == LuaEnumOverlordComponentType.Title then
        return self:IsShowTitle()
    elseif id == LuaEnumOverlordComponentType.SecondPlayerName then
        return self:IsShowSecondPlayerName()
    elseif id == LuaEnumOverlordComponentType.SecondContribution then
        return self:IsShowSecondContribution()
    elseif id == LuaEnumOverlordComponentType.SecondOverlordText then
        return self:IsShowSecondOverlordText()
    elseif id == LuaEnumOverlordComponentType.ReceivedReward then
        return self:IsShowReceivedReward()
    elseif id == LuaEnumOverlordComponentType.CompetitionBtn then
        return self:IsShowCompetitionBtn()
    end
end

return UIOverlordRank_BaseUnitClass