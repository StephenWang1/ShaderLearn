---@class UIItemInfoPanel_Union_RightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons 帮会战利品兑换按钮模板
local UIItemInfoPanel_Union_RightUpOperate = {}
setmetatable(UIItemInfoPanel_Union_RightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)
---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Union_RightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    ---@type bagV2.BagItemInfo
    self.mBagItemInfo = bagItemInfo
    ---@type TABLE.CFG_ITEMS
    self.mItemInfo = itemInfo
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    ---@type CSUnionInfoV2
    local unionInfoV2 = mainPlayerInfo.UnionInfoV2
    ---当前职位是否在副帮主以上
    local myPos = unionInfoV2:GetCurrentPosition()
    local president = unionInfoV2.LeaderUnionMemberInfo
    if CS.CSScene.MainPlayerInfo.UnionInfoV2:IsUnionManager(15) then
        local addNum = 0
        local showBtnInfo = {}
        if self:CanShowBtn(myPos, president) then
            --红包券不显示分配
            if not Utility.IsUnionRedPack(self.mItemInfo) and not Utility.IsDiamondItemId(self.mItemInfo.id) then
                local data = {}
                data.name = "分配"
                data.action = function(go)
                    self:Grant(go)
                end
                table.insert(showBtnInfo, data)
            end

            --显示红包
            if self:CanShowRedPack(myPos, president) then
                local redPackInfo = {}
                redPackInfo.name = "发红包"
                redPackInfo.action = function(go)
                    self:SendRedPack(go)
                end
                table.insert(showBtnInfo, redPackInfo)
            end
        end

        self:GetBtns_UIGridContainer().MaxCount = #showBtnInfo
        for i = 1, #showBtnInfo do
            local go = self:GetBtns_UIGridContainer().controlList[i - 1]
            local info = showBtnInfo[i]
            self:SetButtonShow(go, info.name, info.action)
        end

        if #showBtnInfo <= 0 then
            self.go:SetActive(false)
        else
            self:BGSelfAdaptaion()
        end
        return
    end
    self.go:SetActive(false)
end

function UIItemInfoPanel_Union_RightUpOperate:CanShowBtn(myPos, president)
    if president and myPos == LuaEnumGuildPosType.VicePresident and president.online then
        --会长/代理会长/副会长可分发  会长在线副会长不可发
        return false
    end
    return true
end

---目前只有元宝可分发，有需要再加
function UIItemInfoPanel_Union_RightUpOperate:CanShowRedPack()
    if self.mItemInfo then
        --红包券
        if Utility.IsUnionRedPack(self.mItemInfo) then
            return true
        end
        --元宝
        local limit = CS.Cfg_GlobalTableManager.Instance:GetRedPackPersonNum()
        local itemID = self.mItemInfo.id
        if (itemID == LuaEnumCoinType.YuanBao or Utility.IsDiamondItemId(self.mItemInfo.id)) and limit then
            if self.mBagItemInfo and self.mBagItemInfo.count > limit then
                return true
            end
        end
    end
    return false
end

---设置按钮显示及事件
function UIItemInfoPanel_Union_RightUpOperate:SetButtonShow(buttonGO, des, tab)
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = des
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = tab
end

function UIItemInfoPanel_Union_RightUpOperate:Grant(go)
    uimanager:CreatePanel("UIGuildSendBenefitsPanel", nil, { bagItemInfo = self.mBagItemInfo })
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---发红包
function UIItemInfoPanel_Union_RightUpOperate:SendRedPack(go)
    local customData = {}
    customData.BagItemInfo = self.mBagItemInfo
    if Utility.IsUnionRedPack(self.mItemInfo) then
        ---@type UIGuildSendRedPackCouponPanelTemplate
        customData.Template = luaComponentTemplates.UIGuildSendRedPackCouponPanelTemplate
    end
    uimanager:CreatePanel("UIGuildSendRedPackPanel", nil, customData)
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

return UIItemInfoPanel_Union_RightUpOperate