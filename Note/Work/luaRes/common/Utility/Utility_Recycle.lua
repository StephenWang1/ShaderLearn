---@type Utility
local Utility = Utility

---打开回收界面（通用）
function Utility.OpenRecyclePanel()
    if LuaGlobalTableDeal:IsShowQuickRecycle() == false then
        Utility.OpenRecycleHint()
        return
    end
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Recycle })
end

---打开回收提示
function Utility.OpenRecycleHint()
    Utility.ShowSecondConfirmPanel({PromptWordId = 160,CancelCallBack = function(go)
        local quickRecycleOpenResult = LuaGlobalTableDeal:CheckOpenQuickRecycleSystemIsOpen()
        if quickRecycleOpenResult ~= nil and quickRecycleOpenResult.success == false then
            Utility.ShowPopoTips(go,quickRecycleOpenResult.txt,48)
            return false
        end
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Member_Panel)
    end,ComfireAucion = function()
        Utility.TryTransfer(LuaEnumDeliverType.RecycleNpc,false)
    end
    })
end


--region 推荐回收
---是否是推荐回收的物品
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 是否推荐回收
function Utility.IsRecommendItem(bagItemInfo)
    local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    if itemTbl ~= nil and itemTbl:GetType() == luaEnumItemType.Equip and CS.CSServantInfoV2.IsServantRoleEquip(itemTbl:GetSubType()) then
        return Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.NONE
    end
    return CS.CSScene.MainPlayerInfo.BagInfo:IsRecommendRecycleItem(bagItemInfo,true)
end
--endregion


--region 回收开关
---@return number 获取背包类型切换任务id（如果配置的任务id未完成，则为没有回收按钮的背包）
function Utility.GetOpenBagPanelShowRecycleBtnTaskId()
    if Utility.recycleBtnShowTaskId == nil then
        Utility.recycleBtnShowTaskId = CS.Cfg_GlobalTableManager.Instance:GetBagRecycleBtnShowTaskId()
    end
    return Utility.recycleBtnShowTaskId
end
--endregion