---@class UIItemInfoPanel_Info_SingleLine:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_SingleLine = {}

setmetatable(UIItemInfoPanel_Info_SingleLine, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
function UIItemInfoPanel_Info_SingleLine:GetTextLabel_UILabel()
    if self.mTextLabel_UILabel == nil then
        self.mTextLabel_UILabel = self:Get("Text", "UILabel")
    end
    return self.mTextLabel_UILabel
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_SingleLine:RefreshWithInfo(commonData)
    ---@type string
    local info = ""
    if commonData ~= nil and commonData.itemInfo ~= nil and commonData.itemInfo.tips2 ~= nil then
        info = string.gsub(CS.Cfg_ItemsTableManager.Instance:GetTips2ByCareer(commonData.itemInfo, commonData.career), '\\n', '\n')
        --行会红包
        if Utility.IsUnionRedPack(commonData.itemInfo) then
            local maxCoin
            if commonData.itemInfo.useParam and commonData.itemInfo.useParam.list.Count > 1 then
                maxCoin = commonData.itemInfo.useParam.list[1]
            end
            if commonData.bagItemInfo then
                ---@type bagV2.BagItemInfo
                local redBagMoney = commonData.bagItemInfo.redBagMoney
                local addInfo = maxCoin == redBagMoney and "" or "\n" .. luaEnumColorType.Gray .. "红包未领取完毕返还"
                info = string.gsub(info, "{0}", redBagMoney) .. addInfo --行会红包填入数目
            else
                info = string.gsub(info, "{0}", maxCoin)
            end
        end
        --宝箱
        --[[        if Utility.IsSpecialEquipBox(commonData.itemInfo) then
                    local maxNum = self:BoxShowTime(commonData.itemInfo)
                    if maxNum and maxNum ~= 0 then
                        ---@type CSMainPlayerInfo
                        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
                        if mainPlayerInfo then
                            local useNum = 0
                            local res, useInfo = mainPlayerInfo.BagInfo.ItemUseTime:TryGetValue(commonData.itemInfo.id)
                            if res then
                                useNum = useInfo
                            end
                            info = info .. "\n已开启" .. useNum .. "/" .. maxNum .. "次"
                            if gameMgr:GetPlayerDataMgr()
                                    and LuaGlobalTableDeal:IsSpecialBoxUseVIPTipsShow(gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level(), commonData.itemInfo.id) then
                                info = info .. "\r\n提升VIP等级可增加开启次数"
                            end
                        end
                    end
                end]]

        if commonData.itemInfo.id == LuaEnumCoinType.YuanBao then
            local all = 0
            local yuanBao = 0
            ---@type CSMainPlayerInfo
            local mainPlayerInfo = CS.CSScene.MainPlayerInfo
            if mainPlayerInfo ~= nil then
                yuanBao = mainPlayerInfo.BagInfo:GetAuctionIngotNum()
                all = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(LuaEnumCoinType.BangYuan)
            end
            info = string.format(info, yuanBao, all - yuanBao)
        end

        if Utility.IsDiamondItemId(commonData.itemInfo.id) then
            info = string.format(info, Utility.GetAuctionDiamondNum(), Utility.GetBindDiamondNum())
        end
    else
        self.go:SetActive(false)
        return
    end
    if info and info ~= "" then
        if self:GetTextLabel_UILabel() and CS.StaticUtility.IsNull(self:GetTextLabel_UILabel()) == false then
            info = string.gsub(info, '#', '\r\n')
            self:GetTextLabel_UILabel().text = info
        end
    else
        if self.go then
            self.go:SetActive(false)
        end
    end

    --region 使用上限
    if commonData.bagItemInfo ~= nil then
        local useCount, useMaxCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemUseCountLimit(commonData.bagItemInfo)
        if (useMaxCount ~= nil) then
            local color = Utility.GetBBCode(useCount < useMaxCount)
            self:GetTextLabel_UILabel().text = self:GetTextLabel_UILabel().text .. "\r\n" .. Utility.CombineStringQuickly("今日已使用", "") .. Utility.CombineStringQuickly(color, useCount, "[-]/", useMaxCount, "")
            --self:AddAttribute(Utility.CombineStringQuickly("今日已使用", ""), Utility.CombineStringQuickly(color, useCount, "[-]/", useMaxCount, ""), false)
        end
    end
    --endregion
end

---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_SingleLine:BoxShowTime(itemInfo)
    if itemInfo then
        return Utility.GetSpecialBoxUseCountLimitPerDay(itemInfo.id)
    end
    return 0
end

return UIItemInfoPanel_Info_SingleLine