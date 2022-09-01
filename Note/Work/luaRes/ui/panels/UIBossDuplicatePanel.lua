---@class UIBossDuplicatePanel : UIBase 通用副本面板
local UIBossDuplicatePanel = {}

--region  组件

---@return UnityEngine.GameObject
function UIBossDuplicatePanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UILabel
function UIBossDuplicatePanel:GetTitleDes()
    if (self.mGetTitleDes == nil) then
        self.mGetTitleDes = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel");
    end
    return self.mGetTitleDes;
end

---@return UILabel
function UIBossDuplicatePanel:GetDetailDes()
    if (self.mGetDetailDes == nil) then
        self.mGetDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel");
    end
    return self.mGetDetailDes;
end

---@return UILabel
function UIBossDuplicatePanel:GetMapTitleDes()
    if (self.mGetTimeDetailDes == nil) then
        self.mGetTimeDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/maptitle", "Top_UILabel");
    end
    return self.mGetTimeDetailDes;
end

---@return UILabel
function UIBossDuplicatePanel:GetDes()
    if (self.mGetDes == nil) then
        self.mGetDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/Des", "Top_UILabel");
    end
    return self.mGetDes;
end

---@return Top_UIGridContainer
function UIBossDuplicatePanel:GetGrid()
    if (self.mGetGrid == nil) then
        self.mGetGrid = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "Top_UIGridContainer");
    end
    return self.mGetGrid;
end

--endregion

--region 初始化

function UIBossDuplicatePanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UIBossDuplicatePanel:Show(duplicateId, descriptionId)
    if self:ConditionClosePanel(duplicateId) then
        return
    end
    self.duplicateId = duplicateId
    self.descriptionId = descriptionId
    self:RefreshUI()
    self:RefreshGrid()
end

--- 初始化组件
function UIBossDuplicatePanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIBossDuplicatePanel")
    end
end

function UIBossDuplicatePanel:BindNetMessage()

end
--endregion

--region 函数监听

--endregion

--region View

function UIBossDuplicatePanel:RefreshUI()
    if self.descriptionId == nil then
        return
    end
    local desData = self:GetDesTable(self.descriptionId).value
    local des = string.Split(desData,"&")
    self:GetTitleDes().text = des[1]
    self:GetDetailDes().text = des[2]
    self:GetMapTitleDes().text = des[3]
    local name = string.gsub(des[4],'\\n', '\n')
    self:GetDes().text = name
end

function UIBossDuplicatePanel:RefreshGrid()
    if self.duplicateId == nil then
        return
    end
    local DuplicateList = CS.Cfg_DuplicateTableManager.Instance:GetDuplicateInfoListByDuplicateType(self.duplicateId)
    if DuplicateList == nil then
        return
    end
    self.allGoAndTemplateDic = {}
    self:GetGrid().MaxCount = DuplicateList.Count
    for i = 0, DuplicateList.Count - 1 do
        local go = self:GetGrid().controlList[i]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBossDuplicateTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(DuplicateList[i])
        end
    end
end

--endregion

--region 判断是否满足条件

function UIBossDuplicatePanel:ConditionClosePanel(duplicateType)
    local dic = LuaGlobalTableDeal:ConditionDevilSquarePanelDic()
    if dic == nil or dic[duplicateType] == nil then
        return false
    end
    local list = dic[duplicateType]
    for i = 1, #list do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(list[i]) then
            uimanager:ClosePanel("UIBossDuplicatePanel")
            return true
        end
    end
    return false
end
--endregion

--region 获取table

function UIBossDuplicatePanel:GetDesTable(id)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return info
    end
end

function UIBossDuplicatePanel:GetGlobalTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    local temp = string.Split(Lua_GlobalTABLE.value,"#")
    return temp
end

--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UIBossDuplicatePanel