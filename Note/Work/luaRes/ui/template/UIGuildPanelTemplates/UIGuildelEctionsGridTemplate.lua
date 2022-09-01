---帮会竞选格子模板
---@class UIGuildelEctionsGridTemplate:TemplateBase
local UIGuildelEctionsGridTemplate = {}

---@param panel UIGuildelEctionsPanel
function UIGuildelEctionsGridTemplate:Init(panel)
    self.rootPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UIGuildelEctionsGridTemplate:InitComponent()
    ---玩家头像
    ---@type UISprite
    self.headIcon_UISprite = self:Get("headicon", "UISprite")

    ---玩家名字
    ---@type UILabel
    self.name_UILabel = self:Get("name", "UILabel")

    ---票数
    ---@type UILabel
    self.vote_UILabel = self:Get("voted", "UILabel")

    ---投票按钮
    ---@type UnityEngine.GameObject
    self.btnVote_GameObject = self:Get("btn_voted", "GameObject")

    ---投票花费
    ---@type UILabel
    self.voteCost_UILabel = self:Get("Costgold", "UILabel")

    ---投票花费Icon
    ---@type UISprite
    self.vote_UISprite = self:Get("Costgold/Sprite", "UISprite")

    ---背景图片
    ---@type UnityEngine.GameObject
    self.bg_GameObject = self:Get("background", "GameObject")

    ---等级
    ---@type UILabel
    self.level_UILabel = self:Get("level", "UILabel")

    ---@type UIToggle
    self.toggle_UIToggle = self:Get("background", "UIToggle")
end

function UIGuildelEctionsGridTemplate:BindEvents()
    CS.UIEventListener.Get(self.btnVote_GameObject).onClick = function(go)
        if self.OnVoteCallBack then
            self.OnVoteCallBack(go, self.playerInfo.member.roleId)
        end
    end

    CS.UIEventListener.Get(self.toggle_UIToggle.gameObject).onClick = function(go)
        if self.rootPanel then
            local pos = self.go.transform.position
            self.rootPanel:ShowData(pos, self.playerInfo.member.roleId,self.Line)

        end
    end
end

---@alias VoteInfo{MemberInfo:unionV2.ElectionInfo,Index:number,VoteCost:number,VoteItemInfo:TABLE.CFG_ITEMS}
---@param customData VoteInfo
function UIGuildelEctionsGridTemplate:RefreshInfo(customData, line)
    if customData.MemberInfo then
        self.playerInfo = customData.MemberInfo
        self:RefreshPlayerInfo()
    end
    if customData.Index then
        -- self.bg_GameObject:SetActive(customData.Index % 2 == 0)
    end
    if customData.VoteCost then
        self.voteCost_UILabel.text = customData.VoteCost
    end
    if customData.VoteItemInfo then
        self.vote_UISprite.spriteName = customData.VoteItemInfo.icon
    end
    if customData.OnVoteCallBack then
        self.OnVoteCallBack = customData.OnVoteCallBack
    end
    if line then
        self.Line = line
    end

end

---刷新玩家信息
function UIGuildelEctionsGridTemplate:RefreshPlayerInfo()
    if self.playerInfo then
        ---@type unionV2.UnionMemberInfo
        local info = self.playerInfo.member
        local sex = info.sex
        local career = info.career
        self.headIcon_UISprite.spriteName = Utility.GetPlayerHeadIconSpriteName(sex, career)
        self.name_UILabel.text = info.memberName
        self.vote_UILabel.text = luaEnumColorType.Green .. self.playerInfo.votes .. "票"
        self.level_UILabel.text = info.memberLevel
    end
end

return UIGuildelEctionsGridTemplate