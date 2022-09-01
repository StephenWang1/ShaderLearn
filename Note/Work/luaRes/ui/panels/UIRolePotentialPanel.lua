---@class UIRolePotentialPanel : UIBase
local UIRolePotentialPanel = {}

--region 初始化
function UIRolePotentialPanel:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIEvents()
    self:BindNetMessage()
    self:BindLuaRedPoint()
    networkRequest.ReqPotentialInfo()
end

function UIRolePotentialPanel:Show(customData)
    if customData and customData.index then
        self.curIndex = customData.index
    end
    self:RefreshView()
end

function UIRolePotentialPanel:InitComponents()
    self.mCloseBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    self.mHelpBtn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    self.mBookMarkGridContainer = self:GetCurComp("WidgetRoot/events/ScrollView/BookMarks", "UIGridContainer")
    self.mPotentialWeaponBtn = self:GetCurComp("WidgetRoot/events/btn_potentialWeap", "GameObject")
    self.mPotentialActive = self:GetCurComp("WidgetRoot/view/Active", "GameObject")
    self.mPotentialActiveName = self:GetCurComp("WidgetRoot/view/Active/name", "UILabel")
    self.mPotentialStarGridContainer = self:GetCurComp("WidgetRoot/view/Active/stars", "UIGridContainer")
    self.mPotentialUpAttributes = self:GetCurComp("WidgetRoot/view/Active/Tabel/Center/Scroll View/arributelist", "UIGridContainer")
    self.mPotentialUpConditions = self:GetCurComp("WidgetRoot/view/Active/Tabel/Bottom/Scroll View/change", "UIGridContainer")
    self.mPotentialUpConditionsTitle = self:GetCurComp("WidgetRoot/view/Active/Tabel/Bottom/Label", "GameObject")
    self.mPotentialUpBtn = self:GetCurComp("WidgetRoot/view/Active/btn_up", "GameObject")
    self.mPotentialUpMax = self:GetCurComp("WidgetRoot/view/Active/max", "GameObject")
    self.mPotentialUpNeed = self:GetCurComp("WidgetRoot/view/Active/need", "GameObject")
    self.mPotentialUnActive = self:GetCurComp("WidgetRoot/view/UnActive", "GameObject")
    self.mPotentialUnActiveItem = self:GetCurComp("WidgetRoot/view/UnActive/Item", "GameObject")
    self.mPotentialUnActiveIcon = self:GetCurComp("WidgetRoot/view/UnActive/Item/icon", "UISprite")
    self.mPotentialUnActiveName = self:GetCurComp("WidgetRoot/view/UnActive/Item/name", "UILabel")
    self.mPotentialUnActiveTip = self:GetCurComp("WidgetRoot/view/UnActive/lb_activeDes", "UILabel")
    self.mPotentialUnActiveModel = self:GetCurComp("WidgetRoot/view/UnActive/UnroleModel/UnroleModel", "CSUIEffectLoad")
    self.mPotentialActiveBtn = self:GetCurComp("WidgetRoot/view/UnActive/btn_active", "GameObject")
    self.mPotentialTotalAttr = self:GetCurComp("WidgetRoot/view/TotalAttr", "GameObject")
    self.mPotentialTotalAttrBox = self:GetCurComp("WidgetRoot/view/TotalAttr/window/box", "GameObject")
    self.mModelRoot = self:GetCurComp("WidgetRoot/view/roleModel", "GameObject")
end

function UIRolePotentialPanel:InitParameters()
    self.resPotentialInfo = nil
    self.curIndex = 1
    self.carrer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    self.curPotentialTbl = nil
    self.nextPotentialTbl = nil
    self.playerAvatarInfo = nil
    self.observationModel = nil
    self.weaponAppearance = nil
    self.clothesAppearance = nil
    self.isEnoughMaterial = false
end

function UIRolePotentialPanel:BindUIEvents()
    ---点击关闭按钮
    CS.UIEventListener.Get(self.mCloseBtn).onClick = function()
        uimanager:ClosePanel("UIRolePotentialPanel")
    end
    ---点击帮助按钮
    CS.UIEventListener.Get(self.mHelpBtn).onClick = function()
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(225)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end
    ---点击关闭总属性
    CS.UIEventListener.Get(self.mPotentialTotalAttrBox).onClick = function()
        local typeGo = self.mPotentialTotalAttr.transform:Find("Type" .. self.curIndex).gameObject
        typeGo:SetActive(false)
        self.mPotentialTotalAttr:SetActive(false)
    end
end

function UIRolePotentialPanel:BindNetMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPotentialInfoMessage, self.OnResPotentialInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRedPointPotentialMessage, self.OnResRedPointPotentialMessage)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, self.OnBagCoinChangedCallBack)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, self.OnBagCoinChangedCallBack)
end

function UIRolePotentialPanel:BindLuaRedPoint()

end
--endregion

--region 消息处理
function UIRolePotentialPanel.OnResPotentialInfoMessage(msgId, tblData, csData)
    UIRolePotentialPanel.resPotentialInfo = tblData
    UIRolePotentialPanel:RefreshPotentialWeaponBtn(UIRolePotentialPanel.curIndex)
    UIRolePotentialPanel:RefreshPotential(UIRolePotentialPanel.curIndex)
end

function UIRolePotentialPanel.OnResRedPointPotentialMessage(msgId, tblData, csData)
    UIRolePotentialPanel:RefreshBookMarks()
    UIRolePotentialPanel:RefreshUpBtnEffect()
end

function UIRolePotentialPanel.OnBagCoinChangedCallBack()
    UIRolePotentialPanel:RefreshUpConditions()
end
--endregion

function UIRolePotentialPanel:RefreshView()
    self:RefreshBookMarks()
end

function UIRolePotentialPanel:RefreshBookMarks()
    self.mBookMarkGridContainer.MaxCount = 3
    self:RefreshBookMark(1)
    self:RefreshBookMark(2)
    self:RefreshBookMark(3)
end

function UIRolePotentialPanel:RefreshBookMark(index)
    local bookMarkBtn = self.mBookMarkGridContainer.controlList[index - 1]

    if index == self.curIndex then
        local fg = bookMarkBtn.transform:Find("Foreground").gameObject
        fg:SetActive(true)
    end
    local bgLabel = self:GetComp(bookMarkBtn.transform, "Background/Label", "UILabel")
    local fgLabel = self:GetComp(bookMarkBtn.transform, "Foreground/Label", "UILabel")
    bgLabel.text = self:GetBookMarkLabel(index)
    fgLabel.text = self:GetBookMarkLabel(index)

    local uieventlistener = CS.UIEventListener.Get(bookMarkBtn)
    uieventlistener.LuaEventTable = { self, index }
    uieventlistener.OnClickLuaDelegate = self.OnBookMarkClicked

    local showRedPoint = false
    if uiStaticParameter.PotentialRedPointInfo then
        showRedPoint = uiStaticParameter.PotentialRedPointInfo[index]
    end
    bookMarkBtn.transform:Find("redpoint").gameObject:SetActive(showRedPoint)
end

function UIRolePotentialPanel:GetBookMarkLabel(index)
    if index == 1 then
        return "石化"
    end
    if index == 2 then
        return "诅咒"
    end
    if index == 3 then
        return "疾速"
    end
    return ""
end

function UIRolePotentialPanel.OnBookMarkClicked(table, go)
    ---@type UIRolePotentialPanel
    local self = table[1]
    local index = table[2]
    for i = 1, self.mBookMarkGridContainer.MaxCount do
        local bookMarkBtn = self.mBookMarkGridContainer.controlList[i - 1]
        local fg = bookMarkBtn.transform:Find("Foreground").gameObject
        local bg = bookMarkBtn.transform:Find("Background").gameObject
        fg:SetActive(i == index)
        bg:SetActive(i ~= index)
    end
    self.curIndex = index
    self:RefreshPotentialWeaponBtn(index)
    self:RefreshPotential(index)
end

function UIRolePotentialPanel:RefreshPotentialWeaponBtn(index)
    local itemId, spriteName, spriteName2
    if index == 1 then
        itemId = 13010030
        spriteName = "PotentialWeap_1_1"
        spriteName2 = "PotentialWeap_1_2"
    elseif index == 2 then
        itemId = 13010031
        spriteName = "PotentialWeap_2_1"
        spriteName2 = "PotentialWeap_2_2"
    elseif index == 3 then
        itemId = 13010032
        spriteName = "PotentialWeap_3_1"
        spriteName2 = "PotentialWeap_3_2"
    else
        return
    end
    self.weaponAppearance = self:GetAppearance(LuaEnumAppearanceType.Weapon, itemId)
    local isActivated = self.weaponAppearance ~= nil
    self.mPotentialWeaponBtn:GetComponent("UISprite").spriteName = isActivated and spriteName or spriteName2
    local uieventlistener = CS.UIEventListener.Get(self.mPotentialWeaponBtn)
    uieventlistener.LuaEventTable = { isActivated, index }
    uieventlistener.OnClickLuaDelegate = self.OnPotentialWeaponBtnClicked
end

function UIRolePotentialPanel.OnPotentialWeaponBtnClicked(table, go)
    local isActivated = table[1]
    local index = table[2]
    if not isActivated then
        local customData = { type = LuaEnumRechargeType.PreferenceGift }
        --uimanager:CreatePanel("UIRechargePanel", nil, customData)
        uimanager:CreatePanel("UIRechargeMainPanel", nil, {
            type = LuaEnumRechargeMainBookMarkType.Activity,
            customData = { type = luaEnumCompetitionType.PreferenceGift }
        })
        return
    end
    local totalAttr = UIRolePotentialPanel.mPotentialTotalAttr
    totalAttr:SetActive(true)
    local typeGo = totalAttr.transform:Find("Type" .. index).gameObject
    typeGo:SetActive(true)
    local attrValue1, attrValue2
    local value1 = 0
    local value2 = 0
    attrValue1 = CS.Utility_Lua.GetComponent(typeGo.transform:Find("Attr1/AttrValue/AttrValue"), "UILabel")
    attrValue2 = CS.Utility_Lua.GetComponent(typeGo.transform:Find("Attr2/AttrValue/AttrValue"), "UILabel")
    if index == 1 then
        if UIRolePotentialPanel.curPotentialTbl then
            value1 = UIRolePotentialPanel.curPotentialTbl:GetParalysisRate() / 100 .. "%"
            value2 = UIRolePotentialPanel.curPotentialTbl:GetParalysisLevel()
        end
        local weaponValue1 = "([00ff00]+30.0%[-])"
        local weaponValue2 = "([00ff00]+50[-])"
        local playerLevel = string.CSFormat("([00ff00]+{0}[-])", CS.CSScene.MainPlayerInfo.Level)
        attrValue1.text = value1 .. weaponValue1
        attrValue2.text = value2 .. playerLevel .. weaponValue2
    elseif index == 2 then
        if UIRolePotentialPanel.curPotentialTbl then
            value1 = UIRolePotentialPanel.curPotentialTbl:GetDamnationRate() / 100 .. "%"
            value2 = UIRolePotentialPanel.curPotentialTbl:GetDamnationLevel()
        end
        local weaponValue1 = "([00ff00]+30.0%[-])"
        local weaponValue2 = "([00ff00]+30[-])"
        local playerLevel = string.CSFormat("([00ff00]+{0}[-])", CS.CSScene.MainPlayerInfo.Level)
        attrValue1.text = value1 .. weaponValue1
        attrValue2.text = value2 .. playerLevel .. weaponValue2
    elseif index == 3 then
        if UIRolePotentialPanel.curPotentialTbl then
            value1 = UIRolePotentialPanel.curPotentialTbl:GetSpeed()
        end
        local weaponValue1 = "[00ff00](+80)[-]"
        attrValue1.text = value1 .. weaponValue1
    end
end

function UIRolePotentialPanel:RefreshPotential(index)
    local itemId
    local info = LuaGlobalTableDeal.GetGlobalTabl(22876)
    if info then
        local strs = string.Split(info.value, '&')
        local singleInfo = string.Split(strs[index], '#')
        local sex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
        itemId = singleInfo[sex]
    else
        return
    end
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
    if not isFind then
        return
    end
    if self.resPotentialInfo == nil then
        return
    end
    local potentialInfo = self.resPotentialInfo.info[index]
    if potentialInfo == nil then
        potentialInfo.isOpen = 0
    end
    local isActivated = potentialInfo.isOpen == 1
    self.mPotentialActive:SetActive(isActivated)
    self.mPotentialUnActive:SetActive(not isActivated)
    self.clothesAppearance = self:GetAppearance(LuaEnumAppearanceType.Clothes, itemTable.id)
    if isActivated then
        self:RefreshPotentialActivated(itemTable, potentialInfo)
        self.mModelRoot:SetActive(true)
    else
        local isActivatable = self.clothesAppearance ~= nil
        self:RefreshPotentialUnActivated(itemTable, isActivatable)
        self.curPotentialTbl = nil
        self.nextPotentialTbl = nil
        self.mModelRoot:SetActive(false)
    end
end

function UIRolePotentialPanel:RefreshPotentialActivated(itemTable, potentialInfo)
    self.mPotentialActiveName.text = string.CSFormat("{0} [ffd51d]{1}星", itemTable.name, potentialInfo.star)
    self.mPotentialStarGridContainer.MaxCount = 10
    for i = 1, self.mPotentialStarGridContainer.MaxCount do
        local starSprite = self.mPotentialStarGridContainer.controlList[i - 1]:GetComponent("UISprite")
        starSprite.spriteName = potentialInfo.star >= i and "Potential_star" or "Potential_star1"
    end

    self.curPotentialTbl = clientTableManager.cfg_potentialManager:TryGetValue(potentialInfo.id)
    self.nextPotentialTbl = clientTableManager.cfg_potentialManager:TryGetValue(potentialInfo.id + 1)
    self:RefreshUpAttributes()
    self:RefreshUpStatus(potentialInfo)
    self:RefreshModel()
end

function UIRolePotentialPanel:RefreshModel()
    local bodyModelID = 0
    local weaponModelID = 0
    if self.clothesAppearance then
        bodyModelID = self.clothesAppearance.ItemTABLE.model.list[0]
    end
    if self.weaponAppearance then
        weaponModelID = self.weaponAppearance.ItemTABLE.model.list[0]
    end
    if bodyModelID == 0 then
        return
    end
    if self.playerAvatarInfo == nil then
        self.playerAvatarInfo = CS.CSScene.MainPlayerInfo
    end
    self:LoadTargetModel(self.playerAvatarInfo.Sex, self.playerAvatarInfo.Career, bodyModelID,
            weaponModelID, self.playerAvatarInfo:GetHairModelID(), self.playerAvatarInfo:GetFaceModelID())
end

function UIRolePotentialPanel:LoadTargetModel(sex, career, model, weapon, hair, face)
    if self.observationModel == nil then
        self.observationModel = CS.ObservationModel()
    end
    local ModelEffectMountItemList = {}
    --if CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEffectId() ~= 0 then
    --    table.insert(ModelEffectMountItemList, CS.ModelEffectMountItem(CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEffectId(), 1, Utility.EnumToInt(CS.ModelStructure.Weapon), CS.ResourceType.UIEffect))
    --end
    local isModelChanged = false
    if not CS.StaticUtility.IsNull(self.mModelRoot) then
        self.observationModel:SetShowMotion(weapon == 0 and CS.CSMotion.Stand or CS.CSMotion.ShowStand)
        isModelChanged = self.observationModel:CreateRoleModel(sex, career, model,
                weapon, hair, face, ModelEffectMountItemList, self.mModelRoot.transform)
    end
    if isModelChanged then
        local localPosition_x = -159
        if Utility.EnumToInt(self.playerAvatarInfo.Sex) == LuaEnumSex.WoMan then
            localPosition_x = -154
        end
        self.observationModel:SetPosition(CS.UnityEngine.Vector3(localPosition_x, -134, 400))
        self.observationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self.observationModel:SetScaleSize(CS.UnityEngine.Vector3(180, 180, 180))
        self.observationModel:SetDragRoot(self.mModelRoot)
    end
end

function UIRolePotentialPanel:RefreshUpStatus(potentialInfo)
    if potentialInfo.star < 10 then
        local canUp = true
        --[[
        if potentialInfo.type == 2 then
            canUp = self.resPotentialInfo.info[1].star >= 10
        elseif potentialInfo.type == 3 then
            canUp = self.resPotentialInfo.info[2].star >= 10
        end
        --]]
        if canUp then
            self.mPotentialUpBtn:SetActive(true)
            self:RefreshUpBtnEffect()
            self.mPotentialUpMax:SetActive(false)
            self.mPotentialUpNeed:SetActive(false)
            local uieventlistener = CS.UIEventListener.Get(self.mPotentialUpBtn)
            uieventlistener.LuaEventTable = self
            uieventlistener.OnClickLuaDelegate = self.OnPotentialUpBtnClicked
            self.mPotentialUpConditionsTitle:SetActive(true)
            self.mPotentialUpConditions.gameObject:SetActive(true)
            self:RefreshUpConditions()
        else
            self.mPotentialUpConditionsTitle:SetActive(false)
            self.mPotentialUpConditions.gameObject:SetActive(false)
            self.mPotentialUpBtn:SetActive(false)
            self.mPotentialUpMax:SetActive(false)
            self.mPotentialUpNeed:SetActive(true)
            if potentialInfo.type == 2 then
                self.mPotentialUpNeed.transform:Find("lb_level"):GetComponent("UISprite").spriteName = "Potential_level_1"
            elseif potentialInfo.type == 3 then
                self.mPotentialUpNeed.transform:Find("lb_level"):GetComponent("UISprite").spriteName = "Potential_level_2"
            end
        end
    else
        self.mPotentialUpConditionsTitle:SetActive(false)
        self.mPotentialUpConditions.gameObject:SetActive(false)
        self.mPotentialUpBtn:SetActive(false)
        self.mPotentialUpMax:SetActive(true)
        self.mPotentialUpNeed:SetActive(false)
    end
end

function UIRolePotentialPanel:RefreshUpBtnEffect()
    local showEffect = false
    if uiStaticParameter.PotentialRedPointInfo then
        showEffect = uiStaticParameter.PotentialRedPointInfo[self.curIndex]
    end
    self.mPotentialUpBtn.transform:Find("effect").gameObject:SetActive(showEffect)
end

---@param self UIRolePotentialPanel
function UIRolePotentialPanel.OnPotentialUpBtnClicked(self, go)
    if self.isEnoughMaterial then
        networkRequest.ReqUpgradePotential(self.curIndex)
    else
        Utility.ShowPopoTips(go, nil, 486)
    end
end

function UIRolePotentialPanel:RefreshUpAttributes()
    local tbl = self:GetAttributeList()
    self.mPotentialUpAttributes.MaxCount = #tbl
    for i = 1, #tbl do
        local go = self.mPotentialUpAttributes.controlList[i - 1]
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

---获取处理过的属性列表
---@return table<number,potentialAttribute>
function UIRolePotentialPanel:GetAttributeList()
    local attributeNum = 4
    local tbl = {}
    for i = 1, attributeNum do
        local attributeTbl = self:GetAttributeShowData(i)
        if attributeTbl ~= nil then
            table.insert(tbl, attributeTbl)
        end
    end
    if self.curIndex == 3 then
        table.remove(tbl, 2)
    end
    return tbl
end

---获得显示的属性信息
---@return table<number,potentialAttribute>
function UIRolePotentialPanel:GetAttributeShowData(type)
    local mStr = ""
    local mCurMinValue = nil
    local mCurMaxValue = nil
    local mNextMinValue = nil
    local mNextMaxValue = nil

    local curPotentialTbl = self.curPotentialTbl
    local nextPotentialTbl = self.nextPotentialTbl
    if type == 1 then
        if self.curIndex == 1 then
            mStr = "石化概率"
            if curPotentialTbl:GetParalysisRate() ~= nil then
                mCurMinValue = curPotentialTbl:GetParalysisRate() / 100 .. "%"
            end
            if nextPotentialTbl ~= nil and nextPotentialTbl:GetParalysisRate() ~= nil then
                mNextMinValue = nextPotentialTbl:GetParalysisRate() / 100 .. "%"
            end
        elseif self.curIndex == 2 then
            mStr = "降低回血效果"
            if curPotentialTbl:GetDamnationRate() ~= nil then
                mCurMinValue = curPotentialTbl:GetDamnationRate() / 100 .. "%"
            end
            if nextPotentialTbl ~= nil and nextPotentialTbl:GetDamnationRate() ~= nil then
                mNextMinValue = nextPotentialTbl:GetDamnationRate() / 100 .. "%"
            end
        elseif self.curIndex == 3 then
            mStr = "攻击速度"
            if curPotentialTbl:GetSpeed() ~= nil then
                mCurMinValue = curPotentialTbl:GetSpeed()
            end
            if nextPotentialTbl ~= nil and nextPotentialTbl:GetSpeed() ~= nil then
                mNextMinValue = nextPotentialTbl:GetSpeed()
            end
        end
    elseif type == 2 then
        if self.curIndex == 1 then
            mStr = "石化怪物等级上限"
            local playerLevel = string.CSFormat("(+{0})", CS.CSScene.MainPlayerInfo.Level)
            if curPotentialTbl:GetParalysisLevel() ~= nil then
                mCurMinValue = curPotentialTbl:GetParalysisLevel() .. playerLevel
            end
            if nextPotentialTbl ~= nil and nextPotentialTbl:GetParalysisLevel() ~= nil then
                mNextMinValue = nextPotentialTbl:GetParalysisLevel() .. playerLevel
            end
        elseif self.curIndex == 2 then
            mStr = "诅咒怪物等级上限"
            local playerLevel = string.CSFormat("(+{0})", CS.CSScene.MainPlayerInfo.Level)
            if curPotentialTbl:GetDamnationLevel() ~= nil then
                mCurMinValue = curPotentialTbl:GetDamnationLevel() .. playerLevel
            end
            if nextPotentialTbl ~= nil and nextPotentialTbl:GetDamnationLevel() ~= nil then
                mNextMinValue = nextPotentialTbl:GetDamnationLevel() .. playerLevel
            end
        elseif self.curIndex == 3 then

        end
    elseif type == 3 then
        mStr = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp)
        if curPotentialTbl:GetMaxHp() ~= nil then
            mCurMinValue = self:GetValueByRoleType(curPotentialTbl:GetMaxHp())
        end
        if nextPotentialTbl ~= nil and nextPotentialTbl:GetMaxHp() ~= nil then
            mNextMinValue = self:GetValueByRoleType(nextPotentialTbl:GetMaxHp())
        end
    elseif type == 4 then
        mStr = Utility.GetCareerAttackName(self.carrer)
        if curPotentialTbl:GetAtt() ~= nil then
            mCurMinValue = curPotentialTbl:GetAtt()
        end
        if curPotentialTbl:GetAttMax() ~= nil then
            mCurMaxValue = curPotentialTbl:GetAttMax()
        end
        if nextPotentialTbl ~= nil and nextPotentialTbl:GetAtt() ~= nil then
            mNextMinValue = nextPotentialTbl:GetAtt()
        end
        if nextPotentialTbl ~= nil and nextPotentialTbl:GetAttMax() ~= nil then
            mNextMaxValue = nextPotentialTbl:GetAttMax()
        end
    end

    ---@class potentialAttribute
    local potentialAttribute = {
        str = mStr,
        curMinValue = mCurMinValue,
        curMaxValue = mCurMaxValue,
        nextMinValue = mNextMinValue,
        nextMaxValue = mNextMaxValue
    }
    return potentialAttribute
end

---对应不同的角色类型设置参数
function UIRolePotentialPanel:GetValueByRoleType(param)
    local value = nil
    if param ~= nil and #param.list ~= nil then
        for i = 1, #param.list do
            if param.list[i].list[1] == self.carrer then
                return param.list[i].list[2]
            end
        end
    end
    return value
end

function UIRolePotentialPanel:RefreshUpConditions()
    self.mPotentialUpConditions.MaxCount = 2
    if self.nextPotentialTbl == nil or
            self.mPotentialUpConditions.controlList[0] == nil or
            self.mPotentialUpConditions.controlList[1] == nil then
        return
    end
    local cond1 = self.mPotentialUpConditions.controlList[0].transform
    local icon1 = cond1:Find("icon"):GetComponent("UISprite")
    local num1 = cond1:Find("num"):GetComponent("UILabel")
    local add1 = cond1:Find("add").gameObject

    local cost = self.nextPotentialTbl:GetCost()
    local cost1 = cost.list[1]
    local cost2 = cost.list[2]

    local costItemId1 = cost1.list[1]
    local costNum1 = cost1.list[2]

    local ItemInfo1 = CS.Cfg_ItemsTableManager.Instance:GetItems(costItemId1)
    icon1.spriteName = ItemInfo1.icon

    CS.UIEventListener.Get(icon1.gameObject).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = ItemInfo1 })
    end

    local itemCount1 = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(ItemInfo1.id)
    local itemCount1Replace = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(ItemInfo1.linkItemId)
    itemCount1 = itemCount1 + itemCount1Replace
    num1.text = CS.Utility_Lua.SetProgressLabelColor(itemCount1, costNum1)

    CS.UIEventListener.Get(add1).onClick = function()
        if ItemInfo1.wayGet ~= nil then
            Utility.ShowItemGetWay(costItemId1, add1, LuaEnumWayGetPanelArrowDirType.Down)
        end
    end

    local cond2 = self.mPotentialUpConditions.controlList[1].transform
    local icon2 = cond2:Find("icon"):GetComponent("UISprite")
    local num2 = cond2:Find("num"):GetComponent("UILabel")
    local add2 = cond2:Find("add").gameObject

    local costItemId2 = cost2.list[1]
    local costNum2 = cost2.list[2]

    local ItemInfo2 = CS.Cfg_ItemsTableManager.Instance:GetItems(costItemId2)
    icon2.spriteName = ItemInfo2.icon

    CS.UIEventListener.Get(icon2.gameObject).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = ItemInfo2 })
    end

    local itemCount2 = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(ItemInfo2.id)
    num2.text = CS.Utility_Lua.SetProgressLabelColor(itemCount2, costNum2)

    CS.UIEventListener.Get(add2).onClick = function()
        if ItemInfo2.wayGet ~= nil then
            Utility.ShowItemGetWay(costItemId2, add2, LuaEnumWayGetPanelArrowDirType.Down)
        end
    end

    self.isEnoughMaterial = itemCount1 >= costNum1 and itemCount2 >= costNum2
end

function UIRolePotentialPanel:RefreshPotentialUnActivated(itemTable, isActivatable)
    self.mPotentialUnActiveIcon.spriteName = itemTable.icon
    local uieventlistener = CS.UIEventListener.Get(self.mPotentialUnActiveItem)
    uieventlistener.LuaEventTable = { itemTable, isActivatable }
    uieventlistener.OnClickLuaDelegate = self.OnPotentialUnActiveItemClicked
    if isActivatable then
        self.mPotentialUnActiveIcon.color = CS.UnityEngine.Color.white
        self.mPotentialUnActiveName.text = string.CSFormat("{0}", itemTable.name)
        self.mPotentialUnActiveTip.text = "[00ff00]已激活"
    else
        self.mPotentialUnActiveIcon.color = CS.UnityEngine.Color.black
        self.mPotentialUnActiveName.text = string.CSFormat("{0}", itemTable.name)
        self.mPotentialUnActiveTip.text = "[E85038]未激活"
    end
    local roleImage = 1
    if self.curIndex == 2 then
        roleImage = 3
    elseif self.curIndex == 3 then
        roleImage = 2
    end
    local effectName = string.CSFormat("potentialmodel_{0}_{1}", roleImage, itemTable.sex)
    luaclass.UIRefresh:RefreshEffect(self.mPotentialUnActiveModel, effectName)
    self.mPotentialActiveBtn.transform:Find("effect").gameObject:SetActive(isActivatable)
    uieventlistener = CS.UIEventListener.Get(self.mPotentialActiveBtn)
    uieventlistener.LuaEventTable = { self, itemTable, isActivatable }
    uieventlistener.OnClickLuaDelegate = self.OnPotentialActiveBtnClicked
end

function UIRolePotentialPanel.OnPotentialUnActiveItemClicked(table, go)
    local itemTable = table[1]
    local isActivatable = table[2]
    if isActivatable then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
    else
        --local customData = { type = LuaEnumRechargeType.PotentialInvest }
        --uimanager:CreatePanel("UIRechargePanel", nil, customData)

        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
        if itemTable.wayGet ~= nil then
            Utility.ShowItemGetWay(itemTable.id, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(479, 0))
        end
    end
end

function UIRolePotentialPanel.OnPotentialActiveBtnClicked(table, go)
    ---@type UIRolePotentialPanel
    local self = table[1]
    local itemTable = table[2]
    local isActivatable = table[3]
    if isActivatable then
        networkRequest.ReqActivePotential(self.curIndex)
    else
        --local customData = { type = LuaEnumRechargeType.PotentialInvest }
        --uimanager:CreatePanel("UIRechargePanel", nil, customData)

        if itemTable.wayGet ~= nil then
            Utility.ShowItemGetWay(itemTable.id, go, LuaEnumWayGetPanelArrowDirType.Left)
        end
    end
end

function UIRolePotentialPanel:GetAppearance(type, itemId)
    local appearanceBagItemInfo
    local fashionList = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList
    for i = 0, fashionList.Count - 1 do
        local fashion = fashionList[i]
        if fashion.subType == type then
            local itemList = fashion.itemList
            for j = 0, itemList.Count - 1 do
                if itemList[j].itemId == itemId then
                    appearanceBagItemInfo = itemList[j]
                    break
                end
            end
            break
        end
    end
    return appearanceBagItemInfo
end

return UIRolePotentialPanel