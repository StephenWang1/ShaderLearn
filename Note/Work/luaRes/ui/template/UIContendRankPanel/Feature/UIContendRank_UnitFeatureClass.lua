---@class UIContendRank_UnitFeatureClass:UIRankFeatureBaseTemplate 夺榜基类
local UIContendRank_UnitFeatureClass = {}
setmetatable(UIContendRank_UnitFeatureClass, luaclass.UIRankFeatureBaseTemplate)

function UIContendRank_UnitFeatureClass:SetOther()
    self:RunBaseFunction("SetOther")
    self:TryRefreshTitle()
    self:ShowReward()
end

function UIContendRank_UnitFeatureClass:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl == nil then
        return
    end
    if self.unitTbl.isMain then
        self.unitTbl.bg.gameObject:SetActive(true)
    else
        self.unitTbl.bg.gameObject:SetActive(self.unitTbl.rankID % 2 ~= 1)
    end

    if self.unitTbl:GetRankName() ~= nil then
        self.unitTbl.promptPoint = self.unitTbl:GetRankName()
        self.unitTbl:GetRankName().text = self.rankData ~= nil and self.rankData.name or "虚位以待"
        self.unitTbl:GetRankName().gameObject:SetActive(self:IsShowRankName())
    end

    if self.unitTbl:GetRankingValue() ~= nil then
        self.unitTbl:GetRankingValue().text = (self.unitTbl.rankID > 3 or self.unitTbl.isMain) and "第" .. tostring(self.unitTbl.rankID) .. "名" or ''
        self.unitTbl:GetRankingValue().gameObject:SetActive(self:IsShowRanking())
    end

    if self.unitTbl:GetRankMothIcon() ~= nil then
        self.unitTbl:GetRankMothIcon().spriteName = self.rankData ~= nil and self:GetMothName(self.rankData.monthCard) or ''
        self.unitTbl:GetRankMothIcon().gameObject:SetActive(self:IsShowRankNameMothIcon())
        self.unitTbl:GetRankMothIcon():DelayUpdateAnchors()
    end

    self.unitTbl:GetRankDealIngot().gameObject:SetActive(false)
end

function UIContendRank_UnitFeatureClass:TrySetPos()
    if self.unitTbl:GetRankingSprite() ~= nil then
        local origionPos = self.unitTbl:GetRankingSprite().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.ranking, self.unitTbl.isMain)
        self.unitTbl:GetRankingSprite().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankingValue() ~= nil then
        local origionPos = self.unitTbl:GetRankingValue().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rankingStr, self.unitTbl.isMain)
        self.unitTbl:GetRankingValue().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankName() ~= nil then
        local origionPos = self.unitTbl:GetRankName().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.name, self.unitTbl.isMain)
        self.unitTbl:GetRankName().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRewardGrid() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.reward, self.unitTbl.isMain)
        self.unitTbl:GetRewardGrid().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

end

function UIContendRank_UnitFeatureClass:SetBgSize()

end

function UIContendRank_UnitFeatureClass:TryRefreshTitle()
    if self:IsShowTitle() then
        self.unitTbl:RefreshTitle()
    end
end

function UIContendRank_UnitFeatureClass:SetTitleShow(target, atlas)
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
    local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(target.rankConfigId, LuaRankComponentSystem.title, target.isMain)
    target:GetTitleSprite().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)

    target:GetTitleAnim().gameObject:SetActive(true)
    target:SetActiveState(LuaRankComponentSystem.title, target:GetTitleSprite().gameObject)

    CS.UIEventListener.Get(target:GetTitleSprite().gameObject).onClick = nil
    local isFind, titleItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(target.titleItemId)
    if isFind then
        CS.UIEventListener.Get(target:GetTitleSprite().gameObject).onClick = function(go)
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = titleItemInfo, showRight = false })
        end
    end
end

function UIContendRank_UnitFeatureClass:ShowReward()
    if self.unitTbl:GetRewardGrid() ~= nil and self:IsShowReward() then
        for i = 0, self.unitTbl.rewardList.list.Count - 1 do
            if self.unitTbl.rewardList.list[i].list.Count > 1 then
                self.unitTbl:GetRewardGrid().MaxCount = i + 1
                local go = self.unitTbl:GetRewardGrid().controlList[i]
                if go ~= nil then
                    local id = self.unitTbl.rewardList.list[i].list[0]
                    local count = self.unitTbl.rewardList.list[i].list[1]
                    local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
                    temp:RefreshUI(id, count)
                end
            end
        end
        self.unitTbl:SetActiveState(LuaRankComponentSystem.reward, self.unitTbl:GetRewardGrid().gameObject)
        self.unitTbl:GetRewardGrid().gameObject:SetActive(true)
    end
end

--是否显示称号
function UIContendRank_UnitFeatureClass:IsShowTitle()
    return self.unitTbl.isMain and self.unitTbl.title ~= nil and self.unitTbl.title ~= ""
end

--是否显示奖励
function UIContendRank_UnitFeatureClass:IsShowReward()
    return self.unitTbl.rewardList ~= nil and self.unitTbl.rewardList.list.Count > 0
end

--是否显示通用param赋值文本
function UIContendRank_UnitFeatureClass:IsShowNormal()
    return false
end

--是否显示自己标记
function UIContendRank_UnitFeatureClass:IsShowMyMark()
    return self.rid ~= nil and self.rid == CS.CSScene.MainPlayerInfo.ID and not self.unitTbl.isMain
end

---根据id处理显示逻辑
function UIContendRank_UnitFeatureClass:GetIsShowOfId(id)
    if id == LuaRankComponentSystem.title then
        return self:IsShowTitle()
    elseif id == LuaRankComponentSystem.reward then
        return self:IsShowReward()
    elseif id == LuaRankComponentSystem.normalStr then
        return self:IsShowNormal()

    end
end

function UIContendRank_UnitFeatureClass:OnTemplatBtnClick(target, go)
    local panel = uimanager:GetPanel("UIContendRankPanel")
    if panel and target.rankData then
        if panel.CurSelectTemplate == nil then
            panel.CurSelectTemplate = {}
        end
        panel.CurSelectTemplate = target
        if target.rankData.uid == CS.CSScene.MainPlayerInfo.ID then
            if target:GetRankName() ~= nil then
                Utility.ShowPopoTips(target:GetRankName().gameObject, nil, 308, "UIRankPanel")
            end
            return
        end
        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
            roleId = target.rid,
            roleName = target.rankData.name,
            roleSex = target.rankData.sex,
            roleCareer = target.rankData.career
        })
        --networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, target.rankData.uid)
    end
end

return UIContendRank_UnitFeatureClass