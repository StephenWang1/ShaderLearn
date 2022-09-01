---@class UIMagicCirclePanel:UIBase 法阵面板
local UIMagicCirclePanel = {}

--region 初始化
function UIMagicCirclePanel:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UIMagicCirclePanel:Show()
    networkRequest.ReqZhenfaInfo()
end

function UIMagicCirclePanel:InitComponents()
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/events/Btn_Close", "GameObject")
    self.name_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/Head/name", "UILabel")
    self.maxLevel_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Head/maxLevel", "GameObject")
    self.arrow_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Head/arrow", "GameObject")
    self.curLevel_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/Head/arrow/curLevel", "UILabel")
    self.nextLevel_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/Head/arrow/nextLevel", "UILabel")
    self.expBar_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Head/lv_bg", "GameObject")
    self.expBar_UISprite = self:GetCurComp("WidgetRoot/UIMainPanel/Head/lv_bg/roleexp", "UISprite")
    self.expBar_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/Head/lv_bg/roleexpvalue", "UILabel")
    self.zhenFaUpAttributes = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Tabel/Center/Scroll View/arributelist", "UIGridContainer")
    self.conditions_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Tabel/Bottom", "GameObject")
    self.zhenFaUpConditions = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Tabel/Bottom/Scroll View/change", "UIGridContainer")
    self.upgradeBtn_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Btn_Upgrade", "GameObject")
    self.zhenFaUpMax_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/maxSprite", "GameObject")
    self.gold_UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/gold", "UILabel")
    self.helpBtn_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
end

function UIMagicCirclePanel:InitParameters()
    self.zhenFaInfo = nil
    self.carrer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    self.isEnoughMaterial = true
    self.isEnoughCurrency = true
    self.isUpBtnPress = false
    self.coroutineZhenFaUp = nil
end

function UIMagicCirclePanel:BindUIEvents()
    ---点击关闭按钮
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        uimanager:ClosePanel("UIMagicCirclePanel")
        uimanager:ClosePanel("UIMagicCircleRolePanel")
    end
    ---点击帮助按钮
    CS.UIEventListener.Get(self.helpBtn_GameObject).onClick = function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(230)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end
end

function UIMagicCirclePanel:BindNetMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResZhenfaInfoMessage, self.OnResZhenfaInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipChangeMessage, self.OnResEquipChangeMessage)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, self.OnBagChangedCallBack)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, self.OnBagChangedCallBack)
end
--endregion

--region 消息处理
function UIMagicCirclePanel.OnResZhenfaInfoMessage(msgId, tblData, csData)
    UIMagicCirclePanel.zhenFaInfo = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo()
    UIMagicCirclePanel:RefreshZhenFa()
    UIMagicCirclePanel:RefreshZhenFaRole()
    if UIMagicCirclePanel.isUpBtnPress then
        UIMagicCirclePanel:ZhenFaUp(UIMagicCirclePanel.upgradeBtn_GameObject)
    end
end

function UIMagicCirclePanel.OnResEquipChangeMessage(msgId, tblData, csData)
    UIMagicCirclePanel:RefreshZhenFaRole()
end

function UIMagicCirclePanel.OnBagChangedCallBack()
    UIMagicCirclePanel:RefreshUpConditions()
    UIMagicCirclePanel:RefreshZhenFaRole()
end
--endregion

function UIMagicCirclePanel:RefreshZhenFa()
    local zhenFaTable = self.zhenFaInfo:GetZhenFaTable()
    local nextZhenFaTable = self.zhenFaInfo:GetNextZhenFaTable()
    self.name_UILabel.text = string.CSFormat("{0}", zhenFaTable.name)
    self.curLevel_UILabel.text = zhenFaTable.level
    if nextZhenFaTable then
        self.nextLevel_UILabel.text = nextZhenFaTable.level
    end
    if zhenFaTable.level >= 15 then
        self.expBar_UISprite.fillAmount = 1
        self.expBar_UILabel.text = string.CSFormat("{0}/{1}", 51450, 51450)
    else
        self.expBar_UISprite.fillAmount = self.zhenFaInfo:GetZhenFaExp() / zhenFaTable.expSum
        self.expBar_UILabel.text = string.CSFormat("{0}/{1}", self.zhenFaInfo:GetZhenFaExp(), zhenFaTable.expSum)
    end

    self:RefreshUpAttributes()
    self:RefreshUpStatus()
end

function UIMagicCirclePanel:RefreshUpAttributes()
    local tbl = self:GetAttributeList()
    self.zhenFaUpAttributes.MaxCount = #tbl
    for i = 1, #tbl do
        local go = self.zhenFaUpAttributes.controlList[i - 1]
        local curLabel = CS.Utility_Lua.GetComponent(go.transform:Find("curattribute/attack"), "UILabel")
        local nextLabel = CS.Utility_Lua.GetComponent(go.transform:Find("nextattribute/attack"), "UILabel")
        local name = CS.Utility_Lua.GetComponent(go.transform:Find("curattribute/attack/name"), "UILabel")

        local curIsNull = tbl[i].curMaxValue == nil and tbl[i].curMinValue == nil
        local nextIsNull = tbl[i].nextMaxValue == nil and tbl[i].nextMinValue == nil
        local color = luaEnumColorType.Green3
        name.text = tbl[i].str
        curLabel.text = curIsNull and '暂无' or tbl[i].curMaxValue == nil and tostring(tbl[i].curMinValue) or tostring(tbl[i].curMinValue) .. '-' .. tostring(tbl[i].curMaxValue)
        nextLabel.text = nextIsNull and color .. '已达最大' or tbl[i].nextMaxValue == nil and color .. tostring(tbl[i].nextMinValue) or color .. tostring(tbl[i].nextMinValue) .. '-' .. tostring(tbl[i].nextMaxValue)
    end
end

---@return table<number,zhenFaAttribute>
function UIMagicCirclePanel:GetAttributeList()
    local attributeNum = 4
    local tbl = {}
    for i = 1, attributeNum do
        local attributeTbl = self:GetAttributeShowData(i)
        if attributeTbl ~= nil then
            table.insert(tbl, attributeTbl)
        end
    end
    return tbl
end

function UIMagicCirclePanel:GetAttributeShowData(type)
    local mStr = ""
    local mCurMinValue = nil
    local mCurMaxValue = nil
    local mNextMinValue = nil
    local mNextMaxValue = nil

    local curExtraAttributeId = self.zhenFaInfo:GetZhenFaTable().attribute
    local nextExtraAttributeId = 0
    if self.zhenFaInfo:GetNextZhenFaTable() then
        nextExtraAttributeId = self.zhenFaInfo:GetNextZhenFaTable().attribute
    end
    local cfg_extra_mon_effectManager = clientTableManager.cfg_extra_mon_effectManager
    if type == 1 then
        mStr = Utility.GetCareerAttackName(self.carrer)
        if curExtraAttributeId > 0 then
            mCurMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.PhyAttackMin, self.carrer)
            mCurMaxValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.PhyAttackMax, self.carrer)
        end
        if nextExtraAttributeId > 0 then
            mNextMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.PhyAttackMin, self.carrer)
            mNextMaxValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.PhyAttackMax, self.carrer)
        end
    elseif type == 2 then
        mStr = "防御"
        if curExtraAttributeId > 0 then
            mCurMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.PhyDefenceMin, self.carrer)
            mCurMaxValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.PhyDefenceMax, self.carrer)
        end
        if nextExtraAttributeId > 0 then
            mNextMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.PhyDefenceMin, self.carrer)
            mNextMaxValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.PhyDefenceMax, self.carrer)
        end
    elseif type == 3 then
        mStr = "魔防"
        if curExtraAttributeId > 0 then
            mCurMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.MagicDefenceMin, self.carrer)
            mCurMaxValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.MagicDefenceMax, self.carrer)
        end
        if nextExtraAttributeId > 0 then
            mNextMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.MagicDefenceMin, self.carrer)
            mNextMaxValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.MagicDefenceMax, self.carrer)
        end
    elseif type == 4 then
        mStr = "生命"
        if curExtraAttributeId > 0 then
            mCurMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(curExtraAttributeId, LuaEnumExtraAttributeType.Hp, self.carrer)
        end
        if nextExtraAttributeId > 0 then
            mNextMinValue = cfg_extra_mon_effectManager:GetExtraAttributeValue(nextExtraAttributeId, LuaEnumExtraAttributeType.Hp, self.carrer)
        end
    end

    ---@class zhenFaAttribute
    local zhenFaAttribute = {
        str = mStr,
        curMinValue = mCurMinValue,
        curMaxValue = mCurMaxValue,
        nextMinValue = mNextMinValue,
        nextMaxValue = mNextMaxValue
    }
    return zhenFaAttribute
end

function UIMagicCirclePanel:RefreshUpStatus()
    if self.zhenFaInfo:GetZhenFaTable().level < 15 then
        self.maxLevel_GameObject:SetActive(false)
        self.arrow_GameObject:SetActive(true)
        --self.expBar_GameObject:SetActive(true)
        self.upgradeBtn_GameObject:SetActive(true)
        self.zhenFaUpMax_GameObject:SetActive(false)
        self.gold_UILabel.gameObject:SetActive(true)
        self.conditions_GameObject:SetActive(true)
        self:RefreshUpConditions()
        local uieventlistener = CS.UIEventListener.Get(self.upgradeBtn_GameObject)
        uieventlistener.LuaEventTable = self
        uieventlistener.OnClickLuaDelegate = self.OnZhenFaUpBtnClicked
        uieventlistener.onPressLuaDelegate = self.OnZhenFaUpBtnPress
    else
        self.maxLevel_GameObject:SetActive(true)
        self.arrow_GameObject:SetActive(false)
        --self.expBar_GameObject:SetActive(false)
        self.upgradeBtn_GameObject:SetActive(false)
        self.zhenFaUpMax_GameObject:SetActive(true)
        self.gold_UILabel.gameObject:SetActive(false)
        self.conditions_GameObject:SetActive(false)
    end
end

function UIMagicCirclePanel:RefreshUpConditions()
    if self.zhenFaInfo:GetZhenFaTable():GetCostMaterial() == nil then
        return
    end
    self.isEnoughMaterial = true
    local materialList = self.zhenFaInfo:GetZhenFaTable():GetCostMaterial().list
    self.zhenFaUpConditions.MaxCount = #materialList
    for i = 1, #materialList do
        local isEnough = self:RefreshUpConditionsGrid(self.zhenFaUpConditions.controlList[i - 1], materialList[i])
        self.isEnoughMaterial = self.isEnoughMaterial and isEnough
    end

    if self.zhenFaInfo:GetZhenFaTable():GetCostCurrency() == nil then
        self.gold_UILabel.gameObject:SetActive(false)
        return
    end
    local costCurrency = self.zhenFaInfo:GetZhenFaTable():GetCostCurrency().list[1]
    local costCurrencyId = costCurrency.list[1]
    local costCurrencyNum = costCurrency.list[2]
    local currencyInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(costCurrencyId)
    local coinsCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costCurrencyId)
    self.gold_UILabel.gameObject:SetActive(true)
    self.gold_UILabel.text = CS.Utility_Lua.SetProgressLabelColor(coinsCount, costCurrencyNum)
    local currencyIcon = self:GetComp(self.gold_UILabel.transform, "img", "UISprite")
    currencyIcon.spriteName = currencyInfo.icon
    self.isEnoughCurrency = coinsCount >= costCurrencyNum
end

function UIMagicCirclePanel:RefreshUpConditionsGrid(grid, costMaterial)
    if grid == nil or costMaterial == nil then
        return false
    end

    local icon = self:GetComp(grid.transform, "icon", "UISprite")
    local num = self:GetComp(grid.transform, "num", "UILabel")
    local add = self:GetComp(grid.transform, "add", "GameObject")

    local costItemId = costMaterial.list[1]
    local costNum = costMaterial.list[2]

    local ItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(costItemId)
    icon.spriteName = ItemInfo.icon

    CS.UIEventListener.Get(icon.gameObject).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = ItemInfo })
    end

    local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(ItemInfo.id)
    local itemCountReplace = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(ItemInfo.linkItemId)
    itemCount = itemCount + itemCountReplace
    num.text = CS.Utility_Lua.SetProgressLabelColor(itemCount, costNum)

    CS.UIEventListener.Get(add).onClick = function()
        if ItemInfo.wayGet ~= nil then
            Utility.ShowItemGetWay(costItemId, add, LuaEnumWayGetPanelArrowDirType.Down)
        end
    end

    return itemCount >= costNum
end

---@param self UIMagicCirclePanel
function UIMagicCirclePanel.OnZhenFaUpBtnClicked(self, go)
    self:ZhenFaUp(go)
end

---@param self UIMagicCirclePanel
function UIMagicCirclePanel.OnZhenFaUpBtnPress(self, go, state)
    if state then
        self.coroutineZhenFaUp = StartCoroutine(self.DelayZhenFaUp, self, go)
    else
        if self.coroutineZhenFaUp then
            StopCoroutine(self.coroutineZhenFaUp)
        end
    end
    self.isUpBtnPress = state
end

function UIMagicCirclePanel.DelayZhenFaUp(self, go)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    self:ZhenFaUp(go)
end

function UIMagicCirclePanel:ZhenFaUp(go)
    if self.isEnoughMaterial == false then
        Utility.ShowPopoTips(go, "材料不足，无法培养", 486)
        return
    end
    if self.isEnoughCurrency == false then
        Utility.ShowPopoTips(go, "货币不足，无法培养", 486)
        return
    end
    networkRequest.ReqUpgradeZhenfa()
end

function UIMagicCirclePanel:RefreshZhenFaRole()
    local panel = uimanager:GetPanel("UIMagicCircleRolePanel")
    if panel then
        panel:Show()
    else
        self:AddRelationPanel("UIMagicCircleRolePanel")
        uimanager:CreatePanel("UIMagicCircleRolePanel")
    end
end

function ondestroy()
    uimanager:ClosePanel("UIMagicCircleRolePanel")
end

return UIMagicCirclePanel