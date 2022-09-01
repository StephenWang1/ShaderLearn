---任务道具
---@class UIMissionPanel_ItemPartRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIMissionPanel_ItemPartRightUpOperate = {}
setmetatable(UIMissionPanel_ItemPartRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)


---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIMissionPanel_ItemPartRightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    self:GetBtns_UIGridContainer().MaxCount = 2
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[0], "前往",self.OnGotoMission)
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[1], "购买",self.OnBuy)
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIMissionPanel_ItemPartRightUpOperate:SetButtonShow(buttonGO, des, tab)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"),"UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = des
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = tab
end
function UIMissionPanel_ItemPartRightUpOperate:BGSelfAdaptaion()
    ---调整背景图的尺寸
    local bg_UISprite = self:GetBackGround_UISprite()
    local lastBtnUISprite = CS.Utility_Lua.GetComponent(self:GetBtns_UIGridContainer().controlList[self:GetBtns_UIGridContainer().controlList.Count - 1].transform:Find("backGround"),"UISprite")
    local singleBtn_Size = lastBtnUISprite.localSize
    local btnHeightIntervals = self:GetBtns_UIGridContainer().CellHeight - singleBtn_Size.y
    bg_UISprite:SetRect(0, 0, 144, 56*2)
    ---调整背景图的位置
    local bgposition_y = lastBtnUISprite.transform.parent.localPosition.y * 0.5
    local bgposition_x = lastBtnUISprite.transform.localPosition.x + -1 * (self.BgWeight / 2)
    bg_UISprite.transform.localPosition = CS.UnityEngine.Vector3(bgposition_x, bgposition_y, 0)
end

---前往
function UIMissionPanel_ItemPartRightUpOperate:OnGotoMission(go)
  
    luaEventManager.DoCallback(LuaCEvent.Task_GotoTask,  self.mItemInfo);
   
    
    self:OnQuitClicked()
end

---购买
function UIMissionPanel_ItemPartRightUpOperate:OnBuy(go)
    luaEventManager.DoCallback(LuaCEvent.Task_BuyItem);
    self:OnQuitClicked()
end
---取消（关闭TIps）
function UIMissionPanel_ItemPartRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UIMissionPanel_ItemPartRightUpOperate