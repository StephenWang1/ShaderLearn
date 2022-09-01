---寻宝仓库右侧模板重新
---@class UITreasurePanel_ItemPartRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons
local UITreasurePanel_ItemPartRightUpOperate = {}
setmetatable(UITreasurePanel_ItemPartRightUpOperate,luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)


---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UITreasurePanel_ItemPartRightUpOperate:RefreshWithInfo(commonData)
    self:GetBtns_UIGridContainer().MaxCount = 1
    local buttonGO = self:GetBtns_UIGridContainer().controlList[0]
    self.itemLid = commonData.commonData.bagItemInfo.lid
    self:SetButtonShow(buttonGO)
    self.mBagItemInfo = commonData.bagItemInfo
    self.mItemInfo = commonData.itemInfo
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UITreasurePanel_ItemPartRightUpOperate:SetButtonShow(buttonGO)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"),"UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text ="提取"
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self.OnClicked

end

---提取
function UITreasurePanel_ItemPartRightUpOperate:OnClicked(go)
    self:OnQuitClicked()
    if self.itemLid ~= nil then
        networkRequest.ReqOneKeyOperation(2,self.itemLid)
    end
    if self.mBagItemInfo~=nil then
        networkRequest.ReqGetItem(self.mBagItemInfo.lid)
        CS.CSScene.MainPlayerInfo.TreasureInfo.IsNeedAllSort=true;
    end
     
end
---取消（关闭TIps）
function UITreasurePanel_ItemPartRightUpOperate:OnQuitClicked()
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UITreasurePanel_ItemPartRightUpOperate