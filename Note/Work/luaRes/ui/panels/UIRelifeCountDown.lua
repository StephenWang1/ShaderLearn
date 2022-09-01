---@class UIRelifeCountDown:UIBase 通用场景倒计时面板
local UIRelifeCountDown = {}

--region 数据
---@type table<UnityEngine.GameObject,UIRelifeCountDownTemplate>
UIRelifeCountDown.AllCountDownTemplate = nil
--endregion

--region 初始化
function UIRelifeCountDown:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIRelifeCountDown:InitComponent()
    ---@type UIGridContainer
    self.grid_UIGridContainer = self:GetCurComp("ShowTime/Grid","UIGridContainer")
end

function UIRelifeCountDown:BindEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityEndCountDownOpen, function()
        local countDownPackageList = luaclass.ActivityEndCountDownData:GetHintCountDownPackageList()
        self:RefreshCountDownList(countDownPackageList)
    end)
end
--endregion

--region 刷新
---@param countDownPackageList table<CountDownEndPackage> 倒计时结束包列表
function UIRelifeCountDown:RefreshCountDownList(countDownPackageList)
    luaclass.UIRefresh:RefreshGridContainer(self.grid_UIGridContainer,countDownPackageList,function(grid,info)
        if self.AllCountDownTemplate == nil then
            self.AllCountDownTemplate = {}
        end
        local countDownTemplate = self.AllCountDownTemplate[grid]
        if countDownTemplate == nil then
            countDownTemplate = templatemanager.GetNewTemplate(grid,luaComponentTemplates.UIRelifeCountDownTemplate)
        end
        if countDownTemplate ~= nil then
            countDownTemplate:RefreshCountDown(info)
            self.AllCountDownTemplate[grid] = countDownTemplate
        end
    end)
end

function update()
    UIRelifeCountDown:OnUpdate()
end

function UIRelifeCountDown:OnUpdate()
    if type(self.AllCountDownTemplate) ~= 'table' or Utility.GetLuaTableCount(self.AllCountDownTemplate) <= 0 then
        return
    end
    for k,v in pairs(self.AllCountDownTemplate) do
        ---@type UIRelifeCountDownTemplate
        local singleCountDownTemplate = v
        singleCountDownTemplate:UpdateRefreshCountDown()
    end
end
--endregion

return UIRelifeCountDown