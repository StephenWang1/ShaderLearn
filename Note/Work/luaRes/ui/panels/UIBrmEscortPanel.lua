---@class UIBrmEscortPanel:UIBase 白日门押镖活动
local UIBrmEscortPanel = {}

--region 数据
---@type string 押镖次数文本格式
UIBrmEscortPanel.YaBiaoDesFormat = "押镖次数%s%s[-]/%s"
---@type string 押镖次数文本格式
UIBrmEscortPanel.PlunderDartDesFormat = "劫镖次数%s%s[-]/%s"
---@type table<number,UIBrmEscortDartCarTemplate>
UIBrmEscortPanel.DartCarTemplates = nil
--endregion

--region 初始化
function UIBrmEscortPanel:Init()
    self:InitComponent()
end

---初始化组件
function UIBrmEscortPanel:InitComponent()
    ---@type UILabel
    self.EscortNum_UILabel = self:GetCurComp("WidgetRoot/view/MainView/Escort/Table1/number","UILabel")
    ---@type UILabel
    self.PlunderDartNum_UILabel = self:GetCurComp("WidgetRoot/view/MainView/Escort/Table2/number","UILabel")
    ---@type UIGridContainer
    self.DartCarList_GridContainer = self:GetCurComp("WidgetRoot/view/MainView/Escort/scroll/Grid","UIGridContainer")
end
--endregion

--region 刷新
function UIBrmEscortPanel:Show()
    self:RefreshEscortNum()
    self:RefreshPlunderNum()
    self:RefreshDartCarList()
    gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():RequestServerData()
end

---刷新押镖次数
function UIBrmEscortPanel:RefreshEscortNum()
    local yaBiaoNum = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().YaBiaoNum
    local yaBiaoNumColor = ternary(yaBiaoNum <= 0,luaEnumColorType.Red,luaEnumColorType.Green)
    local yaBiaoMaxNum = LuaGlobalTableDeal.GetYaBiaoNumMax()
    if yaBiaoNum == nil or yaBiaoMaxNum == nil then
        luaclass.UIRefresh:RefreshActive(self.EscortNum_UILabel,false)
        return
    end
    local des = string.format(self.YaBiaoDesFormat,yaBiaoNumColor,yaBiaoNum,yaBiaoMaxNum)
    luaclass.UIRefresh:RefreshActive(self.EscortNum_UILabel,true)
    luaclass.UIRefresh:RefreshLabel(self.EscortNum_UILabel,des)
end

---刷新劫镖次数
function UIBrmEscortPanel:RefreshPlunderNum()
    local plunderNum = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().PlunderDartNum
    local plunderNumColor = ternary(plunderNum <= 0,luaEnumColorType.Red,luaEnumColorType.Green)
    local plunderDartMaxNum = LuaGlobalTableDeal.GetPlunderNumMax()
    if plunderNum == nil or plunderDartMaxNum == nil then
        luaclass.UIRefresh:RefreshActive(self.PlunderDartNum_UILabel,false)
        return
    end
    local des = string.format(self.PlunderDartDesFormat,plunderNumColor,plunderNum,plunderDartMaxNum)
    luaclass.UIRefresh:RefreshActive(self.PlunderDartNum_UILabel,true)
    luaclass.UIRefresh:RefreshLabel(self.PlunderDartNum_UILabel,des)
end

---刷新镖车列表
function UIBrmEscortPanel:RefreshDartCarList()
    local dartCarList = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():GetConfigDartCarList()
    if dartCarList == nil then
        dartCarList = {}
    end
    luaclass.UIRefresh:RefreshGridContainer(self.DartCarList_GridContainer,dartCarList,function(grid,info)
        if CS.StaticUtility.IsNull(grid) == false then
            ---@type UIBrmEscortDartCarTemplate
            local template = templatemanager.GetNewTemplate(grid,luaComponentTemplates.UIBrmEscortDartCarTemplate)
            ---@type ConfigDartCar
            local configDartCarClass = info
            if template ~= nil then
                local haveOperationDartCar = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():CheckPlayerHaveOptionDartCar()
                local operationDartCar = nil
                if configDartCarClass ~= nil and configDartCarClass.YaBiaoConfigTbl ~= nil then
                    operationDartCar = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():GetOperationDartCarByYaBiaoId(configDartCarClass.YaBiaoConfigTbl:GetId())
                end
                template:RefreshPanel({configDartCarClass = info,haveOperationDartCar = haveOperationDartCar,operationDartCar = operationDartCar})
                if self.DartCarTemplates == nil then
                    self.DartCarTemplates = {}
                end
                if configDartCarClass ~= nil and configDartCarClass.YaBiaoConfigTbl ~= nil then
                    self.DartCarTemplates[configDartCarClass.YaBiaoConfigTbl:GetId()] = template
                end
            end
        end
    end)
end
--endregion

return UIBrmEscortPanel