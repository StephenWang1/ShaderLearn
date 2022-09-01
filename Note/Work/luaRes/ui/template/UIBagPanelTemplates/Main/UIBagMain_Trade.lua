---@class UIBagMain_Trade:UIBagMain_Normal
local UIBagMain_Trade = {}

setmetatable(UIBagMain_Trade, luaComponentTemplates.UIBagMainNormal)

--region 字段
local Utility = Utility
local LuaEnumCareer = LuaEnumCareer
local luaEnumItemType = luaEnumItemType
local LuaEnumMainHint_BetterBagItemType = LuaEnumMainHint_BetterBagItemType

---@return CSBagItemHint
function UIBagMain_Trade:GetBagItemHint()
    if self.mBagItemHint == nil then
        self.mBagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    end
    return self.mBagItemHint
end

---主角的职业
UIBagMain_Trade.mMainPlayerCareer = nil
--endregion

--region 重写初始化方法
function UIBagMain_Trade:OnInit()
    self:RunBaseFunction("OnInit")
    self.mMainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
end
--endregion

--region 重写属性
---不使用服务器排序
function UIBagMain_Trade:IsUseServerOrder()
    return false
end

---不可进行双击
function UIBagMain_Trade:IsItemDoubleClickedAvailable()
    return false
end

---不可进行拖拽
function UIBagMain_Trade:IsItemDragAvailable()
    return false
end
--endregion

--region 重写筛选方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIBagMain_Trade:BagItemFilterFunction(bagItemInfo, itemInfo)
    if bagItemInfo ~= nil and bagItemInfo.canTrade == 1 and not CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(bagItemInfo) and itemInfo ~= nil and itemInfo.faceToFaceDeal ~= 1
            and (not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)) then
        return true
    end
    return false
end
--endregion

---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_Trade:ShowItemInfo(bagItemInfo)
    if bagItemInfo.count > 1 then
        --uiStaticParameter.UIItemInfoManager:CreatePanel({
        --    bagItemInfo = bagItemInfo,
        --    showRight = false, showAssistPanel = true,
        --    showMoreAssistData = true, showTabBtns = true,
        --    showAction = true }
        --)
        uimanager:CreatePanel("UIAuctionItemPanel", nil,
                {
                    BagItemInfo = bagItemInfo,
                    Template = luaComponentTemplates.UIFaceToFaceTrade_AuctionItem
                })
    else
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            bagItemInfo = bagItemInfo,
            rightUpButtonsModule = luaComponentTemplates.UIFaceToFaceDeal_BagItemPartRightUpOperate,
            showRight = true, showAssistPanel = true,
            showMoreAssistData = true, showTabBtns = true,
            showAction = true }
        )
    end
end

--function UIBagMain_Trade:TryDoAnyOperation(bagGrid, bagItemInfo, itemTbl)
--    -- print("尝试打开或使用物品~~~???")
--end

--region 重写关闭按钮显示
---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_Trade:IsShowCloseButton()
    return false
end
--endregion

--region 重写扩展按钮显示
---@public
---@return boolean
function UIBagMain_Trade:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Trade:IsShowRecycleButton()
    return false
end

function UIBagMain_Trade:IsShowTrimButton()
    return false
end
--endregion

--region 重写销毁方法
function UIBagMain_Trade:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    -- uimanager:ClosePanel("UISkillPanel")
end
--endregion

--region 面板关闭
---面板关闭
---@public
function UIBagMain_Trade:PanelClose(panelName)
    -- if panelName == "UISkillPanel" then
    --     uimanager:ClosePanel("UIBagPanel")
    -- end
end
--endregion

return UIBagMain_Trade