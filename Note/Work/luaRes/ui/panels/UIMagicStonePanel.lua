local UIMagicStonePanel = {}

--region 参数
function UIMagicStonePanel:GetCSBagInfo()
    return CS.CSScene.MainPlayerInfo.BagInfo
end
--endregion

--region 初始化
function UIMagicStonePanel:Init()
    self:BindEvents()
end

function UIMagicStonePanel:BindEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if self.template ~= nil then
            self.template:RefreshCurPanel()
        end
    end)
end
--endregion

--region 刷新
function UIMagicStonePanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
    end
    self.template = templatemanager.GetNewTemplate(self.go,self.panelTemplate)
    if self.template == nil then
        return
    end
    self.template:RefreshPanel(self.commonData)
end

---解析数据
---@param 通用数据
---@return 是否解析成功
function UIMagicStonePanel:AnalysisParams(commonData)
    if commonData == nil then
        return false
    end
    self.bagItemInfoList = commonData.bagItemInfoList
    self.itemInfo = commonData.itemInfo
    if self.bagItemInfoList == nil and self.itemInfo ~= nil then
        self.bagItemInfoList = self:GetCSBagInfo():GetBagItemInfoListByItemId(self.itemInfo.id)
    end
    if self.bagItemInfoList == nil or self.bagItemInfoList.Count <= 0 then
        return false
    end
    self.itemInfo = self.bagItemInfoList[0].ItemTABLE
    self.bagItemCount = self.bagItemInfoList.Count
    self.panelTemplate = ternary(commonData.panelTemplate == nil,self:GetTemplateByItemInfo(self.itemInfo),commonData.panelTemplate)
    if self.panelTemplate == nil then
        return false
    end
    self.commonData = commonData
    self.commonData.bagItemInfoList = self.bagItemInfoList
    return true
end
--endregion

--region 获取
function UIMagicStonePanel:GetTemplateByItemInfo(itemInfo)
    if itemInfo == nil then
        return nil
    end
    if itemInfo.type == luaEnumItemType.Assist then
        ---@type ItemUsePanelTemplate_Normal
        return luaComponentTemplates.ItemUsePanelTemplate_Normal
    end
end
--endregion
return UIMagicStonePanel