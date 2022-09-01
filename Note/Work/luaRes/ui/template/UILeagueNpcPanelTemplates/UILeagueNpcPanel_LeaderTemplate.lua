---@class UILeagueNpcPanel_LeaderTemplate:TemplateBase 联盟盟主信息模板
local UILeagueNpcPanel_LeaderTemplate = {}

local IsNullGO = CS.StaticUtility.IsNull

--region 组件
---@return UILabel 称谓 盟主/副盟主
function UILeagueNpcPanel_LeaderTemplate:GetLeaderName_UILabel()
    if self.mLeaderNameLb == nil then
        self.mLeaderNameLb = self:Get("lb_name", "UILabel")
    end
    return self.mLeaderNameLb
end

---@return UILabel 平台
function UILeagueNpcPanel_LeaderTemplate:GetPlatform_UILabel()
    if self.mPlatformLb == nil then
        self.mPlatformLb = self:Get("platform", "UILabel")
    end
    return self.mPlatformLb
end

---@return UnityEngine.GameObject 背景
function UILeagueNpcPanel_LeaderTemplate:GetBG_GO()
    if self.BGGo == nil then
        self.BGGo = self:Get("bg", "GameObject")
    end
    return self.BGGo
end

---@return UILabel 标题
function UILeagueNpcPanel_LeaderTemplate:GetTitleName_UILabel()
    if self.mTitleNameLb == nil then
        self.mTitleNameLb = self:Get("leader", "UILabel")
    end
    return self.mTitleNameLb
end
--endregion

---@param data CustomLeagueShow 盟主信息
function UILeagueNpcPanel_LeaderTemplate:RefreshLeader(data)
    if data == nil then
        return
    end

    local isTitle = data.type == 0
    if IsNullGO(self:GetTitleName_UILabel()) == false then
        self:GetTitleName_UILabel().gameObject:SetActive(isTitle)
        self:GetTitleName_UILabel().text = data.Title
    end

    local lb1 = ""
    local lb2 = ""
    if data.type == 1 then
        local leaderData = data.CustomLeadersInfo
        if leaderData then
            lb1 = "【" .. leaderData.UnionName .. "】" .. leaderData.LeaderName
            lb2 = leaderData.IsLeader and "[ff2f2f]盟主" or "[ff6a29]副盟主"
        else
            lb1 = luaEnumColorType.Gray .. "   暂无盟主"
            lb2 = "[ff2f2f]盟主"
        end
    elseif data.type == 2 then
        local unionData = data.CustomUnionInfo
        if unionData then
            lb1 = "   [2977eb]" .. unionData.HostId .. "[-]【" .. unionData.UnionName .. "】"
            lb2 = unionData.UnionActive
        end
    end

    if not CS.StaticUtility.IsNull(self:GetPlatform_UILabel()) then
        self:GetPlatform_UILabel().gameObject:SetActive(not isTitle)
        self:GetPlatform_UILabel().text = lb1
    end

    if not CS.StaticUtility.IsNull(self:GetLeaderName_UILabel()) then
        self:GetLeaderName_UILabel().gameObject:SetActive(not isTitle)
        self:GetLeaderName_UILabel().text = lb2
    end

    if not CS.StaticUtility.IsNull(self:GetBG_GO()) then
        self:GetBG_GO():SetActive(not isTitle)
    end
end

return UILeagueNpcPanel_LeaderTemplate