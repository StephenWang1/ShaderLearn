---@class GuildActivity_GuildForHangHuiShouLin:GuildActivity_Base 行会首领
local GuildActivity_GuildForHangHuiShouLin = {}

setmetatable(GuildActivity_GuildForHangHuiShouLin, luaComponentTemplates.GuildActivity_Base)

--region 初始化
function GuildActivity_GuildForHangHuiShouLin:Init()
    self:RunBaseFunction("Init")
end

function GuildActivity_GuildForHangHuiShouLin:InitParams()
    self:RunBaseFunction("InitParams")
end
--endregion

--region 刷新
---@param commonData { activityId = activityInfo.ActivityId, activityInfo = activityInfo }
function GuildActivity_GuildForHangHuiShouLin:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)

    self:RefreshActive(self:GetButton_GameObject(), true)
    local canEnter = commonData.activityInfo.isOpen
    self:RefreshActive(self:GetButtonEffect_GameObject(), canEnter)
    self:RefreshActive(self:GetBossPrompt_UILabel(), true)

    local luaTable = clientTableManager.cfg_union_activityManager:TryGetValue(self.activityInfo.UnionActivityTable.id)
    if luaTable then
        self:RefreshLabel(self:GetBossPrompt_UILabel(), luaTable:GetDes())
    end
    if (canEnter) then
        self:GetBtnBG_UISprite().spriteName = "anniu1"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.764, 0.956, 1)
    else
        self:GetBtnBG_UISprite().spriteName = "anniu26"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.447, 0.447, 0.447)
    end
    self:GetButton_UILabel().text = "行会首领"
end

--endregion

--region 点击事件
function GuildActivity_GuildForHangHuiShouLin:EnterBtnOnClick(go)
    --uiStaticParameter.GuildForHangHuiShouLinActivity = self.activityId
    --print("请求进入"..self.activityId)
    --local isOpen = gameMgr:GetPlayerDataMgr():GetActivityMgr():IsOpenActivity(46)
    ---@type LuaActivityItem
    local activityItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(46);
    local runningState,activityItemSubInfo = activityItem:GetRunningState()

    --print("请求进入".. activityItemSubInfo.Tbl:GetId())
    if (runningState == LuaActivityRunningState.IsRunning) then
        local duplicateId = activityItemSubInfo.Tbl:GetId() == 434 and 25001 or 25002
        if self:IsFullCondition(go, duplicateId) then
            if (self.activityId == 433) then
                networkRequest.ReqEnterDuplicate(25001)
            else
                networkRequest.ReqEnterDuplicate(25002)
            end
        end
    else
        self:ShowTips(go, 463, nil)
    end
end

---@return boolean 玩家等级是否满足进入活动
function GuildActivity_GuildForHangHuiShouLin:IsFullCondition(go, duplicateId)
    local res, csDuplicateTbl = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(duplicateId)
    if res then
        ---@type TABLE.CFG_DUPLICATE
        local tbl = csDuplicateTbl
        local condition = tbl.condition
        if condition and condition ~= 0 then
            local result = Utility.IsMainPlayerMatchCondition(condition)
            if result and result.success == false and result.param then
                local str = Utility.CombineStringQuickly("达到", result.param, "级可进入")
                Utility.ShowPopoTips(go, str, 1)
                return false
            end
        end
    end
    return true
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function GuildActivity_GuildForHangHuiShouLin:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---背景点击事件
function GuildActivity_GuildForHangHuiShouLin:Bg1BtnOnClick(go)
end

function GuildActivity_GuildForHangHuiShouLin:OnDisable()
end
--endregion

return GuildActivity_GuildForHangHuiShouLin