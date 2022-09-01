---@class UIMonsterAttackPanel:UIBase 怪物攻城
local UIMonsterAttackPanel = {}

--region 组件

---@return UnityEngine.GameObject
function UIMonsterAttackPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UnityEngine.GameObject
function UIMonsterAttackPanel:GetBtnTransfer_GameObject()
    if (self.mBtnTransfer_GameObject == nil) then
        self.mBtnTransfer_GameObject = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject");
    end
    return self.mBtnTransfer_GameObject;
end

---@return UILabel
function UIMonsterAttackPanel:GetTitleDes()
    if (self.mGetTitleDes == nil) then
        self.mGetTitleDes = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel");
    end
    return self.mGetTitleDes;
end

---@return UILabel
function UIMonsterAttackPanel:GetDetailDes()
    if (self.mGetDetailDes == nil) then
        self.mGetDetailDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel");
    end
    return self.mGetDetailDes;
end

---@return UILabel
function UIMonsterAttackPanel:GetDorpTitleDes()
    if (self.mDorpTitleDes == nil) then
        self.mDorpTitleDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/dorpTitle", "Top_UILabel");
    end
    return self.mDorpTitleDes;
end

---@return UILabel
function UIMonsterAttackPanel:GetDorpDes()
    if (self.mDorpDes == nil) then
        self.mDorpDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/dorpDes", "Top_UILabel");
    end
    return self.mDorpDes;
end

---@return UILabel
function UIMonsterAttackPanel:GetMonsterDes()
    if (self.mMonsterDes == nil) then
        self.mMonsterDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/monsterDes", "Top_UILabel");
    end
    return self.mMonsterDes;
end

--endregion


--region 初始化

function UIMonsterAttackPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UIMonsterAttackPanel:Show(conditionId,desId)
    if desId ~= nil then
        self.desId = desId
        self:RefreshView(desId)
    end
    if conditionId ~= nil then
        self:GetBtnShow(conditionId)
    else
        self:GetBtnShow(true)
    end
end


function UIMonsterAttackPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIMonsterAttackPanel")
    end
    CS.UIEventListener.Get(self:GetBtnTransfer_GameObject()).onClick = function()
        self:GetBtnClick()
    end
end

function UIMonsterAttackPanel:BindNetMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResActivityMapInfoMessage, UIMonsterAttackPanel.GetNetMsg)
end

--endregion

function UIMonsterAttackPanel:GetNetMsg(id, data)
    UIMonsterAttackPanel.num = gameMgr:GetPlayerDataMgr():GetLuaMonsterAttackMgr():MonsterAttackData()
    UIMonsterAttackPanel:GetMonsterDes().text = UIMonsterAttackPanel.num
end

--region 服务器消息

--endregion

--region 界面显示

function UIMonsterAttackPanel:RefreshView(desId)
    local des = self:GetDesTable(desId)
    if des ~= nil then
        local desData = string.Split(des.value,"&")
        self:GetTitleDes().text = desData[1]
        self:GetDetailDes().text = desData[2]
        self:GetDorpTitleDes().text = desData[3]
        self:GetDorpDes().text = desData[4]
        self.num = gameMgr:GetPlayerDataMgr():GetLuaMonsterAttackMgr():MonsterAttackData()
        if self.num ~= nil then
            self:GetMonsterDes().text = self.num
        else
            self.num = 0
            self:GetMonsterDes().text = self.num
        end
    end
end

function UIMonsterAttackPanel:GetBtnShow(conditionId)
    if conditionId == true then
        self:GetBtnTransfer_GameObject():SetActive(true)
        return
    end
    local isOpen = Utility.IsMainPlayerMatchCondition_LuaAndCS(conditionId)
    self:GetBtnTransfer_GameObject():SetActive(isOpen.success)
end

--endregion

--region 按钮逻辑

function UIMonsterAttackPanel:GetBtnClick()
    if self.num == nil or self.num == 0 then
        Utility.ShowPopoTips(self:GetBtnTransfer_GameObject(), nil, 506)
    else
        networkRequest.ReqRandomDeliverToMonster()
        uimanager:ClosePanel("UIMonsterAttackPanel")
    end

end
--endregion

--region 获取table

function UIMonsterAttackPanel:GetDesTable(id)
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        return info
    end
end

--endregion

return UIMonsterAttackPanel