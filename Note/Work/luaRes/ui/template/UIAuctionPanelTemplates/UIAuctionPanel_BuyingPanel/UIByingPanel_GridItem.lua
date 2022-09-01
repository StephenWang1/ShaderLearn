local UIByingPanel_GridItem = {}
function UIByingPanel_GridItem:Init()
    self:InitComponents()
    self:InitParameters()
end

function UIByingPanel_GridItem:InitComponents()
    self.ItemIcon_UISprite = self:Get("icon", "UISprite")
    self.Check_GameObject = self:Get("check", "GameObject")
    self.CheckSign_UISprite = self:Get("check", "UISprite")
    self.ItemCount_UILabel = self:Get("count","UILabel")
end

function UIByingPanel_GridItem:InitParameters()
    ---背包物品信息,bagV2.BagItemInfo类型
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = nil
    ---物品信息,TABLE.CFG_ITEMS类型
    ---@type TABLE.CFG_ITEMS
    self.ItemInfo = nil
    ---格子类型
    ---@type 背包格子类型
    self.mGridType = LuaEnumBagGridType.None
end

---刷新UI
---@param info bagV2.BagItemInfo 背包物品信息
---@param gridType 背包格子类型 格子类型
function UIByingPanel_GridItem:RefreshUI(info, gridType)
    self.mGridType = gridType
    if gridType == LuaEnumBagGridType.Lock then
        self:ResetUI(true)
    elseif gridType == LuaEnumBagGridType.None then
        self:ResetUI(false)
    elseif gridType == LuaEnumBagGridType.CanLock then
        self:ResetUI(true)
        self.ItemLock_UISprite.spriteName = "tips_suo"
    elseif gridType == LuaEnumBagGridType.Block then
        self:ResetUI(true)
        self.ItemIcon_UISprite.color = CS.UnityEngine.Color(0, 0, 0, 1)
    end

    if info ~= nil then
        self.BagItemInfo = info
        local res = false
        res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.itemId)
        --若Item表中有该物品,根据Item表和背包物品信息设置物品显示
        if res then
            --region 设置物品Icon
            if self.ItemIcon_UISprite and CS.StaticUtility.IsNull(self.ItemIcon_UISprite) == false then
                if self.ItemInfo.reuseType ~= nil and self.ItemInfo.reuseType.list ~= nil and self.ItemInfo.reuseType.list.Count >= 2 and self.BagItemInfo ~= nil and self.BagItemInfo.leftUseNum ~= nil and self.BagItemInfo.leftUseNum == 1 then
                    self.ItemIcon_UISprite.spriteName = tostring(self.ItemInfo.reuseType.list[1])
                else
                    self.ItemIcon_UISprite.spriteName = self.ItemInfo.icon
                end
                self.ItemIcon_UISprite:MakePixelPerfect()
            end
            --endregion

            --region 设置物品颜色
            if self.ItemInfo.type == luaEnumItemType.Equip then
                if self.BagItemInfo.currentLasting >= 0 then
                    local limitingValue = tonumber(CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax())
                    if self.BagItemInfo.currentLasting <= limitingValue then

                        self.ItemIcon_UISprite.color = CS.UnityEngine.Color(232 / 255, 80 / 255, 56 / 255, 1)
                    else
                        self.ItemIcon_UISprite.color = CS.UnityEngine.Color.white
                    end
                else
                    self.ItemIcon_UISprite.color = CS.UnityEngine.Color.white
                end
            else
                self.ItemIcon_UISprite.color = CS.UnityEngine.Color.white
            end
            --endregion

            --region 设置物品堆叠数量
            if self.ItemCount_UILabel and CS.StaticUtility.IsNull(self.ItemCount_UILabel) == false then
                if self.ItemInfo.reuseType ~= nil and self.ItemInfo.reuseType.list ~= nil and self.ItemInfo.reuseType.list[0] == LuaEnumItemUseNumType.ShowUIBagPanel and self.BagItemInfo ~= nil and self.BagItemInfo.leftUseNum ~= nil and self.BagItemInfo.leftUseNum > 1 then
                    self.ItemCount_UILabel.text = info.leftUseNum
                elseif self.ItemInfo.overlying ~= nil and self.ItemInfo.overlying ~= 1 and info.count > 1 then
                    self.ItemCount_UILabel.text = info.count
                else
                    self.ItemCount_UILabel.text = ""
                end
            end
            --endregion
        else
            luaDebug.LogError("Item表中未找到ID为" .. tostring(info.itemId) .. "的物品")
            self:ResetUI(false)
        end
    end
end

---重置UI
---@param isLock boolean 是否为锁定格子
function UIByingPanel_GridItem:ResetUI(isLock)
    if self.ItemIcon_UISprite then
        self.ItemIcon_UISprite.spriteName = ""
    end
    if self.Check_GameObject then
        self.Check_GameObject:SetActive(false)
    end
    if self.CheckSign_UISprite then
        self.CheckSign_UISprite.spriteName = ""
    end
    if  self.ItemCount_UILabel then
        self.ItemCount_UILabel.text = ""
    end
end
return UIByingPanel_GridItem