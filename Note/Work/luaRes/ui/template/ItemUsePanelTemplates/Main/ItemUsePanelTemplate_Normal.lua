---@class ItemUsePanelTemplate_Normal:ItemUsePanelTemplate_Base 辅助道具模板
local ItemUsePanelTemplate_Normal = {}

setmetatable(ItemUsePanelTemplate_Normal, luaComponentTemplates.ItemUsePanelTemplate_Base)

--region 点击事件
function ItemUsePanelTemplate_Normal:SingleUseBtnOnClick(go)
    self:RunBaseFunction("SingleUseBtnOnClick", go)
    if self.bagItemInfoList ~= nil then
        local bagItemInfo = self:GetBagItemInfoListFirstItem()
        if bagItemInfo ~= nil then
            networkRequest.ReqUseItem(1, bagItemInfo.lid, 0)
            self:PlayEffect(self:GetUseEffect_GameObject())
        end
    end
end

function ItemUsePanelTemplate_Normal:MoreUseBtnOnClick(go)
    self:RunBaseFunction("MoreUseBtnOnClick", go)
    if self.bagItemInfoList ~= nil then
        if self.bagItemInfoList ~= nil then
            local length = self.bagItemInfoList.Count - 1
            for k = 0, length do
                local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(self.bagItemInfoList[k].lid)
                if bagItemInfo ~= nil then
                    networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, 0)
                end
            end
        end
    end
end
--endregion

function ItemUsePanelTemplate_Normal:TryRefreshSingleBtn()
    if self.bagItemCount <= 1 then
        self:RefreshBtnState(false)
    else
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            ---@type CSMagicCircleInfo
            local circle = mainPlayerInfo.MagicCircleInfo
            if circle:IsMagicBallItem(self.itemInfo.id) then
                local playerLevel = mainPlayerInfo.Level
                local limitLevel = CS.Cfg_GlobalTableManager.Instance:UseAllMagicStoneLevel()
                self:RefreshBtnState(playerLevel >= limitLevel)
            else
                self:RefreshBtnState(true)
            end
        end
    end
end

return ItemUsePanelTemplate_Normal