---@class UIBaHuangEGuPanel : UIBase 通用副本面板
local UIBaHuangEGuPanel = {}

--region  组件

---@return UnityEngine.GameObject
function UIBaHuangEGuPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UILabel
function UIBaHuangEGuPanel:GetTitleDes()
    if (self.mGetTitleDes == nil) then
        self.mGetTitleDes = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel");
    end
    return self.mGetTitleDes;
end

---@return UILabel
function UIBaHuangEGuPanel:GetDetailDes()
    if (self.mGetDetailDes == nil) then
        self.mGetDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel");
    end
    return self.mGetDetailDes;
end

---@return Top_UIGridContainer
function UIBaHuangEGuPanel:GetGrid()
    if (self.mGetGrid == nil) then
        self.mGetGrid = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "Top_UIGridContainer");
    end
    return self.mGetGrid;
end

--endregion

--region 初始化

function UIBaHuangEGuPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UIBaHuangEGuPanel:Show(globalId, descriptionId)
    if self:ConditionClosePanel(74) then
        return
    end
    self.curGlobalId = globalId
    self.curDescriptionID = descriptionId
    self:RefreshView()
end


--- 初始化变量
function UIBaHuangEGuPanel:InitComp()
    local desInfo = self:GetDesTable(self.curDescriptionID).value
    local des = string.Split(desInfo,"&")
    self:GetTitleDes().text = des[1]
    self:GetDetailDes().text = des[2]
end

--- 初始化组件


function UIBaHuangEGuPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIBaHuangEGuPanel")
    end
end

function UIBaHuangEGuPanel:BindNetMessage()

end
--endregion

--region 函数监听

--endregion

--region View

function UIBaHuangEGuPanel:RefreshView()
    self:InitComp()
    self:RefreshGridView()
end


function UIBaHuangEGuPanel:RefreshGridView()
    local getTable = self:GetGlobalTable()
    if getTable == nil then
        return
    end
    local showDuplicate= {}
    for i = 1, #getTable do
        local isfind, tempData = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(tonumber(getTable[i]))
        table.insert(showDuplicate, tempData)
    end
    local temp = {}
    for i = 1, #showDuplicate do
        local isOpen = Utility.IsMainPlayerMatchCondition_LuaAndCS(showDuplicate[i].display)
        if isOpen.success == true then
            table.insert(temp, showDuplicate[i])
        end
    end
    self.allGoAndTemplateDic = {}
    self:GetGrid().MaxCount = #temp
    if #temp == 0 then
        return
    end
    for i = 1, #temp do
        local go = self:GetGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBaHuangEGuTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(temp[i])
        end
    end
end

--endregion

--region 判断是否满足条件

function UIBaHuangEGuPanel:ConditionClosePanel(duplicateType)
    local dic = LuaGlobalTableDeal:ConditionDevilSquarePanelDic()
    if dic == nil or dic[duplicateType] == nil then
        return false
    end
    local list = dic[duplicateType]
    for i = 1, #list do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(list[i]) then
            uimanager:ClosePanel("UIBaHuangEGuPanel")
            return true
        end
    end
    return false
end
--endregion

--region 获取table

function UIBaHuangEGuPanel:GetDesTable(id)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return info
    end
end

function UIBaHuangEGuPanel:GetGlobalTable()
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(self.curGlobalId)
    local temp = string.Split(Lua_GlobalTABLE.value,"#")
    return temp
end
--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UIBaHuangEGuPanel