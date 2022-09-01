local UISpecialMissionPanel_ItemPartRightUpOperate = {}
setmetatable(UISpecialMissionPanel_ItemPartRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UISpecialMissionPanel_ItemPartRightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    self.index = 0
    if itemInfo.subType == 1 then
        self:GetBtns_UIGridContainer().MaxCount = 3
    else
        self:GetBtns_UIGridContainer().MaxCount = 2
    end

    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[self.index], self:GetBtnShowLabel(), self.OnGotoMission)
    if itemInfo.subType == 1 then
        self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[self.index], "雇佣矿工", self.OnHireMiner)
    end
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[self.index], "购买", self.OnBuy)
    self:BGSelfAdaptaion()
end

function UISpecialMissionPanel_ItemPartRightUpOperate:GetBtnShowLabel()
    return Utility.GetDailyTaskShowLabel(self.mItemInfo);
end

---设置按钮显示及事件
function UISpecialMissionPanel_ItemPartRightUpOperate:SetButtonShow(buttonGO, des, tab)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = des
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = tab
    self.index = self.index + 1
end
--function UISpecialMissionPanel_ItemPartRightUpOperate:BGSelfAdaptaion()
--    ---调整背景图的尺寸
--    local bg_UISprite = self:GetBackGround_UISprite()
--    local lastBtnUISprite = self:GetBtns_UIGridContainer().controlList[self:GetBtns_UIGridContainer().controlList.Count - 1].transform:Find("backGround"):GetComponent("UISprite")
--    local singleBtn_Size = lastBtnUISprite.localSize
--    local btnHeightIntervals = self:GetBtns_UIGridContainer().CellHeight - singleBtn_Size.y
--    bg_UISprite:SetRect(0, 0, 144, 56*2)
--    ---调整背景图的位置
--    local bgposition_y = lastBtnUISprite.transform.parent.localPosition.y * 0.5
--    local bgposition_x = lastBtnUISprite.transform.localPosition.x + -1 * (self.BgWeight / 2)
--    bg_UISprite.transform.localPosition = CS.UnityEngine.Vector3(bgposition_x, bgposition_y, 0)
--end
---雇佣矿工
function UISpecialMissionPanel_ItemPartRightUpOperate:OnHireMiner(go)
    if CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:IsAnyPathToMainCityInCurrentMap() == false then
        ---不能前往主城时,先前往主城
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            self:OnHireMiner(go)
        end)
    else
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(10001502);
        uimanager:ClosePanel("UISpecialMissionPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIDayToDayPanel")
    end
end

---前往
function UISpecialMissionPanel_ItemPartRightUpOperate:OnGotoMission(go)
    if CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:IsAnyPathToMainCityInCurrentMap() == false then
        ---不能前往主城时,先前往主城
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            self:OnGotoMission(go)
        end)
    else
        if self.mItemInfo ~= nil then
            CS.CSMissionManager.Instance.TaskFindItemID = self.mItemInfo.id
        end
        luaEventManager.DoCallback(LuaCEvent.Task_GotoTask, self.mItemInfo);
        uimanager:ClosePanel("UISpecialMissionPanel")
        self:OnQuitClicked()
    end
end

---购买
function UISpecialMissionPanel_ItemPartRightUpOperate:OnBuy(go)
    if CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:IsAnyPathToMainCityInCurrentMap() == false then
        ---不能前往主城时,先前往主城
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            self:OnBuy(go)
        end)
    else
        luaEventManager.DoCallback(LuaCEvent.Task_BuyItem);
        self:OnQuitClicked()
    end
end

---取消（关闭TIps）
function UISpecialMissionPanel_ItemPartRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UISpecialMissionPanel_ItemPartRightUpOperate