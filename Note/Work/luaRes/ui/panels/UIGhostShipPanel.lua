---@class UIGhostShipPanel : UIBase 通用副本面板
local UIGhostShipPanel = {}

--region  组件

---@return UnityEngine.GameObject
function UIGhostShipPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UILabel
function UIGhostShipPanel:GetTitleDes()
    if (self.mGetTitleDes == nil) then
        self.mGetTitleDes = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel");
    end
    return self.mGetTitleDes;
end

---@return UILabel
function UIGhostShipPanel:GetDetailDes()
    if (self.mGetDetailDes == nil) then
        self.mGetDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel");
    end
    return self.mGetDetailDes;
end

---@return UILabel
function UIGhostShipPanel:GetTimeDetailDes()
    if (self.mGetTimeDetailDes == nil) then
        self.mGetTimeDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/title", "Top_UILabel");
    end
    return self.mGetTimeDetailDes;
end

---@return Top_UIGridContainer
function UIGhostShipPanel:GetGrid()
    if (self.mGetGrid == nil) then
        self.mGetGrid = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "Top_UIGridContainer");
    end
    return self.mGetGrid;
end

--endregion

--region 初始化

function UIGhostShipPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UIGhostShipPanel:Show(globalId, descriptionId)
    if self:ConditionClosePanel(75) then
        return
    end
    self.globalId = globalId
    self.descriptionId = descriptionId
    self:RefreshUI()
    self:RefreshGrid()
end

--- 初始化组件
function UIGhostShipPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIGhostShipPanel")
    end
end

function UIGhostShipPanel:BindNetMessage()

end
--endregion

--region 函数监听

--endregion

--region View

function UIGhostShipPanel:RefreshUI()
    if self.descriptionId == nil then
        return
    end
    local desData = self:GetDesTable(self.descriptionId).value
    local des = string.Split(desData,"&")
    self:GetTitleDes().text = des[1]
    self:GetDetailDes().text = des[2]
    local name = string.gsub(des[3],'\\n', '\n')
    self:GetTimeDetailDes().text = name
end

function UIGhostShipPanel:RefreshGrid()
    if self.globalId == nil then
        return
    end
    local getTable = self:GetGlobalTable(self.globalId)
    if getTable == nil then
        return
    end
    local showDuplicate= {}
    for i = 1, #getTable do
        local isfind, tempData = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(tonumber(getTable[i]))
        if isfind then
            table.insert(showDuplicate, tempData)
        end
    end
    self.allGoAndTemplateDic = {}
    self:GetGrid().MaxCount = #showDuplicate
    if #showDuplicate == 0 then
        return
    end
    for i = 1, #showDuplicate do
        local go = self:GetGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGhostShipTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(showDuplicate[i])
        end
    end
end

--endregion

--region 判断是否满足条件

function UIGhostShipPanel:ConditionClosePanel(duplicateType)
    local dic = LuaGlobalTableDeal:ConditionDevilSquarePanelDic()
    if dic == nil or dic[duplicateType] == nil then
        return false
    end
    local list = dic[duplicateType]
    for i = 1, #list do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(list[i]) then
            uimanager:ClosePanel("UIGhostShipPanel")
            return true
        end
    end
    return false
end
--endregion

--region 获取table

function UIGhostShipPanel:GetDesTable(id)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return info
    end
end

function UIGhostShipPanel:GetGlobalTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    local temp = string.Split(Lua_GlobalTABLE.value,"#")
    return temp
end

--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UIGhostShipPanel