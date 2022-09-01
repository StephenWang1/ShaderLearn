---血继面板
---@class UIRoleBloodSuitPanel:UIBase
local UIRoleBloodSuitPanel = {}

function UIRoleBloodSuitPanel:InitComponents()
    ---帮助按钮
    self.btn_help = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    ---关闭按钮
    self.btn_close = self:GetCurComp("WidgetRoot/window/window/left_main/events/btn_close", "GameObject")
    ---装备类型Grid
    self.TypeUIGridContainer = self:GetCurComp("WidgetRoot/events/ScrollView/BookMarks", "Top_UIGridContainer")
    ---角色模型根节点
    self.roleModel = self:GetCurComp("WidgetRoot/view/roleModel", "GameObject")

    ---套装属性按钮
    self.btn_Inherit = self:GetCurComp("WidgetRoot/events/btn_Inherit", "Top_UISprite")

    ---脑
    self.Brain = self:GetCurComp("WidgetRoot/view/body/Brain", "GameObject")
    ---心
    self.Heart = self:GetCurComp("WidgetRoot/view/body/Heart", "GameObject")
    ---骨
    self.Bone = self:GetCurComp("WidgetRoot/view/body/Bone", "GameObject")
    ---血
    self.Blood = self:GetCurComp("WidgetRoot/view/body/Blood", "GameObject")
    ---灵兽1
    self.huanshou1 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou1", "GameObject")
    ---灵兽2
    self.huanshou2 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou2", "GameObject")
    ---灵兽3
    self.huanshou3 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou3", "GameObject")
    ---灵兽4
    self.huanshou4 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou4", "GameObject")
    ---灵兽5
    self.huanshou5 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou5", "GameObject")
    ---灵兽6
    self.huanshou6 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou6", "GameObject")
    ---灵兽7
    self.huanshou7 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou7", "GameObject")
    ---灵兽8
    self.huanshou8 = self:GetCurComp("WidgetRoot/view/huanshou/huanshou8", "GameObject")
end

function UIRoleBloodSuitPanel:InitOther()
    ---@type LuaPlayerBloodSuitEquipMgr
    self.MainData = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()

    CS.UIEventListener.Get(self.btn_help.gameObject).onClick = self.onClickBtn_help
    CS.UIEventListener.Get(self.btn_close.gameObject).onClick = self.onClickBtn_close

    self.btn_Inherit.gameObject:SetActive(false)
    --CS.UIEventListener.Get(self.btn_Inherit.gameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.btn_Inherit.gameObject).OnClickLuaDelegate = self.OnClickbtn_Inherit

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAllEquipMessage, function()
        self:OnResAllEquipMessage()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipChangeMessage, function()
        self:OnResEquipChangeMessage()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, function()
        self:OpenBagPanel()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshBlooodSuitEquipInfo, function()
        self:OnResBagItemChanged()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, function()
        self:RefreshBagPanelState()
        self:RefreshChooseItemState()
    end)

end

---初始化数据
function UIRoleBloodSuitPanel:Init()
    self:InitComponents()
    self:InitOther()
    self:InitRedDic()
end

---@class RoleBloodPanelData
---@field ItemTemplateEgg UIRoleBloodSuitItemBase 血继灵兽蛋格子模板
---@field ItemTemplateBody UIRoleBloodSuitItemBase 血继肉身格子模板
---@field Suittype LuaEquipBloodSuitType 套装类型
---@field pos LuaEquipBloodSuitItemType 血继装备位下标类型
---@field isRecordSelectIndex boolean 是否记录装备位选择
---@field IsOpenBag boolean 是否打开背包
---@field SuitRedDic table<LuaEquipBloodSuitType,LuaRedPointName> 血继套装红点
---@field EqupIndexRedDic table<LuaEquipBloodSuitItemType,LuaRedPointName> 装备位置红点

---@param customData RoleBloodPanelData
function UIRoleBloodSuitPanel:Show(customData)
    if customData == nil then
        customData = {}
    end
    if customData.SuitRedDic then
        self.SuitRedPointDic = customData.SuitRedDic
    else
        self.SuitRedPointDic = self.defaultSuitRedPointDic
    end

    if customData.ItemTemplateEgg ~= nil then
        self.ItemTemplateEgg = customData.ItemTemplateEgg
    else
        self.ItemTemplateEgg = luaComponentTemplates.UIRoleBloodSuitItemTemplate
    end
    if customData.ItemTemplateBody ~= nil then
        self.ItemTemplateBody = customData.ItemTemplateBody
    else
        self.ItemTemplateBody = luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate
    end

    self.MainData.NowSelectSuit = self:GetCurrentOpenPanelType(customData)

    if customData.IsOpenBag ~= nil then
        self.IsOpenBag = customData.IsOpenBag
    else
        local redPointManager = gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager()
        local key = redPointManager:GetLuaRedPointKey(LuaRedPointName.BloodSuit_All)
        local open = redPointManager:GetRedPointValue(key)
        self.IsOpenBag = open
    end
    if customData.pos then
        self.MainData.NowSelectEquipItemType = customData.pos
    else
        if self.IsOpenBag then
            self.MainData.NowSelectEquipItemType = LuaEquipBloodSuitItemType.egg1
        else
            self.MainData.NowSelectEquipItemType = LuaEquipBloodSuitItemType.None
        end
    end
    if customData.isRecordSelectIndex ~= nil then
        self.isRecordSelectIndex = customData.isRecordSelectIndex
    else
        self.isRecordSelectIndex = false
    end
    if customData.EqupIndexRedDic then
        self.EqupIndexRedDic = customData.EqupIndexRedDic
    else
        self.EqupIndexRedDic = self.defaultEqupIndexRedPointDic
    end

    self:InitEquipIndexDic()
    self:RefreshUI(self.MainData.NowSelectSuit, self.MainData.NowSelectEquipItemType)
    if self.IsOpenBag then
        self:OnOpenBag()
    end
end

---@return LuaEquipBloodSuitType 打开选中类型
function UIRoleBloodSuitPanel:GetCurrentOpenPanelType(customData)
    if customData.Suittype and self.MainData:IsOpenEquipType(customData.Suittype) then
        return customData.Suittype
    end

    local redPointManager = gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager()
    for k, v in pairs(self.SuitRedPointDic) do
        local key = redPointManager:GetLuaRedPointKey(v)
        local state = redPointManager:GetRedPointValue(key)
        local open = self.MainData:IsOpenEquipType(k)
        if state and open then
            return k
        end
    end
    return LuaEquipBloodSuitType.Yao
end

---刷新数据
---@param selectType number   套装类型
---@param selectIndex number  套装装备位
function UIRoleBloodSuitPanel:RefreshUI(selectType, selectIndex)
    if selectType then
        self.MainData.NowSelectSuit = selectType
    end
    if selectIndex then
        self.MainData.NowSelectEquipItemType = selectIndex
    else
        if self.isRecordSelectIndex == false then
            self.MainData.NowSelectEquipItemType = LuaEquipBloodSuitItemType.egg1
        else
            self.MainData.NowSelectEquipItemType = UIRoleBloodSuitPanel:GetDefaultSelectIndex()
        end
    end
    self:RefreshAllEquip()
    self:LoadModel()
    self:RefreshTopTab()
    self:OnResBagItemChanged()
    self:Refreshbtn_Inherit()
    luaEventManager.DoCallback(LuaCEvent.RefreshBloodSuitBag)
end

---设置选择位置
function UIRoleBloodSuitPanel:SetSelectIndex(selectIndex)
    if selectIndex ~= nil then
        self.MainData.NowSelectEquipItemType = selectIndex
    else
        self.MainData.NowSelectEquipItemType = self:GetDefaultSelectIndex()
    end
    self:SetSelectIndexDic(self.MainData.NowSelectEquipItemType)
end

---设置默认选择位置字典
function UIRoleBloodSuitPanel:SetSelectIndexDic(selectIndex)
    if self.isRecordSelectIndex == false then
        return
    end
    self.SelectIndexData = self.MainData:GetEquipIndex(self.MainData.NowSelectSuit, self.MainData.NowSelectEquipItemType)
end

---得到默认选择的位置
---@return LuaEquipBloodSuitItemType
function UIRoleBloodSuitPanel:GetDefaultSelectIndex()
    if self.isRecordSelectIndex == false then
        return LuaEquipBloodSuitItemType.egg1
    end
    if self.SelectIndexData == nil then
        return LuaEquipBloodSuitItemType.None
    end
    local type, pos = self.MainData:GetEquipTypeAndPos(self.SelectIndexData)
    if type == self.MainData.NowSelectSuit then
        return pos
    end
    return LuaEquipBloodSuitItemType.None
end

--region 初始化装备字典
---刷新装备字典
function UIRoleBloodSuitPanel:InitEquipIndexDic()
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body1, self.Brain, self.ItemTemplateBody)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body2, self.Heart, self.ItemTemplateBody)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body3, self.Bone, self.ItemTemplateBody)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body4, self.Blood, self.ItemTemplateBody)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg1, self.huanshou1, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg2, self.huanshou2, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg3, self.huanshou3, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg4, self.huanshou4, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg5, self.huanshou5, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg6, self.huanshou6, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg7, self.huanshou7, self.ItemTemplateEgg)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg8, self.huanshou8, self.ItemTemplateEgg)
end

function UIRoleBloodSuitPanel:InitRedDic()
    ---@type table<LuaEquipBloodSuitType,LuaRedPointName> 血继套装红点
    self.defaultSuitRedPointDic = {
        [LuaEquipBloodSuitType.Yao] = LuaRedPointName.BloodSuit_Yao,
        [LuaEquipBloodSuitType.Xian] = LuaRedPointName.BloodSuit_Xian,
        [LuaEquipBloodSuitType.Mo] = LuaRedPointName.BloodSuit_Mo,
        [LuaEquipBloodSuitType.Ling] = LuaRedPointName.BloodSuit_Ling,
        [LuaEquipBloodSuitType.Shen] = LuaRedPointName.BloodSuit_Shen,
    }
    ---@type table<LuaEquipBloodSuitType,LuaRedPointName> 血继装备格子红点
    self.defaultEqupIndexRedPointDic = {
        [LuaEquipBloodSuitItemType.egg1] = LuaRedPointName.BloodSuit_egg1,
        [LuaEquipBloodSuitItemType.egg2] = LuaRedPointName.BloodSuit_egg2,
        [LuaEquipBloodSuitItemType.egg3] = LuaRedPointName.BloodSuit_egg3,
        [LuaEquipBloodSuitItemType.egg4] = LuaRedPointName.BloodSuit_egg4,
        [LuaEquipBloodSuitItemType.egg5] = LuaRedPointName.BloodSuit_egg5,
        [LuaEquipBloodSuitItemType.egg6] = LuaRedPointName.BloodSuit_egg6,
        [LuaEquipBloodSuitItemType.egg7] = LuaRedPointName.BloodSuit_egg7,
        [LuaEquipBloodSuitItemType.egg8] = LuaRedPointName.BloodSuit_egg8,
        [LuaEquipBloodSuitItemType.body1] = LuaRedPointName.BloodSuit_body1,
        [LuaEquipBloodSuitItemType.body2] = LuaRedPointName.BloodSuit_body2,
        [LuaEquipBloodSuitItemType.body3] = LuaRedPointName.BloodSuit_body3,
        [LuaEquipBloodSuitItemType.body4] = LuaRedPointName.BloodSuit_body4,
    }
end

---添加装备字典数据
function UIRoleBloodSuitPanel:AddEquipIndexDic(pos, go, template)
    if pos == nil or go == nil or self.MainData == nil then
        return
    end
    if UIRoleBloodSuitPanel.EquipDic == nil then
        ---@type table<LuaEquipBloodSuitType,UIRoleBloodSuitItemBase> key装备类型 value UIRoleBloodSuitItemTemplate
        UIRoleBloodSuitPanel.EquipDic = {}
    end
    if UIRoleBloodSuitPanel.EquipDic[pos] == nil then
        if template == nil then
            template = luaComponentTemplates.UIRoleBloodSuitItemTemplate
        end
        UIRoleBloodSuitPanel.EquipDic[pos] = templatemanager.GetNewTemplate(go, template, self, pos)
    end
end
--endregion

--region  刷新顶部页签
---刷新顶部页签
function UIRoleBloodSuitPanel:RefreshTopTab(selectType)
    if self.BloodSuitTempListDic == nil then
        ---@type table<number,UIRoleBloodSuitTblTemplate>
        self.BloodSuitTempListDic = {}
    end
    local data = clientTableManager.cfg_bloodsuit_combinationManager.EquipTypeDic
    local OpenSuitTypeList = self.MainData:RefreShOpenSuitTypeList()
    local needShowCount = #OpenSuitTypeList + 1
    local count = #data
    if needShowCount < #data then
        count = needShowCount
    end
    self.TypeUIGridContainer.MaxCount = count
    local index = 0
    for i, v in pairs(data) do
        if index + 1 > count then
            return
        end
        if self.BloodSuitTempListDic[i] == nil then
            local item = self.TypeUIGridContainer.controlList[index]
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIRoleBloodSuitTblTemplate, self, i)
            self.BloodSuitTempListDic[i] = template
        end
        self.BloodSuitTempListDic[i]:RefreshUI(v, self.MainData.NowSelectSuit == i)
        index = index + 1
    end
end

--endregion

--region 刷新装备位
---刷新所有装备位
function UIRoleBloodSuitPanel:RefreshAllEquip()
    local SingleBloodSuitDic = self.MainData:GetSingleBloodSuitDic(self.MainData.NowSelectSuit)
    self:RefreshBagPanelState()
    if self.EquipDic ~= nil then
        for i, v in pairs(self.EquipDic) do
            local equipIndex = self.MainData:GetEquipIndex(self.MainData.NowSelectSuit, i)
            if SingleBloodSuitDic ~= nil then
                v:RefreshUI(equipIndex, true, SingleBloodSuitDic[i], self.MainData, Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
            else
                v:RefreshUI(equipIndex, true)
            end
        end
    end
    self:Refreshbtn_Inherit()
end

---刷新选中框状态
function UIRoleBloodSuitPanel:RefreshChooseItemState()
    if self.EquipDic ~= nil then
        for i, v in pairs(self.EquipDic) do
            v:RefreshChooseItem()
        end
    end
end

---获取背包界面是否存在
---@return boolean
function UIRoleBloodSuitPanel:GetBagPanelExistState()
    return self.mHasBagPanel
end

---刷新背包界面存在状态
function UIRoleBloodSuitPanel:RefreshBagPanelState()
    local panel = uimanager:GetPanel("UIBagPanel")
    local hasBagPanel = panel ~= nil and CS.StaticUtility.IsNull(panel.go) == false
    self.mHasBagPanel = hasBagPanel
end

---刷新装备（指定装备位刷新）
function UIRoleBloodSuitPanel:RefreshEquip(index, data)
    if self.EquipDic == nil or self.index == nil then
        return
    end
    self.EquipDic:RefreshUI(data)
end

---刷新装备位选中状态
function UIRoleBloodSuitPanel:RefreshSelectIndex(pos)
    self.MainData.NowSelectEquipItemType = pos
    self:SetSelectIndex(pos)
    for i, v in pairs(self.EquipDic) do
        v:RefreShChoose()
    end
end

--endregion

--region 加载模型
function UIRoleBloodSuitPanel:LoadModel()
    if CS.CSScene.Sington == nil then
        return
    end
    if CS.CSScene.Sington.MainPlayer == nil or CS.CSScene.Sington.MainPlayer.BaseInfo == nil then
        return
    end
    self.playerAvatarInfo = CS.CSScene.Sington.MainPlayer.BaseInfo
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    local ModelEffectMountItemList = {}
    local isModelChanged = false
    if not CS.StaticUtility.IsNull(self.roleModel) then
        isModelChanged = self.ObservationModel:CreateRoleModel(self.playerAvatarInfo.Sex,
                self.playerAvatarInfo.Career,
                self.playerAvatarInfo:GetBodyModelID(),
                self.playerAvatarInfo:GetWeaponModelID(),
                self.playerAvatarInfo:GetHairModelID(),
                self.playerAvatarInfo:GetFaceModelID(),
                ModelEffectMountItemList,
                self.roleModel.transform)
    end
    if isModelChanged then
        local localPosition_x = -159
        if Utility.EnumToInt(self.playerAvatarInfo.Sex) == LuaEnumSex.WoMan then
            localPosition_x = -154
        end
        self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(localPosition_x, -134, -250))
        self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self.ObservationModel:SetScaleSize(CS.UnityEngine.Vector3(180, 180, 180))
        self.ObservationModel:SetDragRoot(self.roleModel)
    end
end
--endregion

---刷新点击套装展示按钮
function UIRoleBloodSuitPanel:Refreshbtn_Inherit()

    local IsWearBloodSuit = self.MainData ~= nil and self.MainData:IsWearBloodSuit()
    if IsWearBloodSuit then
        self.btn_Inherit.color = CS.UnityEngine.Color(1, 1, 1);
    else
        self.btn_Inherit.color = CS.UnityEngine.Color(0, 0, 0);
    end
end

--region 点击事件
---帮助点击事件
function UIRoleBloodSuitPanel.onClickBtn_help()
    local data = {}
    data.id = 179
    Utility.ShowHelpPanel(data)
end
---关闭点击事件
function UIRoleBloodSuitPanel.onClickBtn_close()
    uimanager:ClosePanel("UIRoleBloodSuitPanel")
end

---点击套装展示按钮
function UIRoleBloodSuitPanel:OnClickbtn_Inherit()
    if self.MainData ~= nil and self.MainData:IsWearBloodSuit() then
        uimanager:CreatePanel("UISuitAttributeBloodSuitPanel", nil, self.MainData.NowSelectSuit, 1)
    end
end

--endregion

---刷新所有裝備
function UIRoleBloodSuitPanel:OnResAllEquipMessage()
    self:RefreshAllEquip()
end

---刷新单个装备刷新
function UIRoleBloodSuitPanel:OnResEquipChangeMessage()
    self:RefreshAllEquip()
end

---打开背包
function UIRoleBloodSuitPanel:OnOpenBag()
    if self.IsOpenBag then
        self:OpenBagPanel()
    end
end

---直接打开背包
function UIRoleBloodSuitPanel:OpenBagPanel()
    uimanager:CreatePanel("UIBagPanel", function()
        self:RefreshBagPanelState()
        self:RefreshChooseItemState()
    end, { type = LuaEnumBagType.BloodSuit })
    local pos = self.MainData.NowSelectEquipItemType
    if pos == LuaEquipBloodSuitItemType.None or pos == nil then
        pos = self:GetDefaultSelectIndex()
    end
    if pos == LuaEquipBloodSuitItemType.None then
        pos = LuaEquipBloodSuitItemType.egg1
    end
    self:RefreshSelectIndex(pos)
end

function UIRoleBloodSuitPanel:OnResBagItemChanged()
    if self.EquipDic then
        for i, v in pairs(self.EquipDic) do
            v:RefreshAddActive(i)
        end
    end
end

function ondestroy()
    uimanager:ClosePanel("UIBagPanel")
end

return UIRoleBloodSuitPanel