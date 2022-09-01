---@class UIOtherRoleBloodSuitPanel 查看他人的时候 他人的血继面板
local UIOtherRoleBloodSuitPanel = {}

---初始化数据
function UIOtherRoleBloodSuitPanel:Init()
    self:InitComponents()
    self:InitData()
    self:InitEquipIndexDic()
    self:RefreshUI(1, 1)
end

function UIOtherRoleBloodSuitPanel:InitComponents()
    ---装备类型Grid
    self.TypeUIGridContainer = self:GetCurComp("WidgetRoot/events/ScrollView/BookMarks", "Top_UIGridContainer")
    ---角色模型根节点
    self.roleModel = self:GetCurComp("WidgetRoot/view/roleModel", "GameObject")

    ---套装属性按钮
    ---@type Top_UISprite
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

function UIOtherRoleBloodSuitPanel:InitData()
    ---@type LuaPlayerBloodSuitEquipMgr
    if (self.MainData == nil) then
        self.MainData = luaclass.LuaPlayerBloodSuitEquipMgr:New()
    end

    self.btn_Inherit.gameObject:SetActive(false)
    --CS.UIEventListener.Get(self.btn_Inherit.gameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.btn_Inherit.gameObject).OnClickLuaDelegate = self.OnClickbtn_Inherit

    ---@type roleV2.RoleToOtherInfo
    local RoleToOtherInfo = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo
    self.career = RoleToOtherInfo.career

    for i, item in pairs(RoleToOtherInfo.equipList) do
        self.MainData:RefreShBloodSuitDic(item, item.index)
    end

    self:RefreshTopTab()
end

---刷新顶部页签
function UIOtherRoleBloodSuitPanel:RefreshTopTab(selectType)
    if self.BloodSuitTempListDic == nil then
        ---@type table<number,UIRoleBloodSuitTblTemplate>
        self.BloodSuitTempListDic = {}
    end
    local data = clientTableManager.cfg_bloodsuit_combinationManager.EquipTypeDic
    local OpenSuitTypeList = self.MainData:GetOtherOpenSuitTypeList()
    local needShowCount = #OpenSuitTypeList
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
        self.BloodSuitTempListDic[i]:RefreshUI(v, self.MainData.NowSelectSuit == i,false,self.MainData)
        index = index + 1
    end
end

---刷新数据
---@param selectType number   套装类型
---@param selectIndex number  套装装备位
function UIOtherRoleBloodSuitPanel:RefreshUI(selectType, selectIndex)
    if selectType then
        self.MainData.NowSelectSuit = selectType
    end
    if selectIndex then
        self.MainData.NowSelectEquipItemType = selectIndex
    end
    if self.isRecordSelectIndex == false then
        self.MainData.NowSelectEquipItemType = LuaEquipBloodSuitItemType.egg1
    else
        self.MainData.NowSelectEquipItemType = self:GetDefaultSelectIndex()
    end
    self:RefreshAllEquip()
    self:LoadModel()
    self:RefreshTopTab()
    self:Refreshbtn_Inherit()
end

---得到默认选择的位置
---@return LuaEquipBloodSuitItemType
function UIOtherRoleBloodSuitPanel:GetDefaultSelectIndex()
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

function UIOtherRoleBloodSuitPanel:InitEquipIndexDic()
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body1, self.Brain, luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body2, self.Heart, luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body3, self.Bone, luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.body4, self.Blood, luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg1, self.huanshou1, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg2, self.huanshou2, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg3, self.huanshou3, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg4, self.huanshou4, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg5, self.huanshou5, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg6, self.huanshou6, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg7, self.huanshou7, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
    self:AddEquipIndexDic(LuaEquipBloodSuitItemType.egg8, self.huanshou8, luaComponentTemplates.UIRoleBloodSuitItemTemplate)
end

---添加装备字典数据
function UIOtherRoleBloodSuitPanel:AddEquipIndexDic(pos, go, template)
    if pos == nil or go == nil or self.MainData == nil then
        return
    end
    if self.EquipDic == nil then
        ---@type table<number,UIRoleBloodSuitItemBase> key装备类型 value UIRoleBloodSuitItemTemplate
        self.EquipDic = {}
    end
    if self.EquipDic[pos] == nil then
        if template == nil then
            template = luaComponentTemplates.UIRoleBloodSuitItemTemplate
        end
        self.EquipDic[pos] = templatemanager.GetNewTemplate(go, template, self, pos)
        self.EquipDic[pos].OnClickItemOpenRight = false
    end
end

--region 刷新装备位
---刷新所有装备位
function UIOtherRoleBloodSuitPanel:RefreshAllEquip()
    local SingleBloodSuitDic = self.MainData:GetSingleBloodSuitDic(self.MainData.NowSelectSuit)
    if self.EquipDic ~= nil then
        for i, v in pairs(self.EquipDic) do
            local equipIndex = self.MainData:GetEquipIndex(self.MainData.NowSelectSuit, i)
            if SingleBloodSuitDic ~= nil then
                v:RefreshUI(equipIndex, false, SingleBloodSuitDic[i], self.MainData, self.career)
            else
                v:RefreshUI(equipIndex, false)
            end
        end
    end
end

---刷新装备（指定装备位刷新）
function UIOtherRoleBloodSuitPanel:RefreshEquip(index, data)
    if self.EquipDic == nil or self.index == nil then
        return
    end
    self.EquipDic:RefreshUI(data)
end

---刷新装备位选中状态
function UIOtherRoleBloodSuitPanel:RefreshSelectIndex(pos)
    self.MainData.NowSelectEquipItemType = pos
    --self:SetSelectIndex(pos)
    --for i, v in pairs(self.EquipDic) do
    --    v:RefreShChoose()
    --end
end

--endregion

---刷新点击套装展示按钮
function UIOtherRoleBloodSuitPanel:Refreshbtn_Inherit()

    local IsWearBloodSuit = self.MainData ~= nil and self.MainData:IsWearBloodSuit()
    if IsWearBloodSuit then
        self.btn_Inherit.color = CS.UnityEngine.Color(1, 1, 1);
    else
        self.btn_Inherit.color = CS.UnityEngine.Color(0, 0, 0);
    end
end

function UIOtherRoleBloodSuitPanel:LoadModel()
    ---@type roleV2.RoleToOtherInfo
    local RoleToOtherInfo = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo
    if (RoleToOtherInfo == nil) then
        return ;
    end

    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    local ModelEffectMountItemList = {}
    local isModelChanged = false
    if not CS.StaticUtility.IsNull(self.roleModel) then
        isModelChanged = self.ObservationModel:CreateRoleModelByItem(RoleToOtherInfo.sex,
                RoleToOtherInfo.career,
                RoleToOtherInfo.armor,
                RoleToOtherInfo.weapon,
                RoleToOtherInfo.helmet,
                RoleToOtherInfo.face,
                RoleToOtherInfo.bambooHat,
                RoleToOtherInfo.shield,
                ModelEffectMountItemList,
                self.roleModel.transform)
    end
    if isModelChanged then
        local localPosition_x = -159
        if Utility.EnumToInt(RoleToOtherInfo.sex) == LuaEnumSex.WoMan then
            localPosition_x = -154
        end
        self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(localPosition_x, -134, -250))
        self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self.ObservationModel:SetScaleSize(CS.UnityEngine.Vector3(180, 180, 180))
        self.ObservationModel:SetDragRoot(self.roleModel)
    end
end

function UIOtherRoleBloodSuitPanel:OnOpenBag()

end

---获取背包界面是否存在
---@return boolean
function UIOtherRoleBloodSuitPanel:GetBagPanelExistState()
    return false
end

---点击套装展示按钮
function UIOtherRoleBloodSuitPanel:OnClickbtn_Inherit()
    if self.MainData ~= nil and self.MainData:IsWearBloodSuit() then
        uimanager:CreatePanel("UISuitAttributeBloodSuitPanel", nil, self.MainData.NowSelectSuit, 2)
    end
end

return UIOtherRoleBloodSuitPanel