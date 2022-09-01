local UIBagRecycle_SettingOption = {}

--region 初始化
function UIBagRecycle_SettingOption:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvent()
end

function UIBagRecycle_SettingOption:InitComponent()
    self.btnName_UILabel = self:Get("Forge", "UILabel")
    self.check_GameObject = self:Get("Forge/check", "GameObject")
end

function UIBagRecycle_SettingOption:InitParams()
    self.bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
end

function UIBagRecycle_SettingOption:BindEvent()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self:GetChooseType() == luaEnumRecycleSettingOptionCheckType.MUILTIPLECHOOSE_SingleCheck and self.uiBagRecycleSetting ~= nil then
            local lastChoose = self.chooseState
            self.uiBagRecycleSetting:ResetOptionUIChooseState(self.optionId)
            if lastChoose == false then
                self:RefreshCheckState(true,true)
            end
        else
            self:RefreshCheckState(not self.chooseState,true)
        end
        self:RefreshBagGrid()
    end
end
--endregion

--region 刷新
function UIBagRecycle_SettingOption:RefreshPanel(commonData)
    self:AnalysisCommonData(commonData)
    self:RefreshBtn()
end

function UIBagRecycle_SettingOption:AnalysisCommonData(commonData)
    ---@type RecycleSettingOption
    self.recycleSettingOptionInfo = commonData.recycleSettingOptionInfo
    ---@type UIBagRecycle_Setting
    self.uiBagRecycleSetting = commonData.uiBagRecycleSetting
    self.optionId = ternary(self.recycleSettingOptionInfo == nil, 0, self.recycleSettingOptionInfo.SettingOptionPureID)
    self.optionText = ternary(self.recycleSettingOptionInfo == nil, "", self.recycleSettingOptionInfo.OptionText)
    self.index = ternary(self.recycleSettingOptionInfo == nil, 0, self.recycleSettingOptionInfo.Index)
    self.chooseState = ternary(self.recycleSettingOptionInfo == nil, false, self.recycleSettingOptionInfo.ChooseState)
    self.defaultChooseState = self.chooseState
    self.recycleSetTbl = clientTableManager.cfg_recoversetManager:TryGetValue(self.recycleSettingOptionInfo.RecoverSetTableInfo.id)
end

---刷新按钮
function UIBagRecycle_SettingOption:RefreshBtn()
    if self.recycleSettingOptionInfo ~= nil then
        self:RefreshOptionName()
        self:RefreshCheckState(self.chooseState)
    end
end

---刷新选项文本内容
function UIBagRecycle_SettingOption:RefreshOptionName()
    if self.btnName_UILabel ~= nil then
        self.btnName_UILabel.text = self.optionText
    end
end

---刷新选项状态
---@param state boolean 选项状态
---@param saveSetting boolean 是否保存选项状态
function UIBagRecycle_SettingOption:RefreshCheckState(state,saveSetting)
    if self.check_GameObject ~= nil then
        self.check_GameObject:SetActive(state)
        self.chooseState = state
    end
    if saveSetting == true then
        CS.Cfg_RecoverSetTableManager.Instance:SetRecycleSettingOptionChooseState(self.index, state,saveSetting == true)
    end
end

---刷新背包物品
function UIBagRecycle_SettingOption:RefreshBagGrid()
    if self.uiBagRecycleSetting ~= nil and self.uiBagRecycleSetting.recyclePanel ~= nil then
        self.uiBagRecycleSetting.recyclePanel:onRecycleSettingOptionStateChanged(self:GetRightOptionTypeTable())
    end
end
--endregion

--region 获取
---获取选项类型
function UIBagRecycle_SettingOption:GetChooseType()
    if self.optionId == luaEnumRecycleSettingOptionType.ROLEEQUIP_UPSTAR
            or self.optionId == luaEnumRecycleSettingOptionType.ROLEEQUIP_REIN
            or self.optionId == luaEnumRecycleSettingOptionType.ServantEgg_REIN
            or self.optionId == luaEnumRecycleSettingOptionType.ServantEquip_REIN then
        return luaEnumRecycleSettingOptionCheckType.MUILTIPLECHOOSE_SingleCheck
    end
    return luaEnumRecycleSettingOptionCheckType.SINGLECHOOSE
end

---获取右侧回收选项类型(例如：升星装备针对所有的装备，那就要将等级装备，转生装备，特殊装备的逻辑都刷新一下)
---@return table<number, luaEnumRecycleOptionType>
function UIBagRecycle_SettingOption:GetRightOptionTypeTable()
    --if self.optionId == luaEnumRecycleSettingOptionType.ROLEEQUIP_UPSTAR then
    --    return { luaEnumRecycleOptionType.LEVELEQUIP, luaEnumRecycleOptionType.REINLVEQUIP, luaEnumRecycleOptionType.SPECIALEQUIP }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.ROLEEQUIP_REIN then
    --    return { luaEnumRecycleOptionType.REINLVEQUIP, luaEnumRecycleOptionType.SPECIALEQUIP }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.ServantEgg_REIN then
    --    return { luaEnumRecycleOptionType.SERVANT }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.ServantEquip_REIN then
    --    return { luaEnumRecycleOptionType.SERVANTEQUIP }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.QingTongQi then
    --    return { luaEnumRecycleOptionType.COLLECTION }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.TaoQi then
    --    return { luaEnumRecycleOptionType.COLLECTION }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.CiQi then
    --    return { luaEnumRecycleOptionType.COLLECTION }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.YuQi then
    --    return { luaEnumRecycleOptionType.COLLECTION }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.JinYinQi then
    --    return { luaEnumRecycleOptionType.COLLECTION }
    --elseif self.optionId == luaEnumRecycleSettingOptionType.FaQi then
    --    return { luaEnumRecycleOptionType.COLLECTION }
    --end
    if self.recycleSetTbl == nil or self.recycleSetTbl:GetRecoveType() == nil or type(self.recycleSetTbl:GetRecoveType().list) ~= 'table' then
        return {}
    end
    return self.recycleSetTbl:GetRecoveType().list
end
--endregion

return UIBagRecycle_SettingOption