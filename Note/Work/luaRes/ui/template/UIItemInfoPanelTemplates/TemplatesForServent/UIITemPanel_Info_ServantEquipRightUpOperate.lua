---@class UIITemPanel_Info_ServantEquipRightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons  物品信息界面子界面(灵兽装备)
local UIITemPanel_Info_ServantEquipRightUpOperate = {}

setmetatable(UIITemPanel_Info_ServantEquipRightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

--region重写装备和卸下逻辑，判定按照灵兽判定
function UIITemPanel_Info_ServantEquipRightUpOperate:SetEquipInfo()
    if self.mBagItemInfo.index ~= 0 then
        return "卸下"
    else
        return "装备"
    end
end

---"装备"按钮点击回调
---@param go UnityEngine.GameObject
function UIITemPanel_Info_ServantEquipRightUpOperate:OnButtonClicked_EquipOperate(go)
    --region 灵兽背包另外处理
    if self:IsServantBagUseItem(go) then
        return
    end
    --endregion
    --灵兽装备
    local index = 0
    if self.mBagItemInfo.index == 0 then
        --背包装备
        if CS.CSServantInfoV2.IsServantJustEquip(self.mItemInfo) or CS.CSServantInfoV2.IsServantMagicWeapon(self.mItemInfo) then
            --灵兽装备
            local BubbleId = CS.CSScene.MainPlayerInfo.ServantInfoV2:ReqEquipItem(self.mBagItemInfo, self.mItemInfo)
            if BubbleId ~= -1 then
                self:BubbleTips(BubbleId, go)
                return
            else
                uimanager:ClosePanel("UIItemInfoPanel")
                index = CS.CSScene.MainPlayerInfo.ServantInfoV2:LevelEquipToShowBaseServantPanel(self.mBagItemInfo)
                if (index == 1) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM);
                elseif (index == 2) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX);
                elseif (index == 3) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC);
                end
            end
            --CS.CSScene.MainPlayerInfo.ServantInfoV2:ReqEquipItem(self.mBagItemInfo, self.mItemInfo)
        elseif CS.CSServantInfoV2.IsServantBody(self.mItemInfo) then
            if not self:EquipServantBody(go) then
                return
            end
        end
    else
        --已经装备的装备位
        networkRequest.ReqPutOffTheEquip(self.mBagItemInfo.index)
    end
    uimanager:ClosePanel("UIItemInfoPanel")
end

---装备灵兽肉身
---@return boolean false表示装备失败了
function UIITemPanel_Info_ServantEquipRightUpOperate:EquipServantBody(go)
    local BubbleId = -1
    if CS.CSServantInfoV2.IsServantCommonBody(self.mItemInfo) then
        ---@type number 跳转id
        local bodyEquipIndex = 0
        local servantType = 0
        local bagPanel = uimanager:GetPanel("UIBagPanel")
        if bagPanel then
            --有背包界面的时候请求当前选中灵兽替换装备
            local servantPanel = uimanager:GetPanel("UIServantPanel")
            if servantPanel then
                servantType = servantPanel:GetSelectHeadInfo():GetServantType()
                BubbleId, bodyEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:ReqEquipCommonBodyEquip(self.mBagItemInfo, self.mItemInfo, servantType)
            else
                BubbleId, bodyEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:ReqEquipCommonBodyEquip(self.mBagItemInfo, self.compareBagItemInfo)
            end
        end
    else
        ---灵兽肉身
        local bodyEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyIndex(self.mItemInfo.subType)
        local servantType = math.modf(bodyEquipIndex / 1000)
        ---灵兽界面
        ---@type UIServantPanel
        local servantPanel = uimanager:GetPanel("UIServantPanel")
        if servantPanel ~= nil and servantPanel.ServantIndex ~= nil then
            local servantTypeOfCurrentServantPanel = servantPanel.ServantIndex + 1
            ---若灵兽界面存在,则装备到灵兽界面当前选中的灵兽位上
            bodyEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:TransferBodyIndexWithServantType(bodyEquipIndex, servantTypeOfCurrentServantPanel)
        else
            ---若灵兽界面不存在,且为通用灵兽,则选择一个最弱的灵兽位装备上去
            if servantType == 4 then
                bodyEquipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipBodyRecommendedServantIndex(self.mBagItemInfo)
            end
        end
        --肉身装备
        BubbleId = CS.CSScene.MainPlayerInfo.ServantInfoV2:ReqEquipBodyItem(self.mBagItemInfo, bodyEquipIndex)
    end

    if BubbleId ~= -1 then
        Utility.ShowPopoTips(go, nil, BubbleId)
        return false
    else
        Utility.TransferServantPanelOpenBag(bodyEquipIndex, self.mBagItemInfo)
        uimanager:ClosePanel("UIItemInfoPanel")
    end
    return true
end

---显示提示
function UIITemPanel_Info_ServantEquipRightUpOperate:BubbleTips(id, go)
    if go and CS.StaticUtility.IsNull(go) == false then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = id
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
    end
end

function UIITemPanel_Info_ServantEquipRightUpOperate:GetCurrentServantType()

end

---"锻造"按钮点击回调
---@param go UnityEngine.GameObject
function UIITemPanel_Info_ServantEquipRightUpOperate:OnButtonClicked_ForgeOperate(go)
    --region 检查是否为打开界面
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    uimanager:ClosePanel("UIServantPanel")
    local customData = {};
    customData.bagItemInfo = self.mBagItemInfo;
    customData.type = LuaEnumStrengthenType.YuanLing
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Strengthen_Servant, customData);
    --endregion
end
--endregion

return UIITemPanel_Info_ServantEquipRightUpOperate