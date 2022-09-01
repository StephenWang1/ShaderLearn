---@class UIOverlordRank_MeritUnitClass:UIOverlordRank_BaseUnitClass  建功立业单元
local UIOverlordRank_MeritUnitClass = {}
setmetatable(UIOverlordRank_MeritUnitClass, luaclass.UIOverlordRank_BaseUnitClass)

function UIOverlordRank_MeritUnitClass:Show(unitTbl)
    self:RunBaseFunction("Show", unitTbl)
end

function UIOverlordRank_MeritUnitClass:OnGetRewardBtnClick()
    if self.rankData == nil or self.rankData.merit == nil or CS.CSScene.MainPlayerInfo == nil then
        return
    end
    if self.rankData.subtype == 3 then
        for i = 0, self.rankData.merit.Count - 1 do
            if self.rankData.merit[i].thisType == 0 and self.rankData.merit[i].lid == CS.CSScene.MainPlayerInfo.ID then
                networkRequest.ReqRewardUnionAchievement(self.rankData.merit[i].id)
                return
            end
        end
    else
        networkRequest.ReqRewardUnionAchievement(self.rankData.merit[0].id)
    end
end

function UIOverlordRank_MeritUnitClass:SetRankView()
    self:SetBgWidght(108)

    if self.unitTbl:GetOverlordText() ~= nil then
        local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
        local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.OverlordText)
        self.unitTbl:GetOverlordText().text = string.gsub(info.str, "\\n", '\n')
        self.unitTbl:GetOverlordText().gameObject:SetActive(self:IsShowOverlordText())
    end

    if self.unitTbl:GetOverlordTime() ~= nil then
        local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
        local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.OverlordTime)
        if self.rankData == nil or self.rankData.merit == nil or self.rankData.merit[0].lid == 0 then
            local timeInfo = CS.Cfg_Overlord_EspecialTableManager.Instance:GetRemainTimeShow(type)
            local str = timeInfo.Month .. '月' .. timeInfo.Day .. '日'
            self.unitTbl:GetOverlordTime().text = string.format(info.str, str)
        else
            local showStr = self.rankData.merit[0].name
            if showStr == nil or showStr == '' then
                local meritShowTextTbl = uiStaticParameter.GetMeridShowTextTbl()
                if showStr ~= nil and #meritShowTextTbl >= type then
                    showStr = meritShowTextTbl[type]
                else
                    showStr = ''
                end
            end
            self.unitTbl:GetOverlordTime().text = showStr
        end
        self.unitTbl:GetOverlordTime().gameObject:SetActive(self:IsShowOverlordTime())
    end

    if self:IsShowSecondOverlordText() and self.unitTbl:GetSecondOverlordText() ~= nil then
        self.unitTbl:GetSecondOverlordText().text = self.rankData.merit[1].name
        self.unitTbl:GetSecondOverlordText().gameObject:SetActive(true)
        self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.SecondOverlordText, self.unitTbl:GetSecondOverlordText().gameObject)
    end

    self:ShowRewardList()
    self:RefreshRewardState()
    self:TryRefreshTitle()
end

function UIOverlordRank_MeritUnitClass:TrySetPos()
    if self.unitTbl:GetOverlordText() ~= nil then
        local origionPos = self.unitTbl:GetOverlordText().transform.localPosition
        local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
        local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.OverlordText)
        self.unitTbl:GetOverlordText().transform.localPosition = CS.UnityEngine.Vector3(info.posx, origionPos.y, 0)
    end

    if self.unitTbl:GetOverlordTime() ~= nil then
        local y = self:IsShowSecondOverlordText() and 9 or -3
        local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
        local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.OverlordTime)
        self.unitTbl:GetOverlordTime().transform.localPosition = CS.UnityEngine.Vector3(info.posx, y, 0)
    end

    if self:IsShowSecondOverlordText() and self.unitTbl:GetSecondOverlordText() ~= nil then
        local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
        local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.OverlordTime)
        self.unitTbl:GetSecondOverlordText().transform.localPosition = CS.UnityEngine.Vector3(info.posx, -27, 0)
    end

    if self.unitTbl:GetRewardGrid() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
        local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.UnionReward)
        self.unitTbl:GetRewardGrid().transform.localPosition = CS.UnityEngine.Vector3(info.posx, origionPos.y, 0)
    end

    --if self.unitTbl:GetRewardBtn() ~= nil then
    --    local origionPos = self.unitTbl:GetRewardBtn().transform.localPosition
    --    local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
    --    local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.GetRewardBtn)
    --    self.unitTbl:GetRewardBtn().transform.localPosition = CS.UnityEngine.Vector3(info.posx, origionPos.y, 0)
    --end
    --
    --if self.unitTbl:GetReceivedRewardObj() ~= nil then
    --    local origionPos = self.unitTbl:GetReceivedRewardObj().transform.localPosition
    --    local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
    --    local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.GetRewardBtn)
    --    self.unitTbl:GetReceivedRewardObj().transform.localPosition = CS.UnityEngine.Vector3(info.posx, origionPos.y, 0)
    --end
end

function UIOverlordRank_MeritUnitClass:TryRefreshTitle()
    if self:IsShowTitle() then
        self.unitTbl.titleId = self.unitTbl:RefreshTitle()
    end
end

function UIOverlordRank_MeritUnitClass:SetTitleShow(target, atlas)
    local spriteCount = atlas.spriteList.Count
    if spriteCount > 0 then
        if spriteCount == 1 then
            ---单张精灵
            target:GetTitleAnim().enabled = false
            target:GetTitleSprite().spriteName = atlas.spriteList[0].name
            target:GetTitleSprite():MakePixelPerfect()
        else
            ---帧动画
            target:GetTitleAnim().enabled = true
            target:GetTitleAnim():RebuildSpriteList()
            target:GetTitleAnim():Play()
        end
    end

    local origionPos = target:GetTitleSprite().transform.localPosition
    local type = self.rankData ~= nil and self.rankData.subtype or self.rankID
    local info = CS.Cfg_Overlord_EspecialTableManager.Instance:GetComponentInfo(type, LuaEnumOverlordComponentType.Title, true)
    target:GetTitleSprite().transform.localPosition = CS.UnityEngine.Vector3(info.posx, origionPos.y, 0)

    target:GetTitleAnim().gameObject:SetActive(true)
    target:SetActiveState(LuaRankComponentSystem.title, target:GetTitleSprite().gameObject)

    CS.UIEventListener.Get(target:GetTitleSprite().gameObject).onClick = nil
    local isFind, titleItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(target.titleInfo.itemId)
    if isFind then
        CS.UIEventListener.Get(target:GetTitleSprite().gameObject).onClick = function(go)
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = titleItemInfo, showRight = false })
        end
    end
end

function UIOverlordRank_MeritUnitClass:GetRewardList()
    if self.rankData ~= nil and self.rankData.merit ~= nil then
        return self.rankData.merit[0].rewardList
    end
    return nil
end

---是否显示特殊文本
function UIOverlordRank_MeritUnitClass:IsShowOverlordText()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.OverlordText, self.unitTbl:GetOverlordText().gameObject)
    return true
end
---是否显示特殊时间
function UIOverlordRank_MeritUnitClass:IsShowOverlordTime()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.OverlordTime, self.unitTbl:GetOverlordTime().gameObject)
    return true
end
---是否显示称号
function UIOverlordRank_MeritUnitClass:IsShowTitle()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.Title, self.unitTbl:GetTitleSprite().gameObject)
    return true
end
---是否显示特殊文本 (特殊)
function UIOverlordRank_MeritUnitClass:IsShowSecondOverlordText()
    return self.rankData ~= nil and self.rankData.merit ~= nil and self.rankData.merit.Count > 1 and self.rankData.merit[1].lid ~= 0
end
---是否显示奖励
function UIOverlordRank_MeritUnitClass:IsShowGetRewardBtn()
    if self.rankData ~= nil then
        for i = 0, self.rankData.merit.Count - 1 do
            if self.rankData.merit[i].receiveType == 1 then
                return true
            end
        end
    end
    return false
end

---是否显示已领取
function UIOverlordRank_MeritUnitClass:IsShowReceivedReward()
    if self.rankData ~= nil and self.rankData.merit ~= nil then
        for i = 0, self.rankData.merit.Count - 1 do
            if self.rankData.merit[i].receiveType == 2 then
                return true
            end
        end
    end
    return false
end

return UIOverlordRank_MeritUnitClass