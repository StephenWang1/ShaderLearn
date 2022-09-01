---@class UISaleOrePanel_UnitTemplate 物品格子模板
local UISaleOrePanel_UnitTemplate = {}

--region 初始化

function UISaleOrePanel_UnitTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()
    self:InitParameters()
end
--初始化变量
function UISaleOrePanel_UnitTemplate:InitParameters()
    self.callBack = nil
    self.itemInfo = nil
    self.lid = 0
    self.maxCount = 0
    self.info = nil
    self.bagItemInfo = nil
    self.stockNum = 0
    -----默认位置为加了库存的，改了不负责
    --self.origionNamePoint = self.Name.transform.localPosition
    --self.origionPricePoint = self.priceObj.transform.localPosition
    -----无库存时 上名字-5，下价格+5
    --self.changeNamePoint = CS.UnityEngine.Vector3(self.origionNamePoint.x, self.origionNamePoint.y - 5, self.origionNamePoint.z)
    --self.changePricePoint = CS.UnityEngine.Vector3(self.origionPricePoint.x, self.origionPricePoint.y + 5, self.origionPricePoint.z)
end

function UISaleOrePanel_UnitTemplate:InitComponents()
    ---@type Top_UISprite Icon
    self.Icon = self:Get("Icon", "Top_UISprite")
    ---@type Top_UILabel 名称
    self.Name = self:Get("Name", "Top_UILabel")
    ---@type Top_UILabel 数量
    self.count = self:Get("count", "Top_UILabel")
    ---@type Top_UILabel 价格
    self.price = self:Get("price/value", "Top_UILabel")
    ---@type Top_UISprite 货币icon
    self.coinIcon = self:Get("price/value/icon", "Top_UISprite")
    ---@type Top_UILabel 库存
    self.stock_Label = self:Get("Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 按钮
    self.Btn_Sale = self:Get("Btn_Sale", "GameObject")
    ---@type Top_UILabel
    self.btn_Label = self:Get("Btn_Sale/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.background = self:Get("background", "Top_UISprite")
    ---@type Top_UILabel 回购显示 数量
    self.cansale = self:Get("cansale", "Top_UILabel")
    ---@type Top_UILabel 回购数量 单价
    self.saleprice = self:Get("saleprice/temp/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject 价格总父物体
    self.priceObj = self:Get("price", "GameObject")
end

function UISaleOrePanel_UnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.Btn_Sale).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn_Sale).OnClickLuaDelegate = function(go)
        if self.callBack ~= nil then
            self.callBack(go.Btn_Sale, self)
        end
    end

    CS.UIEventListener.Get(self.Icon.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Icon.gameObject).OnClickLuaDelegate = self.OnIconClickCallBack
end

function UISaleOrePanel_UnitTemplate:BindNetMessage()

end


--endregion

--region Show
---{
---@param customData table  显示信息
---@field customData.comId    number    商品id
---@field customData.itemID   number    物品id
---@field customData.lid      number    物品lid
---@field customData.tradType number    贸易类型
---@field customData.priceItemid number 贸易需求物品
---@field customData.price    number    价格
---@field customData.maxCount number    最大个数
---@field customData.stockNum number    库存数量
---@field customData.callBack function  点击回调
---@field customData.index    number    用于背景色
---@field customData.bagItemInfo bagV2.BagItemInfo 物品信息
---}
function UISaleOrePanel_UnitTemplate:SetTemplat(customData)
    if customData then
        self.info = customData
        self.bagItemInfo = customData.bagItemInfo
        self.callBack = customData.callBack
        self:SetItemInfo()
        self:RefreshOther()
        self.background.alpha = customData.index % 2 == 0 and 1 or 0.001
    end
end
---刷新购买出售信息
---@private
function UISaleOrePanel_UnitTemplate:RefreshOther()
    self.Name.gameObject:SetActive(self.info.tradType == 1)
    self.saleprice.gameObject:SetActive(self.info.tradType == 2)
    self.price.gameObject:SetActive(true)
    self.cansale.gameObject:SetActive(self.info.tradType == 2)
    self.btn_Label.text = self.info.tradType == 1 and '购买' or '出售'
    self.stock_Label.text = tostring(self.info.stockNum) --.. '/' .. tostring(self.maxCount)
    self.stockNum = self.maxCount == 0 and self.info.stockNum or self.maxCount - self.info.stockNum
    self.cansale.text = '回购数  ' .. tostring(self.stockNum) .. '  个'
    if self.info.price == nil then
        return
    end
    self.price.text = tostring(self.info.price)
    self.lid = self.info.lid
    self:IsShowStockCount()
    --local stockNum = self.maxCount == 0 and self.info.stockNum or self.maxCount - self.info.stockNum
end

---刷新物品相关
---@private
function UISaleOrePanel_UnitTemplate:SetItemInfo()
    local isFindPriceItem, priceItemTable = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.info.priceItemid)
    if (isFindPriceItem) then
        self.coinIcon.spriteName = priceItemTable.icon;
    end
    --self.coinIcon.spriteName = self.info.priceItemid
    local npcInfo = self:GetNPCStoreInfo()
    if npcInfo then
        --self.coinIcon.spriteName = npcInfo.moneyType
        self.maxCount = npcInfo.num
    end
    self.count.text = ""
    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.info.itemId)
    if isFind then
        self.itemInfo = info
        self.Name.text = info.name
        self.Icon.spriteName = info.icon
        self.count.text = (info.reuseAmount ~= nil and info.reuseAmount ~= 0 and info.reuseAmount ~= 1) and tostring(info.reuseAmount) or ""
    end
    if self.bagItemInfo then
        self.Name.text = self.bagItemInfo.ItemFullName
    end

end

---@return TABLE.CFG_NPC_SHOP NPC商店信息
function UISaleOrePanel_UnitTemplate:GetNPCStoreInfo()
    if self.info and self.info.comId then
        ___, self.mNPCStoreInfo = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(self.info.comId)
    end
    return self.mNPCStoreInfo
end

---判断是否显示库存
---@private
function UISaleOrePanel_UnitTemplate:IsShowStockCount()
    local isShowStockLabel = false
    --购买面板 且 类型为2 的不显示库存数量
    if self.info.tradType == 1 then
        if self:GetNPCStoreInfo() then
            isShowStockLabel = self:GetNPCStoreInfo().type ~= 2
        else
            --未在表中找到，即为回收的道具需要显示
            isShowStockLabel = true
        end
    end
    self.stock_Label.gameObject:SetActive(isShowStockLabel)
    --if isShowStockLabel then
    --    self.Name.transform.localPosition = self.origionNamePoint
    --    self.priceObj.transform.localPosition = self.origionPricePoint
    --else
    --    self.Name.transform.localPosition = self.changeNamePoint
    --    self.priceObj.transform.localPosition = self.changePricePoint
    --end
end

--endregion

--region UI函数监听

function UISaleOrePanel_UnitTemplate:OnIconClickCallBack(go)
    if self.info.bagItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.info.bagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
    elseif self.itemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
    end
end

--endregion

--region otherFunction



--endregion


return UISaleOrePanel_UnitTemplate