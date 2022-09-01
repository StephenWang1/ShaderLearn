---@class UIRolePanel_GridTemplateBase:TemplateBase
local UIRolePanel_GridTemplateBase = {}

--region 组件
--region 基础组件
---@return CSDynamicCloneManager 克隆组件
function UIRolePanel_GridTemplateBase:CloneModule()
    if CS.StaticUtility.IsNull(self.mCloneModule) then
        self.mCloneModule = self:Get("", "CSDynamicCloneManager")
    end
    return self.mCloneModule
end
--endregion

--region 模块
---Icon模块
function UIRolePanel_GridTemplateBase:GetItemIcon_GameObject()
    if CS.StaticUtility.IsNull(self.mItemIcon_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mItemIcon_GameObject = self:CloneModule():GetComponent("icon", "GameObject", "icon", self.go)
        self.mItemIcon_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mItemIcon_GameObject
end

---choose模块
function UIRolePanel_GridTemplateBase:GetChoose_GameObject()
    if CS.StaticUtility.IsNull(self.mChoose_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mChoose_GameObject = self:CloneModule():GetComponent("choose", "GameObject", "choose", self.go)
        self.mChoose_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mChoose_GameObject
end

---add模块
function UIRolePanel_GridTemplateBase:GetAdd_GameObject()
    if CS.StaticUtility.IsNull(self.mAdd_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mAdd_GameObject = self:CloneModule():GetComponent("add", "GameObject", "add", self.go)
        self.mAdd_GameObject.transform.localPosition = CS.UnityEngine.Vector3(24, -24, 0)
    end
    return self.mAdd_GameObject
end

---effect模块
function UIRolePanel_GridTemplateBase:GetEffect_GameObject()
    if CS.StaticUtility.IsNull(self.mEffect_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mEffect_GameObject = self:CloneModule():GetComponent("effect", "GameObject", "effect", self.go)
        self.mEffect_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mEffect_GameObject
end

---eleadd模块
function UIRolePanel_GridTemplateBase:GetEleadd_GameObject()
    if CS.StaticUtility.IsNull(self.mEleadd_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mEleadd_GameObject = self:CloneModule():GetComponent("eleadd", "GameObject", "eleadd", self.go)
        self.mEleadd_GameObject.transform.localPosition = CS.UnityEngine.Vector3(22, -14, 0)
    end
    return self.mEleadd_GameObject
end

---yinji模块
function UIRolePanel_GridTemplateBase:GetYinJi_GameObject()
    if CS.StaticUtility.IsNull(self.mYinJi_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mYinJi_GameObject = self:CloneModule():GetComponent("yinji", "GameObject", "yinji", self.go)
        self.mYinJi_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mYinJi_GameObject
end

---魂装模块
function UIRolePanel_GridTemplateBase:GetSoulEquip_GameObject()
    if CS.StaticUtility.IsNull(self.mSoulEquip_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mSoulEquip_GameObject = self:CloneModule():GetComponent("soulEquip", "GameObject", "soulEquip", self.go);
        self.mSoulEquip_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mSoulEquip_GameObject;
end

---check模块
function UIRolePanel_GridTemplateBase:GetCheck_GameObject()
    if CS.StaticUtility.IsNull(self.mCheck_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mCheck_GameObject = self:CloneModule():GetComponent("check", "GameObject", "check", self.go)
        self.mCheck_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mCheck_GameObject
end

---Evolotion模块
function UIRolePanel_GridTemplateBase:GetEvolotion_GameObject()
    if CS.StaticUtility.IsNull(self.mEvolotion_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mEvolotion_GameObject = self:CloneModule():GetComponent("Evolotion", "GameObject", "Evolotion", self.go)
        self.mEvolotion_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mEvolotion_GameObject
end

---up模块
function UIRolePanel_GridTemplateBase:GetUp_GameObject()
    if CS.StaticUtility.IsNull(self.mUp_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mUp_GameObject = self:CloneModule():GetComponent("up", "GameObject", "up", self.go)
        self.mUp_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    return self.mUp_GameObject
end
--endregion

--region UI组件(获取时克隆加载)
---装备图片组件
function UIRolePanel_GridTemplateBase:GetIcon_UISprite()
    if CS.StaticUtility.IsNull(self.mIcon_UISprite) and CS.StaticUtility.IsNull(self:GetItemIcon_GameObject()) == false then
        self.mIcon_UISprite = self:GetCurComp(self:GetItemIcon_GameObject(), "", "UISprite")
    end
    return self.mIcon_UISprite
end

---装备图片组件
function UIRolePanel_GridTemplateBase:GetStrength_UILabel()
    if CS.StaticUtility.IsNull(self.mStrength_UILabel) and CS.StaticUtility.IsNull(self:GetItemIcon_GameObject()) == false then
        self.mStrength_UILabel = self:GetCurComp(self:GetItemIcon_GameObject(), "quality", "UILabel")
    end
    return self.mStrength_UILabel
end

---@return UISprite 星级图片
function UIRolePanel_GridTemplateBase:GetStrengthStar_UISprite()
    if CS.StaticUtility.IsNull(self.mStrengthStarSp) and CS.StaticUtility.IsNull(self:GetItemIcon_GameObject()) == false then
        self.mStrengthStarSp = self:GetCurComp(self:GetItemIcon_GameObject(), "star", "UISprite")
    end
    return self.mStrengthStarSp
end

---背景图装备类型icon
function UIRolePanel_GridTemplateBase:GetBackGroundEquipIcon_GameObject()
    if CS.StaticUtility.IsNull(self.mBackGroundEquipIcon_GameObject) then
        self.mBackGroundEquipIcon_GameObject = self:Get("background/Sprite", "GameObject")
    end
    return self.mBackGroundEquipIcon_GameObject
end

---元素图片
function UIRolePanel_GridTemplateBase:GetElementAdd_UISprite()
    if CS.StaticUtility.IsNull(self.mElementAdd_UISprite) and CS.StaticUtility.IsNull(self:GetEleadd_GameObject()) == false then
        self.mElementAdd_UISprite = self:GetCurComp(self:GetEleadd_GameObject(), "", "UISprite")
    end
    return self.mElementAdd_UISprite
end

---元素添加图片
function UIRolePanel_GridTemplateBase:GetElementAdd_GameObject()
    if CS.StaticUtility.IsNull(self.mElementAdd_GameObject) and CS.StaticUtility.IsNull(self:GetEleadd_GameObject()) == false then
        self.mElementAdd_GameObject = self:GetCurComp(self:GetEleadd_GameObject(), "add", "GameObject")
    end
    return self.mElementAdd_GameObject
end

---元素k
function UIRolePanel_GridTemplateBase:GetElementK_UISprite()
    if CS.StaticUtility.IsNull(self.mElementK_UISprite) and CS.StaticUtility.IsNull(self:GetEleadd_GameObject()) == false then
        self.mElementK_UISprite = self:GetCurComp(self:GetEleadd_GameObject(), "k", "UISprite")
    end
    return self.mElementK_UISprite
end

---印记1图片
function UIRolePanel_GridTemplateBase:GetYinJi1_UISprite()
    if CS.StaticUtility.IsNull(self.mYinJi1_UISprite) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJi1_UISprite = self:GetCurComp(self:GetYinJi_GameObject(), "yinji1", "UISprite")
    end
    return self.mYinJi1_UISprite
end

---印记icon
function UIRolePanel_GridTemplateBase:GetYinJiIcon_UISprite()
    if CS.StaticUtility.IsNull(self.mYinJiIcon_UISprite) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJiIcon_UISprite = self:GetCurComp(self:GetYinJi_GameObject(), "yinjiicon", "UISprite")
    end
    return self.mYinJiIcon_UISprite
end

---印记add
function UIRolePanel_GridTemplateBase:GetYinJiAdd_GameObject()
    if CS.StaticUtility.IsNull(self.mYinJiAdd_GameObject) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJiAdd_GameObject = self:GetCurComp(self:GetYinJi_GameObject(), "yinjiadd", "GameObject")
    end
    return self.mYinJiAdd_GameObject
end

---印记add
function UIRolePanel_GridTemplateBase:GetYinJiAdd_UISprite()
    if CS.StaticUtility.IsNull(self.mYinJiAdd_UISprite) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJiAdd_UISprite = self:GetCurComp(self:GetYinJi_GameObject(), "yinjiadd", "UISprite")
    end
    return self.mYinJiAdd_UISprite
end

---印记提升
function UIRolePanel_GridTemplateBase:GetYinJiTiSheng_GameObject()
    if CS.StaticUtility.IsNull(self.mYinJiTiSheng_GameObject) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJiTiSheng_GameObject = self:GetCurComp(self:GetYinJi_GameObject(), "yinjitisheng", "GameObject")
    end
    return self.mYinJiTiSheng_GameObject
end

---印记k
function UIRolePanel_GridTemplateBase:GetYinJiK_UISprite()
    if CS.StaticUtility.IsNull(self.mYinJiK_UISprite) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJiK_UISprite = self:GetCurComp(self:GetYinJi_GameObject(), "yinjiicon/k", "UISprite")
    end
    return self.mYinJiK_UISprite
end

---印记冲突
function UIRolePanel_GridTemplateBase:GetYinJiChongTu_GameObject()
    if CS.StaticUtility.IsNull(self.mYinJiChongTu_GameObject) and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self.mYinJiChongTu_GameObject = self:GetCurComp(self:GetYinJi_GameObject(), "yinjichongtu", "GameObject")
    end
    return self.mYinJiChongTu_GameObject
end

function UIRolePanel_GridTemplateBase:GetSoulEquipIcon_UISprite()
    if CS.StaticUtility.IsNull(self.mSoulEquipIcon_UISprite) and CS.StaticUtility.IsNull(self:GetSoulEquip_GameObject()) == false then
        self.mSoulEquipIcon_UISprite = self:GetCurComp(self:GetSoulEquip_GameObject(), "icon", "UISprite")
    end
    return self.mSoulEquipIcon_UISprite;
end

function UIRolePanel_GridTemplateBase:GetSoulEquipIcon_Grid()
    if CS.StaticUtility.IsNull(self.mSoulEquipIcon_Grid) and CS.StaticUtility.IsNull(self:GetSoulEquip_GameObject()) == false then
        self.mSoulEquipIcon_Grid = self:GetCurComp(self:GetSoulEquip_GameObject(), "Grid", "UIGridContainer")
    end
    return self.mSoulEquipIcon_Grid;
end

function UIRolePanel_GridTemplateBase:GetSoulEquipQuality_UISprite()
    if CS.StaticUtility.IsNull(self.SoulEquipQuality_UISprite) and CS.StaticUtility.IsNull(self:GetSoulEquip_GameObject()) == false then
        self.SoulEquipQuality_UISprite = self:GetCurComp(self:GetSoulEquip_GameObject(), "soulEquipQuality", "UISprite")
    end
    return self.SoulEquipQuality_UISprite;
end

function UIRolePanel_GridTemplateBase:GetSoulEquipEffect_CSUIEffectLoad()
    if CS.StaticUtility.IsNull(self.SoulEquipEffect_CSUIEffectLoad) and CS.StaticUtility.IsNull(self:GetSoulEquip_GameObject()) == false then
        self.SoulEquipEffect_CSUIEffectLoad = self:GetCurComp(self:GetSoulEquip_GameObject(), "soulEffect", "CSUIEffectLoad")
    end
    return self.SoulEquipEffect_CSUIEffectLoad;
end

---额外装备1
function UIRolePanel_GridTemplateBase:GetOverlayIcon1_UISprite()
    if CS.StaticUtility.IsNull(self.mOverlayIcon1_UISprite) and CS.StaticUtility.IsNull(self:GetItemIcon_GameObject()) == false then
        self.mOverlayIcon1_UISprite = self:GetCurComp(self:GetItemIcon_GameObject(), "overLayicon", "UISprite")
    end
    return self.mOverlayIcon1_UISprite
end

---额外装备2
function UIRolePanel_GridTemplateBase:GetOverlayIcon2_UISprite()
    if CS.StaticUtility.IsNull(self.mOverlayIcon2_UISprite) and CS.StaticUtility.IsNull(self:GetItemIcon_GameObject()) == false then
        self.mOverlayIcon2_UISprite = self:GetCurComp(self:GetItemIcon_GameObject(), "overLayicon2", "UISprite")
    end
    return self.mOverlayIcon2_UISprite
end

---@return UnityEngine.GameObject 魂装模块
function UIRolePanel_GridTemplateBase:GetLastingMask_Go()
    if CS.StaticUtility.IsNull(self.mSoulEquip_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.LastingMask = self:CloneModule():GetComponent("mask", "GameObject", "mask", self.go);
        if (self.LastingMask ~= nil) then
            self.LastingMask.transform.localPosition = CS.UnityEngine.Vector3.zero
        end
    end
    return self.LastingMask;
end

---投保标识
function UIRolePanel_GridTemplateBase:GetInsure_GameObject()
    if CS.StaticUtility.IsNull(self.mInsureIcon_GameObject) and CS.StaticUtility.IsNull(self:CloneModule()) == false and self:CloneModule().targetTemplate ~= nil then
        self.mInsureIcon_GameObject = self:CloneModule():GetComponent("Insure", "GameObject", "insure", self.go)
        if (self.mInsureIcon_GameObject ~= nil) then
            self.mInsureIcon_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
        end
    end
    return self.mInsureIcon_GameObject
end

--endregion
--endregion
---@type bagV2.BagItemInfo
UIRolePanel_GridTemplateBase.bagItemInfo = nil
function UIRolePanel_GridTemplateBase:Init()
    --self:InitComponent()
    self.limitingValue = tonumber(CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax())
    self.bagItemInfo = nil
    ---装备位Index
    self.equipIndex = nil
    ---背包装可装备物品信息 bagV2.BagItemInfo
    self.canEquip = nil

    ---镶嵌(额外)装备字典
    self.mExtraEquipDic = nil;

    ---镶嵌ICON UISprite 列表
    self.mExtraEquipIconList = {};
    if (self:GetOverlayIcon1_UISprite() ~= nil) then
        table.insert(self.mExtraEquipIconList, self:GetOverlayIcon1_UISprite());
    end
    if (self:GetOverlayIcon2_UISprite() ~= nil) then
        table.insert(self.mExtraEquipIconList, self:GetOverlayIcon2_UISprite());
    end
end

---新加组件可以在这里添加
function UIRolePanel_GridTemplateBase:InitComponent()
    self.go_UIRolePanelComponent = self:Get("", "UIRolePanelCompoent")
    if self.go_UIRolePanelComponent ~= nil then
        ---物品ICON
        self.mItemIcon_UISprite = self.go_UIRolePanelComponent.ItemIcon
        ---添加按钮
        self.mAddIcon_GameObject = self.go_UIRolePanelComponent.AddIcon
        ---强化等级
        self.mStrength_UILabel = self.go_UIRolePanelComponent.Strength_UILabel
        ---背景花纹图片
        self.mIconBg_GameObject = self.go_UIRolePanelComponent.IconBg_GameObject
        ---设置耐久显示图片
        --self.mLastingFrame_UISprite = self:Get("icon/frame", "UISprite")
        ---特效节点
        self.mEffect_GameObject = self.go_UIRolePanelComponent.Effect_GameObject
        ---选中
        self.mChoose_GameObject = self.go_UIRolePanelComponent.Choose_GameObject
        ---元素
        self.mElementIcon_UISprite = self.go_UIRolePanelComponent.ElementIcon_UISprite
        ---元素Add
        self.mElementAdd_GameObject = self.go_UIRolePanelComponent.ElementAdd_GameObject
        ---元素背景图
        self.mElementBg_UISprite = self.go_UIRolePanelComponent.ElementBg_UISprite
        --region印记
        self.mSignet_GameObject = self.go_UIRolePanelComponent.Signet_GameObject
        ------印记Icon
        self.mSignetIcon_UISprite = self.go_UIRolePanelComponent.SignetIcon_UISprite
        ---印记镶嵌ICon
        self.mSignetInlayIcon_UISprite = self.go_UIRolePanelComponent.SignetInlayIcon_UISprite
        ---印记添加图标
        self.mSignetAdd_GameObject = self.go_UIRolePanelComponent.SignetAdd_GameObject
        ---印记添加图标
        self.mSignetAdd_UISprite = self.go_UIRolePanelComponent.SignetAdd_UISprite
        ---印记已添加图标底图
        self.mGetSignetInlayIconBg_UISprite = self.go_UIRolePanelComponent.GetSignetInlayIconBg_UISprite
        ---印记冲突图标
        self.mGetSignetConflict = self.go_UIRolePanelComponent.GetSignetConflict
        ---印记提升图标
        self.mGetSignetTisheng = self.go_UIRolePanelComponent.SignetTisheng_GameObject
        ---防守之源（三层镶嵌）
        self.mOverLayIcon2_UISprite = self.go_UIRolePanelComponent.OverLayIcon2_UISprite
        ---二层镶嵌图片
        self.mOverLayIcon1_UISprite = self.go_UIRolePanelComponent.OverLayIcon1_UISprite
        --endregion
        ---维修选中
        self.check_GameObject = self.go_UIRolePanelComponent.check_GameObject
        ---可进化标记
        self.mEvolution_GameObject = self.go_UIRolePanelComponent.CanEvoliutionObj
        ---绿色箭头
        self.mGreedArrow = self.go_UIRolePanelComponent.Up_GameObject
    end
end
--region 组件

--region 红点

---@return Top_UIRedPoint
function UIRolePanel_GridTemplateBase:RedPoint()
    if self.red == nil then
        self.red = self:Get('background/Red', 'Top_UIRedPoint')
    end
    return self.red
end

function UIRolePanel_GridTemplateBase:BindRedPoint(bagItemInfo)

end

function UIRolePanel_GridTemplateBase:RemoveRedPoint()

end

function UIRolePanel_GridTemplateBase:CallRedPoint(bagItemInfo)

end

--endregion

---显示装备物品
function UIRolePanel_GridTemplateBase:ShowEquip(bagItemInfo, equipIndex)
    self:RemoveRedPoint(bagItemInfo)
    if equipIndex then
        self.equipIndex = equipIndex
    end
    if bagItemInfo then
        --if(self.go.name == "ringL") then
        --    print("刷新物品:"..bagItemInfo.ItemFullName.."----"..self.go.name);
        --end
        self:BindRedPoint(bagItemInfo)
        self:RefreshGrid(bagItemInfo)
    else
        --if(self.go.name == "ringL") then
        --    print("spriteName reset".."----"..self.go.name);
        --end
        self:ResetGrid()
    end
    self:UpdateSoulEquipSign();
end

---角色默认的刷新方法
function UIRolePanel_GridTemplateBase:RefreshGrid(bagItemInfo)
    if bagItemInfo then

        self.bagItemInfo = bagItemInfo
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
        if res then
            self.itemInfo = itemInfo
            self:RefreshIconInfo()
            self:RefreshAddIcon(0)
            self:RefreshBackgroundInfo()
            self:RefreshLastingFrame(0)
            self:RefreshMarryRing()
            self:PlayShakeTween()
        end
    end
    self:RefreshStrengthenInfo()
    --self:SetOtherIcon()
    self:SetAddIConInfo()
    self:SetInsureIConInfo()
    self:OverrideRefreshGrid()
end

---重写使用增加刷新放法
function UIRolePanel_GridTemplateBase:OverrideRefreshGrid()
end

---刷新Icon显示
function UIRolePanel_GridTemplateBase:RefreshIconInfo()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        self:GetIcon_UISprite().gameObject:SetActive(self.itemInfo ~= nil)
        self:GetIcon_UISprite().spriteName = self.itemInfo.icon
    end
end

---刷新背景显示
function UIRolePanel_GridTemplateBase:RefreshBackgroundInfo()
    if CS.StaticUtility.IsNull(self:GetBackGroundEquipIcon_GameObject()) == false then
        --self:GetBackGroundEquipIcon_GameObject():SetActive(not CS.CSScene.MainPlayerInfo.EquipInfo:HasEquipInIndex(self.equipIndex) and not (self.mExtraEquipDic ~= nil and #self.mExtraEquipDic > 0))
        self:GetBackGroundEquipIcon_GameObject():SetActive(not CS.CSScene.MainPlayerInfo.EquipInfo:HasEquipInIndex(self.equipIndex));
    end
end

---刷新强化等级
function UIRolePanel_GridTemplateBase:RefreshStrengthenInfo()
    if CS.StaticUtility.IsNull(self:GetStrength_UILabel()) == false then
        local showInfo = ""
        local star = ""
        if self.bagItemInfo and self.bagItemInfo.intensify ~= nil and self.bagItemInfo.intensify > 0 then
            showInfo, star = Utility.GetIntensifyShow(self.bagItemInfo.intensify)
        end
        self:GetStrength_UILabel().text = showInfo
        self:GetStrengthStar_UISprite().spriteName = star
        local hasData = self.bagItemInfo and self.bagItemInfo.intensify ~= nil and self.bagItemInfo.intensify > 0
        self:GetStrength_UILabel().gameObject:SetActive(hasData)
        self:GetStrengthStar_UISprite().gameObject:SetActive(hasData)
    end
end

---重置格子状态
function UIRolePanel_GridTemplateBase:ResetGrid()
    if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
        self:GetIcon_UISprite().spriteName = "";
        self:GetIcon_UISprite().gameObject:SetActive(true);
    end
    self:RefreshAddIcon(1)
    self:RefreshBackgroundInfo()
    self:RefreshLastingFrame(1)
    --self:SetOtherIcon()
    self:SetAddIConInfo()
    self:RefreshStrengthenInfo()
    self.bagItemInfo = nil;
end

---刷新加号状态
---@param state XLua.Cast.Int32 状态 0 显示道具 1 不显示道具
function UIRolePanel_GridTemplateBase:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        if state == 0 then
            self:GetAdd_GameObject():SetActive(false)
        else
            if (self.equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SEAL)) then
                local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
                ---@type LuaEquipDataItem
                local EquipDataItem = LuaPlayerEquipmentListData:GetEquipItemByBasicIndex(LuaEquipmentItemType.POS_SEAL)
                if (EquipDataItem == nil or EquipDataItem.ItemTbl == nil) then
                    self.hasEquip = false
                else
                    self.hasEquip = true
                end
                self.canEquip = self:GetBagCanEquipSealInfo()

            else
                self.hasEquip = CS.CSScene.MainPlayerInfo.EquipInfo:HasEquipInIndex(self.equipIndex)
                self.canEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetBagCanEquipInfo(self.equipIndex)
            end

            if not self.hasEquip then
                self.bagItemInfo = nil
            end
            self:GetAdd_GameObject():SetActive(ternary(self.hasEquip == false and self.canEquip ~= nil, true, false))
        end
    end
end

---获取背包内有无可穿戴的官印
---@return boolean
function UIRolePanel_GridTemplateBase:GetBagCanEquipSealInfo()
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local bagInfo = mainPlayerInfo.BagInfo:GetBagItemList()
        for i = 0, bagInfo.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = bagInfo[i]
            local itemInfo = bagItemInfo.ItemTABLE
            ---找到官印装备
            if itemInfo ~= nil and itemInfo.type == luaEnumItemType.Equip and itemInfo.subType == LuaEnumEquipSubType.Equip_seal then
                local info = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
                if (info ~= nil) then
                    ---如果找到的这个官印可以穿戴，则return true
                    local isOpen = uimanager:IsOpenWithKey(info:GetConditions().list[1]);
                    if (isOpen) then
                        return bagInfo[i]
                    end
                end
            end
        end
    end
    return nil
end

---刷新耐久度图片  (暂改为改变icon本身颜色  - by yh)
function UIRolePanel_GridTemplateBase:RefreshLastingFrame(state)
    if self.mLastingFrame_UISprite then
        self.mLastingFrame_UISprite.spriteName = ""
    end
    local isRed = false
    if state == 0 then

        if self.limitingValue then
            if self.bagItemInfo.currentLasting >= -10 and self.bagItemInfo.currentLasting <= self.limitingValue then
                isRed = true
            end
        end
    end
    --序列帧的图片icon没法变红，先用图片盖上
    --  local color = isRed and CS.UnityEngine.Color(232 / 255, 80 / 255, 56 / 255, 1) or CS.UnityEngine.Color.white
    -- self:GetIcon_UISprite().color = color
    if CS.StaticUtility.IsNull(self:GetLastingMask_Go()) == false then
        self:GetLastingMask_Go():SetActive(isRed)
    end
end

---隐藏其他界面调用Icon
function UIRolePanel_GridTemplateBase:SetOtherIcon()
    --元素
    if self:GetElementAdd_UISprite() ~= nil and CS.StaticUtility.IsNull(self:GetElementAdd_UISprite()) == false then
        self:GetElementAdd_UISprite().gameObject:SetActive(false)
    end
    --特效
    if self:GetEffect_GameObject() and CS.StaticUtility.IsNull(self:GetEffect_GameObject()) then
        self:GetEffect_GameObject():SetActive(false)
    end
    self:HideChoose()
    --印记
    if self:GetYinJi_GameObject() and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
        self:GetYinJi_GameObject():SetActive(false)
    end
    if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite()) == false then
        self:GetOverlayIcon2_UISprite().spriteName = ""
    end
    --维修
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(false)
    end
end

---重写设置选中特效
function UIRolePanel_GridTemplateBase:HideChoose()
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(false)
    end
end

---添加额外装备到字典
function UIRolePanel_GridTemplateBase:AddExtraEquips(itemIds)
    self.mExtraEquipDic = itemIds;
end

---设置镶嵌信息(额外装备)
function UIRolePanel_GridTemplateBase:SetAddIConInfo()
    if (self.mExtraEquipDic ~= nil) then
        for k, v in pairs(self.mExtraEquipIconList) do
            if v ~= nil and CS.StaticUtility.IsNull(v) == false then
                v.gameObject:SetActive(false);
            end
        end

        for k, v in pairs(self.mExtraEquipDic) do
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
            local spriteSize = CS.UnityEngine.Vector2.one * 46
            local localPosition = CS.UnityEngine.Vector3.zero
            local uiSprite = self.mExtraEquipIconList[1]
            if (isFind) then
                if (itemTable.type == luaEnumItemType.Equip and itemTable.subType == LuaEnumEquiptype.LightComponent) then
                elseif (itemTable.type == luaEnumItemType.Equip and itemTable.subType == LuaEnumEquiptype.SoulJade) then
                elseif (itemTable.type == luaEnumItemType.Equip and itemTable.subType == LuaEnumEquiptype.Gem) then
                    spriteSize = CS.UnityEngine.Vector2.one * 35
                elseif (itemTable.type == luaEnumItemType.Equip and itemTable.subType == LuaEnumEquiptype.Jingongzhiyuan) then
                    spriteSize = CS.UnityEngine.Vector2.one * 19
                    localPosition = CS.UnityEngine.Vector3(1, 12, 0)
                elseif (itemTable.type == luaEnumItemType.Equip and itemTable.subType == LuaEnumEquiptype.Shouhuzhiyuan) then
                    uiSprite = self.mExtraEquipIconList[2]
                    spriteSize = CS.UnityEngine.Vector2.one * 19
                    localPosition = CS.UnityEngine.Vector3(1, -12, 0)
                end
            end
            if CS.StaticUtility.IsNull(uiSprite) == false then
                self:SetAddIcon(v, uiSprite);
                uiSprite.transform.localPosition = localPosition
                uiSprite:SetDimensions(spriteSize.x, spriteSize.y)
            end
        end
    end
end

---设置镶嵌图片(额外装备)
function UIRolePanel_GridTemplateBase:SetAddIcon(addItemId, sprite)
    if addItemId and sprite and CS.StaticUtility.IsNull(sprite) == false then
        sprite.gameObject:SetActive(true)
        local res, InLayItem = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(addItemId)
        if res then
            sprite.spriteName = InLayItem.icon
        end
    end
end

---隐藏镶嵌图片
function UIRolePanel_GridTemplateBase:HidAddIcon()
    if self:GetOverlayIcon2_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon2_UISprite()) == false then
        self:GetOverlayIcon2_UISprite().gameObject:SetActive(false)
    end
    if self:GetOverlayIcon1_UISprite() and CS.StaticUtility.IsNull(self:GetOverlayIcon1_UISprite()) == false then
        self:GetOverlayIcon1_UISprite().gameObject:SetActive(false)
    end
end

---设置投标标识
function UIRolePanel_GridTemplateBase:SetInsureIConInfo()
    luaclass.UIRefresh:RefreshActive(self:GetInsure_GameObject(), self:IsInsurance(self.bagItemInfo))
end

---是否已投保
function UIRolePanel_GridTemplateBase:IsInsurance(bagItemInfo)
    return gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
end

--region 外部调用
---设置选中框（选中框不同时可以重写此方法）
function UIRolePanel_GridTemplateBase:SetItemChoose(isChoose)
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isChoose)
        self.mCurrentChooseState = isChoose
    end
end

---@return boolean 当前选中状态
function UIRolePanel_GridTemplateBase:GetItemChooseState()
    if self.mCurrentChooseState ~= nil then
        return self.mCurrentChooseState
    end
    return false
end

--endregion

--region 虎符
function UIRolePanel_GridTemplateBase:RefreshGridByHuFu(HuFuId, isActive)
    self:ResetGrid()
    local luaHuFuInfo = clientTableManager.cfg_official_emperor_tokenManager:TryGetValue(HuFuId)
    if luaHuFuInfo then
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(luaHuFuInfo:GetLinkItemId())
        if res then
            self.itemInfo = itemInfo
            self:RefreshIconInfo()
            self:RefreshBackgroundInfo()
            self:PlayShakeTween()
            if CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
                self:GetIcon_UISprite().color = isActive and CS.UnityEngine.Color.white or CS.UnityEngine.Color(232 / 255, 80 / 255, 56 / 255, 1)
            end
        end
    end
end
--endregion

--region 婚戒处理
---刷新结婚戒指格子
function UIRolePanel_GridTemplateBase:RefreshMarryRing()
    self:RefreshMarryGrid()
end
---设置婚戒格子显示（当玩家以结婚的情况下，才会显示婚戒装备位）
function UIRolePanel_GridTemplateBase:RefreshMarryGrid()
    local state = false
    if self.equipIndex ~= nil and self.equipIndex == LuaEnumEquiptype.WeddingRing then
        state = true
        self:GetIcon_UISprite():SetDimensions(50, 50)
        self.go:SetActive(state)
    end
end
--endregion

--region 装备抖动
---播放抖动动画
function UIRolePanel_GridTemplateBase:PlayShakeTween()
    --if self.equipIndex == 1 then
    --    print("播放抖动动画1")
    --end
    if self.mItemIcon_Top_TwweenShake == nil or CS.StaticUtility.IsNull(self.mItemIcon_Top_TwweenShake) == true then
        if self:GetIcon_UISprite() ~= nil then
            self.mItemIcon_Top_TwweenShake = self:GetCurComp(self:GetIcon_UISprite(), "", "Top_TweenShake")
        end
    end
    if self.mItemIcon_Top_TwweenShake ~= nil and CS.CSScene.MainPlayerInfo.BagInfo:CheckIsDomountEquipAndRemoveCache(LuaEnumBagChangeAction.PUTON, self.bagItemInfo) then
        --if self.equipIndex == 1 then
        --    print("播放抖动动画2")
        --end
        self.mItemIcon_Top_TwweenShake:PlayShake()
    end
end
--endregion

function UIRolePanel_GridTemplateBase:UpdateSoulEquipSign()
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquip_GameObject(), true)
    local baseMapSpriteName, effectName, inlayEffectTbl = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetEquipIndexEffectNameAndBaseMap(self.equipIndex)
    local effectTblParamsType, AnyParams
    if inlayEffectTbl ~= nil then
        effectTblParamsType, AnyParams = clientTableManager.cfg_inlay_effectManager:GetInlayEffectParticleParams(inlayEffectTbl:GetId())
    end
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquipQuality_UISprite(), CS.StaticUtility.IsNullOrEmpty(baseMapSpriteName) == false)
    luaclass.UIRefresh:RefreshSprite(self:GetSoulEquipQuality_UISprite(), baseMapSpriteName)
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquipEffect_CSUIEffectLoad(), CS.StaticUtility.IsNullOrEmpty(effectName) == false)
    if self.soulEquipEffect == nil then
        luaclass.UIRefresh:RefreshEffect(self:GetSoulEquipEffect_CSUIEffectLoad(), effectName, function(effectObj)
            if CS.StaticUtility.IsNull(effectObj) == false and effectTblParamsType == LuaEnumInlayEffectTblParamsType.EffectColor and AnyParams ~= nil then
                self.soulEquipEffect = effectObj
                effectObj:SetActive(false)
                Utility.SetParticleColor(effectObj, AnyParams)
                CS.CSListUpdateMgr.Add(100, nil, function()
                    effectObj:SetActive(true)
                end, false)
            end
        end)
    end
end

return UIRolePanel_GridTemplateBase