---@class UIBrmHuntingRewardPanel
local UIBrmHuntingRewardPanel = {}

function UIBrmHuntingRewardPanel:InitComponents()
    ---Grid
    self.Grid = self:GetCurComp("WidgetRoot/view/MainView/HuntingReward/scroll/Grid", "UILoopScrollViewPlus")
    ---剩余次数
    self.remainNumber = self:GetCurComp("WidgetRoot/view/MainView/HuntingReward/Table/number", "UILabel")
    ---刷新时间
    self.Time = self:GetCurComp("WidgetRoot/view/MainView/HuntingReward/Time", "UILabel")
    ---特效裁剪
    self.ClipShader = self:GetCurComp("WidgetRoot/view/MainView/HuntingReward/scroll", "Top_OptimizeClipShaderScript")
    ---花费体力
    self.costNumber = self:GetCurComp("WidgetRoot/view/MainView/HuntingReward/Cost/number", "UILabel")
end

function UIBrmHuntingRewardPanel:InitOther()
    ---@type BaiRiMenActController_HuntingRewar
    self.HuntingRewarController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_HuntingRewar()

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BaiRiMenActivityDataReceived, function()
        self:RefreshUI()
    end)
end

---初始化数据
function UIBrmHuntingRewardPanel:Init()
    self:InitComponents()
    self:InitOther()

end

function UIBrmHuntingRewardPanel:Show()
    self:RefreshUI()
end

function UIBrmHuntingRewardPanel:RefreshUI()
    --self:RefreshKillNumber()
    self:RefreshTime()
    self:RefreShGrid()
    self:RefreshCurLastingStamina()
    self:RefreshCostStamina()
end

---刷新击杀数量
function UIBrmHuntingRewardPanel:RefreshKillNumber()
    if self.HuntingRewarController == nil then
        return
    end
    local AvailableNumber = self.HuntingRewarController:GetAvailableNumber()
    local MaxNumber = self.HuntingRewarController:GetMaxNumber()
    local surplusNumber = AvailableNumber
    local color = "[00ff00]"
    if surplusNumber <= 0 then
        surplusNumber = 0
        color = "[ff0000]"
    end
    self.remainNumber.text = "精英任务击杀数量 " .. color .. surplusNumber .. '[-]/' .. MaxNumber
end

---刷新当前剩余体力值
function UIBrmHuntingRewardPanel:RefreshCurLastingStamina()
    if self.HuntingRewarController == nil then
        return
    end
    local CurLastingStamina = self.HuntingRewarController:GetCurLastingStamina()
    local color = luaEnumColorType.Red
    if CurLastingStamina > 0 then
        color = luaEnumColorType.Green
    end
    luaclass.UIRefresh:RefreshLabel(self.remainNumber,"当前体力 " .. color .. CurLastingStamina)
end

---刷新体力消耗
function UIBrmHuntingRewardPanel:RefreshCostStamina()
    if self.HuntingRewarController == nil then
        return
    end
    local brmActivityTbl = self.HuntingRewarController:GetRepresentActivityTbl()
    luaclass.UIRefresh:RefreshLabel(self.costNumber,"体力消耗 " .. luaEnumColorType.Red .. tostring(brmActivityTbl:GetPhysicalstrength()))
end

---刷新时间
function UIBrmHuntingRewardPanel:RefreshTime()
    local openTime = self.HuntingRewarController:GetActiveOpenTime()
    local endTime = self.HuntingRewarController:GetActiveEndTime()
    local des = self.HuntingRewarController:TimeChangeStr(openTime) .. "-" .. self.HuntingRewarController:TimeChangeStr(endTime)
    self.Time.text = "每日 " .. des .. "  刷新"
end

function UIBrmHuntingRewardPanel:RefreShGrid()
    self.DataInfo = self.HuntingRewarController:GetServerDataInfoList()
    self.Grid:Init(function(go, line)
        return self:GridCallBack(go, line, 1)
    end)
end

function UIBrmHuntingRewardPanel:GridCallBack(go, line, key)
    if self.DataInfo == nil then
        return false
    end
    local number = #self.DataInfo
    if line >= number then
        return false
    end
    if self.templateList == nil then
        ---@type table<gameObject,UIBrmHuntingRewardTemplate>
        self.templateList = {}
    end
    if self.templateList[go] == nil then
        self.templateList[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBrmHuntingRewardTemplate)
    end
    self.templateList[go]:RefreshUI(self.DataInfo[line+1], self.ClipShader)
    return true
end

return UIBrmHuntingRewardPanel