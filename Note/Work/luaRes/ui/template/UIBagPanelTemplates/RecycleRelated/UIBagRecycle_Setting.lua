---@class UIBagRecycle_Setting:TemplateBase
local UIBagRecycle_Setting = {}

--region 初始化
function UIBagRecycle_Setting:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
end

function UIBagRecycle_Setting:InitComponent()
    self.Grid_GridContainer = self:Get("ScrollView/Grid", "UIGridContainer")
    self.CloseBtn_GameObject = self:Get("box", "GameObject")
end

function UIBagRecycle_Setting:InitParams()
    self.isRefresh = false
    self.bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    self.optionTable = {}
end

function UIBagRecycle_Setting:BindEvents()
    CS.UIEventListener.Get(self.CloseBtn_GameObject).onClick = function()
        self:ClosePanel()
    end
end
--endregion

--region 刷新
function UIBagRecycle_Setting:RefreshPanel(recyclePanel)
    if self.isRefresh == false then
        self.isRefresh = true
        ---@type UIBagMain_Recycle
        self.recyclePanel = recyclePanel
        local recycleSettingOptionList = CS.Cfg_RecoverSetTableManager.Instance.ShowRecycleSettingOptionList
        if recycleSettingOptionList ~= nil then
            local length = recycleSettingOptionList.Count - 1
            if self.Grid_GridContainer ~= nil then
                self.Grid_GridContainer.MaxCount = recycleSettingOptionList.Count
            end
            for k = 0, length do
                local recycleOptionBtn = self.Grid_GridContainer.controlList[k]
                ---@type RecycleSettingOption
                local recycleSettingOptionInfo = recycleSettingOptionList[k]
                local optionTemplate = templatemanager.GetNewTemplate(recycleOptionBtn, luaComponentTemplates.UIBagRecycle_SettingOption)
                optionTemplate:RefreshPanel({ recycleSettingOptionInfo = recycleSettingOptionInfo, uiBagRecycleSetting = self })
                self.optionTable[recycleOptionBtn] = optionTemplate
            end
        end
    end
    self:OpenPanel()
end
--endregion

--region 重置选项
---刷新指定选项类型的选项状态
function UIBagRecycle_Setting:ResetOptionUIChooseState(optionId)
    if self.optionTable ~= nil then
        for k, v in pairs(self.optionTable) do
            if v.optionId == optionId then
                v:RefreshCheckState(false,true)
            end
        end
    end
end

---重置所有选项类型的状态
function UIBagRecycle_Setting:ResetAllOptionChooseState()
    if self.optionTable ~= nil then
        for k, v in pairs(self.optionTable) do
            v:RefreshCheckState(v.defaultChooseState)
        end
    end
end
--endregion

function UIBagRecycle_Setting:OpenPanel()
    self.go:SetActive(true)
end

function UIBagRecycle_Setting:ClosePanel()
    self.go:SetActive(false)
end

function UIBagRecycle_Setting:OnDestroy()
    CS.Cfg_RecoverSetTableManager.Instance:ClearAllShowSettingOption()
end

return UIBagRecycle_Setting