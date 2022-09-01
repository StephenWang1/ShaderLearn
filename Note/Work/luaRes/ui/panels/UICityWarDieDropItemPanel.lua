local UICityWarDieDropItemPanel = {};

local this = nil

UICityWarDieDropItemPanel.mRankVo = nil;

--region Components

function UICityWarDieDropItemPanel:GetBackGround_GameObject()
    if(this.mBackGround_GameObject == nil) then
        this.mBackGround_GameObject = this:GetCurComp("WidgetRoot/window/backGround","GameObject");
    end
    return this.mBackGround_GameObject;
end

function UICityWarDieDropItemPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/event/CloseBtn","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICityWarDieDropItemPanel:GetItemPageViewTemplate_GameObject()
    if(this.mItemPageViewTemplate_GameObject == nil) then
        this.mItemPageViewTemplate_GameObject = this:GetCurComp("WidgetRoot/view","GameObject");
    end
    return this.mItemPageViewTemplate_GameObject;
end

function UICityWarDieDropItemPanel:GetPlayerName_Text()
    if(this.mPlayerName_Text == nil) then
        this.mPlayerName_Text = this:GetCurComp("WidgetRoot/window/name","UILabel");
    end
    return this.mPlayerName_Text;
end

function UICityWarDieDropItemPanel:GetItemPageViewTemplate()
    if(this.mItemPageViewTemplate == nil) then
        this.mItemPageViewTemplate = templatemanager.GetNewTemplate(this:GetItemPageViewTemplate_GameObject(), luaComponentTemplates.UIItemPageViewTemplate);
    end
    return this.mItemPageViewTemplate;
end

--endregion

--region Method

--region Public

function UICityWarDieDropItemPanel:UpdateUI()
    if(self.mRankVo ~= nil) then
        self:GetPlayerName_Text().text = self.mRankVo.name;
    else
        self:GetPlayerName_Text().text = "";
    end
end

--endregion

--region Private

function UICityWarDieDropItemPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarDieDropItemPanel");
    end;

    CS.UIEventListener.Get(this:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarDieDropItemPanel");
    end;
end

function UICityWarDieDropItemPanel:RemoveEvents()

end

--endregion

--endregion

function UICityWarDieDropItemPanel:Init()
    this = self;
    this:InitEvents();
end

function UICityWarDieDropItemPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    if(customData.rankVo ~= nil) then
        self.mRankVo = customData.rankVo;
    end

    if(customData.itemIdList ~= nil) then
        this:GetItemPageViewTemplate():UpdateToItemIdList(customData.itemIdList);
    else
        uimanager:ClosePanel("UICityWarDieDropItemPanel");
    end

    self:UpdateUI();
end

function ondestroy()
    this:RemoveEvents();
    this = nil;
end

return UICityWarDieDropItemPanel;