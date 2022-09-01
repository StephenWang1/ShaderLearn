---@class UIAppearancePanelAppellationViewTemplate:TemplateBase
local UIAppearancePanelAppellationViewTemplate = {}

--region 初始化

function UIAppearancePanelAppellationViewTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:InitParameters()
end
--初始化变量
function UIAppearancePanelAppellationViewTemplate:InitParameters()
    self.infoTemplate = templatemanager.GetNewTemplate(self.appellationInfo, luaComponentTemplates.UIAppellationInfoTemplate)
    --当前选中的id
    self.curAppellationId = 0
    --当前选中的模块
    self.curTemplate = nil
    --当前按钮的启动状态
    self.btnState = false
    --称谓模板表
    self.itemTemplateDic = {}
end

function UIAppearancePanelAppellationViewTemplate:InitComponents()
    ---@type UnityEngine.GameObject 信息
    self.appellationInfo = self:Get("AppellationInfo", "GameObject")
    ---@type Top_UIGridContainer 称谓列表
    self.grid = self:Get("ScrollView/Grid", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 按钮
    self.stateButton = self:Get("StateButton", "GameObject")
    ---@type Top_UILabel 按钮文本
    self.StateLabel = self:Get("StateButton/StateLabel", "Top_UILabel")
end

function UIAppearancePanelAppellationViewTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.stateButton).LuaEventTable = self
    CS.UIEventListener.Get(self.stateButton).OnClickLuaDelegate = self.OnStateBtnClick
end

function UIAppearancePanelAppellationViewTemplate:BindNetMessage()

end

--endregion

--region UI函数监听

function UIAppearancePanelAppellationViewTemplate:OnStateBtnClick(go)
    networkRequest.ReqEnableTitle(self.curAppellationId, self.btnState and 2 or 1)
end

--endregion

--region UI

function UIAppearancePanelAppellationViewTemplate:SetGoActive(isOpen)
    self.go:SetActive(isOpen)
    if isOpen then
        --初始化
        self:RefreshGrid()
        self:ClickTempCallBack()
        self:RefreshInfoView()
        self:RefreshBtnType()
    end
end

---刷新列表
function UIAppearancePanelAppellationViewTemplate:RefreshGrid()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil then
        local appearanceData = CS.CSScene.MainPlayerInfo.Appearance.AppearanceData
        local appellationList = appearanceData.AppellationList
        local appellationID = appearanceData.CurAppellationID
        local length = appellationList.Count
        self.grid.MaxCount = length
        for i = 0, length - 1 do
            local go = self.grid.controlList[i]
            local template = self.itemTemplateDic[go] ~= nil and self.itemTemplateDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAppellationUnitTemplate)
            local temp = {}
            temp.text = appellationList[i].titleDes
            temp.index = i
            local isFind, info = CS.Cfg_AppellationTableManager.Instance.dic:TryGetValue(appellationList[i].titleId)
            if isFind then
                temp.spriteName = info.showImg
                temp.id = info.id
                temp.isShowBtn = info.canChange ~= nil and info.canChange == 1
                if appellationList[i].titleId == appearanceData.CurAppellationID or i == 0 then
                    self.curTemplate = template
                    self.curAppellationId = appellationList[i].titleId
                end
            end
            temp.isUsed = appellationID == appellationList[i].titleId
            temp.CallBack = function()
                self.curTemplate = template
                self.curAppellationId = appellationList[i].titleId
                self:ClickTempCallBack()
                self:RefreshInfoView()
                self:RefreshBtnType()
            end
            template:SetTemplate(temp)
            if self.itemTemplateDic[go] == nil then
                self.itemTemplateDic[go] = template
            end
        end
    end
end

---刷新下方描述信息
function UIAppearancePanelAppellationViewTemplate:RefreshInfoView()
    if self.infoTemplate then
        local text
        if self.curTemplate ~= nil and self.curTemplate.data ~= nil then
            text = self.curTemplate.data.text
        end
        self.infoTemplate:SetTemplate({ id = self.curAppellationId, text = text })
    end
end

---点击刷新选中框
function UIAppearancePanelAppellationViewTemplate:ClickTempCallBack()
    if self.curTemplate == nil then
        return
    end
    for i, v in pairs(self.itemTemplateDic) do
        v:RefreshEffectShow(v.id == self.curTemplate.id)
    end
end

function UIAppearancePanelAppellationViewTemplate:OnResAppellationStateChangeMessageReceived()
    self:RefreshGrid()
    self:RefreshBtnType()
    if self.curTemplate ~= nil then
        self.curTemplate:RefreshEffectShow(true)
    end
end

---刷新按钮的状态
function UIAppearancePanelAppellationViewTemplate:RefreshBtnType()
    local appearanceData = CS.CSScene.MainPlayerInfo.Appearance.AppearanceData
    self.btnState = self.curAppellationId == appearanceData.CurAppellationID
    self.StateLabel.text = self.btnState and '停用称谓' or '启用称谓'
end

--endregion

return UIAppearancePanelAppellationViewTemplate