---@class UIHotRepairPanel
local UIHotRepairPanel = {}

function UIHotRepairPanel:InitComponents()
    ---检测面板
    self.Check = self:GetCurComp("root/Check", "GameObject")
    ---选择面板
    self.Select = self:GetCurComp("root/Select", "GameObject")
    ---检测完成面板
    self.completePanel = self:GetCurComp("root/completePanel", "GameObject")
    ---检测进度
    self.updatelabel = self:GetCurComp("root/Check/updatelabel", "Top_UILabel")
    ---检测进度条
    self.updateslider = self:GetCurComp("root/Check/updateslider", "Top_UISlider")
    ---检测进度条
    self.BG = self:GetCurComp("root/BG", "GameObject")

    ---检测进度
    self.allcheck = self:GetCurComp("root/Select/allcheck", "GameObject")
    ---检测进度
    self.fastCheck = self:GetCurComp("root/Select/fastCheck", "GameObject")
    ---检测完成面板按钮
    self.completeBtn = self:GetCurComp("root/completePanel/completeBtn", "GameObject")
    ---关闭
    self.Close = self:GetCurComp("root/Select/Close", "GameObject")
    ---确认面板
    self.AllRepairPromptPanel = self:GetCurComp("root/AllRepairPromptPanel", "GameObject")
    ---确认面板确认按钮
    self.AllRepairPromptPanel_completeBtn = self:GetCurComp("root/AllRepairPromptPanel/completeBtn", "GameObject")
    ---确认面板关闭按钮
    self.AllRepairPromptPanel_mask = self:GetCurComp("root/AllRepairPromptPanel/Close", "GameObject")

    CS.UIEventListener.Get(self.Close.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Close.gameObject).OnClickLuaDelegate = self.OnClickBG

    CS.UIEventListener.Get(self.allcheck.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.allcheck.gameObject).OnClickLuaDelegate = self.OnClickAllcheck

    CS.UIEventListener.Get(self.fastCheck.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.fastCheck.gameObject).OnClickLuaDelegate = self.OnClickFastCheck

    CS.UIEventListener.Get(self.completeBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.completeBtn.gameObject).OnClickLuaDelegate = self.OnClickCompleteBtn

    CS.UIEventListener.Get(self.AllRepairPromptPanel_completeBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.AllRepairPromptPanel_completeBtn.gameObject).OnClickLuaDelegate = self.OnClickCompletePanel_completeBtn

    CS.UIEventListener.Get(self.AllRepairPromptPanel_mask.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.AllRepairPromptPanel_mask.gameObject).OnClickLuaDelegate = self.OnClickCompletePanel_mask
end

---初始化数据
function UIHotRepairPanel:Init()
    self:InitComponents()
    self.Select.gameObject:SetActive(true)
    HotCheckout.MaxSchedule = 0
    HotCheckout.NowSchedule = 0
    self.Close.gameObject:SetActive(true)
end

function update()
    if HotCheckout.MaxSchedule ~= 0 and HotCheckout.MaxSchedule ~= nil then
        local index = HotCheckout.NowSchedule / HotCheckout.MaxSchedule
        local schedule = (math.ceil(index * 10000)) / 100
        UIHotRepairPanel.updatelabel.text = "检测进度  " .. tostring(schedule) .. "%"
        UIHotRepairPanel.updateslider.sliderValue = index
        if index >= 1 then
            UIHotRepairPanel.completePanel.gameObject:SetActive(true)
        end
    end

end

function UIHotRepairPanel.OnClickBG()
    uimanager:ClosePanel("UIHotRepairPanel")
end

function UIHotRepairPanel:OnClickAllcheck()
    self.Check.gameObject:SetActive(false)
    self.Select.gameObject:SetActive(false)
    self.Close.gameObject:SetActive(false)
    self.AllRepairPromptPanel.gameObject:SetActive(true)

end
function UIHotRepairPanel:OnClickFastCheck()
    self.Check.gameObject:SetActive(true)
    self.Select.gameObject:SetActive(false)
    self.Close.gameObject:SetActive(false)
    HotCheckout:CheckoutRes(false)
end

function UIHotRepairPanel:OnClickCompleteBtn()
    uimanager:ClosePanel("UIHotRepairPanel")
    CS.SDKManager.GameInterface:RestartApplication()
end

---点击全部更新确认按钮
function UIHotRepairPanel:OnClickCompletePanel_completeBtn()
    self.Check.gameObject:SetActive(true)
    self.AllRepairPromptPanel.gameObject:SetActive(false)
    HotCheckout:CheckoutRes(true)
end

function UIHotRepairPanel:OnClickCompletePanel_mask()
    uimanager:ClosePanel("UIHotRepairPanel")
end

return UIHotRepairPanel