---背包与灵兽界面组合时
---@class UIBagMain_ServantHighLv:UIBagMainServant
local UIBagMain_ServantHighLv = {}

setmetatable(UIBagMain_ServantHighLv, luaComponentTemplates.UIBagMainServant)

---刷新提示列表
function UIBagMain_ServantHighLv:RefreshHintList()
    ---@type UIServantPanel
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    local isServantPushout = servantPanel:GetSelectHeadInfo().id ~= 0
    local typeInServantPanel = servantPanel:GetSelectHeadInfo():GetServantType()
    ---@type CSServantInfoV2
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    if self:GetBagItemHint() ~= nil then
        --region 获取最佳的灵兽蛋
        ---@type bagV2.BagItemInfo
        local bestEggInBag = servantInfo:GetBestServantEggForServantType(typeInServantPanel)
        if bestEggInBag ~= nil then
            self.mRecommendedServantEggLID = bestEggInBag.lid
        else
            self.mRecommendedServantEggLID = nil
        end
        --endregion

        --region 获取最佳的灵兽肉身装备
        if isServantPushout then
            ---灵兽界面的灵兽位有灵兽时,推荐灵兽肉身装备(如果有的话)
            ---@type bagV2.BagItemInfo
            local nao, xin, gu, xue
            if typeInServantPanel ~= nil then

                nao, xin, gu, xue = servantInfo:GetBestBodyEquipForCurrentServant(typeInServantPanel)
                if nao ~= nil then
                    self.mRecommendedServantBodyNaoEquipLID = nao.lid
                else
                    self.mRecommendedServantBodyNaoEquipLID = nil
                end
                if xin ~= nil then
                    self.mRecommendedServantBodyXinEquipLID = xin.lid
                else
                    self.mRecommendedServantBodyXinEquipLID = nil
                end
                if gu ~= nil then
                    self.mRecommendedServantBodyGuEquipLID = gu.lid
                else
                    self.mRecommendedServantBodyGuEquipLID = nil
                end
                if xue ~= nil then
                    self.mRecommendedServantBodyXueEquipLID = xue.lid
                else
                    self.mRecommendedServantBodyXueEquipLID = nil
                end
            else
                self.mRecommendedServantBodyNaoEquipLID = nil
                self.mRecommendedServantBodyXinEquipLID = nil
                self.mRecommendedServantBodyGuEquipLID = nil
                self.mRecommendedServantBodyXueEquipLID = nil
            end
        else
            ---灵兽界面的灵兽位没有灵兽时,不推荐灵兽肉身装备
            self.mRecommendedServantBodyNaoEquipLID = nil
            self.mRecommendedServantBodyXinEquipLID = nil
            self.mRecommendedServantBodyGuEquipLID = nil
            self.mRecommendedServantBodyXueEquipLID = nil
        end
        --endregion
    else
        ---清空所有推荐的ID
        self.mRecommendedServantEggLID = nil
        self.mRecommendedServantBodyNaoEquipLID = nil
        self.mRecommendedServantBodyXinEquipLID = nil
        self.mRecommendedServantBodyGuEquipLID = nil
        self.mRecommendedServantBodyXueEquipLID = nil
    end
end

return UIBagMain_ServantHighLv