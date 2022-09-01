---@class UIRolePanel_SLEquipGridTemp:UIRolePanel_GridTemplateBase 人物面板神力的装备格子模板
local UIRolePanel_SLEquipGridTemp = {}
setmetatable(UIRolePanel_SLEquipGridTemp, luaComponentTemplates.UIRolePanel_GridTemplateBase)

---@type LuaPlayerEquipmentListData 指定类型的装备清单
UIRolePanel_SLEquipGridTemp.EquipmentList = nil


function UIRolePanel_SLEquipGridTemp:GetCSUIEffect()
    if(self.mGetCSUIEffect == nil) then
        self.mGetCSUIEffect = self:Get("icon/bgEffect", "CSUIEffectLoad")
    end
    return self.mGetCSUIEffect
end

function UIRolePanel_SLEquipGridTemp:Init()
    self:RunBaseFunction("Init")
    self:BindEvents()
end

function UIRolePanel_SLEquipGridTemp:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self.PlayerBagMgr then
            if self.bagItemInfo then
                if self.bagItemInfo.Lua_DivineSuitTABLE.type == 6 then
                    local isOpen = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsSLequipLevelOpen()
                    if isOpen == true then
                        luaEventManager.DoCallback(LuaCEvent.BingJianChoose, self.bagItemInfo)
                        return
                    end
                end
                uiStaticParameter.UIItemInfoManager:CreatePanel({
                    bagItemInfo = self.bagItemInfo,
                    showRight = true,
                })
            else
                if (self.canEquip ~= nil) then
                    networkRequest.ReqPutOnTheEquip(self.equipIndex, self.canEquip.lid)
                end
            end
        else
            if self.bagItemInfo then
                uiStaticParameter.UIItemInfoManager:CreatePanel({
                    bagItemInfo = self.bagItemInfo, showRight = true,
                    showTabBtns = true,
                    itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL,
                    roleId = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo.roleId,
                    showAssistPanel = true })
            end
        end
    end
end

function UIRolePanel_SLEquipGridTemp:InitData()
    local type = Utility.IsSLEquip(self.equipIndex, true)
    self.EquipmentList = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(type)
end

---设置背包数据,  为了在查看其他玩家面板的时候通用,主角打开的时候 传入正常的主角背包,其他玩家的时候,传入nil就好了
---@param data LuaMainPlayerBagMgr
function UIRolePanel_SLEquipGridTemp:SetBagMgrData(data)
    --self.PlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    ---@type LuaMainPlayerBagMgr
    self.PlayerBagMgr = data
end

function UIRolePanel_SLEquipGridTemp:BindRedPoint()

end

---移除红点
function UIRolePanel_SLEquipGridTemp:RemoveRedPoint()
end

function UIRolePanel_SLEquipGridTemp:CallRedPoint()
end

---刷新加号状态
---@param state XLua.Cast.Int32 状态 0 显示道具 1 不显示道具
function UIRolePanel_SLEquipGridTemp:RefreshAddIcon(state)
    if (self.EquipmentList == nil or Utility.IsSLEquip(self.equipIndex, true) ~= self.EquipmentList.EquipmentListType) then
        self:InitData();
    end
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        if state == 0 then
            --self.go:SetActive(true)
            self:GetAdd_GameObject():SetActive(false)
            --self:ShowHideGridEffect(true)
        else
            --self:ShowHideGridEffect(false)
            if (self.PlayerBagMgr == nil) then
                --没有任何数据
                --self.go:SetActive(false)
            else
                ---@type LuaEquipDataItem
                local LuaEquipDataItem = self.EquipmentList:GetEquipItem(self.equipIndex)
                self.hasEquip = LuaEquipDataItem ~= nil and LuaEquipDataItem.BagItemInfo ~= nil
                self.canEquip = self.PlayerBagMgr:GetCanEquipItem(self.equipIndex, self.EquipmentList.EquipmentListType)
                if not self.hasEquip then
                    self.bagItemInfo = nil
                end
                local exitAdd = ternary(self.hasEquip == false and self.canEquip ~= nil, true, false)
                self:GetAdd_GameObject():SetActive(exitAdd)
                --print(tostring(self.equipIndex).."    "..tostring(self.EquipmentList.EquipmentListType))
                local isExitSlEquip = self.PlayerBagMgr:IsExitSLEquip(self.equipIndex, self.EquipmentList.EquipmentListType)
                --self.go:SetActive(self.hasEquip or isExitSlEquip)
            end
        end
    end
end

UIRolePanel_SLEquipGridTemp.LastEffectKey = nil

function UIRolePanel_SLEquipGridTemp:ShowHideGridEffect(show)
    if(self:GetCSUIEffect() == nil) then
        return
    end

    ---@type TABLE.cfg_divinesuit
    local divinesuit = Utility.GetDivineSuitTblByBagItemInfo(self.bagItemInfo)
    if(show == true and self.bagItemInfo ~= nil and divinesuit ~= nil) then

        local textureName = Utility.GetSLEquipIndexEffectID(divinesuit:GetType(), Utility.GetSLEquipBasicIndex(self.equipIndex))
        --local textureName = "23042001"
        local key = tostring(divinesuit:GetType()).."_"..tostring(Utility.GetSLEquipBasicIndex(self.equipIndex)).."_"..tostring(divinesuit:GetLevel()).."_"..tostring(textureName)
        if(key == self.LastEffectKey) then
            return
        end
        self.LastEffectKey = key
        self:GetCSUIEffect():DestroyEffect()
        self:GetCSUIEffect().effectId = "700278"
        self:GetCSUIEffect():LoadEffect(function (obj)
            obj:SetActive(false)
            Utility.LoadSLMaterial(obj, divinesuit:GetType(), Utility.GetSLEquipBasicIndex(self.equipIndex), divinesuit:GetLevel(), textureName)
        end)
    else
        self.LastEffectKey = nil
        self:GetCSUIEffect():DestroyEffect()
    end
end


return UIRolePanel_SLEquipGridTemp