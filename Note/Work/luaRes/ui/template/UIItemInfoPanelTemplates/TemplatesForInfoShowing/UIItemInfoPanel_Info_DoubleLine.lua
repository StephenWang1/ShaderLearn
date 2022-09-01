---@class UIItemInfoPanel_Info_DoubleLine
local UIItemInfoPanel_Info_DoubleLine = {}

setmetatable(UIItemInfoPanel_Info_DoubleLine, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
function UIItemInfoPanel_Info_DoubleLine:GetTextLabel_UILabel()
    if self.mTextLabel_UILabel == nil then
        self.mTextLabel_UILabel = self:Get("Text", "UILabel")
    end
    return self.mTextLabel_UILabel
end

function UIItemInfoPanel_Info_DoubleLine:GetText1Label_UILabel()
    if self.mText1Label_UILabel == nil then
        self.mText1Label_UILabel = self:Get("Text1", "UILabel")
    end
    return self.mText1Label_UILabel
end

function UIItemInfoPanel_Info_DoubleLine:GetEndLine_UISprite()
    if self.mEndLine_UISprite == nil then
        self.mEndLine_UISprite = self:Get("endline", "UISprite")
    end
    return self.mEndLine_UISprite
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_DoubleLine:RefreshWithInfo(commonData)
    local info = commonData.itemInfo
    if info == nil then
        return
    end
    local donateInfo = tonumber(info.gongXian)
    local equalInfo = info.equal
    if (donateInfo and donateInfo ~= 0) or (CS.StaticUtility.IsNullOrEmpty(equalInfo) == false) then
        if self:GetTextLabel_UILabel() and CS.StaticUtility.IsNull(self:GetTextLabel_UILabel()) == false and CS.StaticUtility.IsNull(self:GetText1Label_UILabel()) == false then
            local unionDonationTextFormat = CS.Cfg_ReadTableManager.Instance:GetUnionDonationTextFormat()
            if donateInfo and donateInfo ~= 0 and unionDonationTextFormat ~= "" then
                self:GetTextLabel_UILabel().text = string.format(unionDonationTextFormat, donateInfo)
                self:ShowRecycleInfo(equalInfo, self:GetText1Label_UILabel())
            else
                self:ShowRecycleInfo(equalInfo, self:GetTextLabel_UILabel())
                self:GetText1Label_UILabel().gameObject:SetActive(false)
            end
        end
        if self:GetEndLine_UISprite() and CS.StaticUtility.IsNull(self:GetEndLine_UISprite()) == false then
            local textHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self.go.transform, self:GetTextLabel_UILabel().transform, false, true).size.y
            local originPos = self:GetEndLine_UISprite().transform.localPosition
            originPos.y = self:GetTextLabel_UILabel().transform.localPosition.y - textHeight - 2
            self:GetEndLine_UISprite().transform.localPosition = originPos
        end
        --elseif info ~= nil and info.smeltExtra ~= nil and info.smeltExtra.list ~= nil and info.smeltExtra.list.Count > 0 then
        --    if donateInfo and donateInfo ~= 0 and unionDonationTextFormat ~= "" then
        --        self:ShowSmeltInfo(info, self:GetText1Label_UILabel())
        --    else
        --        self:ShowSmeltInfo(info, self:GetTextLabel_UILabel())
        --        self:GetText1Label_UILabel().gameObject:SetActive(false)
        --    end

    else
        if self.go then
            self.go:SetActive(false)
        end
    end
end

---显示回收信息
---@param label UILabel
function UIItemInfoPanel_Info_DoubleLine:ShowRecycleInfo(equalInfo, label)
    if CS.StaticUtility.IsNullOrEmpty(equalInfo) == false then
        local recycleItemInfoTable = string.Split(equalInfo, '&')
        local strFormat = nil
        local equipStr = ''
        for k, v in pairs(recycleItemInfoTable) do
            local recycleInfo = string.Split(v, '#')
            if #recycleInfo >= 2 then
                if strFormat == nil then
                    strFormat = CS.Cfg_GlobalTableManager.Instance:GetRecycleTextFormat(tonumber(recycleInfo[1]))
                end

                local itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(tonumber(recycleInfo[1]))
                if itemName ~= nil and itemName ~= '' then
                    equipStr = equipStr .. recycleInfo[2] .. itemName
                    if k < #recycleItemInfoTable then
                        equipStr = equipStr .. ','
                    end
                end
            end
        end
        if strFormat ~= nil and strFormat ~= "" and equipStr ~= '' then
            self:GetText1Label_UILabel().gameObject:SetActive(true)
            label.text = string.format(strFormat, equipStr)
            return
        end
    end
    self:GetText1Label_UILabel().gameObject:SetActive(false)
end

---显示熔炼信息
---@param itemInfo table item表数据
---@param targetLabel UILabel  目标文本
function UIItemInfoPanel_Info_DoubleLine:ShowSmeltInfo(itemInfo, targetLabel)
    if targetLabel == nil or CS.StaticUtility.IsNull(targetLabel) then
        return
    end
    ---熔炼的奖励物品列表,number为itemid,boolean值为true的表示已经添加
    ---@return table<number,boolean>
    local AddedShowItemDic = {}
    ---获得文本格式
    local showContent = CS.Cfg_ReadTableManager.Instance:GetTextFormat(229)
    local str = ''
    for i = 0, itemInfo.smeltExtra.list.Count - 1 do
        local smeltInfoList = itemInfo.smeltExtra.list[i]
        if smeltInfoList ~= nil and smeltInfoList.list.Count > 0 then
            local itemId = smeltInfoList.list[0]
            if AddedShowItemDic[itemId] == nil then
                local itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemId)
                if itemName ~= '' and itemName ~= "" then
                    str = str .. itemName
                    if i ~= itemInfo.smeltExtra.list.Count - 1 then
                        str = str .. ','
                    end
                end
                AddedShowItemDic[itemId] = true
            end
        end
    end
    targetLabel.text = string.format(showContent, str)
end

return UIItemInfoPanel_Info_DoubleLine