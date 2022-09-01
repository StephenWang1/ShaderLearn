---@class UIChallengeBoss_WildBossTemplates:UIChallengeBossBaseTemplates 野外Boss
local UIChallengeBoss_WildBossTemplates = {}
setmetatable(UIChallengeBoss_WildBossTemplates, luaComponentTemplates.UIChallengeBossBaseTemplates)

function UIChallengeBoss_WildBossTemplates:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---选中
    self.mChoose_Go = self:Get("choose", "GameObject")
end

function UIChallengeBoss_WildBossTemplates:InitOther()
    self:RunBaseFunction("InitOther")
end

function UIChallengeBoss_WildBossTemplates:RefreshUI(data, ClipShader)
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    self:RefreshMapGrid()
    self:ShowBossSkill()
end

function UIChallengeBoss_WildBossTemplates:ClickOperation(bossInfo, go)
    if self:IsHangHuiMiJingDuplicate(bossInfo) then
        ---如果是行会秘境副本,首先检查下是否满足进入条件
        local mijingDuplicateID = math.floor(bossInfo:GetMapId() / 100)
        ---行会boss首领排名  -1:没有打过 0 不在前3名 1 2 3分别对应名词
        local unionBossRankNo = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionBossRankNo()
        local canEnterDuplicate = false
        if unionBossRankNo == 1 then
            canEnterDuplicate = mijingDuplicateID == 230
        elseif unionBossRankNo == 2 then
            canEnterDuplicate = mijingDuplicateID == 231
        elseif unionBossRankNo == 3 then
            canEnterDuplicate = mijingDuplicateID == 232
        elseif unionBossRankNo == -1 then
            canEnterDuplicate = true
        end
        --if canEnterDuplicate == false then
        --    if mijingDuplicateID == 230 then
        --        Utility.ShowPopoTips(go.transform, "击杀行会首领第一可进入", 290, "UIBossPanel")
        --        return
        --    elseif mijingDuplicateID == 231 then
        --        Utility.ShowPopoTips(go.transform, "击杀行会首领第二可进入", 290, "UIBossPanel")
        --        return
        --    elseif mijingDuplicateID == 232 then
        --        Utility.ShowPopoTips(go.transform, "击杀行会首领第三可进入", 290, "UIBossPanel")
        --        return
        --    end
        --end
    end
    self:RunBaseFunction("ClickOperation", bossInfo, go)
end

function UIChallengeBoss_WildBossTemplates:ChooseItem(isChoose)
    if not CS.StaticUtility.IsNull(self.mChoose_Go) then
        self.mChoose_Go:SetActive(isChoose)
    end
end

return UIChallengeBoss_WildBossTemplates