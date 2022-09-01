---神庙BS 复活界面
---@class UIReviveMonsterPanel:UIBase
local UIReviveMonsterPanel ={}
function UIReviveMonsterPanel:GetBtnClose_GameObject()
    if(self.mBtnClose_GameObject==nil)then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject
end
function UIReviveMonsterPanel:GetBtnRefresh_GameObject()
    if(self.mBtnRefresh_GameObject==nil)then
        self.mBtnRefresh_GameObject = self:GetCurComp("WidgetRoot/event/btn_center", "GameObject");
    end
    return self.mBtnRefresh_GameObject
end
function UIReviveMonsterPanel:GetCost_UILabel()
    if(self.mCost_UILabel==nil)then
        self.mCost_UILabel = self:GetCurComp("WidgetRoot/view/lb_cost", "UILabel");
    end
    return self.mCost_UILabel
end
---@return UICountdownLabel 刷新倒计时
function UIReviveMonsterPanel:GetTime_UICountdownLabel()
    if(self.mBtnTime_UICountdownLabel==nil)then
        self.mBtnTime_UICountdownLabel = self:GetCurComp("WidgetRoot/view/lb_countdown", "UICountdownLabel");
    end
    return self.mBtnTime_UICountdownLabel
end
function UIReviveMonsterPanel.CountDownCallBack(Param,Countdown)
    uimanager:ClosePanel('UIReviveMonsterPanel')
end
function UIReviveMonsterPanel:ShowPanel(info)
    self.npcid = info
    local avatar = CS.CSSceneExt.Sington:getAvatar(info)
    if(avatar==nil)then
        self:ClosePanel()
        return
    end
    self.time = avatar.Info.npcData.removeTime
    local cost = avatar.SourceMonster.reviveTimeClearCost
    --self.bossName = avatar.SourceMonster.name
    if(cost ==nil or cost.list==nil or cost.list.Count<2) then
        self:ClosePanel()
        return
    end
    self.itemId =cost.list[0]
    local isget, spriteInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.itemId)
    if(isget)then
        self.itemName =spriteInfo.name
    end

    self.itemNum = cost.list[1]
    self:SetData()
end
function UIReviveMonsterPanel :SetData()
    if(self:GetTime_UICountdownLabel()~=nil)then
        self:GetTime_UICountdownLabel():StartCountDown(400,6,self.time,luaEnumColorType.Red1,'后刷新',nil,self.CountDownCallBack)
    end
    if(self:GetCost_UILabel()~=nil)then
        self:GetCost_UILabel().text = '花费[ffbc1c]'..self.itemNum..self.itemName ..'[-]立即刷新'
    end
    if(CS.StaticUtility.IsNull(self:GetBtnRefresh_GameObject()) ==false)then
        CS.UIEventListener.Get(self:GetBtnRefresh_GameObject()).onClick =function(go)
            if(CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.itemId)>=self.itemNum)then
                networkRequest.ReqReliveHuntMonster(self.npcid)
                self:ClosePanel()
            else
                Utility.ShowPopoTips(self:GetBtnRefresh_GameObject().transform,self.itemName.."不足",290,"UIReviveMonsterPanel")
            end
        end
    end
end
function UIReviveMonsterPanel:Init()
    self:BindUIEvent()
end
function UIReviveMonsterPanel:BindUIEvent()
    if(CS.StaticUtility.IsNull(self:GetBtnClose_GameObject()) ==false)then
        CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick =function(go)
            self:ClosePanel()
        end
    end
end
function UIReviveMonsterPanel:Show(npcid,onlyid)
    if(npcid==nil or onlyid==nil)then
        self:ClosePanel()
    end
    self:ShowPanel(onlyid)
end
return UIReviveMonsterPanel