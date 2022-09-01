---@class UIOpenPanel:UIBase
local UIOpenPanel = {}

UIOpenPanel.PanelLayerType = CS.UILayerType.BasicPlane

function UIOpenPanel:InitComponents()
    ---左侧面板
    UIOpenPanel.left = self:GetCurComp("left", "GameObject")
    ---左侧面板背景板
    UIOpenPanel.lb_bg = self:GetCurComp("left/bg", "GameObject")
    ---功能描述1
    UIOpenPanel.lb_content = self:GetCurComp("left/lb_content", "Top_UILabel")
    ---功能描述2
    UIOpenPanel.lb_content2 = self:GetCurComp("left/lb_content2", "Top_UILabel")

    ---中间面板
    UIOpenPanel.centrePanel = self:GetCurComp("centrePanel", "GameObject")
    ---面板标题
    UIOpenPanel.lb_title = self:GetCurComp("centrePanel/lb_title", "Top_UILabel")
    ---面板描述
    UIOpenPanel.lb_dec = self:GetCurComp("centrePanel/lb_dec", "Top_UILabel")
    ---中间面板BG
    UIOpenPanel.centrePanelBG = self:GetCurComp("centrePanel/window/mainBg", "GameObject")

end
function UIOpenPanel:InitOther()
    UIOpenPanel.Notice = nil
    CS.UIEventListener.Get(UIOpenPanel.lb_bg).onClick = UIOpenPanel.OpenCentrePanel
    CS.UIEventListener.Get(UIOpenPanel.centrePanelBG).onClick = UIOpenPanel.CloseCentrePanel
    --  UIOpenPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel, UIOpenPanel.RefreshUI)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.SystemOpenReminderMessage, UIOpenPanel.RefreshUI)
end

function UIOpenPanel:Init()
    self:InitComponents()
    self:InitOther()
    self:RefreshUI(0, CS.CSScene.MainPlayerInfo.OpenSystemTipInfo)

end

function UIOpenPanel:RefreshUI(id, data)
    if data == nil then
        UIOpenPanel.left.gameObject:SetActive(false)
        return
    end
    local isfind, notice = CS.Cfg_NoticeTableManager.Instance:TryGetValue(data.configId);
    if isfind then
        UIOpenPanel.Notice = notice
    else
        UIOpenPanel.Notice = nil
    end
    if UIOpenPanel.Notice == nil then
        UIOpenPanel.left.gameObject:SetActive(false)
    else
        UIOpenPanel.left.gameObject:SetActive(true)
        UIOpenPanel.lb_content.text = CS.Cfg_GlobalTableManager.Instance:LevelForeshow(data.levelDiffer, UIOpenPanel.Notice.remarks);
        UIOpenPanel.lb_dec.text = ''
        UIOpenPanel.lb_title.text = UIOpenPanel.Notice.remarks
    end
end

---打开中间面板
function UIOpenPanel.OpenCentrePanel()
    UIOpenPanel.centrePanel.gameObject:SetActive(true)

end

---关闭中间面板
function UIOpenPanel.CloseCentrePanel()
    UIOpenPanel.centrePanel.gameObject:SetActive(false)
end

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.SystemOpenReminderMessage, UIOpenPanel.RefreshUI)
end
return UIOpenPanel