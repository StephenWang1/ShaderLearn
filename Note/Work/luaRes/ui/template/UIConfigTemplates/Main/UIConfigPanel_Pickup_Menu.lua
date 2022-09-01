---@class UIConfigPanel_Pickup_Menu:TemplateBase
local UIConfigPanel_Pickup_Menu = {}

--region 组件
---@return UIToggle
function UIConfigPanel_Pickup_Menu:GetChooseToggle()
    if self.mChooseToggle == nil then
        self.mChooseToggle = self:Get("Pickup", "UIToggle")
    end
    return self.mChooseToggle
end

---@return UILabel
function UIConfigPanel_Pickup_Menu:GetDes_Lb()
    if self.mDesLb == nil then
        self.mDesLb = self:Get("Label", "UILabel")
    end
    return self.mDesLb
end

---@return UnityEngine.GameObject
function UIConfigPanel_Pickup_Menu:GetDetail_Go()
    if self.mDetailGo == nil then
        self.mDetailGo = self:Get("details", "GameObject")
    end
    return self.mDetailGo
end
--endregion

---@param panel UIConfigPanel_Pickup
function UIConfigPanel_Pickup_Menu:Init(panel)
    self.mRootPanel = panel
    self:BindEvent()
end

---@param data TABLE.cfg_pick_up
function UIConfigPanel_Pickup_Menu:RefreshMenu(data)
    self.data = data
    self.state = false
    if self.mRootPanel and data then
        self.state = self.mRootPanel:IsItemValid(data:GetId(), 0)
    end
    self:SetCurrentState(self.state)
    self:GetDes_Lb().text = data:GetDes()

end

function UIConfigPanel_Pickup_Menu:BindEvent()
    CS.EventDelegate.Add(self:GetChooseToggle().onChange, function()
        local chooseState = self:GetChooseToggle().value
        if chooseState ~= self.mCurrentChooseState then
            self:SetCurrentState(chooseState)
            self:SaveNewState(chooseState)
        end
    end)

    CS.UIEventListener.Get(self:GetDetail_Go()).onClick = function()
        if self.mRootPanel and self.data then
            self.mRootPanel:SelectDetail(self.data:GetId(), self.data:GetDes())
        end
    end
end

---设置当前状态
function UIConfigPanel_Pickup_Menu:SetCurrentState(isChoose)
    if self:GetChooseToggle().value ~= isChoose then
        self:GetChooseToggle():Set(isChoose)
    end
    self.mCurrentChooseState = isChoose
end

---存储当前状态
function UIConfigPanel_Pickup_Menu:SaveNewState(chooseState)
    if self.mRootPanel and self.data then
        self.mRootPanel:SaveNewMenuState(self.data:GetId(), 0, chooseState)
        self:ChangeSubTypeListChooseState(chooseState)
    end
end

---存储并修改子类列表选择状态
---@param chooseState boolean
function UIConfigPanel_Pickup_Menu:ChangeSubTypeListChooseState(chooseState)
    if self.mRootPanel == nil or self.data == nil then
        return
    end
    local itemIdList = clientTableManager.cfg_itemsManager:GetPickTypeItemList(self.data:GetId())
    if type(itemIdList) == 'table' then
        for k,v in pairs(itemIdList) do
            self.mRootPanel:SaveNewMenuState(v, self.data:GetId(), chooseState)
        end
    end
    if self.mRootPanel.mCurrentChooseMenuId == self.data:GetId() then
        luaclass.UIRefresh:RefreshLoopScrollViewPlusCurPage(self.mRootPanel:GetDetail_Loop())
    end
end

return UIConfigPanel_Pickup_Menu