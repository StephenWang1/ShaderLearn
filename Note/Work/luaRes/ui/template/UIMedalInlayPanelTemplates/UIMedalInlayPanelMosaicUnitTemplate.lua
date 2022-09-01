---@class UIMedalInlayPanelMosaicUnitTemplate 镶嵌位模板
local UIMedalInlayPanelMosaicUnitTemplate = {}

--region 初始化

function UIMedalInlayPanelMosaicUnitTemplate:Init()
    self:InitParameters()
    self:InitComponents()
    self:BindUIMessage()
end
--初始化变量
function UIMedalInlayPanelMosaicUnitTemplate:InitParameters()
    self.lid = nil
    self.index = nil
    self.itemTab = nil
    self.bagInfo = nil
    self.subType = 0
    self.addCallBack = nil
    self.iconCallBack = nil
    self.equipIndex = nil
end

function UIMedalInlayPanelMosaicUnitTemplate:InitComponents()
    ---@type Top_UILabel 名称
    self.lb = self:Get("lb", "Top_UILabel")
    ---@type Top_UISprite item
    self.item = self:Get("Item", "GameObject")
    ---@type Top_UISprite icon
    self.icon = self:Get("Item/icon", "Top_UISprite")
    ---@type UnityEngine.GameObject
    self.add = self:Get("Add", "GameObject")
    ---@type UnityEngine.GameObject
    self.choose = self:Get("choose", "GameObject")
    ---@type Top_UILabel 持久
    self.endurance = self:Get("lb/endurance", "Top_UILabel")
    ---@type UnityEngine.GameObject 更换按钮
    self.btn_replace = self:Get("btn_replace", "GameObject")
end

function UIMedalInlayPanelMosaicUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.add).LuaEventTable = self
    CS.UIEventListener.Get(self.add).OnClickLuaDelegate = self.OnAddBtnClick
    CS.UIEventListener.Get(self.item).LuaEventTable = self
    CS.UIEventListener.Get(self.item).OnClickLuaDelegate = self.OnIconBtnClick
    CS.UIEventListener.Get(self.btn_replace).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_replace).OnClickLuaDelegate = self.OnReplaceBtnClick
end


--endregion

--region UI函数监听
--点击添加
function UIMedalInlayPanelMosaicUnitTemplate:OnAddBtnClick(go)
    if self.addCallBack ~= nil then
        --self.subType, self.index,
        self.addCallBack(go)
    end
end
--点击icon
function UIMedalInlayPanelMosaicUnitTemplate:OnIconBtnClick(go)
    if self.iconCallBack ~= nil then
        self.iconCallBack(self.bagInfo, self.index)
    end
end

--点击更换
function UIMedalInlayPanelMosaicUnitTemplate:OnReplaceBtnClick(go)
    if self.replaceCallBack ~= nil then
        self.replaceCallBack(self.commodityID, self.index)
    end
end

--endregion

--region UI

function UIMedalInlayPanelMosaicUnitTemplate:SetTemplate(customData)
    if customData then
        self.index = customData.index == nil and 0 or customData.index
        self.subType = customData.subType == nil and 0 or customData.subType
        self.commodityID = customData.commodityID == nil and 0 or customData.commodityID
        self.addCallBack = customData.addCallBack
        self.iconCallBack = customData.iconCallBack
        self.replaceCallBack = customData.replaceCallBack
        self.endurance.text = ''
        self:SetInfo(nil, true)
    end
end

function UIMedalInlayPanelMosaicUnitTemplate:SetInfo(bagItemInfo, isEquip, isShow)
    if self.add ~= nil then
        self.add:SetActive(bagItemInfo == nil)
    end
    self.item:SetActive(bagItemInfo ~= nil)
    if bagItemInfo then
        self.bagInfo = bagItemInfo
        self.lid = bagItemInfo.lid
        self.equipIndex = bagItemInfo.index * (-1)
        self.isEquip = isEquip
        self.itemTab = bagItemInfo.ItemTABLE
        self.icon.spriteName = self.itemTab.icon
        self.icon.gameObject:SetActive(true)
        local durableValue = ''
        if (self.itemTab.maxLasting > 0) then
            local currentLastingMaxValue = CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax()
            durableValue = Utility.NewGetBBCode(bagItemInfo.currentLasting > currentLastingMaxValue) .. tostring(bagItemInfo.currentLasting) .. " / " .. tostring(self.itemTab.maxLasting) .. "[-]"
        else
            durableValue = tostring(bagItemInfo.currentLasting) .. " / --"
        end
        self.endurance.text = durableValue
    end
    self:ShowUnitItemInfo(bagItemInfo == nil, isShow == nil and false or isShow)
end

function UIMedalInlayPanelMosaicUnitTemplate:ShowUnitItemInfo(isNull, isShow)
    if isNull then
        self.icon.gameObject:SetActive(false)
        self.endurance.text = ''
        self.lb.text = '荣誉勋章'
        self.btn_replace:SetActive(false)
    else
        self.lb.text = self.bagInfo.ItemFullName
        self.btn_replace:SetActive(not isShow)
    end
end

function UIMedalInlayPanelMosaicUnitTemplate:RefreshChoseState(isNull, isShow)
    self.choose:SetActive(isShow)
end

function UIMedalInlayPanelMosaicUnitTemplate:ClearInfo()
    self:SetInfo(nil, nil, nil)
    self.bagInfo = nil
    self.lid = 0
    self.itemTab = nil
    self.icon.spriteName = ''
    self.endurance.text = ''
end

--endregion

--region otherFunction


--endregion


return UIMedalInlayPanelMosaicUnitTemplate