---物品信息界面UIItem
---@type 物品信息界面信息
---@class UIItemInfoPanel_ServentUpInfo:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_ServentUpInfo = {}

setmetatable(UIItemInfoPanel_ServentUpInfo, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

UIItemInfoPanel_ServentUpInfo.FrameIcon = {
    [LuaEnumServantSpeciesType.First] = "LsQuality_1",
    [LuaEnumServantSpeciesType.Second] = "LsQuality_2",
    [LuaEnumServantSpeciesType.Third] = "LsQuality_3",
}

--region 组件
---UIItem根节点
---@return UnityEngine.GameObject
function UIItemInfoPanel_ServentUpInfo:GetUIItemRoot_GameObject()
    if self.mUIItemRoot_GO == nil then
        self.mUIItemRoot_GO = self:Get("UIItem", "GameObject")
    end
    return self.mUIItemRoot_GO
end

---类型文本
function UIItemInfoPanel_ServentUpInfo:GetTypeLabel_UILabel()
    if self.mTypeLabel_UILabel == nil then
        self.mTypeLabel_UILabel = self:Get("baseInfo/Type", "UILabel")
    end
    return self.mTypeLabel_UILabel
end

---等级文本
function UIItemInfoPanel_ServentUpInfo:GetLevelLabel_UILabel()
    if self.mLevelLabel_UILabel == nil then
        self.mLevelLabel_UILabel = self:Get("baseInfo/Level", "UILabel")
    end
    return self.mLevelLabel_UILabel
end

---装备状态游戏物体
function UIItemInfoPanel_ServentUpInfo:GetWearState_GameObject()
    if self.mWearState_GO == nil then
        self.mWearState_GO = self:Get("baseInfo/WearState", "GameObject")
    end
    return self.mWearState_GO
end

function UIItemInfoPanel_ServentUpInfo:GetWearState_UILabel()
    if self.mWearState_UILabel == nil then
        self.mWearState_UILabel = self:Get("baseInfo/WearState", "UILabel")
    end
    return self.mWearState_UILabel
end

---性别文本
function UIItemInfoPanel_ServentUpInfo:GetSexLabel_UILabel()
    if self.mSexLabel_UILabel == nil then
        self.mSexLabel_UILabel = self:Get("baseInfo/Sex", "UILabel")
    end
    return self.mSexLabel_UILabel
end

---职业文本
function UIItemInfoPanel_ServentUpInfo:GetCareerLabel_UILabel()
    if self.mCareerLabel_UILabel == nil then
        self.mCareerLabel_UILabel = self:Get("baseInfo/Career", "UILabel")
    end
    return self.mCareerLabel_UILabel
end

---CD时间文本
function UIItemInfoPanel_ServentUpInfo:GetCDTimeLabel_UILabel()
    if self.mCDTimeLabel_UILabel == nil then
        self.mCDTimeLabel_UILabel = self:Get("baseInfo/CDTime", "UILabel")
    end
    return self.mCDTimeLabel_UILabel
end

---CD事件倒计时
---@return UICountdownLabel
function UIItemInfoPanel_ServentUpInfo:GetCDTimeCountDown()
    if self.mCDTimeCountDown == nil then
        self.mCDTimeCountDown = self:Get("baseInfo/CDTime", "UICountdownLabel")
    end
    return self.mCDTimeCountDown
end

---重量
function UIItemInfoPanel_ServentUpInfo:GetWeight_UILabel()
    if self.mWeight_UILabel == nil then
        self.mWeight_UILabel = self:Get("baseInfo/weight", "UILabel")
    end
    return self.mWeight_UILabel
end

---耐久
function UIItemInfoPanel_ServentUpInfo:GetNaijiu_UILabel()
    if self.mNaijiu_UILabel == nil then
        self.mNaijiu_UILabel = self:Get("baseInfo/naijiu", "UILabel")
    end
    return self.mNaijiu_UILabel
end

---重量 TweenColor
function UIItemInfoPanel_ServentUpInfo:GetWeight_TweenColor()
    if self.mWeight_TweenColor == nil then
        self.mWeight_TweenColor = self:Get("baseInfo/weight", "TweenColor")
    end
    return self.mWeight_TweenColor
end

---耐久 TweenColor
function UIItemInfoPanel_ServentUpInfo:GetNaijiu_TweenColor()
    if self.mNaijiu_TweenColor == nil then
        self.mNaijiu_TweenColor = self:Get("baseInfo/naijiu", "TweenColor")
    end
    return self.mNaijiu_TweenColor
end

---强化等级
function UIItemInfoPanel_ServentUpInfo:GetintensifyNum_UILabel()
    if self.mintensifyNum_UILabel == nil then
        self.mintensifyNum_UILabel = self:Get("baseInfo/num", "UILabel")
    end
    return self.mintensifyNum_UILabel
end

---强化等级_星星
function UIItemInfoPanel_ServentUpInfo:GetintensifyStar_GameObject()
    if self.mintensifyStar_GameObject == nil then
        self.mintensifyStar_GameObject = self:Get("baseInfo/star", "GameObject")
    end
    return self.mintensifyStar_GameObject
end

---品质
function UIItemInfoPanel_ServentUpInfo:GetFrame_UISprite()
    if self.mFrameSprite == nil then
        self.mFrameSprite = self:Get("UIItem/frame", "UISprite")
    end
    return self.mFrameSprite
end

---绑定
function UIItemInfoPanel_ServentUpInfo:GetBind_TweenPosition()
    if self.Bind_GameObject == nil then
        self.Bind_GameObject = self:Get("baseInfo/bind", "TweenPosition")
    end
    return self.Bind_GameObject
end

---可交易
function UIItemInfoPanel_ServentUpInfo:GetCanDeal()
    if self.CanDeal == nil then
        self.CanDeal = self:Get("baseInfo/canDeal", "UILabel")
    end
    return self.CanDeal
end

function UIItemInfoPanel_ServentUpInfo:GetCanDeal_TweenPosition()
    if self.CanDealtween == nil then
        self.CanDealtween = self:Get("baseInfo/canDeal", "TweenPosition")
    end
    return self.CanDealtween
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_ServentUpInfo:RefreshWithInfo(commonData)
    ---@type bagV2.BagItemInfo 背包信息
    local bagItemInfo = commonData.bagItemInfo
    ---@type TABLE.CFG_ITEMS 物品信息
    local itemInfo = commonData.itemInfo
    self.bagItemInfo = bagItemInfo
    self.itemInfo = itemInfo
    self.showBind = commonData.showBind
    self.showAction = commonData.showAction
    if itemInfo == nil then
        ___, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
        self.ItemInfo = itemInfo
    end
    self.showItemInfo = itemInfo
    if itemInfo then
        if self.showItemInfo ~= nil and self.showItemInfo.useParam ~= nil then
            ___, self.serventInfoTable = CS.Cfg_ServantTableManager.Instance:TryGetValue(self.showItemInfo.useParam.list[0])
        end
    end

    self.IsNeedShowBind = false
    if self.bagItemInfo ~= nil then
        self.IsNeedShowBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.bagItemInfo)
    elseif self.itemInfo ~= nil then
        self.IsNeedShowBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.itemInfo)
    end

    if self.serventInfoTable or itemInfo.type == luaEnumItemType.ServantFragment then
        --UIItem
        if self:GetUIItemRoot_GameObject() and CS.StaticUtility.IsNull(self:GetUIItemRoot_GameObject()) == false then
            local icon = CS.Utility_Lua.GetComponent(self:GetUIItemRoot_GameObject().transform:Find("icon"), "UISprite")
            local name = CS.Utility_Lua.GetComponent(self:GetUIItemRoot_GameObject().transform:Find("name"), "UILabel")
            if icon and name then
                icon.spriteName = itemInfo.icon
                local str = ""
                if bagItemInfo ~= nil then
                    str = CS.Utility_Lua.GetServantLuck(bagItemInfo.luck)
                end
                --name.text = itemInfo.name .. str
                name.text = itemInfo.name
            end
            ---@type UnityEngine.GameObject
            local bloodSuitLvGO = self:GetUIItemRoot_GameObject().transform:Find("BloodLv").gameObject
            ---@type UILabel
            local bloodSuitLvLabel = CS.Utility_Lua.GetComponent(self:GetUIItemRoot_GameObject().transform:Find("BloodLv/Label"), "UILabel")
            if bloodSuitLvGO and bloodSuitLvLabel then
                local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
                if bloodsuitTbl and bagItemInfo and bagItemInfo.bloodLevel > 0 then
                    bloodSuitLvGO:SetActive(true)
                    bloodSuitLvLabel.text = tostring(bagItemInfo.bloodLevel)
                else
                    bloodSuitLvGO:SetActive(false)
                end
            end
        end
        --类型
        if self:GetTypeLabel_UILabel() and CS.StaticUtility.IsNull(self:GetTypeLabel_UILabel()) == false then
            self:GetTypeLabel_UILabel().gameObject:SetActive(false)
        end
        --等级
        if self:GetLevelLabel_UILabel() and CS.StaticUtility.IsNull(self:GetLevelLabel_UILabel()) == false then
            self:GetLevelLabel_UILabel().gameObject:SetActive(false)
        end
        --性别
        if self:GetSexLabel_UILabel() and CS.StaticUtility.IsNull(self:GetSexLabel_UILabel()) == false then
            self:GetSexLabel_UILabel().gameObject:SetActive(false)
        end
        --装备标识
        if self:GetWearState_GameObject() and CS.StaticUtility.IsNull(self:GetWearState_GameObject()) == false then
            if self:GetWearState_GameObject() and CS.StaticUtility.IsNull(self:GetWearState_GameObject()) == false then
                local servantID = 1
                if bagItemInfo ~= nil then
                    if (bagItemInfo.lid ~= nil) then
                        servantID = bagItemInfo.lid
                    else
                        servantID = bagItemInfo.servantId
                    end
                end
                if (CS.CSScene.MainPlayerInfo.ServantInfoV2:CheckServantIsEquip(servantID)) then
                    self.isEquip = true
                    self:GetWearState_GameObject().gameObject:SetActive(true)
                else
                    self.isEquip = false
                    self:GetWearState_GameObject().gameObject:SetActive(false)
                end
            end
        end

        --重量
        if self:GetWeight_UILabel() and CS.StaticUtility.IsNull(self:GetWeight_UILabel()) == false then
            local serventType = self:GetServentType(self.serventInfoTable)
            local textContent = nil
            if itemInfo.type == luaEnumItemType.ServantFragment then
                textContent = Utility.GetItemType(itemInfo.type, itemInfo.subType)
            else
                textContent = serventType
            end
            --[[            ---血继套装类型
                        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
                        if bloodsuitTbl then
                            textContent = textContent .. "  " .. bloodsuitTbl:GetQualityName()
                        end]]
            self:GetWeight_UILabel().text = textContent
        end

        --强化等级
        if self:GetintensifyNum_UILabel() and CS.StaticUtility.IsNull(self:GetintensifyNum_UILabel()) == false then
            self:GetintensifyNum_UILabel().gameObject:SetActive(false)
        end

        --耐久
        if self:GetNaijiu_UILabel() and CS.StaticUtility.IsNull(self:GetNaijiu_UILabel()) == false then
            if itemInfo.type == luaEnumItemType.ServantFragment then
                self:GetNaijiu_UILabel().text = CS.CSScene.MainPlayerInfo.ServantInfoV2:ReverseServantFragmentTipsLevel(itemInfo)
            elseif itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 8 then
                if itemInfo.useLv == 0 and itemInfo.reinLv == 0 then
                    self:GetNaijiu_UILabel().text = "无等级"
                else
                    if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) then
                        local canUse = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id) == LuaEnumUseItemParam.CanUse
                        local useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
                        local attributeName = ternary(itemInfo.reinLv > 0, "需要人物转生 ", "需要人物等级 ")
                        ---设置初始颜色
                        if not canUse and self:GetNaijiu_TweenColor() ~= nil then
                            self:AddBlinkList(self:GetNaijiu_UILabel())
                            self:GetNaijiu_UILabel().text = attributeName .. useLevel
                        else
                            local useLevelColor = Utility.NewGetBBCode(canUse)
                            self:GetNaijiu_UILabel().text = useLevelColor .. attributeName .. useLevel
                        end
                    end
                end
            else
                self:GetNaijiu_UILabel().text = self.serventInfoTable.quality .. "阶"
            end
        end

        --星星
        if self:GetintensifyStar_GameObject() and CS.StaticUtility.IsNull(self:GetintensifyStar_GameObject()) == false then
            self:GetintensifyStar_GameObject().gameObject:SetActive(false)
        end
        self:RefreshFrame()
        self:RefreshBind()
        self:RefreshTrade()
    end
end

---获取灵兽类型
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentUpInfo:GetServentType(serventTable)
    if serventTable then
        local serventType = serventTable.type
        if serventType == LuaEnumServantSpeciesType.First then
            return "寒芒"
        elseif serventType == LuaEnumServantSpeciesType.Second then
            return "落星"
        elseif serventType == LuaEnumServantSpeciesType.Third then
            return "天成"
        elseif serventType == LuaEnumServantSpeciesType.Forth then
            return "通用"
        end
    end
    return ""
end

---刷新可交易状态
function UIItemInfoPanel_ServentUpInfo:RefreshTrade()
    if self:GetCanDeal() == nil then
        return
    end
    if self.showAction == nil or self.showAction == false then
        self:GetCanDeal().gameObject:SetActive(false)
        return
    end
    if self.bagItemInfo ~= nil then
        if self.bagItemInfo.index ~= 0 then
            self:GetCanDeal_TweenPosition():PlayForward()
        else
            self:GetCanDeal_TweenPosition():PlayReverse()
        end
        local isBind = self.bagItemInfo.canTrade == 1 and not self.IsNeedShowBind
        self:GetCanDeal().gameObject:SetActive(isBind)
        self:GetCanDeal().text = "可交易"
    end
end

---刷新绑定
function UIItemInfoPanel_ServentUpInfo:RefreshBind()
    if self:GetBind_TweenPosition() == nil then
        return
    end
    if self.showBind == nil or self.showBind == false then
        self:GetBind_TweenPosition().gameObject:SetActive(false)
        return
    end
    if self.itemInfo ~= nil then
        local isBind = false
        if self.bagItemInfo ~= nil then
            isBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.bagItemInfo)
        elseif self.itemInfo ~= nil then
            isBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.itemInfo)
        end
        if self.isEquip == true then
            self:GetBind_TweenPosition():PlayForward()
        else
            self:GetBind_TweenPosition():PlayReverse()
        end
        self:GetBind_TweenPosition().gameObject:SetActive(isBind)
    end
end
--endregion

---刷新品质
function UIItemInfoPanel_ServentUpInfo:RefreshFrame()
    if CS.StaticUtility.IsNull(self:GetFrame_UISprite()) == false then
        if self.serventInfoTable and self.serventInfoTable.type then
            self:GetFrame_UISprite().spriteName = self.FrameIcon[self.serventInfoTable.type]
            self:GetFrame_UISprite().gameObject:SetActive(self.FrameIcon[self.serventInfoTable.type] ~= nil)
        end
    end
end

return UIItemInfoPanel_ServentUpInfo