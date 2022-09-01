---@class UIItemInfoPanel_UnionBag_RightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons 帮会仓库兑换模板
local UIItemInfoPanel_UnionBag_RightUpOperate = {}

setmetatable(UIItemInfoPanel_UnionBag_RightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_UnionBag_RightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    self:GetBtns_UIGridContainer().MaxCount = 1
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[0], "兑换", function(go)
        self:Exchange(go)
    end)
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIItemInfoPanel_UnionBag_RightUpOperate:SetButtonShow(buttonGO, des, tab)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = des
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = tab
end

function UIItemInfoPanel_UnionBag_RightUpOperate:Exchange(go)
    local info = self.mBagItemInfo
    if info and info.itemId and info.lid then
        -- networkRequest.ReqConversionEquip(info.itemId, info.lid)
    end
    uimanager:ClosePanel("UIPetInfoPanel")
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UIItemInfoPanel_UnionBag_RightUpOperate