---任务道具
---@class UIItemGetWay_ItemPartRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIItemGetWay_ItemPartRightUpOperate = {}
setmetatable(UIItemGetWay_ItemPartRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIItemGetWay_ItemPartRightUpOperate:RefreshWithInfo(commonData)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo

    self.itemGetWayList = CS.CSTargetGetWayManager.Instanece.itemGetWayList
    if self.itemGetWayList == nil or self.itemGetWayList.Count == 0 then
        self:GetBtns_UIGridContainer().MaxCount = 0
        self:GetBtns_UIGridContainer().gameObject:SetActive(false)
        return
    end

    self:GetBtns_UIGridContainer().MaxCount = self.itemGetWayList.Count
    for i = 0, self.itemGetWayList.Count - 1 do
        self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[i], self.itemGetWayList[i].buttonName, self.itemGetWayList[i].id)
    end
    -- self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[0], "前往",self.OnGotoMission)
    -- self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[1], "购买",self.OnBuy)
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIItemGetWay_ItemPartRightUpOperate:SetButtonShow(buttonGO, des, id)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = des
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = function()
        ---CS.CSTargetGetWayManager.Instanece:OpenFindTarget(id)
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(id)
        self:OnQuitClicked()
    end
end

function UIItemGetWay_ItemPartRightUpOperate:BGSelfAdaptaion()
    ---调整背景图的尺寸
    local bg_UISprite = self:GetBackGround_UISprite()
    bg_UISprite.height = self:GetBtns_UIGridContainer().MaxCount * 50 + 10

end
---取消（关闭TIps）
function UIItemGetWay_ItemPartRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UIItemGetWay_ItemPartRightUpOperate