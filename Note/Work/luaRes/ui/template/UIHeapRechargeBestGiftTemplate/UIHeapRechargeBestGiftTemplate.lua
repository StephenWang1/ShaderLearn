--- DateTime: 2021/05/17 21:08
--- Description 累充豪礼单元模板

---@class UIHeapRechargeBestGiftTemplate:TemplateBase
local UIHeapRechargeBestGiftTemplate = {}

--setmetatable(UIHeapRechargeBestGiftTemplate, UIBase)

--region parameters
--endregion

--region Init

---@private
function UIHeapRechargeBestGiftTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindEvent()
end

---@private
function UIHeapRechargeBestGiftTemplate:InitParameters()
    ---@type activitiesV2.ConsumRankInfo
    self.curRankData = nil
    self.rewardTbl = {}
    self.allTemplateByRewardGoTbl = {}
    self.IsInitialized = false
end

---@private
function UIHeapRechargeBestGiftTemplate:InitComponents()
    ---@type UnityEngine.GameObject
    self.go_has_got = self:Get('has_got', 'GameObject')
    ---@type UnityEngine.GameObject
    self.go_btn_get = self:Get('btn_get', 'GameObject')
    ---@type UIHeapRechargeBestGiftAwardTemplate
    self.template_reward = templatemanager.GetNewTemplate(self:Get('reward', 'GameObject'), luaComponentTemplates.UIHeapRechargeBestGiftAwardTemplate)
    ---@type Top_UILabel
    self.title = self:Get('title', 'Top_UILabel')
    ---@type UnityEngine.GameObject
    self.go_unfinish = self:Get('unfinish', 'GameObject')
end

--endregion

--region public methods
function UIHeapRechargeBestGiftTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.curRewardData = data
    self:RefreshView()
end
--endregion

--region private methods

---@private
function UIHeapRechargeBestGiftTemplate:RefreshView()
    luaclass.UIRefresh:RefreshActive(self.go_has_got, self.curRewardData.finish ~= nil and self.curRewardData.finish == 1)
    luaclass.UIRefresh:RefreshActive(self.go_btn_get, self.curRewardData.finish ~= nil and self.curRewardData.finish == 2)
    luaclass.UIRefresh:RefreshActive(self.go_unfinish, self.curRewardData.finish == nil or self.curRewardData.finish == 0)

    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(self.curRewardData.configId)
    if (specialActivityTbl ~= nil) then
        local count = (specialActivityTbl:GetGoal() ~= nil and specialActivityTbl:GetGoal().list ~= nil and #specialActivityTbl:GetGoal().list > 0) and specialActivityTbl:GetGoal().list[1] or 0
        local color = count <= self.curRewardData.dataParam and luaEnumColorType.Green or luaEnumColorType.Red
        luaclass.UIRefresh:RefreshLabel(self.title, string.format('累计充值%s元%s(%s/%s)[-]', count, color, count, self.curRewardData.dataParam))
    end

    if (self.template_reward ~= nil) then
        self.template_reward:SetTemplate(self.curRewardData.configId)
    end
end
--endregion

--region bind event
function UIHeapRechargeBestGiftTemplate:BindEvent()
    luaclass.UIRefresh:BindClickCallBack(self.go_btn_get, function()
        if (self.curRewardData ~= nil) then
            networkRequest.ReqGetOneActivitiesAward(self.curRewardData.configId)
        end
    end)
end
--endregion

--region destroy
--endregion

return UIHeapRechargeBestGiftTemplate