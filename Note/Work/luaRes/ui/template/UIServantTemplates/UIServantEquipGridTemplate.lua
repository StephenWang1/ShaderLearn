---灵兽装备格子模板
---@class UIServantEquipGridTemplate
local UIServantEquipGridTemplate = {}

--region 组件
function UIServantEquipGridTemplate:GetRedPoint_UIRedPoint()
    if CS.StaticUtility.IsNull(self.mRedPoint_UIRedPoint) then
        self.mRedPoint_UIRedPoint = self:Get("RedPoint", "Top_UIRedPoint")
        if self.mRedPoint_UIRedPoint == nil then
            local mRedPoint_GameObject = self:Get("RedPoint", "GameObject")
            if CS.StaticUtility.IsNull(mRedPoint_GameObject) == false then
                self.mRedPoint_UIRedPoint = CS.Utility_Lua.AddComponent(mRedPoint_GameObject, "Top_UIRedPoint")
            end
        end
    end
    return self.mRedPoint_UIRedPoint
end
--endregion

--region 基础数据
---装备耐久较少最大值
function UIServantEquipGridTemplate:GetLimitingValue()
    if self.LimitingValue == nil or self.LimitingValue == 0 then
        self.LimitingValue = tonumber(CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax())
    end
    return self.LimitingValue
end
--endregion

---@param Panel UIServantPanel
function UIServantEquipGridTemplate:Init(Panel)
    ---@typw UIServantPanel
    self.ServantPanel = Panel
    self:InitComponents()
    self:InitParameters()
end

function UIServantEquipGridTemplate:InitComponents()
    ---强化
    self.Strengthen_UILabel = self:Get("icon/quality", "UILabel")
    self.Star_Sp = self:Get("icon/star", "UISprite")
    ---Icon
    self.ItemIcon_UISprite = self:Get("icon", "UISprite")
    ---添加符合
    self.Add_GameObject = self:Get("add", "GameObject")
    ---背景
    self.BackGround_GameObject = self:Get("background/Sprite", "GameObject")
    ---选中框
    self.Choose_GameObject = self:Get("choose", "GameObject")
    ---品质
    self.Frame_UISprite = self:Get("icon/frame", "UISprite")
    ---维修选中
    self.mRepairChoose_GameObject = self:Get("check", "GameObject")
    ---@type Top_TweenShake
    ---抖动组件
    self.IconShake_TweenShake = self:Get("icon", "Top_TweenShake")
    ---红点
    self.redPoint_GameObject = self:Get("RedPoint", "GameObject")
    self.ItemIcon_UISprite.gameObject:SetActive(true)
end

function UIServantEquipGridTemplate:InitParameters()
    ---背包物品信息,bagV2.BagItemInfo类型
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = nil
    ---物品信息,TABLE.CFG_ITEMS类型
    ---@type TABLE.CFG_ITEMS
    self.ItemInfo = nil
end

function UIServantEquipGridTemplate:SetEquipPosIndex(equipPosIndex, servantType)
    self.mEquipPosIndex = equipPosIndex;
    self.mServantType = servantType
end

---@return boolean
function UIServantEquipGridTemplate:IsServantRoleEquip()
    return gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():IsServantRoleEquipIndex(self:GetEquipPosIndex())
end

function UIServantEquipGridTemplate:GetEquipPosIndex()
    return self.mEquipPosIndex;
end

---刷新装备
---@param info bagV2.BagItemInfo 装备信息
---@param type number 显示类型
function UIServantEquipGridTemplate:RefreshEquip(info, type)
    self:ResetEquip()
    if info == nil then
        return
    end

    self.BagItemInfo = info
    local res
    res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
    if res then
        self:RefreshGrid(self.BagItemInfo, self.ItemInfo, type)
    end
    self:RefreshFrame()
    self:PlayShakeTween()
    self:RefreshOther()
end

---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@param type number 显示类型
function UIServantEquipGridTemplate:RefreshGrid(bagItemInfo, itemInfo, type)
    if itemInfo == nil then
        return
    end
    if type == nil then
        type = LuaEnumServantEquipShowColorType.Normal
    end
    if self.ItemIcon_UISprite then
        self.ItemIcon_UISprite.spriteName = itemInfo.icon
        if type == LuaEnumServantEquipShowColorType.Gray then
            self.ItemIcon_UISprite.color = LuaEnumUnityColorType.Gray
        else
            self.ItemIcon_UISprite.color = LuaEnumUnityColorType.Normal
        end
    end
    --强化
    if self.Strengthen_UILabel then
        local isShow = bagItemInfo ~= nil and bagItemInfo.intensify ~= 0
        if isShow then
            local showInfo, icon = Utility.GetIntensifyShow(bagItemInfo.intensify)
            if CS.StaticUtility.IsNull(self.Star_Sp) == false then
                self.Star_Sp.spriteName = icon
            end
            self.Strengthen_UILabel.text = showInfo
        end
        self.Strengthen_UILabel.gameObject:SetActive(isShow)
        if CS.StaticUtility.IsNull(self.Star_Sp) == false then
            self.Star_Sp.gameObject:SetActive(isShow)
        end
    end
    --Add
    if self.Add_GameObject then
        self.Add_GameObject:SetActive(false)
    end
    --背景
    if self.BackGround_GameObject then
        self.BackGround_GameObject:SetActive(false)
    end

    if (type == LuaEnumServantEquipShowColorType.Normal) then
        if bagItemInfo ~= nil and bagItemInfo.currentLasting >= -10 and bagItemInfo.currentLasting <= self:GetLimitingValue() then
            if self.ItemIcon_UISprite and itemInfo ~= nil and itemInfo.isWastageLasting > -1 then
                self.ItemIcon_UISprite.color = CS.UnityEngine.Color(232 / 255, 80 / 255, 56 / 255)
            else
                self.ItemIcon_UISprite.color = CS.UnityEngine.Color.white
            end
        end
    end
end

---重置装备
function UIServantEquipGridTemplate:ResetEquip()
    self.BagItemInfo = nil
    self.ItemInfo = nil
    if self.ItemIcon_UISprite then
        self.ItemIcon_UISprite.color = LuaEnumUnityColorType.Transparent
    end
    if self.Add_GameObject then
        self.Add_GameObject:SetActive(false)
    end
    if self.BackGround_GameObject then
        self.BackGround_GameObject:SetActive(true)
    end
    if CS.StaticUtility.IsNull(self:GetRedPoint_UIRedPoint()) == false then
        self:GetRedPoint_UIRedPoint():RemoveRedPointKey()
        self:GetRedPoint_UIRedPoint().gameObject:SetActive(false)
    end
end

---没有装备时候的刷新
---@param equipIndex number
---@param servantType number
function UIServantEquipGridTemplate:NoEquipRefresh(equipIndex, servantType)
    if servantType == nil then
        return
    end
    local curServantIndex = equipIndex - servantType * 1000
    ---灵兽法宝刷新
    if curServantIndex == self.mEquipPosIndex and curServantIndex == 6 then
        local equipIndexDefaultEquipConfigInfo = LuaGlobalTableDeal.GetServantMagicEquipDefaultEquipInfo(equipIndex)
        if equipIndexDefaultEquipConfigInfo == nil then
            return
        end
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(equipIndexDefaultEquipConfigInfo.itemId)
        if itemInfoIsFind == true then
            self.ItemInfo = itemInfo
            self:RefreshGrid(nil, self.ItemInfo, LuaEnumServantEquipShowColorType.Gray)
            self:RefreshFrame()
        end
    end
end

---设置选中
function UIServantEquipGridTemplate:SetItemChoose(isChoose)
    if CS.StaticUtility.IsNull(self.Choose_GameObject) == false then
        self.Choose_GameObject:SetActive(isChoose)
    end
end

---刷新品质
function UIServantEquipGridTemplate:RefreshFrame()
    self.Frame_UISprite.gameObject:SetActive(false)
    --if CS.StaticUtility.IsNull(self.Frame_UISprite) == false then
    --    self.Frame_UISprite.gameObject:SetActive(self.ItemInfo ~= nil)
    --    self.Frame_UISprite.spriteName = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipFrameIcon(self.ItemInfo)
    --end
end

---设置维修道具选中
---@param isChoose boolean 是否选中
function UIServantEquipGridTemplate:SetItemRepairChoose(isChoose)
    if isChoose == nil then
        isChoose = false
    end
    if not CS.StaticUtility.IsNull(self.mRepairChoose_GameObject) then
        self.mRepairChoose_GameObject:SetActive(isChoose)
    end
end

--region 装备抖动
---播放抖动动画
function UIServantEquipGridTemplate:PlayShakeTween()
    if self.ServantPanel and self.ServantPanel:GetServantInfo():CheckIsNeedShake(self.BagItemInfo.lid) then
        if not CS.StaticUtility.IsNull(self.IconShake_TweenShake) then
            self.IconShake_TweenShake:PlayShake()
        end
    end
end
--endregion

---刷新其他
function UIServantEquipGridTemplate:RefreshOther()

end

return UIServantEquipGridTemplate