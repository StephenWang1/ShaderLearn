---@class UISLequipLevelPanel:UIBase 兵鉴神力突破与升级
local UISLequipLevelPanel = {}


local effectIds = {};
effectIds.upLevelEffectId = "700008";

--region 组件
---@return UnityEngine.GameObject
function UISLequipLevelPanel:OnBtnClose_GameObject()
    if (self.mBtnClose == nil) then
        self.mBtnClose = self:GetCurComp("WidgetRoot/events/Btn_Close", "GameObject");
    end
    return self.mBtnClose
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:OnBtnUpgrade_GameObject()
    if (self.mBtnUpGrade == nil) then
        self.mBtnUpGrade = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Btn_Upgrade", "GameObject");
    end
    return self.mBtnUpGrade
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:LevelUp_GameObject()
    if (self.mLevelUp == nil) then
        self.mLevelUp = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/LevelMainPanel", "GameObject");
    end
    return self.mLevelUp
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:BreakThrough_GameObject()
    if (self.mBreakThrough == nil) then
        self.mBreakThrough = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/BreakthroughMainPanel", "GameObject");
    end
    return self.mBreakThrough
end

---@return Top_UIGridContainer
function UISLequipLevelPanel:CurAttrGrid()
    if (self.mCurAttrGrid == nil) then
        self.mCurAttrGrid = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/BreakthroughMainPanel/curLevelAttribute/ScrollView/otherAttribute", "Top_UIGridContainer");
    end
    return self.mCurAttrGrid
end

---@return Top_UIGridContainer
function UISLequipLevelPanel:NextAttrGrid()
    if (self.mNextAttrGrid == nil) then
        self.mNextAttrGrid = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/BreakthroughMainPanel/nextLevelAttribute/ScrollView/otherAttribute", "Top_UIGridContainer");
    end
    return self.mNextAttrGrid
end

---@return Top_UIGridContainer
function UISLequipLevelPanel:LevelAttrGrid()
    if (self.mLevelAttrGrid == nil) then
        self.mLevelAttrGrid = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/LevelMainPanel/ScrollView/otherAttribute", "Top_UIGridContainer");
    end
    return self.mLevelAttrGrid
end

---@return Top_UIGridContainer
function UISLequipLevelPanel:StarGrid()
    if (self.mStarGrid == nil) then
        self.mStarGrid = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/LevelMainPanel/stars", "Top_UIGridContainer");
    end
    return self.mStarGrid
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:BreakThroughFrist_GameObject()
    if (self.mBreakThroughFrist == nil) then
        self.mBreakThroughFrist = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/BreakthroughMainPanel/curLevelAttribute/NoBreakthrough", "GameObject");
    end
    return self.mBreakThroughFrist
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:BreakThroughMax_GameObject()
    if (self.mBreakThroughMax == nil) then
        self.mBreakThroughMax = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/BreakthroughMainPanel/nextLevelAttribute/levelmax", "GameObject");
    end
    return self.mBreakThroughMax
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:OnBtnJump_GameObject()
    if (self.mBtnJump == nil) then
        self.mBtnJump = self:GetCurComp("WidgetRoot/events/btn_jump", "GameObject");
    end
    return self.mBtnJump
end

---@return Top_UISprite
function UISLequipLevelPanel:OnBtnJumpSprit()
    if (self.mBtnJumpSprite == nil) then
        self.mBtnJumpSprite = self:GetCurComp("WidgetRoot/events/btn_jump", "Top_UISprite");
    end
    return self.mBtnJumpSprite
end

---@return UILabel
function UISLequipLevelPanel:CurLevel_Label()
    if (self.mCurLevel == nil) then
        self.mCurLevel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Level", "UILabel");
    end
    return self.mCurLevel
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:NoEquipment_GameObject()
    if (self.mNoEquipment == nil) then
        self.mNoEquipment = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/NoEquipment", "GameObject");
    end
    return self.mNoEquipment
end

---@return Top_UISprite
function UISLequipLevelPanel:EquipIcon_Sprite()
    if (self.mEquipIcon == nil) then
        self.mEquipIcon = self:GetCurComp("WidgetRoot/UIMainPanel/Background/Item/icon", "Top_UISprite");
    end
    return self.mEquipIcon
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:EquipLock_GameObject()
    if (self.mEquipLock == nil) then
        self.mEquipLock = self:GetCurComp("WidgetRoot/UIMainPanel/Background/Item/Lock", "GameObject");
    end
    return self.mEquipLock
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:Condition_GameObject()
    if (self.mCondition == nil) then
        self.mCondition = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition", "GameObject");
    end
    return self.mCondition
end

---@return UILabel
function UISLequipLevelPanel:GoldText_Label()
    if (self.mGoldText == nil) then
        self.mGoldText = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/gold", "UILabel");
    end
    return self.mGoldText
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:EquipIcon_GameObject()
    if (self.mEquipIcon_GameObject == nil) then
        self.mEquipIcon_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Background/Item", "GameObject");
    end
    return self.mEquipIcon_GameObject
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:BtnCon1_GameObject()
    if (self.mBtnCon1 == nil) then
        self.mBtnCon1 = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con1", "GameObject");
    end
    return self.mBtnCon1
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:BtnCon2_GameObject()
    if (self.mBtnCon2 == nil) then
        self.mBtnCon2 = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con2", "GameObject");
    end
    return self.mBtnCon2
end

---@return UILabel
function UISLequipLevelPanel:BtnCon1_UILabel()
    if (self.mBtnCon1UILabel == nil) then
        self.mBtnCon1UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con1/Label", "UILabel");
    end
    return self.mBtnCon1UILabel
end

---@return UILabel
function UISLequipLevelPanel:BtnCon2_UILabel()
    if (self.mBtnCon2UILabel == nil) then
        self.mBtnCon2UILabel = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con2/Label", "UILabel");
    end
    return self.mBtnCon2UILabel
end

---@return UILabel
function UISLequipLevelPanel:Con1Name_UILabel()
    if (self.mCon1Name == nil) then
        self.mCon1Name = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con1/itemName", "UILabel");
    end
    return self.mCon1Name
end

---@return UILabel
function UISLequipLevelPanel:Con2Name_UILabel()
    if (self.mCon2Name == nil) then
        self.mCon2Name = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con2/itemName", "UILabel");
    end
    return self.mCon2Name
end

---@return Top_UISprite
function UISLequipLevelPanel:Con2Icon()
    if (self.mCon2Icon == nil) then
        self.mCon2Icon = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con2/icon", "Top_UISprite");
    end
    return self.mCon2Icon
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:Con2Add_GameObject()
    if (self.mCon2Add == nil) then
        self.mCon2Add = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Condition/Btn_Con2/Btn_ChangToBuy", "GameObject");
    end
    return self.mCon2Add
end

---@return UILabel
function UISLequipLevelPanel:GoldShow_UILabel()
    if (self.mGoldShow == nil) then
        self.mGoldShow = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/gold", "UILabel");
    end
    return self.mGoldShow
end

---@return Top_UISprite
function UISLequipLevelPanel:GoldShow_UISprite()
    if (self.mGoldShow_sprite == nil) then
        self.mGoldShow_sprite = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/gold/img", "Top_UISprite");
    end
    return self.mGoldShow_sprite
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:Max_GameObject()
    if (self.mMax == nil) then
        self.mMax = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/maxLevelAttribute", "GameObject");
    end
    return self.mMax
end

---@return UnityEngine.GameObject
function UISLequipLevelPanel:UpEffect()
    if (self.mEffect == nil) then
        self.mEffect = self:GetCurComp("WidgetRoot/UIMainPanel/upEffect/upEffect", "GameObject");
    end
    return self.mEffect
end

--endregion


--region 数据初始化
function UISLequipLevelPanel:Init()
    self:BindUIEvent()
    self:BindNetMsg()
    self:InitEvents()
end

---@type number 1升级 2突破
function UISLequipLevelPanel:Show(type, bagItemInfo)
    self.type = type
    self.bagItemInfo = bagItemInfo
    self:RefreshPanel()
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsSLequipLevelOpen(true)
end

function UISLequipLevelPanel:BindUIEvent()
    CS.UIEventListener.Get(self:OnBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UISLequipLevelPanel")
    end
    CS.UIEventListener.Get(self:OnBtnUpgrade_GameObject()).onClick = function()
        self:OnUpgradeClick()
    end
    CS.UIEventListener.Get(self:OnBtnJump_GameObject()).onClick = function()
        self:OnBtnJumpClick()
    end
    CS.UIEventListener.Get(self:EquipIcon_GameObject()).onClick = function()
        if self.bagItemInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = self.bagItemInfo,showRight = false})
        end
    end
    CS.UIEventListener.Get(self:Con2Add_GameObject()).onClick = function()
        Utility.ShowItemGetWay(self.itemId, self:Con2Add_GameObject())
    end
end

function UISLequipLevelPanel:BindNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipChangeMessage, UISLequipLevelPanel.OnResEquipMessageReceived)
end

function UISLequipLevelPanel:InitEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BingJianChoose, function(id, bagItemInfo)
        self:SetBagItemInfo(bagItemInfo)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:SetBagItemInfo()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:SetBagItemInfo()
    end)
end

--endregion

--region 界面显示

---检测是否有装备
function UISLequipLevelPanel:RefreshPanel()
    ---金币需求
    self.goldDemand = true
    ---物品需求
    self.itemDemand = true
    ---任务需求
    self.curLevel = true
    if self.type == 2 then
        self:OnBtnJumpSprit().spriteName = "SLequip_breakthroughbtn"
    elseif self.type == 1 then
        self:OnBtnJumpSprit().spriteName = "SLequip_levelupbtn"
    end
    ---如果没有装备 则一一隐藏界面
    if self.bagItemInfo == nil or self.type == nil then
        self:CurLevel_Label().text = ""
        self:NoEquipment_GameObject():SetActive(true)
        self:EquipIcon_Sprite().gameObject:SetActive(false)
        self:EquipLock_GameObject():SetActive(true)
        self:LevelUp_GameObject():SetActive(false)
        self:BreakThrough_GameObject():SetActive(false)
        self:Condition_GameObject():SetActive(false)
        self:OnBtnUpgrade_GameObject():SetActive(false)
        self:GoldText_Label().gameObject:SetActive(false)
        return
    end

    self:LevelUp_GameObject():SetActive(self.type == 1)
    self:BreakThrough_GameObject():SetActive(self.type == 2)
    self:NoEquipment_GameObject():SetActive(false)
    self:EquipLock_GameObject():SetActive(false)
    self:EquipIcon_Sprite().gameObject:SetActive(true)
    self:Condition_GameObject():SetActive(true)
    self:OnBtnUpgrade_GameObject():SetActive(true)
    self:GoldText_Label().gameObject:SetActive(true)

    local GlobalTable = LuaGlobalTableDeal.GetGlobalTabl(23121)
    local colourTemp = string.Split(GlobalTable.value, "&")
    local classData = self:GetClassTable(self.bagItemInfo.itemId)
    for i = 1, #colourTemp do
        local colour = string.Split(colourTemp[i], "#")
        if classData.weaponClass == tonumber(colour[1]) then
            self.colourDes = colour[2]
        end
    end
    self:ShowItemInfo()
    self:ShowFuncWithType()
end

---显示选中物品信息
function UISLequipLevelPanel:ShowItemInfo()
    if self.bagItemInfo == nil then
        return
    end
    local itemData = self:GetItemsTable(self.bagItemInfo.itemId)
    if itemData == nil then
        return
    end
    self:EquipIcon_Sprite().spriteName = itemData:GetIcon()
end

---根据type跳转到不同逻辑
function UISLequipLevelPanel:ShowFuncWithType()
    if self.type == 1 then
        self:RefreshLevelShow()
    elseif self.type == 2 then
        self:RefreshBreakThroughShow()
    end
end

---升级界面显示
function UISLequipLevelPanel:RefreshLevelShow()
    local levelData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetLevelTableByClassTable(self.bagItemInfo.itemId)
    local equipLevel = self.bagItemInfo.growthLevel
    if equipLevel == nil then
        equipLevel = 0
    end
    self:CurLevel_Label().text = self.colourDes and self.colourDes .. "当前等级："..equipLevel or "当前等级："..equipLevel

    local curData, nextData, isMaxLevel = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetCurAndNextTable(equipLevel, levelData)
    self.isMaxLevel = isMaxLevel
    self:Condition_GameObject():SetActive(not self.isMaxLevel)
    self:OnBtnUpgrade_GameObject():SetActive(not self.isMaxLevel)
    self:GoldShow_UILabel().gameObject:SetActive(false)
    self:Max_GameObject():SetActive(self.isMaxLevel)

    self:RefreshLevelGrid(curData, nextData)
    self:RefreshLevelCost(curData)
    self:RefreshStarGrid(equipLevel)
end

---升级星星显示
function UISLequipLevelPanel:RefreshStarGrid(equipLevel)
    if type(equipLevel) ~= 'number' then
        return
    end
    local bigLevel = math.floor(equipLevel / 10)
    local smallLevel = (equipLevel % 10) == 0 and 10 or  equipLevel % 10
    if equipLevel == 0 then
        smallLevel = 0
    end
    local starSprite = {
        "star1",
        "star_g",
        "star_b",
        "star_o",
        "star_r",
    }
    self:StarGrid().MaxCount = 10
    self.allGoAndTemplateDic = {}
    for i = 1, 10 do
        local go = self:StarGrid().controlList[i - 1]
        if go then
            local sprite = self:GetComp(go.transform,"star1",'UISprite')
            if i <= smallLevel and (equipLevel % 10) ~= 0 then
                sprite.spriteName = starSprite[bigLevel + 2]
            else
                sprite.spriteName = starSprite[bigLevel + 1]
            end
        end
    end
end

---升级界面grid
function UISLequipLevelPanel:RefreshLevelGrid(curData, nextData)
    local data = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetCurAndNextAttr(curData, nextData, self.bagItemInfo.itemId)
    self:LevelAttrGrid().MaxCount = #data
    self.allGoAndTemplateDic = {}
    for i = 1, #data do
        local go = self:LevelAttrGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISLequip_LevelTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(data[i])
        end
    end

end

---突破界面显示
function UISLequipLevelPanel:RefreshBreakThroughShow()
    local classData = self:GetClassTable(self.bagItemInfo.itemId)
    if classData == nil then
        return
    end
    self.isMaxClass = classData:GetItemid() == 0 or classData:GetItemid() == nil or classData:GetItemid() == ""
    self:CurLevel_Label().text = self.colourDes and self.colourDes .. "【突破+"..classData:GetWeaponClass().."】" or "【突破+"..classData:GetWeaponClass().."】"
    self:BreakThroughFrist_GameObject():SetActive(classData:GetWeaponClass() == 0)
    if classData:GetWeaponClass() ~= 0 then
        self:CurAttr(classData)
    end
    self:CurAttrGrid().gameObject:SetActive(classData:GetWeaponClass() ~= 0)
    self:NextAttrGrid().gameObject:SetActive(not self.isMaxClass)
    self:BreakThroughMax_GameObject():SetActive(self.isMaxClass)
    self:Condition_GameObject():SetActive(not self.isMaxClass)
    self:OnBtnUpgrade_GameObject():SetActive(not self.isMaxClass)
    self:GoldShow_UILabel().gameObject:SetActive(not self.isMaxClass)
    self:Max_GameObject():SetActive(self.isMaxClass)
    if self.isMaxClass == false then
        self:NextAttr(classData)
        self:RefreshBreakThroughCost(classData)
    end
end

---当前属性grid
function UISLequipLevelPanel:CurAttr(classData)
    local attrList = string.Split(classData.attributeTip, "&")
    local y = (#attrList * 12.6) - 10
    self:CurAttrGrid().gameObject.transform.localPosition = CS.UnityEngine.Vector3(-56, y, 0);
    self:CurAttrGrid().MaxCount = #attrList
    self.allGoAndTemplateDic = {}
    for i = 1, #attrList do
        local go = self:CurAttrGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISLequip_ClassTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(attrList[i])
        end
    end

end

---升级属性grid
function UISLequipLevelPanel:NextAttr(classData)
    local attributeTip = self:GetNextAttr(classData)
    local attrList = string.Split(attributeTip, "&")
    local y = (#attrList * 12.6) - 10
    self:NextAttrGrid().gameObject.transform.localPosition = CS.UnityEngine.Vector3(-56, y, 0);
    self:NextAttrGrid().MaxCount = #attrList
    self.allGoAndTemplateDic = {}
    for i = 1, #attrList do
        local go = self:NextAttrGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISLequip_ClassTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(attrList[i])
        end
    end
end

---突破所需材料
function UISLequipLevelPanel:RefreshBreakThroughCost(classData)
    if classData == nil then
        return
    end
    self:GetCon2Req(classData.cost)
    self:GetCon1Req(classData)
    self:GoldCost(classData)
end

---元宝/钻石消耗
function UISLequipLevelPanel:GoldCost(Data)
    local costData = string.Split(Data.cost2, "#")
    if costData[2] == nil then
        self:GoldShow_UILabel().gameObject:SetActive(false)
        return
    end
    self:GoldShow_UILabel().gameObject:SetActive(true)
    local itemInfo = self:GetItemsTable(tonumber(costData[1]))
    if itemInfo == nil then
        return
    end
    self:GoldShow_UISprite().spriteName = itemInfo:GetIcon()
    local curHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemInfo:GetId())
    self.goldDemand = curHave >= tonumber(costData[2])
    self:GoldShow_UILabel().text = self.goldDemand and luaEnumColorType.Green3 .. curHave .. "[-]/" .. costData[2] or luaEnumColorType.Red .. curHave .. "[-]/" .. costData[2]
end

---con2材料
function UISLequipLevelPanel:GetCon2Req(Data)
    local itemData = string.Split(Data, "#")
    local itemInfo = self:GetItemsTable(tonumber(itemData[1]))
    if itemInfo ~= nil then
        self:BtnCon1_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-49, -142, 0);
        self:BtnCon2_GameObject():SetActive(true)
        self:BtnCon2_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-49, -178, 0);
        self.itemId = itemInfo:GetId()
        self:Con2Name_UILabel().text = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemInfo:GetId())
        self:Con2Icon().spriteName = itemInfo:GetIcon()
        local curItemHave
        if self.type == 2 then
            curItemHave = itemInfo:GetLinkItemId() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemInfo:GetId()) + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemInfo:GetLinkItemId()) or gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemInfo:GetId())
        elseif self.type == 1 then
            if itemInfo:GetType() == 1 then
                curItemHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemInfo:GetId())
            else
                curItemHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemInfo:GetId())
            end
        end
        self.itemDemand = curItemHave >= tonumber(itemData[2])
        self:BtnCon2_UILabel().text = self.itemDemand and luaEnumColorType.Green3 .. curItemHave .. "[-]/" .. itemData[2] or luaEnumColorType.Red .. curItemHave .. "[-]/" .. itemData[2]

    else
        self:BtnCon1_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-49, -161, 0);
        self:BtnCon2_GameObject():SetActive(false)
    end
end

---突破con1材料
function UISLequipLevelPanel:GetCon1Req(Data)
    if Data.needLevel == nil then
        return
    end
    self:BtnCon1_GameObject():SetActive(true)
    self:Con1Name_UILabel().text = "装备等级达到Lv." .. Data.needLevel .. "可突破"
    local equipLevel = self.bagItemInfo.growthLevel
    if equipLevel == nil then
        equipLevel = 0
    end
    self.curLevel = equipLevel >= tonumber(Data.needLevel)
    self:BtnCon1_UILabel().text = self.curLevel and luaEnumColorType.Green3 .. equipLevel .. "[-]/" .. Data.needLevel or luaEnumColorType.Red .. equipLevel .. "[-]/" .. Data.needLevel
end

---升级所需材料
function UISLequipLevelPanel:RefreshLevelCost(curData, nextData)
    self:GetCon2Req(curData.cost)
    self:GetLevelCon1(curData)
end

---升级con1材料
function UISLequipLevelPanel:GetLevelCon1(data)
    local curGoal = self.bagItemInfo.killMonsterCount
    if curGoal == nil then
        curGoal = 0
    end
    local taskgoalTbl = clientTableManager.cfg_taskgoalManager:TryGetValue(tonumber(data.taskgoal))
    if taskgoalTbl == nil then
        self:BtnCon2_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-49, -161, 0);
        self:BtnCon1_GameObject():SetActive(false)
        return
    end
    self:BtnCon1_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-49, -142, 0);
    self:BtnCon2_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-49, -178, 0);
    self:BtnCon1_GameObject():SetActive(true)
    local goalNeed = taskgoalTbl:GetTaskGoalCountParam()
    self.curLevel = curGoal >= goalNeed.list[0]
    self:Con1Name_UILabel().text = taskgoalTbl:GetName()
    self:BtnCon1_UILabel().text = self.curLevel and luaEnumColorType.Green3 .. curGoal .. "[-]/" .. goalNeed.list[0] or luaEnumColorType.Red .. curGoal .. "[-]/" .. goalNeed.list[0]
end

---监听点击事件
function UISLequipLevelPanel:SetBagItemInfo(bagitemInfo)
    if bagitemInfo ~= nil then
        self.bagItemInfo = bagitemInfo
    end
    self:RefreshPanel()
end

---获取下一级属性
function UISLequipLevelPanel:GetNextAttr(classData)
    if classData.itemid == nil then
        return
    end
    local nextItem = self:GetClassTable(classData.itemid)
    if nextItem == nil then
        return nil
    end
    return nextItem.attributeTip
end

---播放升级成功特效
function UISLequipLevelPanel:PlayEffect()
    if self.mUpEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectIds.upLevelEffectId, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                if self:UpEffect() == nil or CS.StaticUtility.IsNull(self:UpEffect()) then
                    return
                end
                self.mUpEffect = res:GetObjInst()
                if self.mUpEffect then
                    self.mUpEffect.transform.parent = self:UpEffect().transform
                    self.mUpEffect.transform.localPosition = CS.UnityEngine.Vector3(2, 0, 0);
                    self.mUpEffect.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        self.mUpEffect:SetActive(false);
        self.mUpEffect:SetActive(true);
    end
end

---突破/升级服务器消息返回
---@param id LuaEnumNetDef 消息ID
---@param data equipV2.ResEquipChange lua table类型消息数据
function UISLequipLevelPanel:OnResEquipMessageReceived(id, data)
    if data == nil or data.equipChange[0].changeEquip == nil then
        return
    end
    local bagItemInfo = data.equipChange[0].changeEquip
    local isSL = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsSLBingJian(bagItemInfo.itemId)
    if isSL then
        luaEventManager.DoCallback(LuaCEvent.BingJianChoose, bagItemInfo)
    end
    if data.reason == 7 then
        UISLequipLevelPanel:PlayEffect()
    end
end
--endregion

--region 按钮点击事件
function UISLequipLevelPanel:OnUpgradeClick()
    if self.goldDemand == false then
        Utility.ShowPopoTips(self:OnBtnUpgrade_GameObject(), "元宝不足", 1)
        return
    end
    if self.itemDemand == false or self.curLevel == false then
        if self.type == 1 then
            Utility.ShowPopoTips(self:OnBtnUpgrade_GameObject(), "升级条件不足", 1)
            return
        elseif self.type == 2 then
            Utility.ShowPopoTips(self:OnBtnUpgrade_GameObject(), "突破条件不足", 1)
            return
        end
    end
    networkRequest.ReqGrowthEquip(self.type, self.bagItemInfo.index)
end

function UISLequipLevelPanel:OnBtnJumpClick()
    if self.type == 1 then
        self.type = 2
    elseif self.type == 2 then
        self.type = 1
    end
    self:RefreshPanel()
end

--endregion

--region 读取table
function UISLequipLevelPanel:GetItemsTable(itemId)
    if itemId == nil then
        return
    end
    local Lua_itemsTABLE = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if Lua_itemsTABLE ~= nil then
        return Lua_itemsTABLE
    end
end

function UISLequipLevelPanel:GetClassTable(itemId)
    if itemId == nil then
        return
    end
    local Lua_ClassTABLE = clientTableManager.cfg_growth_weapon_classManager:TryGetValue(itemId)
    if Lua_ClassTABLE ~= nil then
        return Lua_ClassTABLE
    end
end

function UISLequipLevelPanel:GetLevelTable(itemId)
    if itemId == nil then
        return
    end
    local Lua_LevelTABLE = clientTableManager.cfg_growth_weapon_levelManager:TryGetValue(itemId)
    if Lua_LevelTABLE ~= nil then
        return Lua_LevelTABLE
    end
end
--endregion

function ondestroy()
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsSLequipLevelOpen(false)
    luaEventManager.DoCallback(LuaCEvent.BingJianChoose)
end


return UISLequipLevelPanel