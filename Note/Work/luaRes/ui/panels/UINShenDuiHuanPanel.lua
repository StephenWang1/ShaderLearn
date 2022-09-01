local UINShenDuiHuanPanel = {}

function UINShenDuiHuanPanel:Init()
    self:InitComponents()
    self:InitOther()
end
-- 控件变量
function UINShenDuiHuanPanel:InitComponents()
    UINShenDuiHuanPanel.Cost = self:GetCurComp("WidgetRoot/Cost", "GameObject")
    UINShenDuiHuanPanel.CloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    UINShenDuiHuanPanel.EnterBtn = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    UINShenDuiHuanPanel.value = self:GetCurComp("WidgetRoot/Cost/value", "Top_UILabel")


end
--初始化 变量 按钮点击 服务器消息事件等
function UINShenDuiHuanPanel:InitOther()
    CS.UIEventListener.Get(UINShenDuiHuanPanel.CloseBtn).onClick = UINShenDuiHuanPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UINShenDuiHuanPanel.EnterBtn).onClick = UINShenDuiHuanPanel.OnClickEnterBtn

    UINShenDuiHuanPanel:GetClientEventHandler():AddEvent(CS.CEvent.AccessOrderCountChange, UINShenDuiHuanPanel.RefreShUI)
end
function UINShenDuiHuanPanel:Show()
    UINShenDuiHuanPanel.GoddessesPanel= uimanager:GetPanel("UIGoddessesBlessLeftMianPanel")
    if UINShenDuiHuanPanel.GoddessesPanel~=nil then
        UINShenDuiHuanPanel.GoddessesPanel.SetActive(false)
    end
    UINShenDuiHuanPanel.RefreShUI()
end

function UINShenDuiHuanPanel.RefreShUI()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem == nil then
        UINShenDuiHuanPanel.value.text = '0'
        UINShenDuiHuanPanel.Cost.gameObject:SetActive(false)
    else
        UINShenDuiHuanPanel.value.text = CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem.count
        UINShenDuiHuanPanel.Cost.gameObject:SetActive(true)
    end

end


function UINShenDuiHuanPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UINShenDuiHuanPanel')
end
function UINShenDuiHuanPanel.OnClickEnterBtn(go)
    networkRequest.ReqGoddessBlessingExchange()
    UINShenDuiHuanPanel.OnClickCloseBtn(go)
    if  CS.CSScene.MainPlayerInfo~=nil and  CS.CSScene.MainPlayerInfo.DuplicateV2~=nil and CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem~=nil and CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateItem.count>0 then
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = LuaEnumCoinType.YuanBao, from = go.transform.position}) 
    end
end

function ondestroy()
    if UINShenDuiHuanPanel.GoddessesPanel~=nil then
        UINShenDuiHuanPanel.GoddessesPanel.SetActive(true)
    end
end




return UINShenDuiHuanPanel