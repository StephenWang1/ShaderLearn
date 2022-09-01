---@class UIUnionPreselectedPanel_UnitTemplate:UIBaseTemplate  联盟预选单个模板
local UIUnionPreselectedPanel_UnitTemplate = {}

--region 初始化

function UIUnionPreselectedPanel_UnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIUnionPreselectedPanel_UnitTemplate:InitParameters()
    self.leagueType = 0
end

function UIUnionPreselectedPanel_UnitTemplate:InitComponents()
    ---@type CSUIEffectLoad 背景
    self.bgLoad = self:Get("bg", "CSUIEffectLoad")
    ---@type UnityEngine.GameObject 投票按钮
    self.btn = self:Get("btn", "GameObject")
    ---@type UnityEngine.GameObject 已投标志
    self.nowFlag = self:Get("now", "GameObject")
end

function UIUnionPreselectedPanel_UnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.btn).LuaEventTable = self
    CS.UIEventListener.Get(self.btn).OnClickLuaDelegate = self.OnVoteBtnClick
end

--endregion

--region Show

---@param data table
---@field public bgABStr       string 加载背景ab名称
---@field public curVoteType   number 当前投票
---@field public curLeagueType number 当前联盟类型
function UIUnionPreselectedPanel_UnitTemplate:SetTemplate(data)
    if data then
        self.leagueType = data.curLeagueType
        --加载背景
        self.bgLoad:ChangeEffect(data.bgABStr)
        self:RefreshVoteState(data.curVoteType)
    end
end

function UIUnionPreselectedPanel_UnitTemplate:RefreshVoteState(voteType)
    self.btn:SetActive(voteType == 0)
    self.nowFlag:SetActive(voteType == self.leagueType)
end

--endregion


--region UI函数监听

---点击投票按钮
---@param go UnityEngine.GameObject
function UIUnionPreselectedPanel_UnitTemplate:OnVoteBtnClick(go)
    ---点击投票
    if self.leagueType ~= 0 then
        networkRequest.ReqWillJoinUniteUnion(self.leagueType, 1)
    end
end

--endregion

--region ondestroy

function UIUnionPreselectedPanel_UnitTemplate:onDestroy()

end

--endregion

return UIUnionPreselectedPanel_UnitTemplate