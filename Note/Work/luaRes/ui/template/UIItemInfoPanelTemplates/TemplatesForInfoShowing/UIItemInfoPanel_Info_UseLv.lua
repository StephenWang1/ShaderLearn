local UIItemInfoPanel_Info_UseLv = {}
setmetatable(UIItemInfoPanel_Info_UseLv, luaComponentTemplates.UIItemInfoPanel_Info_SingleLine)

---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_UseLv:RefreshWithInfo(commonData)
    local itemInfo = commonData.itemInfo
    if itemInfo then
        if itemInfo.useLv == 0 and itemInfo.reinLv == 0 then
            self:GetTextLabel_UILabel().text = " " .. "无等级"
        else
            if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) and itemInfo.type == luaEnumItemType.Equip then
                --local useLevelColor = Utility.NewGetBBCode((CS.CSScene.MainPlayerInfo.Level >= itemInfo.useLv) and (CS.CSScene.MainPlayerInfo.ReinLevel >= itemInfo.reinLv))
                local useLevelColor
                if clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id) == LuaEnumUseItemParam.CanUse then
                    useLevelColor = CS.UnityEngine.Color.white
                else
                    useLevelColor = CS.UnityEngine.Color.red
                end
                local useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
                local attributeName = ternary(itemInfo.reinLv > 0, "转可装备", "级可装备")
                self:GetTextLabel_UILabel().text = " " .. useLevel .. attributeName
                self:GetTextLabel_UILabel().color = useLevelColor
            end
        end
    end
end
return UIItemInfoPanel_Info_UseLv