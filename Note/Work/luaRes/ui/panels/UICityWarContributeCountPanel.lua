---@class UICityWarContributeCountPanel:UIBase
local UICityWarContributeCountPanel = {};

UICityWarContributeCountPanel.mIntervalValue = 100;

function UICityWarContributeCountPanel:GetBtnContribute_GameObject()
    if(self.mBtnContribute_GameObject == nil) then
        self.mBtnContribute_GameObject = self:GetCurComp("WidgetRoot/events/btnContribute","GameObject")
    end
    return self.mBtnContribute_GameObject;
end

function UICityWarContributeCountPanel:GetBtnAdd_GameObject()
    if(self.mBtnAdd_GameObject == nil) then
        self.mBtnAdd_GameObject = self:GetCurComp("WidgetRoot/view/Num/add","GameObject")
    end
    return self.mBtnAdd_GameObject;
end

function UICityWarContributeCountPanel:GetBtnLess_GameObject()
    if(self.mBtnLess_GameObject == nil) then
        self.mBtnLess_GameObject = self:GetCurComp("WidgetRoot/view/Num/reduce","GameObject")
    end
    return self.mBtnLess_GameObject;
end

function UICityWarContributeCountPanel:GetContributeNum_UIInput()
    if(self.mContributeNum_UIInput == nil) then
        self.mContributeNum_UIInput = self:GetCurComp("WidgetRoot/view/Num/inputcount","UIInput")
    end
    return self.mContributeNum_UIInput;
end

function UICityWarContributeCountPanel:OnContributeNumInputValueChange()
    local num = tonumber(self:GetContributeNum_UIInput().value);
    self:SetContributeNum(num);
end

function UICityWarContributeCountPanel:SetContributeNum(num)
    local mDiamondNum = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum;
    if num == nil then
        num = 0
    end
    num = num > mDiamondNum and mDiamondNum or num;
    num = num < 0 and 0 or num;
    self:GetContributeNum_UIInput().value = num;
end

function UICityWarContributeCountPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnContribute_GameObject()).onClick = function()
        local curNum = tonumber(self:GetContributeNum_UIInput().value);
        if(curNum > 0) then
            networkRequest.ReqSabacDonate(curNum);
        end
        uimanager:ClosePanel("UICityWarContributeCountPanel");
    end;

    CS.UIEventListener.Get(self:GetBtnAdd_GameObject()).onClick = function()
        local curNum = tonumber(self:GetContributeNum_UIInput().value);
        self:SetContributeNum(curNum + self.mIntervalValue);
    end;

    CS.UIEventListener.Get(self:GetBtnLess_GameObject()).onClick = function()
        local curNum = tonumber(self:GetContributeNum_UIInput().value);
        self:SetContributeNum(curNum - self.mIntervalValue);
    end;

    self.CallOnUIInputValueChanged = function()
        self:OnContributeNumInputValueChange();
    end
    CS.EventDelegate.Add(self:GetContributeNum_UIInput().onChange, self.CallOnUIInputValueChanged);
end

function UICityWarContributeCountPanel:Init()
    self:InitEvents();
    self:AddCollider();
end

---@class ContributeParams
---@field diamondNum number 钻石数量
---@param customData ContributeParams
function UICityWarContributeCountPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end
    if(customData.diamondNum == nil) then
        customData.diamondNum = 0;
    end

    self:SetContributeNum(customData.diamondNum);
end

return UICityWarContributeCountPanel;