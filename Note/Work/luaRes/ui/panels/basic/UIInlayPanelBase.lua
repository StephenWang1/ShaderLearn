---@class UIInlayPanelBase:UIBase 镶嵌类型面板通用
local UIInlayPanelBase = {}

---@type table<UnityEngine.GameObject, UIItem>
UIInlayPanelBase.mUIItemDic = nil;

---@type bagV2.BagItemInfo
UIInlayPanelBase.mSelectEquip = nil;

---@type bagV2.BagItemInfo
UIInlayPanelBase.mSelectSoulEquip = nil;

---@type LuaEnumSoulEquipType 当前界面类型
UIInlayPanelBase.mSuitBelong = nil

---@type number 当前选中镶嵌孔位
UIInlayPanelBase.subIndex = nil

---@return LuaSoulEquipMgr
function UIInlayPanelBase:GetDataManager()
    return gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr()
end

--region 组件
---@return UnityEngine.GameObject
function UIInlayPanelBase:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetItemTemplate_GameObject()
    if (self.mItemTemplate_GameObject == nil) then
        self.mItemTemplate_GameObject = self:GetCurComp("WidgetRoot/view/itemTemplate", "GameObject");
    end
    return self.mItemTemplate_GameObject;
end

-----@return UnityEngine.GameObject
--function UIInlayPanelBase:GetBtnRemove_GameObject()
--    if (self.mBtnRemove_GameObject == nil) then
--        self.mBtnRemove_GameObject = self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquipIcon/remove", "GameObject");
--    end
--    return self.mBtnRemove_GameObject;
--end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetBtnSet_GameObject()
    if (self.mBtnSet_GameObject == nil) then
        self.mBtnSet_GameObject = self:GetCurComp("WidgetRoot/view/btn_use", "GameObject")
    end
    return self.mBtnSet_GameObject
end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetBtnSuit_GameObject()
    if (self.mBtnSuit_GameObject == nil) then
        self.mBtnSuit_GameObject = self:GetCurComp("WidgetRoot/events/btn_suit", "GameObject");
    end
    return self.mBtnSuit_GameObject;
end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetNoEquipment_GameObject()
    if (self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:GetCurComp("WidgetRoot/view/NoEquipment", "GameObject");
    end
    return self.mChoose_GameObject;
end

---@return UILabel
function UIInlayPanelBase:GetSoulEquipName_Text()
    if (self.mSoulEquipName_Text == nil) then
        self.mSoulEquipName_Text = self:GetCurComp("WidgetRoot/view/itemTemplate/name", "UILabel")
    end
    return self.mSoulEquipName_Text;
end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetStoneList_GameObject()
    if (self.mStoneList_GameObject == nil) then
        self.mStoneList_GameObject = self:GetCurComp("WidgetRoot/view/stoneList", "GameObject")
    end
    return self.mStoneList_GameObject;
end

---@return UnityEngine.GameObject
function UIInlayPanelBase:GetNoSoulEquip_GameObject()
    if (self.mNoSoulEquip_GameObject == nil) then
        self.mNoEquipment_GameObject = self:GetCurComp("WidgetRoot/view/stoneList/NoElementtips", "GameObject")
    end
    return self.mNoEquipment_GameObject;
end

---@return UISprite
function UIInlayPanelBase:GetSoulEquipQuality_UISprite()
    if (self.mSoulEquipQuality_UISprite == nil) then
        self.mSoulEquipQuality_UISprite = self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquipQuality", "UISprite");
    end
    return self.mSoulEquipQuality_UISprite;
end

---@return UISprite
function UIInlayPanelBase:GetItemIcon_UISprite()
    if (self.mItemIcon_UISprite == nil) then
        self.mItemIcon_UISprite = self:GetCurComp("WidgetRoot/view/itemTemplate/icon", "UISprite");
    end
    return self.mItemIcon_UISprite;
end

-----@return UISprite
--function UIInlayPanelBase:GetSoulEquipIcon_UISprite()
--    if (self.mSoulEquipIcon_UISprite == nil) then
--        self.mSoulEquipIcon_UISprite = self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquipIcon", "UISprite");
--    end
--    return self.mSoulEquipIcon_UISprite;
--end

---@return UISoulEquipInlayHole
function UIInlayPanelBase:GetSoulEquipHole_centre()
    if (self.mSoulEquipHole_centre == nil) then
        self.mSoulEquipHole_centre = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquip1", "GameObject"), luaComponentTemplates.UISoulEquipInlayHole)
    end
    return self.mSoulEquipHole_centre;
end

---@return UISoulEquipInlayHole
function UIInlayPanelBase:GetSoulEquipHole_left()
    if (self.mSoulEquipHole_left == nil) then
        self.mSoulEquipHole_left = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquip3", "GameObject"), luaComponentTemplates.UISoulEquipInlayHole)
    end
    return self.mSoulEquipHole_left;
end

---@return UISoulEquipInlayHole
function UIInlayPanelBase:GetSoulEquipHole_right()
    if (self.mSoulEquipHole_right == nil) then
        self.mSoulEquipHole_right = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/itemTemplate/soulEquip2", "GameObject"), luaComponentTemplates.UISoulEquipInlayHole)
    end
    return self.mSoulEquipHole_right;
end

---@return UILabel
function UIInlayPanelBase:GetSoulEquipDes_Text()
    if (self.mSoulEquipDes_Text == nil) then
        self.mSoulEquipDes_Text = self:GetCurComp("WidgetRoot/view/SoulDes/soulEquipDes", "UILabel");
    end
    return self.mSoulEquipDes_Text;
end

---@return UIGridContainer
function UIInlayPanelBase:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/stoneList/stoneList/activityBtns", "UIGridContainer");
    end
    return self.mGridContainer;
end

---@return UILabel 选中魂装名字
function UIInlayPanelBase:GetSoulName_Lb()
    if (self.mSoulName == nil) then
        self.mSoulName = self:GetCurComp("WidgetRoot/view/soulName", "UILabel");
    end
    return self.mSoulName;

end

---@return UnityEngine.GameObject 成功特效
function UIInlayPanelBase:GetSuccessEffect()
    if self.mSuccessEffect == nil then
        self.mSuccessEffect = self:GetCurComp("WidgetRoot/view/itemTemplate/successEffect", "GameObject")
    end
    return self.mSuccessEffect
end

---@return UnityEngine.GameObject 使用条件
function UIInlayPanelBase:UseCondition_GameObject()
    if self.mUseCondition_GameObject == nil then
        self.mUseCondition_GameObject = self:GetCurComp("WidgetRoot/view/needlevel", "GameObject")
    end
    return self.mUseCondition_GameObject
end
--endregion

--region 初始化
function UIInlayPanelBase:Init()
    self:SetCurrentSoulEquipState(false)
    self:InitEvents()
end

function UIInlayPanelBase:Show(customData)
    if (customData == nil) then
        customData = {}
    end

    if customData.mMaterial ~= nil then
        ---@type bagV2.BagItemInfo 需要选中的材料
        self.mAutoChooseMaterial = customData.mMaterial
        self.mAutoChooseItemInfo = self:GetAutoChooseBagItemInfoByMaterial(customData.mMaterial)
    end
    if self.mAutoChooseItemInfo == nil then
        self.mAutoChooseItemInfo = self:GetAutoChooseBagItemInfo()
    end

    if self.mSuitBelong == LuaEnumSoulEquipType.XianZhuang then
        local pushXianZhuang = self:GetDataManager():GetCurrentPushXianZhuang()
        if pushXianZhuang then
            self.mAutoChooseItemInfo = self:GetAutoChooseBagItemInfoByMaterial(pushXianZhuang)
        end
    end

    self:OpenRolePanel()
    self:CanUseSystemAndChangePanel()
end

---是否可以系统（改变面板）
---@return boolean
function UIInlayPanelBase:CanUseSystemAndChangePanel()
    local canUseSystem = self:CanUseSystem()
    luaclass.UIRefresh:RefreshActive(self:UseCondition_GameObject(), canUseSystem == false)
    luaclass.UIRefresh:RefreshActive(self:GetBtnSet_GameObject(), canUseSystem)
    return canUseSystem
end

---@private 初始化事件
function UIInlayPanelBase:InitEvents()

    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        self:ClosePanel()
    end

    --luaclass.UIRefresh:BindClickCallBack(self:GetBtnRemove_GameObject(),function()
    --   if self:GetSelectEquip() then
    --     networkRequest.ReqPutOffSoulEquip(self:GetSelectEquip().index, self.mSuitBelong);
    --end
    --end)

    CS.UIEventListener.Get(self:GetBtnSet_GameObject()).onClick = function()
        if (self:GetSelectEquip() ~= nil and self:GetCurrentChooseMaterialLid() ~= nil and self.subIndex ~= 0) then
            if (not self:GetDataManager():CheckIfItCanBeMounted(self.mSuitBelong, self:GetSelectEquip().index, self.subIndex, self.mCurrentChooseMaterial)) then
                return
            end
            networkRequest.ReqPutOnSoulEquip(self:GetSelectEquip().index, self:GetCurrentChooseMaterialLid(), self.mSuitBelong, self.subIndex);
            self:GetSuccessEffect():SetActive(false)
            self:GetSuccessEffect():SetActive(true)
        end
    end

    CS.UIEventListener.Get(self:GetItemIcon_UISprite().gameObject).onClick = function()
        self:SetSelectEquip(nil)
    end

    CS.UIEventListener.Get(self:GetBtnSuit_GameObject()).onClick = function()
        uimanager:CreatePanel("UISuitAttributeSoulEquipPanel");
    end;

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, desTable = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(self.mHelpId)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, desTable)
        end
    end;

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, function()
        self:RefreshMaterialByBagItemChange()
        if (self:IsOpenHoleByBagItemChange()) then
            self:RefreshCurrentSoulEquipHole()
            self:RefreshTheInlayPos()
            self:RefreshTheInlayGrid()
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mInlaySingleDataChange, function(msgId, type)
        if type == self.mSuitBelong and self:GetSelectEquip() then
            self:SetSelectEquip(self:GetSelectEquip())
        end
    end)
end
--endregion

--region 支持重写
---是否可以使用系统
---@return boolean
function UIInlayPanelBase:CanUseSystem()
    return false
end
--endregion

--region 选中装备改变
---选中角色装备
---@param equipInfo bagV2.BagItemInfo
function UIInlayPanelBase:SetSelectEquip(equipInfo)
    self.mSelectEquip = equipInfo;
    self:RefreshTheInlayPos()
    self:ChangeCurrentChooseEquip(equipInfo)
    self:RefreshCurrentChooseEquip()
    --self:RefreshCurrentSoulEquip()
    self:RefreshMaterialByReset()
    self:RefreshCurrentSoulEquipHole()
    self:RefreshTheInlayGrid()
end

---改变当前选中装备数据
function UIInlayPanelBase:ChangeCurrentChooseEquip(equipInfo)
    self.mSelectEquip = equipInfo;
    self:ChangeCurrentChooseSoulEquip()
    self:RefreshCurrentSoulEquip()
end

---@return bagV2.BagItemInfo 获取当前选中装备
function UIInlayPanelBase:GetSelectEquip()
    return self.mSelectEquip;
end

---改变当前选中装备上镶嵌的魂装数据
function UIInlayPanelBase:ChangeCurrentChooseSoulEquip()
    if self:GetSelectEquip() then
        self.mCurrentChooseSoulEquip = self:GetDataManager():GetSingleTypeEquipByEquipIndex(self.mSuitBelong, self:GetSelectEquip().index, self.subIndex)
    else
        self.mCurrentChooseSoulEquip = nil
    end
end

---获取指定位置的魂器 1中 2左 3右
---@return LuaSoulEquipHoleInfo
function UIInlayPanelBase:AcquireHorcruxOfTheHolePosition(pos)
    if (self:GetSelectEquip()) then
        local soluEquip = self:GetDataManager():GetSoulEquipClassToEquipIndex(self.mSuitBelong, self:GetSelectEquip().index)
        if (soluEquip ~= nil) then
            return soluEquip:GetSoulEquip_SubIndex(pos)
        end
    end
    return nil
end

---获取一个格子位置 1左 2中 3右
---@return number
function UIInlayPanelBase:GetFirstGridPosition()
    local index = 0
    if (self:GetSelectEquip()) then
        index = self:GetDataManager():GetFirstGridPosition(self.mSuitBelong, self:GetSelectEquip().index)
    end
    return index
end

---@return bagV2.BagItemInfo 当前选中装备上镶嵌的魂装
function UIInlayPanelBase:GetCurrentChooseSoulEquip()
    return self.mCurrentChooseSoulEquip
end
--endregion

--region 刷新当前选中装备对应位置上的仙装/神器
---@param equipInfo bagV2.BagItemInfo
function UIInlayPanelBase:RefreshCurrentSoulEquip()
    if (self:GetSelectEquip() ~= nil) then
        self:GetSoulEquipName_Text().text = self:GetDataManager():GetInlayItemName(self:GetSelectEquip().itemId, self:GetSelectEquip().index)
        self:GetSoulEquipQuality_UISprite().spriteName = ""
    end
end

--region 刷新当前选中装备
---刷新当前选中装备显示
function UIInlayPanelBase:RefreshCurrentChooseEquip()
    local hasData = self:GetSelectEquip() ~= nil
    self:GetNoEquipment_GameObject():SetActive(not hasData and self:CanUseSystem());
    self:GetItemIcon_UISprite().gameObject:SetActive(hasData);
    self:GetBtnSet_GameObject():SetActive(hasData and self:CanUseSystem());
    if not hasData then
        return
    end
    ---@type TABLE.cfg_items
    local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(self:GetSelectEquip().itemId);
    if (itemTable ~= nil) then
        self:GetItemIcon_UISprite().spriteName = itemTable:GetIcon();
    end
end
--endregion

--region 刷新镶嵌格子
---刷新镶嵌格子类型
function UIInlayPanelBase:RefreshTheInlayPos()
    self.subIndex = 0
end

---刷新镶嵌格子的选中
function UIInlayPanelBase:RefreshTheInlayGrid()
end
--endregion

---设置镶嵌装备显示状态
function UIInlayPanelBase:SetCurrentSoulEquipState(isShow)
    --luaclass.UIRefresh:RefreshActive(self:GetSoulEquipIcon_UISprite(),isShow)
    --luaclass.UIRefresh:RefreshActive(self:GetBtnRemove_GameObject(),isShow)
    self:GetSoulEquipQuality_UISprite().gameObject:SetActive(isShow);
    luaclass.UIRefresh:RefreshActive(self:GetSoulEquipName_Text(), true)
end
----endregion

--region 刷新材料
---重置材料刷新
function UIInlayPanelBase:RefreshMaterialByReset()
    ---@type table<number,UIItem> 存储装备lid对应模板
    self.mMaterialLidToTemplate = {}
    local chooseMatGo = self:RefreshMaterials()
    if chooseMatGo then
        self:SelectMaterialChoose(chooseMatGo)
    end
end

---背包改变刷新材料
function UIInlayPanelBase:RefreshMaterialByBagItemChange()
    local needChoose = self:RefreshMaterials()
    if self:GetCurrentChooseMaterialLid() and self.mMaterialLidToTemplate then
        local template = self.mMaterialLidToTemplate[self:GetCurrentChooseMaterialLid()]
        if template then
            self:SelectMaterialChoose(template.go)
        end
    else
        self:SelectMaterialChoose(needChoose)
    end
end

---刷新孔位
function UIInlayPanelBase:RefreshCurrentSoulEquipHole()
end

---物品变动时满足开孔条件
---@return boolean
function UIInlayPanelBase:IsOpenHoleByBagItemChange()
    return false
end

---@private
---刷新材料
---@return UnityEngine.GameObject 一般返回第一个材料，如果有默认选中则选中默认材料
function UIInlayPanelBase:RefreshMaterials()
    if self:GetSelectEquip() == nil then
        self:GetNoSoulEquip_GameObject():SetActive(false)
        self:GetGridContainer().MaxCount = 0
        self:SelectMaterialChoose()
        return
    end

    local equipList = self:GetCanInlayItemList()
    if equipList == nil or #equipList <= 0 then
        self:GetNoSoulEquip_GameObject():SetActive(true and self:CanUseSystem())
        self:GetGridContainer().MaxCount = 0
        self:SelectMaterialChoose()
        return
    end

    local noData = #equipList <= 0
    local noSoul = self:GetCurrentChooseSoulEquip() == nil
    self:GetNoSoulEquip_GameObject():SetActive(noData and noSoul and self:CanUseSystem())

    self:GetGridContainer().MaxCount = #equipList
    ---@type table<number,bagV2.BagItemInfo>
    self.mGoToBagItemInfo = {}
    if noData then
        self:SelectMaterialChoose()
        return
    end
    local needChooseMaterial = nil

    for i = 0, self:GetGridContainer().controlList.Count - 1 do
        local go = self:GetGridContainer().controlList[i]
        local template = self:GetMaterialItemTemplate(go)
        local bagItemInfo = equipList[i + 1]
        self.mGoToBagItemInfo[go] = bagItemInfo
        self.mMaterialLidToTemplate[bagItemInfo.lid] = template
        if i == 0 then
            needChooseMaterial = go
        end

        if self.mAutoChooseMaterial and self.mAutoChooseMaterial.lid == bagItemInfo.lid then
            needChooseMaterial = go
            self.mAutoChooseMaterial = nil
        end

        ---@type TABLE.cfg_items
        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if itemTable then
            template:RefreshUIWithItemInfo(itemTable:CsTABLE())
            CS.UIEventListener.Get(go).onClick = function()
                self:SelectMaterialChoose(go)
            end
        end
    end
    return needChooseMaterial
end

---@private
---@return UIItem
function UIInlayPanelBase:GetMaterialItemTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
        self.mGoToTemplate[go] = template
    end
    return template
end

---@private
---选中材料
function UIInlayPanelBase:SelectMaterialChoose(go)
    if go then
        if self.mCurrentChooseTemplate ~= nil then
            self.mCurrentChooseTemplate:SetAsUnselectedState()
        end
        local template = self:GetMaterialItemTemplate(go)
        if template then
            template:SetAsSelectedState()
        end
        self.mCurrentChooseTemplate = template
        if self.mGoToBagItemInfo then
            local bagItemInfo = self.mGoToBagItemInfo[go]
            if bagItemInfo then
                self:SaveCurrentChooseMaterialLid(bagItemInfo)
            end
        end
    else
        self:SaveCurrentChooseMaterialLid()
    end
end

---存储当前选中材料
---@param bagItemInfo bagV2.BagItemInfo
function UIInlayPanelBase:SaveCurrentChooseMaterialLid(bagItemInfo)
    self.mCurrentChooseMaterial = bagItemInfo
    if bagItemInfo then
        self:RefreshSkillShow(bagItemInfo)
    --elseif self:GetCurrentChooseSoulEquip() then
    --    self:RefreshSkillShow(self:GetCurrentChooseSoulEquip())
    else
        self:RefreshSkillShow()
    end
end

---仙装是属性，神器是技能，所以在自己面板中处理显示
---@param bagItemInfo bagV2.BagItemInfo 选中魂装信息
function UIInlayPanelBase:RefreshSkillShow(bagItemInfo)
end

---@param soulEffect number
function UIInlayPanelBase:SetEquipDes(soulEffect)
    local signetTable = clientTableManager.cfg_signetManager:TryGetValue(soulEffect)
    if (signetTable == nil) then
        return
    end
    if (signetTable:GetParameter() ~= nil and signetTable:GetParameter().list.Count > 0) then
        local value = signetTable:GetParameter().list[0];
        self:GetSoulEquipDes_Text().text = tbl:GetName() .. "\n" .. luaEnumColorType.Purple .. string.CSFormat(signetTable:GetDescription(), value) .. "[-]";
    end
end

---@public
---@return number
function UIInlayPanelBase:GetCurrentChooseMaterialLid()
    if self.mCurrentChooseMaterial then
        return self.mCurrentChooseMaterial.lid
    end
end

---@protected
function UIInlayPanelBase:GetCanInlayItemList()
end

---刷新选中道具显示
function UIInlayPanelBase:RefreshTitleShow()

end
--endregion

--region 角色界面
---打开角色界面
function UIInlayPanelBase:OpenRolePanel()
    ---@param panel UIRolePanel
    uimanager:CreatePanel("UIRolePanel", function(panel)
        if (not CS.StaticUtility.IsNull(self.go)) then
            panel.leftArrow:SetActive(isShow)
            panel:ShowCloseButton(false);
            panel:SetSLToggle(false)
            self:AutoChooseBagItem()
        end
    end, self:GetRolePanelData());
end

---@return RolePanelParam 角色界面参数
function UIInlayPanelBase:GetRolePanelData()
end

---自动选中角色道具
function UIInlayPanelBase:AutoChooseBagItem()
    if self.mHasChoose ~= true then
        if self.mAutoChooseItemInfo then
            self:SetSelectEquip(self.mAutoChooseItemInfo)
        else
            self:SetSelectEquip(nil)
        end
        self.mHasChoose = true
    end
end

---获取默认可镶嵌选中第一个装备
---@return bagV2.BagItemInfo
function UIInlayPanelBase:GetAutoChooseBagItemInfo()

end

---根据材料获取对应装备位上的装备
---@return bagV2.BagItemInfo
---@param materialInfo bagV2.BagItemInfo
function UIInlayPanelBase:GetAutoChooseBagItemInfoByMaterial(materialInfo)
end


--endregion

--region 缓存数据
---@return TABLE.cfg_items
function UIInlayPanelBase:CacheItemInfo(id)
    if self.mItemIdToData == nil then
        self.mItemIdToData = {}
    end
    local info = self.mItemIdToData[id]
    if info == nil then
        info = clientTableManager.cfg_itemsManager:TryGetValue(id)
        self.mItemIdToData[id] = info
    end
    return info
end
--endregion

function UIInlayPanelBase:CloseAllPanel()
    uimanager:ClosePanel("UIRolePanel")
end

return UIInlayPanelBase