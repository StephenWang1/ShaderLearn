---@class UICommerceAdministratorPanel:UIBase
local UICommerceAdministratorPanel = {};

local this = nil;

UICommerceAdministratorPanel.mCardInfo = nil;

--region Components

function UICommerceAdministratorPanel:GetBtnGet_GameObject()
    if (this.mBtnGet_GameObject == nil) then
        this.mBtnGet_GameObject = this:GetCurComp("WidgetRoot/events/btn_receive", "GameObject");
    end
    return this.mBtnGet_GameObject;
end

function UICommerceAdministratorPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return this.mBtnClose_GameObject;
end

function UICommerceAdministratorPanel:GetPlayerName_Text()
    if (this.mPlayerName_Text == nil) then
        this.mPlayerName_Text = this:GetCurComp("WidgetRoot/panel/name/name", "UILabel");
    end
    return this.mPlayerName_Text;
end

function UICommerceAdministratorPanel:GetSecondDescriptionModel()
    if(this.mSecondDescriptionModel == nil) then
        this.mSecondDescriptionModel = this:GetCurComp("WidgetRoot/panel/DesNode/rewardNode","GameObject");
    end
    return this.mSecondDescriptionModel;
end

function UICommerceAdministratorPanel:GetRewardLabel_Text()
    if(this.mRewardLabel_Text == nil) then
        this.mRewardLabel_Text = this:GetCurComp("WidgetRoot/panel/DesNode/rewardNode/rewardLabel","UILabel");
    end
    return this.mRewardLabel_Text;
end

function UICommerceAdministratorPanel:GetRewardGridContainer()
    if (this.mRewardGridContainer == nil) then
        this.mRewardGridContainer = this:GetCurComp("WidgetRoot/panel/rewards", "UIGridContainer")
    end
    return this.mRewardGridContainer;
end

function UICommerceAdministratorPanel:GetRewardDesGridContainer()
    if (this.mRewardDesGridContainer == nil) then
        this.mRewardDesGridContainer = this:GetCurComp("WidgetRoot/panel/DesNode/rewardNode/rewardDescription", "UIGridContainer")
    end
    return this.mRewardDesGridContainer;
end

function UICommerceAdministratorPanel:GetFirstDescriptionModel()
    if (this.mFirstDescriptionModel == nil) then
        this.mFirstDescriptionModel = this:GetCurComp("WidgetRoot/panel/DesNode/rewardExperienceNode", "GameObject")
    end
    return this.mFirstDescriptionModel;
end

function UICommerceAdministratorPanel:GetExperienceRewardDesGridContainer()
    if (this.mExperienceRewardDesGridContainer == nil) then
        this.mExperienceRewardDesGridContainer = this:GetCurComp("WidgetRoot/panel/DesNode/rewardExperienceNode/rewardExperienceDescription", "UIGridContainer")
    end
    return this.mExperienceRewardDesGridContainer;
end

function UICommerceAdministratorPanel:GetDesUITable()
    if (this.mDesUITable == nil) then
        this.mDesUITable = this:GetCurComp("WidgetRoot/panel/DesNode","UITable");
    end
    return this.mDesUITable;
end

function UICommerceAdministratorPanel:GetDesUIPanel()
    if (this.mDesUIPanel == nil) then
        this.mDesUIPanel = this:GetCurComp("WidgetRoot/panel/DesNode","UIPanel");
    end
    return this.mDesUIPanel;
end

function UICommerceAdministratorPanel:GetIntroduceObj()
    if (this.mIntroduce == nil) then
        this.mIntroduce = this:GetCurComp("WidgetRoot/panel/introduce", "GameObject")
    end
    return this.mIntroduce;
end

--endregion

--region Method

--region Public

function UICommerceAdministratorPanel:UpdateUI()

    if (this.mCardInfo == nil) then
        return ;
    end

    if (this.mRewardDesUnitDic == nil) then
        this.mRewardDesUnitDic = {};
    end
    if (this.mRewardUnitDic == nil) then
        this.mRewardUnitDic = {};
    end
    this:GetPlayerName_Text().text = CS.CSScene.MainPlayerInfo.Name;
    local gridContainer_Des = this:GetRewardDesGridContainer();
    local gridContainer_Des_Experience = this:GetExperienceRewardDesGridContainer();
    local gridContainer = this:GetRewardGridContainer();
    if(this.mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD)) then
        this:GetRewardLabel_Text().text = "正式会员额外特权";
        gridContainer_Des_Experience.transform.parent.gameObject:SetActive(true);
        gridContainer.gameObject:SetActive(false);
        local desExperienceShowList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardRewardExperienceString();
        if(desExperienceShowList ~= nil and desExperienceShowList.Count > 0) then
            gridContainer_Des_Experience.MaxCount = desExperienceShowList.Count;
            for i = 0, gridContainer_Des_Experience.MaxCount - 1 do
                local gobj_Des_Experience = gridContainer_Des_Experience.controlList[i];
                if (this.mRewardDesUnitDic[gobj_Des_Experience] == nil) then
                    this.mRewardDesUnitDic[gobj_Des_Experience] = templatemanager.GetNewTemplate(gobj_Des_Experience, luaComponentTemplates.UICommerceRewardDesUnitTemplate)
                end
                this.mRewardDesUnitDic[gobj_Des_Experience]:UpdateDes(desExperienceShowList[i]);
            end
        else
            gridContainer_Des_Experience.MaxCount = 0;
        end

        local desShowList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardOtherRewardExperienceString();
        if(desShowList ~= nil and desShowList.Count > 0) then
            gridContainer_Des.MaxCount = desShowList.Count;
            for i = 0, gridContainer_Des.MaxCount - 1 do
                local gobj_Des = gridContainer_Des.controlList[i];
                if (this.mRewardDesUnitDic[gobj_Des] == nil) then
                    this.mRewardDesUnitDic[gobj_Des] = templatemanager.GetNewTemplate(gobj_Des, luaComponentTemplates.UICommerceRewardDesUnitTemplate)
                end
                this.mRewardDesUnitDic[gobj_Des]:UpdateDes(desShowList[i]);
            end
        else
            gridContainer_Des.MaxCount = 0;
        end
    else
        --region 旧的商会管理员信息
        --this:GetRewardLabel_Text().text = "商会特权";
        --gridContainer_Des_Experience.transform.parent.gameObject:SetActive(false);
        --gridContainer.gameObject:SetActive(true);
        local desList, itemIdList, typeList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCardRewardTypDes(this.mCardInfo);
        if (itemIdList ~= nil and desList ~= nil) then
            --gridContainer_Des.MaxCount = desList.Count;
            gridContainer.MaxCount = itemIdList.Count;
            for i = 0, itemIdList.Count - 1 do
                --local gobj_Des = gridContainer_Des.controlList[i];
                local gobj = gridContainer.controlList[i];
                --if (this.mRewardDesUnitDic[gobj_Des] == nil) then
                --    this.mRewardDesUnitDic[gobj_Des] = templatemanager.GetNewTemplate(gobj_Des, luaComponentTemplates.UICommerceRewardDesUnitTemplate)
                --end
                if (this.mRewardUnitDic[gobj] == nil) then
                    this.mRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem)
                end
                local des = "";
                if (desList.Count > i) then
                    des = desList[i];
                end
                if (typeList.Count > i) then
                    local welfareVo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCoceralDayCardRewardVo(typeList[i]);
                    if (welfareVo ~= nil) then
                        --this.mRewardDesUnitDic[gobj_Des]:UpdateUnit(des, welfareVo.itemId, welfareVo.realNum);
                        local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(welfareVo.itemId);
                        if (isFindItem) then
                            this.mRewardUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, welfareVo.realNum);
                            CS.UIEventListener.Get(gobj).onClick = function()
                                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
                            end
                        end
                    end
                end
            end
            --
            --local desShowList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetMonthCardRewardDesString(this.mCardInfo.cardType);
            --if(desShowList ~= nil and desShowList.Count > 0) then
            --    gridContainer_Des.MaxCount = desShowList.Count;
            --    for i = 0, gridContainer_Des.MaxCount - 1 do
            --        local gobj_Des = gridContainer_Des.controlList[i];
            --        if (this.mRewardDesUnitDic[gobj_Des] == nil) then
            --            this.mRewardDesUnitDic[gobj_Des] = templatemanager.GetNewTemplate(gobj_Des, luaComponentTemplates.UICommerceRewardDesUnitTemplate)
            --        end
            --        this.mRewardDesUnitDic[gobj_Des]:UpdateDes(desShowList[i]);
            --    end
            --else
            --    gridContainer_Des.MaxCount = 0;
            --end
        end
        --endregion
        this:GetFirstDescriptionModel():SetActive(false)
        this:GetSecondDescriptionModel():SetActive(false)
        if this.mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.BIQIMONTHCARD) then
            this.descriptionTable = {}
            local params = {}
            params.title = "比奇特权"
            params.descriptionId = 156
            local descriptionTemplate = templatemanager.GetNewTemplate(this:GetFirstDescriptionModel(),luaComponentTemplates.UICommercePanel_AdministratorDescription)
            if descriptionTemplate ~= nil then
                this.descriptionTable[1] = descriptionTemplate
                descriptionTemplate:RefreshPanel(params)
            end
            params.title = "升级到盟重商会额外享有特权"
            params.descriptionId = 168
            descriptionTemplate = templatemanager.GetNewTemplate(this:GetSecondDescriptionModel(),luaComponentTemplates.UICommercePanel_AdministratorDescription)
            if descriptionTemplate ~= nil then
                this.descriptionTable[2] = descriptionTemplate
                descriptionTemplate:RefreshPanel(params)
            end
        elseif this.mCardInfo.cardType == Utility.EnumToInt(CS.CoceralCardType.MENGZHONGCARD) then
            this.descriptionTable = {}
            local params = {}
            params.title = "盟重特权"
            params.descriptionId = 155
            local descriptionTemplate = templatemanager.GetNewTemplate(this:GetFirstDescriptionModel(),luaComponentTemplates.UICommercePanel_AdministratorDescription)
            if descriptionTemplate ~= nil then
                this.descriptionTable[1] = descriptionTemplate
                descriptionTemplate:RefreshPanel(params)
            end
        end
    end

    this:UpdateGetState();

    this:GetDesUITable():Reposition();
end

function UICommerceAdministratorPanel:UpdateGetState()
    if (this.mCardInfo ~= nil) then
        local isCanGot = not this.mCardInfo.isGot and this.mCardInfo.cardType ~= Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD)
        this:GetBtnGet_GameObject():SetActive(not this.mCardInfo.isGot and this.mCardInfo.cardType ~= Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD));
        this:GetIntroduceObj():SetActive(not this.mCardInfo.isGot and this.mCardInfo.cardType ~= Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD))
        this:GetRewardGridContainer().gameObject:SetActive(not this.mCardInfo.isGot and this.mCardInfo.cardType ~= Utility.EnumToInt(CS.CoceralCardType.MENGZHONGTASTECARD))
        local UIPanelRect = ternary(isCanGot == true, this.HaveAwardUIPanelRect,this.NoAwardUIPanelRect)
        if CS.StaticUtility.IsNull(this:GetDesUIPanel()) == false and UIPanelRect ~= nil then
            this:GetDesUIPanel():SetRect(UIPanelRect.x,UIPanelRect.y,UIPanelRect.z,UIPanelRect.w)
        end
    end
end

--endregion

--region Private

function UICommerceAdministratorPanel:InitEvents()

    CS.UIEventListener.Get(this:GetBtnGet_GameObject()).onClick = function()
        local desList, itemIdList, typeList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCardRewardTypDes(this.mCardInfo);
        if (itemIdList ~= nil and desList ~= nil and CS.CSScene.MainPlayerInfo.BagInfo.EmptyGridCount < itemIdList.Count) then
            ---若背包空位不足,则提示回收气泡
            Utility.ShowPopoTips(this:GetBtnGet_GameObject(), "背包剩余空间不足", 290, "UICommerceAdministratorPanel")
            return;
        end
        if (this.mCardInfo ~= nil and not this.mCardInfo.isGot) then
            networkRequest.ReqReceiveCardDayReward(this.mCardInfo.id);
        end
    end

    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICommerceAdministratorPanel");
    end

    this.CallOnMonthCardChanged = function()
        this.mCardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(1);
        this:UpdateGetState();
    end

    this:GetClientEventHandler():AddEvent(CS.CEvent.V2_BuyMonthCardInfoRefresh, this.CallOnMonthCardChanged)

    this.CallOnResCardDayRewardInfoMessage = function()
        this:UpdateUI();
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCardDayRewardInfoMessage, this.CallOnResCardDayRewardInfoMessage)
end
--endregion

--endregion

function UICommerceAdministratorPanel:Init()
    --self:AddCollider()
    this = self;

    this:InitEvents();
    this:InitParams();
end

function UICommerceAdministratorPanel:InitParams()
    this.HaveAwardUIPanelRect = CS.UnityEngine.Vector4(200,-147,420,290)
    this.NoAwardUIPanelRect = CS.UnityEngine.Vector4(200,-233,420,462)
end

function UICommerceAdministratorPanel:Show(customData)
    this.mCardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(1);
    if (this.mCardInfo ~= nil) then
        this:UpdateUI();
        networkRequest.ReqCardDayRewardInfo(this.mCardInfo.id)
    else
        uimanager:ClosePanel("UICommerceAdministratorPanel");
    end
end

return UICommerceAdministratorPanel;