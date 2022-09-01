---@class UISexMasterPanel : UIBase 通用副本面板
local UISexMasterPanel = {}

--region  组件

function UISexMasterPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UISexMasterPanel:GetBtnHelp_GameObject()
    if (self.mGetBtnHelp_GameObject == nil) then
        self.mGetBtnHelp_GameObject = self:GetCurComp("WidgetRoot/btn_help", "GameObject");
    end
    return self.mGetBtnHelp_GameObject;
end

---@return UILabel
function UISexMasterPanel:GetTitleDes()
    if (self.mGetTitleDes == nil) then
        self.mGetTitleDes = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel");
    end
    return self.mGetTitleDes;
end

---@return UILabel
function UISexMasterPanel:GetDetailDes()
    if (self.mGetDetailDes == nil) then
        self.mGetDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel");
    end
    return self.mGetDetailDes;
end

---@return UILabel
function UISexMasterPanel:GetCondition()
    if (self.mGetCondition == nil) then
        self.mGetCondition = self:GetCurComp("WidgetRoot/introduce/labelGroup/condition", "Top_UILabel");
    end
    return self.mGetCondition;
end

---@return UILabel
function UISexMasterPanel:GetConditionDes()
    if (self.mGetConditionDes == nil) then
        self.mGetConditionDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/conditionDes", "Top_UILabel");
    end
    return self.mGetConditionDes;
end

---@return UILabel
function UISexMasterPanel:GetCostNum()
    if (self.mGetCostNum == nil) then
        self.mGetCostNum = self:GetCurComp("WidgetRoot/cost/num", "Top_UILabel");
    end
    return self.mGetCostNum;
end

---@return UISprite
function UISexMasterPanel:GetCostIcon()
    if (self.mGetCostIcon == nil) then
        self.mGetCostIcon = self:GetCurComp("WidgetRoot/cost/icon", "Top_UISprite");
    end
    return self.mGetCostIcon;
end

---@return Top_UIGridContainer
function UISexMasterPanel:GetGrid()
    if (self.mGetGrid == nil) then
        self.mGetGrid = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "Top_UIGridContainer");
    end
    return self.mGetGrid;
end

--endregion

--region 初始化

function UISexMasterPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

---index 1:为更换性别 2:更换职业
function UISexMasterPanel:Show(index)
    self.index = index
    local desTbl
    if index == 1 then
        desTbl = self:GetDesTable(239)
        self:GetSexGridBtn()
    elseif index == 2 then
        desTbl = self:GetDesTable(240)
        self:GetCareerGridBtn()
    else
        uimanager:ClosePanel("UISexMasterPanel")
        return
    end
    self:GetCost(index)
    if desTbl ~= nil then
        local des = string.Split(desTbl.value,"&")
        self:RefreshView(des)
    end
end


--- 初始化变量
function UISexMasterPanel:InitComp()

end

--- 初始化组件


function UISexMasterPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UISexMasterPanel")
    end
    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        self:ShowHelpPanel()
    end
end

function UISexMasterPanel:BindNetMessage()

end
--endregion

--region 点击事件
function UISexMasterPanel:ShowHelpPanel()
    local data = {}
    if self.index == 1 then
        data.id = 242
    elseif self.index == 2 then
        data.id = 243
    end
    Utility.ShowHelpPanel(data)
end

function UISexMasterPanel:ChangeSexOnClick(go)
    local cost = self:GetGlobalTable(23029)
    local temp = {}
    temp.ID = 165
    temp.IsClose = false
    temp.IsShowGoldLabel = true
    temp.GoldIcon = tonumber(cost[1])
    temp.GoldCount = self.isHave and cost[2] or luaEnumColorType.Red .. cost[2]
    temp.CallBack = function()
        if self.isHave == true then
            uimanager:ClosePanel('UIPromptPanel')
            networkRequest.ReqTransferSex()
        else
            local panel = uimanager:GetPanel("UIPromptPanel")
            Utility.ShowPopoTips(panel.mRightButton_GameObject, nil,489)
        end
    end
    temp.CancelCallBack = function()
        uimanager:ClosePanel('UIPromptPanel')
    end
    uimanager:CreatePanel("UIPromptPanel", nil, temp)
end

function UISexMasterPanel:ChangeCareerOnClick(index, go)
    local cost = self:GetGlobalTable(23030)
    local temp = {}
    temp.ID = 167
    temp.IsClose = false
    temp.IsShowGoldLabel = true
    temp.GoldIcon = tonumber(cost[1])
    temp.GoldCount = self.isHave and cost[2] or luaEnumColorType.Red .. cost[2]
    temp.CallBack = function()
        if self.isHave == true then
            uimanager:ClosePanel('UIPromptPanel')
            networkRequest.ReqTransferCareer(index)
        else
            local panel = uimanager:GetPanel("UIPromptPanel")
            Utility.ShowPopoTips(panel.mRightButton_GameObject, nil,489)
        end
    end
    temp.CancelCallBack = function()
        uimanager:ClosePanel('UIPromptPanel')
    end
    uimanager:CreatePanel("UIPromptPanel", nil, temp)
end

--endregion

--region View

---转性grid按钮
function UISexMasterPanel:GetSexGridBtn()
    self:GetGrid().MaxCount = 1
    local go = self:GetGrid().controlList[0]
    if go == nil then
        return
    end
    local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('TitleName'), "Top_UILabel")
    if btnLabel then
        btnLabel.text = "变更性别"
    end
    CS.UIEventListener.Get(go).onClick = function()
        self:ChangeSexOnClick(go)
    end
end

---转职grid按钮
function UISexMasterPanel:GetCareerGridBtn()
    local temp = {}
    local zhanshi = {}
    table.insert(zhanshi,"战士")
    table.insert(zhanshi,1)
    local fashi = {}
    table.insert(fashi,"法师")
    table.insert(fashi,2)
    local daoshi ={}
    table.insert(daoshi,"道士")
    table.insert(daoshi,3)

    table.insert(temp,zhanshi)
    table.insert(temp,fashi)
    table.insert(temp,daoshi)

    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    table.remove(temp, career)
    self:GetGrid().MaxCount = 2
    for i = 1, 2 do
        local go = self:GetGrid().controlList[i - 1]
        if go == nil then
            return
        end
        local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('TitleName'), "Top_UILabel")
        if btnLabel then
            btnLabel.text = "变更职业—"..temp[i][1]
        end
        CS.UIEventListener.Get(go).onClick = function()
            self:ChangeCareerOnClick(temp[i][2], go)
        end

    end
end

function UISexMasterPanel:RefreshView(des)
    if des ~= nil then
        self:GetTitleDes().text = des[1]
        self:GetDetailDes().text = des[2]
        self:GetCondition().text = des[3]
        local desName = string.gsub(des[4],'\\n', '\n')
        self:GetConditionDes().text = desName
    end
end

function UISexMasterPanel:GetCost(index)
    local cost
    if index == 1 then
        cost = self:GetGlobalTable(23029)
    elseif index == 2 then
        cost = self:GetGlobalTable(23030)
    end
    if cost == nil then
        return
    end
    local curHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(tonumber(cost[1]))
    self.isHave = curHave >= tonumber(cost[2])
    self:GetCostNum().text = self.isHave and cost[2] or luaEnumColorType.Red .. cost[2]
    self:GetCostIcon().spriteName = tonumber(cost[1])
end
--endregion

--region 获取table

function UISexMasterPanel:GetDesTable(id)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return info
    end
end

function UISexMasterPanel:GetGlobalTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    if Lua_GlobalTABLE == nil then
        return nil
    end
    local temp = string.Split(Lua_GlobalTABLE.value,"#")
    return temp
end

--endregion

--region ondestroy

function ondestroy()

end

--endregion

return UISexMasterPanel