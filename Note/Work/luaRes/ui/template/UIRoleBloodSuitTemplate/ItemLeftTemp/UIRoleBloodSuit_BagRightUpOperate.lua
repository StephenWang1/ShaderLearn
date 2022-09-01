---血继背包道具左侧显示模板
---@class UIRoleBloodSuit_BagRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UIRoleBloodSuit_BagRightUpOperate = {}
setmetatable(UIRoleBloodSuit_BagRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIRoleBloodSuit_BagRightUpOperate:RefreshWithInfo(commonData)
    self:GetBtns_UIGridContainer().MaxCount = 1
    local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
    self:SetButtonShow(buttonGO)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    self.bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.mItemInfo.id)
    if self.bloodsuitTbl ~= nil then
        self.TblType = tonumber(self.bloodsuitTbl:GetType())
    end
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIRoleBloodSuit_BagRightUpOperate:SetButtonShow(buttonGO)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = "放入"
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self.OnClicked
end

---放入
function UIRoleBloodSuit_BagRightUpOperate:OnClicked(go)
    local mainPlayerBloodSuitEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
    local iscanUse, notUseIndex = mainPlayerBloodSuitEquipMgr:IsCanUseBloodSuit(self.mItemInfo)
    if iscanUse == false then
        mainPlayerBloodSuitEquipMgr:NotUseTips(go, notUseIndex)
        return
    end

    local currentSelectedSuitType = mainPlayerBloodSuitEquipMgr.NowSelectSuit
    local currentSelectedEquipIndex = mainPlayerBloodSuitEquipMgr:GetNowSelectEquipIndex()
    local currentEquippedBloodSuit = mainPlayerBloodSuitEquipMgr:GetWearSameBloodsuit(self.mItemInfo.id, currentSelectedSuitType)
    local targetEquipIndex = currentSelectedEquipIndex
    if currentEquippedBloodSuit ~= nil then
        ---重复穿戴了该装备
        if currentSelectedEquipIndex == currentEquippedBloodSuit.index then
            ---当前选中的装备就是同itemID装备,则进行替换,不进行处理
        else
            ---当前选中的装备不是同itemID装备,则提示并终止替换
            Utility.ShowPopoTips(go, "不可重复穿戴", 428, "UIItemInfoPanel")
            return
        end
    else
        ---未重复穿戴该装备,寻找一个空格,如果有空格则使用空格的装备位
        local allEquppedBloodSuits = mainPlayerBloodSuitEquipMgr:GetSingleBloodSuitDic(currentSelectedSuitType)
        ---空装备位
        local emptyEquipIndex = nil
        for i, v in pairs(allEquppedBloodSuits) do
            ---装备位上未装备装备，并且和选中的道具类型相同
            if v.BagItemInfo == nil and self.TblType == mainPlayerBloodSuitEquipMgr:GetBloodsuitType(i) then
                emptyEquipIndex = i
                break
            end
        end
        if emptyEquipIndex ~= nil then
            ---如果有空装备位,则将空装备位作为目标装备位并选中它
            targetEquipIndex = mainPlayerBloodSuitEquipMgr:GetEquipIndex(currentSelectedSuitType, emptyEquipIndex)
            ---@type UIRoleBloodSuitPanel
            local roleBloodSuitPanel = uimanager:GetPanel("UIRoleBloodSuitPanel")
            if roleBloodSuitPanel then
                ---让血继界面选中该装备位
                roleBloodSuitPanel:RefreshSelectIndex(emptyEquipIndex)
            end
        else
            ---如果没有空装备位,则保持当前选中的装备位
        end
    end
    networkRequest.ReqPutOnTheEquip(targetEquipIndex, self.mBagItemInfo.lid)
    self:OnQuitClicked()
end
---取消（关闭TIps）
function UIRoleBloodSuit_BagRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

return UIRoleBloodSuit_BagRightUpOperate