local UIActiveItemShowPanel = {};

local this = nil;

UIActiveItemShowPanel.mItemInfo = nil;

--region Components

function UIActiveItemShowPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/Window/bg","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIActiveItemShowPanel:GetBtnGoTo_GameObject()
    if(this.mBtnGoTo_GameObject == nil) then
        this.mBtnGoTo_GameObject = this:GetCurComp("WidgetRoot/Events/btn_GoTo","GameObject");
    end
    return this.mBtnGoTo_GameObject;
end

function UIActiveItemShowPanel:GetBtnBuy_GameObject()
    if(this.mBtnBuy_GameObject == nil) then
        this.mBtnBuy_GameObject = this:GetCurComp("WidgetRoot/Events/btn_Buy","GameObject");
    end
    return this.mBtnBuy_GameObject;
end

function UIActiveItemShowPanel:GetBtnHire_GameObject()
    if(this.mBtnHire_GameObject == nil) then
        this.mBtnHire_GameObject = this:GetCurComp("WidgetRoot/Events/btn_Hire","GameObject");
    end
    return this.mBtnHire_GameObject;
end

function UIActiveItemShowPanel:GetBtnGoTo_Text()
    if(this.mBtnGoTo_Text == nil) then
        this.mBtnGoTo_Text = this:GetCurComp("WidgetRoot/Events/btn_GoTo/Label","UILabel");
    end
    return this.mBtnGoTo_Text;
end

function UIActiveItemShowPanel:GetBtnBackGround_UISprite()
    if(this.mBtnBackGround_UISprite == nil) then
        this.mBtnBackGround_UISprite = this:GetCurComp("WidgetRoot/Events/bg","UISprite");
    end
    return this.mBtnBackGround_UISprite;
end

function UIActiveItemShowPanel:GetDesContent_Text()
    if(this.mDesContent_Text == nil) then
        this.mDesContent_Text = this:GetCurComp("WidgetRoot/UIComponents/content","UILabel");
    end
    return this.mDesContent_Text;
end

function UIActiveItemShowPanel:GetItemGridContainer()
    if(this.mItemGridContainer == nil) then
        this.mItemGridContainer = this:GetCurComp("WidgetRoot/UIComponents/itemGridContainer","UIGridContainer");
    end
    return this.mItemGridContainer;
end

--endregion

--region Method

--region CallFunction

---雇佣矿工
function UIActiveItemShowPanel:OnClickHireMiner()
    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(10001502);
    uimanager:ClosePanel("UIActiveItemShowPanel")
    uimanager:ClosePanel("UIDayToDayPanel")
end

--endregion

--region Public

function UIActiveItemShowPanel:UpdateUI()
    this:UpdateMissionTarget();
end

function UIActiveItemShowPanel:UpdateMissionTarget()
    if(this.mUnitDic == nil) then
        this.mUnitDic = {};
    end

    if(this.mMission ~= nil) then
        local gridContainer = this:GetItemGridContainer();
        local taskItemList, type, curCount, maxCount = this.mMission:GetTaskTarget();
        if(type == 1) then
            --region 满足一种
            this:GetDesContent_Text().text = luaEnumColorType.Gray1.."收集任意以下"..Utility.GetTaskTypeItemName(this.mMission.tbl_tasks.subtype).."  "..curCount.."/"..maxCount.."[-]";
            gridContainer.MaxCount = taskItemList.Count;
            for i = 0, taskItemList.Count - 1 do
                local gobj = gridContainer.controlList[i];
                if(this.mUnitDic[gobj] == nil) then
                    this.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(taskItemList[i].item);
                if(isFind) then
                    this.mUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, 1);
                end
            end
            local itemId = this.mMission:GetRecentlyItemID(taskItemList);
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
            if(isFind) then
                this.mItemInfo = itemTable;
                this:GetBtnGoTo_Text().text = Utility.GetDailyTaskShowLabel(this.mItemInfo);
            end

            if(this.mMission.tbl_tasks.subtype == LuaEnumDailyTaskType.BlacksmithTask) then
                this:GetBtnHire_GameObject():SetActive(true);
                this:GetBtnBuy_GameObject().transform.localPosition = CS.UnityEngine.Vector3(339, -78, 0);
                this:GetBtnBackGround_UISprite().height = 153;
            else
                this:GetBtnHire_GameObject():SetActive(false);
                this:GetBtnBuy_GameObject().transform.localPosition = CS.UnityEngine.Vector3(339, -29, 0);
                this:GetBtnBackGround_UISprite().height = 102;
            end

            --endregion
        elseif(type == 2) then
            --region 满足所有
            uimanager:ClosePanel("UIActiveItemShowPanel");
            --endregion
        end
    end
end

--endregion

--region Private

function UIActiveItemShowPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActiveItemShowPanel");
    end

    CS.UIEventListener.Get(this:GetBtnGoTo_GameObject()).onClick = function()
        if(this.mItemInfo ~= nil) then
            CS.CSMissionManager.Instance.TaskFindItemID = this.mItemInfo.id;
            luaEventManager.DoCallback(LuaCEvent.Task_GotoTask, this.mItemInfo);
            uimanager:ClosePanel("UIActiveItemShowPanel");
        end
    end

    CS.UIEventListener.Get(this:GetBtnBuy_GameObject()).onClick = function()
        luaEventManager.DoCallback(LuaCEvent.Task_BuyItem);
        uimanager:ClosePanel("UIActiveItemShowPanel");
    end

    CS.UIEventListener.Get(this:GetBtnHire_GameObject()).onClick = function()
        this:OnClickHireMiner();
    end
end

function UIActiveItemShowPanel:RemoveEvents()

end

--endregion

--endregion

function UIActiveItemShowPanel:Init()
    this = self;
    this:InitEvents();
end

function UIActiveItemShowPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    if(customData.mission == nil) then
        uimanager:ClosePanel("UIActiveItemShowPanel");
    end
    this.mMission = customData.mission;

    this:UpdateUI();
end

function ondestroy()
    this:RemoveEvents();
    this = nil;
end

return UIActiveItemShowPanel;