---@class UIMagicCircleRolePanel:UIBase
local UIMagicCircleRolePanel = {}

--region 初始化
function UIMagicCircleRolePanel:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIEvents()
end

function UIMagicCircleRolePanel:Show()
    self.zhenFaTable = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo():GetZhenFaTable()
    self:RefreshTitle()
    self:RefreshRoleModel()
    self:RefreshZhenFaArrow()
    self:RefreshZhenFaEffect()
    self:RefreshZhenFaEquip()
end

function UIMagicCircleRolePanel:InitComponents()
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    self.arrow1_GameObject = self:GetCurComp("WidgetRoot/events/arrow1", "GameObject")
    self.arrow2_GameObject = self:GetCurComp("WidgetRoot/events/arrow2", "GameObject")
    self.name_UILabel = self:GetCurComp("WidgetRoot/view/name", "UILabel")
    self.modelRoot_GameObject = self:GetCurComp("WidgetRoot/view/roleModel", "GameObject")
    self.effect_GameObject = self:GetCurComp("WidgetRoot/view/effect", "GameObject")
    self.effect_CSUIEffectLoad = self:GetCurComp("WidgetRoot/view/effect/FaZhenEffect1", "CSUIEffectLoad")
    self.effect_CSUIEffectLoad2 = self:GetCurComp("WidgetRoot/view/effect/FaZhenEffect2", "CSUIEffectLoad")
    self.zhenFaEquips = self:GetCurComp("WidgetRoot/view/equips", "UIGridContainer")
end

function UIMagicCircleRolePanel:InitParameters()
    self.playerAvatarInfo = nil
    self.observationModel = nil
    self.zhenFaTable = nil
    self.zhenFaEquipManager = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaEquipManager()
    self.mGridToTemplate = {}
end

function UIMagicCircleRolePanel:BindUIEvents()
    ---点击关闭按钮
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        uimanager:ClosePanel("UIMagicCircleRolePanel")
    end
    ---点击左箭头
    CS.UIEventListener.Get(self.arrow1_GameObject).onClick = function()
        if self.zhenFaTable.level > 0 then
            self.zhenFaTable = clientTableManager.cfg_zhenfaManager:TryGetValue(self.zhenFaTable.id - 1)
            self:RefreshTitle()
            self:RefreshZhenFaEffect()
            self:RefreshZhenFaArrow()
        end
    end
    ---点击右箭头
    CS.UIEventListener.Get(self.arrow2_GameObject).onClick = function()
        if self.zhenFaTable.level < 15 then
            self.zhenFaTable = clientTableManager.cfg_zhenfaManager:TryGetValue(self.zhenFaTable.id + 1)
            self:RefreshTitle()
            self:RefreshZhenFaEffect()
            self:RefreshZhenFaArrow()
        end
    end
end
--endregion

function UIMagicCircleRolePanel:RefreshTitle()
    self.name_UILabel.text = string.CSFormat("{0}阶法阵", self.zhenFaTable.level)
end

function UIMagicCircleRolePanel:RefreshRoleModel()
    if self.playerAvatarInfo == nil then
        self.playerAvatarInfo = CS.CSScene.MainPlayerInfo
    end
    self:LoadTargetModel(self.playerAvatarInfo.Sex, self.playerAvatarInfo.Career, self.playerAvatarInfo:GetBodyModelID(),
            self.playerAvatarInfo:GetWeaponModelID(), self.playerAvatarInfo:GetHairModelID(), self.playerAvatarInfo:GetFaceModelID())
end

function UIMagicCircleRolePanel:LoadTargetModel(sex, career, model, weapon, hair, face)
    if self.observationModel == nil then
        self.observationModel = CS.ObservationModel()
    end
    local ModelEffectMountItemList = {}
    --if CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEffectId() ~= 0 then
    --    table.insert(ModelEffectMountItemList, CS.ModelEffectMountItem(CS.CSScene.MainPlayerInfo.ElementInfo:GetElementEffectId(), 1, Utility.EnumToInt(CS.ModelStructure.Weapon), CS.ResourceType.UIEffect))
    --end
    local isModelChanged = false
    if not CS.StaticUtility.IsNull(self.modelRoot_GameObject) then
        self.observationModel:SetShowMotion(weapon == 0 and CS.CSMotion.Stand or CS.CSMotion.ShowStand)
        isModelChanged = self.observationModel:CreateRoleModel(sex, career, model,
                weapon, hair, face, ModelEffectMountItemList, self.modelRoot_GameObject.transform)
    end
    if isModelChanged then
        local localPosition_x = -159
        if Utility.EnumToInt(self.playerAvatarInfo.Sex) == LuaEnumSex.WoMan then
            localPosition_x = -154
        end
        self.observationModel:SetPosition(CS.UnityEngine.Vector3(localPosition_x, -134, 400))
        self.observationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
        self.observationModel:SetScaleSize(CS.UnityEngine.Vector3(180, 180, 180))
        self.observationModel:SetDragRoot(self.modelRoot_GameObject)
    end
end

function UIMagicCircleRolePanel:RefreshZhenFaArrow()
    local zhenFaLevel = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo():GetZhenFaTable().level
    self.arrow1_GameObject:SetActive(self.zhenFaTable.level > zhenFaLevel)
    self.arrow2_GameObject:SetActive(self.zhenFaTable.level < 15 and self.zhenFaTable.level < zhenFaLevel + 1)
end

function UIMagicCircleRolePanel:RefreshZhenFaEffect()
    local effect = self.zhenFaTable.effectName
    if effect == nil or effect == 0 then
        self.effect_CSUIEffectLoad.gameObject:SetActive(false)
        self.effect_CSUIEffectLoad2.gameObject:SetActive(false)
        return
    end
    ---@type table<FaZhenEffectInfo>
    local zhenFaEffectInfoList = clientTableManager.cfg_zhenfaManager:GetFaZhenEffectInfoList(self.zhenFaTable.id)
    ---@type FaZhenEffectInfo
    local zhenFaEffect1 = zhenFaEffectInfoList[1]
    local zhenFaEffect2 = zhenFaEffectInfoList[2]
    self.effect_CSUIEffectLoad.gameObject:SetActive(true)
    CS.Utility_Lua.GetComponent(self.effect_CSUIEffectLoad.transform, "UISprite").atlas = nil
    self.effect_CSUIEffectLoad:ChangeEffect(string.CSFormat(zhenFaEffect1.faZhenEffectName))
    if zhenFaEffect2 then
        self.effect_CSUIEffectLoad2.gameObject:SetActive(true)
        CS.Utility_Lua.GetComponent(self.effect_CSUIEffectLoad2.transform, "UISprite").atlas = nil
        self.effect_CSUIEffectLoad2:ChangeEffect(string.CSFormat(zhenFaEffect2.faZhenEffectName))
    else
        self.effect_CSUIEffectLoad2.gameObject:SetActive(false)
    end
    self:AdjustZhenFaEffect()

    local itemId = self.zhenFaTable:GetItemId()
    if itemId == nil or itemId == 0 then
        return
    end
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
    if not isFind then
        return
    end
    local uieventlistener = CS.UIEventListener.Get(self.effect_GameObject)
    uieventlistener.LuaEventTable = itemTable
    uieventlistener.OnClickLuaDelegate = self.OnZhenFaEffectClicked
end

function UIMagicCircleRolePanel:AdjustZhenFaEffect()
    ---@type table<FaZhenEffectInfo>
    local zhenFaEffectInfoList = clientTableManager.cfg_zhenfaManager:GetFaZhenEffectInfoList(self.zhenFaTable.id)
    ---@type FaZhenEffectInfo
    local zhenFaEffect1 = zhenFaEffectInfoList[1]
    local zhenFaEffect2 = zhenFaEffectInfoList[2]
    if zhenFaEffect1 then
        self.effect_CSUIEffectLoad.transform.localPosition = zhenFaEffect1.faZhenLocalPosition
        self.effect_CSUIEffectLoad.transform.localScale = zhenFaEffect1.faZhenScale
    end

    if zhenFaEffect2 then
        self.effect_CSUIEffectLoad2.transform.localPosition = zhenFaEffect2.faZhenLocalPosition
        self.effect_CSUIEffectLoad2.transform.localScale = zhenFaEffect2.faZhenScale
    end
end

function UIMagicCircleRolePanel.OnZhenFaEffectClicked(itemTable, go)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
end

function UIMagicCircleRolePanel:RefreshZhenFaEquip()
    self.zhenFaEquips.MaxCount = 4
    local item1 = self.zhenFaEquips.controlList[0]
    local item2 = self.zhenFaEquips.controlList[1]
    local item3 = self.zhenFaEquips.controlList[2]
    local item4 = self.zhenFaEquips.controlList[3]
    self:RefreshZhenFaEquipGrid(item1, LuaEnumPlayerEquipIndex.LingFu, 1)
    self:RefreshZhenFaEquipGrid(item2, LuaEnumPlayerEquipIndex.BaGuaPan, 3)
    self:RefreshZhenFaEquipGrid(item3, LuaEnumPlayerEquipIndex.LingChen, 5)
    self:RefreshZhenFaEquipGrid(item4, LuaEnumPlayerEquipIndex.XianZhu, 7)
end

function UIMagicCircleRolePanel:RefreshZhenFaEquipGrid(grid, equipIndex, open)
    self:GetComp(grid.transform, "background/Sprite", "UISprite").spriteName = LuaGlobalTableDeal:GetZhenFaConfigInfo(equipIndex).baseSpriteName
    local equipIndexIsUnLock = self.zhenFaEquipManager:EquipIndexIsUnlock(equipIndex)
    if equipIndexIsUnLock then
        self:GetComp(grid.transform, "background/lock", "GameObject"):SetActive(false)
        self:GetComp(grid.transform, "background/open", "UILabel").text = ""
        self:BindTemplate(equipIndex, grid)
    else
        self:GetComp(grid.transform, "background/Sprite", "GameObject"):SetActive(false)
        self:GetComp(grid.transform, "background/lock", "GameObject"):SetActive(true)
        self:GetComp(grid.transform, "background/open", "UILabel").text = string.CSFormat("{0}阶开启", open)
    end
end

function UIMagicCircleRolePanel:BindTemplate(equipIndex, grid)
    ---@type UIRolePanel_GridTemplateZhenFa
    local template = self.mGridToTemplate[grid]
    if template == nil then
        template = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIRolePanel_GridTemplateZhenFa)
        self.mGridToTemplate[grid] = template
    end
    local info = self:GetEquipInfo(equipIndex)
    template:ShowEquip(info, equipIndex)
    CS.UIEventListener.Get(grid).LuaEventTable = template
    CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnItemClicked
end

---获取显示装备信息
---@return bagV2.BagItemInfo
function UIMagicCircleRolePanel:GetEquipInfo(equipIndex)
    return CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(equipIndex)
end

---@param template UIRolePanel_GridTemplateZhenFa
function UIMagicCircleRolePanel.OnItemClicked(template, go)
    UIMagicCircleRolePanel:ShowItemInfo(template)
end

---@param template UIRolePanel_GridTemplateZhenFa
function UIMagicCircleRolePanel:ShowItemInfo(template, isShowRight)
    if (isShowRight == nil) then
        isShowRight = true
    end
    if template.bagItemInfo then
        local curBagItemInfo = ternary(template.itemInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:IsMarryRing(template.itemInfo), CS.CSScene.MainPlayerInfo.MarryInfo:GetPlayerMarryInfo(), template.bagItemInfo)
        local curItemInfo = template.itemInfo
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = curBagItemInfo, itemInfo = curItemInfo, showRight = isShowRight, showAction = true, extraEquipIdTable = nil, showBind = true })
    else
        if template.canEquip and template.equipIndex and template.canEquip.lid then
            networkRequest.ReqPutOnTheEquip(template.equipIndex, template.canEquip.lid)
            CS.CSScene.MainPlayerInfo.BagInfo:RemoveNewItem(template.canEquip)
        end
    end
end

return UIMagicCircleRolePanel