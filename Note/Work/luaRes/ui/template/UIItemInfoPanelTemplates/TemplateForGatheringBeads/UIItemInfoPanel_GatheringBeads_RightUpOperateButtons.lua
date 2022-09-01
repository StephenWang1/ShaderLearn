---@class UIItemInfoPanel_GatheringBeads_RightUpOperateButtons:UIItemInfoPanel_Info_RightUpOperateButtons
local UIItemInfoPanel_GatheringBeads_RightUpOperateButtons = {}
setmetatable(UIItemInfoPanel_GatheringBeads_RightUpOperateButtons, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_GatheringBeads_RightUpOperateButtons:RefreshWithInfo(commonData)
    local isMainPlayer = commonData.isMainPlayer
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    local gatheringBeadsInfo = commonData.gatheringBeadsInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    self.gatheringBeadsInfo = gatheringBeadsInfo
    if bagItemInfo and itemInfo then
        self.uiItemInfoPanel = uimanager:GetPanel("UIItemInfoPanel")
        self.uiPetInfoPanel = uimanager:GetPanel("UIPetInfoPanel")
        self.isEquiped = CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid)
        local leftOperateTable = self:FilterOperate(CS.Cfg_ItemsOperateTableManager.Instance:GetOperateList(itemInfo.leftOperate), bagItemInfo, itemInfo)
        local rightOperateTable = self:FilterOperate(CS.Cfg_ItemsOperateTableManager.Instance:GetOperateList(itemInfo.rightOperate), bagItemInfo, itemInfo)
        local allOperateTable = self:MergeOperateTable(rightOperateTable, leftOperateTable)
        if self:GetBtns_UIGridContainer() ~= nil then
            self:GetBtns_UIGridContainer().MaxCount = #allOperateTable
            for i = 0, self:GetBtns_UIGridContainer().controlList.Count - 1 do
                self:SetButton(self:GetBtns_UIGridContainer().controlList[i], allOperateTable[i + 1])
            end
            ---右上角按钮展开收起自适应
            if self:GetBtns_UIGridContainer().controlList.Count > 1 then
                self.btnListOpenAndClose = templatemanager.GetNewTemplate(self:GetBtns_UIGridContainer(), luaComponentTemplates.UIItemInfoPanel_Info_OpenCloseBtnList)
            else
                if #allOperateTable > 0 then
                    self:BGSelfAdaptaion()
                    self:GetBackGround_GameObject():SetActive(true)
                else
                    self:GetBackGround_GameObject():SetActive(false)
                end
                self:GetShowClose_GameObject():SetActive(false)
            end
        end
    end
    self:GetBtns_UIGridContainer().gameObject:SetActive(isMainPlayer);
    self.tipLevel = CS.Cfg_GlobalTableManagerBase.Instance[20180] == nil and 0 or tonumber(CS.Cfg_GlobalTableManagerBase.Instance[20180].value);
end

---"使用"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_GatheringBeads_RightUpOperateButtons:OnButtonClicked_UseOperate(go)
    if self.mBagItemInfo then
        --聚灵珠当前存储的经验值存在luck中,最大经验值存在maxStart中
        if self.mBagItemInfo.luck < self.mBagItemInfo.maxStar then
            CS.Utility.ShowTips("经验尚未存满,不可领取", 1.5, CS.ColorType.Red)
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
        else
            if self.gatheringBeadsInfo and self.gatheringBeadsInfo.useCount and self.gatheringBeadsInfo.totalCount then
                if self.gatheringBeadsInfo.useCount < self.gatheringBeadsInfo.totalCount or self.gatheringBeadsInfo.totalCount == 0 then
                    Utility.TryOpenJLZPanel({ info = self.mItemInfo })
                    uimanager:ClosePanel("UIItemInfoPanel")
                    uimanager:ClosePanel("UIPetInfoPanel")
                    --uimanager:ClosePanel("UIBagPanel")
                else
                    UIItemInfoPanel_GatheringBeads_RightUpOperateButtons.ShowTips(go.transform, nil, 101)
                end
            end
        end
    end
end

return UIItemInfoPanel_GatheringBeads_RightUpOperateButtons