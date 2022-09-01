---UI物品
---@class UIItem:TemplateBase UI物品
local UIItem = {}

--region 参数
---物品信息
---@type TABLE.CFG_ITEMS
UIItem.ItemInfo = nil

UIItem.mExtraEquipIconList = nil;
--endregion

--region 组件
---物品标签
function UIItem:GetItemSign_UISprite()
    if self.mItemSign_UISprite == nil then
        self.mItemSign_UISprite = self:Get("sign", "UISprite")
    end
    return self.mItemSign_UISprite
end

---物品ICON
function UIItem:GetItemIcon_UISprite()
    if self.mItemIcon_UISprite == nil then
        self.mItemIcon_UISprite = self:Get("icon", "UISprite")
    end
    return self.mItemIcon_UISprite
end

---血继GameObject
---@return UnityEngine.GameObject
function UIItem:GetBloodSuitLvGO()
    if self.mBloodSuitLvGo == nil then
        self.mBloodSuitLvGo = self:Get("BloodLv", "GameObject")
    end
    return self.mBloodSuitLvGo
end

---血继文本的Label
---@return UILabel
function UIItem:GetBloodSuitLvLabel()
    if self.mBloodSuitLvLabel == nil then
        self.mBloodSuitLvLabel = self:Get("BloodLv/Label", "UILabel")
    end
    return self.mBloodSuitLvLabel
end

---物品边框
function UIItem:GetItemFrame_UISprite()
    if self.mItemFrame_UISprite == nil then
        self.mItemFrame_UISprite = self:Get("frame", "UISprite")
    end
    return self.mItemFrame_UISprite
end

---特效图片
function UIItem:GetResSprite_UISprite()
    if self.mResSprite_UISprite == nil then
        self.mResSprite_UISprite = self:Get("bgEffect", "UISprite")
    end
    return self.mResSprite_UISprite
end

---物品数量
function UIItem:GetItemCount_UILabel()
    if self.mItemCount_UILabel == nil then
        self.mItemCount_UILabel = self:Get("count", "UILabel")
    end
    return self.mItemCount_UILabel
end

---物品强化
function UIItem:GetItemStrength_UILabel()
    if self.mItemStrength_UILabel == nil then
        self.mItemStrength_UILabel = self:Get("icon/quality", "UILabel")
    end
    return self.mItemStrength_UILabel
end

---物品名
function UIItem:GetItemName_UILabel()
    if self.mItemName_UILabel == nil then
        self.mItemName_UILabel = self:Get("name", "UILabel")
    end
    return self.mItemName_UILabel
end

---绑定锁定标记
function UIItem:GetBindLock_GameObject()
    if self.mBindLock_GameObject == nil then
        self.mBindLock_GameObject = self:Get("BindLock", "GameObject")
    end
    return self.mBindLock_GameObject
end

---镶嵌ICON
function UIItem:GetOverLayicon_GameObject()
    if self.mOverLayicon_GameObject == nil then
        self.mOverLayicon_GameObject = self:Get("icon/overLayicon", "UISprite")
    end
    return self.mOverLayicon_GameObject
end

--region 印记
function UIItem:Signet()
    if self.mSignet == nil then
        self.mSignet = self:Get("yinji", "GameObject")
    end
    return self.mSignet
end
---印记Icon
function UIItem:GetSignetIcon_UISprite()
    if self.mSignetIcon == nil then
        self.mSignetIcon = self:Get("yinji/yinji1", "UISprite")
    end
    return self.mSignetIcon
end
---印记添加图标
function UIItem:GetSignetAdd()
    if self.mGetSignetAdd == nil then
        self.mGetSignetAdd = self:Get("yinji/yinjiadd", "UISprite")
    end
    return self.mGetSignetAdd
end
---印记镶嵌Icon
function UIItem:GetSignetInlayIcon()
    if self.mSignetInlayIcon == nil then
        self.mSignetInlayIcon = self:Get("yinji/yinjiicon", "UISprite")
    end
    return self.mSignetInlayIcon
end
---印记已添加图标底图
function UIItem:GetSignetInlayIconBg()
    if self.mGetSignetInlayIconBg == nil then
        self.mGetSignetInlayIconBg = self:Get("yinji/yinjiicon/k", "UISprite")
    end
    return self.mGetSignetInlayIconBg
end
---印记冲突图标
function UIItem:GetSignetconflict()
    if self.mGetSignetconflict == nil then
        self.mGetSignetconflict = self:Get("yinji/yinjichongtu", "GameObject")
    end
    return self.mGetSignetconflict
end

---加号
function UIItem:GetAdd()
    if self.mGetAdd == nil then
        self.mGetAdd = self:Get("add", "UISprite")
    end
    return self.mGetAdd
end

function UIItem:GetmoverLayicon2()
    if self.moverLayicon2 == nil then
        local overLayicon2 = self:GetItemIcon_UISprite().transform:Find("overLayicon2")
        if overLayicon2 ~= nil then
            self.moverLayicon2 = CS.Utility_Lua.GetComponent(overLayicon2, "UISprite")
        end
    end
    return self.moverLayicon2
end

---概率标签
function UIItem:GetGaiLv_GameObject()
    if self.gaiLvIcon == nil then
        self.gaiLvIcon = self:Get("gailv", "GameObject")
    end
    return self.gaiLvIcon
end
--endregion


---点击事件监听
---@return UIEventListener
function UIItem:GetEventListener()
    if self.mEventListener == nil then
        self.mEventListener = CS.UIEventListener.Get(self.go)
    end
    return self.mEventListener
end

---选中标识
---@return UnityEngine.GameObject
function UIItem:GetSelectSign_GameObject()
    if self.mSelectSign_GameObject == nil then
        self.mSelectSign_GameObject = self:Get("choose", "GameObject")
    end
    return self.mSelectSign_GameObject
end

---装备格子背景图
---@return UnityEngine.GameObject
function UIItem:GetBackGround_UISprite()
    if self.mBackGround_UISprite == nil then
        self.mBackGround_UISprite = self:Get("background/Sprite", "UISprite")
    end
    return self.mBackGround_UISprite
end

---特效节点
---@return UnityEngine.GameObject
function UIItem:GetEffect_GameObject()
    if self.mEffect_GameObject == nil then
        self.mEffect_GameObject = self:Get("effect", "GameObject")
    end
    return self.mEffect_GameObject
end

---元素提示图片
function UIItem:GetEleAdd_UISprite()
    if self.mEleAdd_UISprite == nil then
        self.mEleAdd_UISprite = self:Get("eleadd", "UISprite")
    end
    return self.mEleAdd_UISprite
end

---装备标签（专属等）
function UIItem:GetItemTag_UISprite()
    if self.mItemTag_UISprite == nil then
        self.mItemTag_UISprite = self:Get("tag", "UISprite")
    end
    return self.mItemTag_UISprite
end

function UIItem:GetExtraEquipIconList()
    ---镶嵌ICON UISprite 列表
    if (self.mExtraEquipIconList == nil) then
        self.mExtraEquipIconList = {};
        if (self:GetOverLayicon_GameObject() ~= nil) then
            table.insert(self.mExtraEquipIconList, CS.Utility_Lua.GetComponent(self:GetOverLayicon_GameObject().transform, "UISprite"));
        end
        if (self:GetmoverLayicon2() ~= nil) then
            table.insert(self.mExtraEquipIconList, self:GetmoverLayicon2());
        end
    end
    return self.mExtraEquipIconList;
end

---投保标识
function UIItem:GetInsure_UISprite()
    if self.mInsure_UISprite == nil then
        self.mInsure_UISprite = self:Get("Insure", "UISprite")
    end
    return self.mInsure_UISprite
end
--endregion

--region 锁定状态
---获取物品锁定状态
---@return boolean
function UIItem:GetIsLock()
    if self.mIsLock == nil then
        self.mIsLock = false
    end
    return self.mIsLock
end

---设置物品的锁定状态
---@param isLock boolean
function UIItem:SetIsLock(isLock)
    if isLock == nil then
        isLock = false
    end
    self.mIsLock = isLock
    self:GetItemIcon_UISprite().color = ternary(isLock, CS.UnityEngine.Color.black, CS.UnityEngine.Color.white)
end
--endregion

--region 选中状态
---设置为选中状态
function UIItem:SetAsSelectedState()
    if self:GetSelectSign_GameObject() ~= nil and CS.StaticUtility.IsNull(self:GetSelectSign_GameObject()) == false then
        self:GetSelectSign_GameObject():SetActive(true)
    end
end

---设置为非选中状态
function UIItem:SetAsUnselectedState()
    if self:GetSelectSign_GameObject() ~= nil and CS.StaticUtility.IsNull(self:GetSelectSign_GameObject()) == false then
        self:GetSelectSign_GameObject():SetActive(false)
    end
end
--endregion

--region 初始化
function UIItem:Init()
    self:ResetUI()
    self:BindUIEvent()
    self:RunBaseFunction("Init")
end

function UIItem:BindUIEvent()

    if self:GetItemIcon_UISprite() ~= nil then
        self.ClickIconCallBack = function()
            self:OnClickIconCallBack()
        end
        CS.UIEventListener.Get(self:GetItemIcon_UISprite().gameObject).onClick = self.ClickIconCallBack
    end

    if self.go ~= nil then
        self.ClickIconCallBack = function()
            self:OnClickIconCallBack()
        end
        CS.UIEventListener.Get(self.go).onClick = self.ClickIconCallBack
    end

end

--endregion

--region UI函数监听

function UIItem:OnClickIconCallBack()
    if self.showItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.showItemInfo, showRight = false })
    end
end

--endregion


--region 刷新与重置UI
---使用物品信息刷新UI
---@param itemInfo TABLE.CFG_ITEMS 类型物品信息
---@param count XLua.Cast.Int32  默认为1
---@param equipLevel XLua.Cast.Int32 默认为1
---@param bagItemInfo bagV2.BagItemInfo
---@param showCount boolean
function UIItem:RefreshUIWithItemInfo(itemInfo, count, equipLevel, bagItemInfo, showCount)
    if itemInfo ~= nil then
        if equipLevel == nil or type(equipLevel) ~= "number" then
            equipLevel = 1
        end
        if count == nil or type(count) ~= "number" then
            count = 1
        end
        --缓存物品信息
        self.ItemInfo = itemInfo
        --显示物品数量
        local showCountStr = ""
        if count >= 100000 then
            showCountStr = string.format("%.1f", tostring(count / 10000)) .. "万"
        else
            if count >= 2 or showCount == true then
                showCountStr = tostring(count)
            end
        end
        if self:GetItemCount_UILabel() ~= nil then
            self:GetItemCount_UILabel().gameObject:SetActive(true)
            self:GetItemCount_UILabel().text = showCountStr
        end
        --显示物品图标
        if self:GetItemIcon_UISprite() ~= nil and itemInfo ~= nil then
            self:GetItemIcon_UISprite().gameObject:SetActive(true)
            local spriteName = tostring(itemInfo.icon)
            local spriteColor = LuaEnumUnityColorType.Normal
            if LuaGlobalTableDeal.IsServantDefaultMagicEquip(itemInfo.id) then
                spriteColor = LuaEnumUnityColorType.Gray
            end
            luaclass.UIRefresh:RefreshSprite(self:GetItemIcon_UISprite(), spriteName, spriteColor)
            --self:GetItemIcon_UISprite():MakePixelPerfect()
        end
        if self:GetBloodSuitLvGO() ~= nil and itemInfo ~= nil then
            local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
            if bloodsuitTbl and bagItemInfo and bagItemInfo.ItemTABLE ~= nil and bagItemInfo.bloodLevel > 0 then
                self:GetBloodSuitLvGO():SetActive(true)
                self:GetBloodSuitLvLabel().text = tostring(bagItemInfo.bloodLevel)
            else
                self:GetBloodSuitLvGO():SetActive(false)
            end
        end

        --显示物品名称
        if self:GetItemName_UILabel() ~= nil then
            self:GetItemName_UILabel().gameObject:SetActive(true)
            self:GetItemName_UILabel().text = itemInfo.name
        end

        --耐久值
        if self:GetItemFrame_UISprite() ~= nil then
            --self:GetItemFrame_UISprite().gameObject:SetActive(false)--暂时全隐藏
            --if itemInfo.type ~= luaEnumItemType.Equip then
            --    if itemInfo.quality == 0 then
            --        --0:白
            --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
            --        self:GetItemFrame_UISprite().spriteName = "quality_white"
            --    elseif itemInfo.quality == 1 then
            --        --1:绿
            --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
            --        self:GetItemFrame_UISprite().spriteName = "quality_green"
            --    elseif itemInfo.quality == 2 then
            --        --2:紫
            --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
            --        self:GetItemFrame_UISprite().spriteName = "quality_purple"
            --    elseif itemInfo.quality == 3 then
            --        --3:橙
            --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
            --        self:GetItemFrame_UISprite().spriteName = "quality_yellow"
            --    elseif itemInfo.quality == 4 then
            --        --4:红
            --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
            --        self:GetItemFrame_UISprite().spriteName = "quality_red"
            --    else
            --        --超出定义,隐藏
            --        self:GetItemFrame_UISprite().gameObject:SetActive(false)
            --    end
            --end
        end
        --显示物品强化
        if self:GetItemStrength_UILabel() ~= nil then
            self:GetItemStrength_UILabel().gameObject:SetActive(true)
            self:GetItemStrength_UILabel().text = ternary(equipLevel > 0, "[00ff00]+" .. tostring(equipLevel), "")
        end
        --隐藏装备标签
        if self:GetItemTag_UISprite() ~= nil and not CS.StaticUtility.IsNull(self:GetItemTag_UISprite().gameObject) then
            if self:GetItemTag_UISprite().gameObject.activeSelf then
                self:GetItemTag_UISprite().gameObject:SetActive(false)
            end
        end
    end
    if (bagItemInfo ~= nil) then
        luaclass.UIRefresh:RefreshActive(self:GetInsure_UISprite(), gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo))
    end
    --self:RefreshGemIcon(nil)
end

---刷新其他 (一定先调用上方的)
---@param customData table
---{
---@field customData.tag string 装备标识
---@field customData.showItemInfo TABLE.CFG_ITEMS 点击显示的装备信息
---}
function UIItem:RefreshOtherUI(customData)
    if customData == nil then
        return
    end
    if customData.tag ~= nil then
        if self:GetItemTag_UISprite() ~= nil and not CS.StaticUtility.IsNull(self:GetItemTag_UISprite().gameObject) then
            self:GetItemTag_UISprite().spriteName = customData.tag
            self:GetItemTag_UISprite().gameObject:SetActive(customData.tag ~= "")
        end
    end
    self.showItemInfo = customData.showItemInfo
end

---设置showItemInfo
function UIItem:SetShowItemInfo(showItemInfo)
    self.showItemInfo = showItemInfo
end

---额外装备添加
function UIItem:AddExtraEquips(v)
    if (self.mExtraEquipDic == nil) then
        self.mExtraEquipDic = {};
    end
    self.mExtraEquipDic = v
end

---获得额外装备id字典
function UIItem:GetExtraEquipDic()
    if (self.mExtraEquipDic ~= nil) then
        return self.mExtraEquipDic
    end
    return nil;
end

function UIItem:RefreshGemIcon(bagItemInfo)
    local hasEquip = false;
    --if bagItemInfo.index == 0 then
    --    return
    --end
    --if (self.ItemInfo ~= nil and self.ItemInfo.type == luaEnumItemType.Equip and bagItemInfo.index ~= 0) then
    --    hasEquip = true;
    --end
    if (self.ItemInfo ~= nil and self.ItemInfo.type == luaEnumItemType.Equip and bagItemInfo ~= nil) then
        hasEquip = true;
    end
    self:RefreshGemIconBySubType(self.ItemInfo.subType, hasEquip)
end

function UIItem:RefreshGemIconBySubType(subType, hasEquip)
    local extraEquipDic = self.mExtraEquipDic
    local extraEquipIconList = self:GetExtraEquipIconList();
    local index = 1;

    for k, v in pairs(extraEquipIconList) do
        v.gameObject:SetActive(false);
    end

    if (extraEquipDic ~= nil) then
        for k, v in pairs(extraEquipDic) do
            self:RefreshOverLayicon(v, extraEquipIconList[index]);
            index = index + 1;
        end
    end

    if (not hasEquip) then
        self:GetItemIcon_UISprite().gameObject:SetActive(true)
        local iconId = CS.Cfg_GlobalTableManager.Instance:GetFurnaceDefaultIcon(self.equipIndex);
        if (iconId ~= nil) then
            self:GetItemIcon_UISprite().spriteName = iconId;
        else
            self:GetItemIcon_UISprite().spriteName = tostring(self.ItemInfo.icon)
        end
    else
        self:GetItemIcon_UISprite().spriteName = tostring(self.ItemInfo.icon)
    end
end

function UIItem:RefreshItemIcon(bagItemInfo)
    --print(self.ItemInfo.reuseType.list[0])
    if self:GetItemIcon_UISprite() ~= nil and bagItemInfo ~= nil and bagItemInfo.leftUseNum ~= nil and bagItemInfo.leftUseNum == 1 and self.ItemInfo.reuseType ~= nil and self.ItemInfo.reuseType.list ~= nil and self.ItemInfo.reuseType.list.Count >= 2 then
        self:GetItemIcon_UISprite().spriteName = tostring(self.ItemInfo.reuseType.list[1])
    end
end

---刷新概率标签显示
---@param show boolean 是否显示概率标签
function UIItem:RefreshGaiLvIcon(show)
    if CS.StaticUtility.IsNull(self:GetGaiLv_GameObject()) == false then
        self:GetGaiLv_GameObject():SetActive(show)
    end
end

--function UIItem:RefreshGemIcon_EquipIndex(bagItemInfo,equipIndex)
--    if equipIndex ~= nil then
--        self.equipIndex = equipIndex
--        self:RefreshGemIcon(bagItemInfo)
--    end
--end

---设置镶嵌icon
---@param itemId 镶嵌元素的iconid
---@param overlayIcon icon对象
function UIItem:RefreshOverLayicon(itemId, overlayIcon)
    if itemId ~= 0 and overlayIcon ~= nil then
        local InLayItem = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId)
        overlayIcon.gameObject:SetActive(true)
        self:RefreshOverLayiconPosition(itemId, overlayIcon)
        if InLayItem ~= nil then
            overlayIcon.spriteName = InLayItem.icon
        end
    else
        overlayIcon.gameObject:SetActive(false)
    end
end

---设置镶嵌icon的和尺寸
function UIItem:RefreshOverLayiconPosition(itemId, overlayIcon)
    if itemId == nil or itemId == 0 or overlayIcon == nil then
        return
    end
    local pos = CS.Cfg_GlobalTableManager.Instance:GetGemExtraEquipIconPosByItemId(itemId)
    local size = CS.Cfg_GlobalTableManager.Instance:GetGemExtraEquipIconSizeByItemId(itemId)
    overlayIcon.transform.localPosition = pos
    overlayIcon.transform.localScale = CS.UnityEngine.Vector3.one * size
end

---重置UI
---@param isRemoveClick 是否移除点击事件 默认不移除
function UIItem:ResetUI(isRemoveClick)
    if isRemoveClick == nil then
        isRemoveClick = false
    end
    if self:GetItemIcon_UISprite() ~= nil then
        self:GetItemIcon_UISprite().gameObject:SetActive(false)
    end
    if self:GetItemCount_UILabel() ~= nil then
        self:GetItemCount_UILabel().gameObject:SetActive(false)
    end
    if self:GetItemFrame_UISprite() ~= nil then
        --self:GetItemFrame_UISprite().gameObject:SetActive(false)
    end
    if self:GetResSprite_UISprite() ~= nil then
        self:GetResSprite_UISprite().gameObject:SetActive(false)
    end
    if self:GetItemStrength_UILabel() ~= nil then
        self:GetItemStrength_UILabel().text = ""
    end
    if self:GetItemName_UILabel() ~= nil then
        self:GetItemName_UILabel().text = ""
    end
    if self:GetItemCount_UILabel() ~= nil then
        self:GetItemCount_UILabel().text = ""
    end
    self:SetAsUnselectedState()
    if isRemoveClick == true then
        self:GetEventListener().onClick = nil
        self:GetEventListener().LuaEventTable = nil
        self:GetEventListener().OnClickLuaDelegate = nil
    end
    self.mIsLock = false
    self.Index = -1.
    self.ItemInfo = nil
end

function UIItem:RefreshName(name)
    if self:GetItemName_UILabel() ~= nil and name ~= nil then
        self:GetItemName_UILabel().gameObject:SetActive(true)
        self:GetItemName_UILabel().text = name
    end
end
--endregion

function UIItem:SetShowExtraEquip(extraEquipId, type)
    if (self.ItemInfo.subType == LuaEnumEquiptype.Light and type == LuaEnumEquiptype.LightComponent)
            or (self.ItemInfo.subType == LuaEnumEquiptype.Baoshishoutao and type == LuaEnumEquiptype.Gem)
            or (self.ItemInfo.subType == LuaEnumEquiptype.SoulJade and type == LuaEnumEquiptype.ShengMingJingPo)
            or (self.ItemInfo.subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling and type == LuaEnumEquiptype.Jingongzhiyuan)
            or (self.ItemInfo.subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling and type == LuaEnumEquiptype.Shouhuzhiyuan)
    then
        self:RefreshOverLayicon(extraEquipId, self:GetOverLayicon_GameObject())
    end
end

--region OnDestroy
function UIItem:OnDestroy()
    self.mItemIcon_UISprite = nil
    self.mItemFrame_UISprite = nil
    self.mItemCount_UILabel = nil
    self.mItemName_UILabel = nil
    self.mItemStrength_UILabel = nil
    self.ItemInfo = nil
end
--endregion

return UIItem
