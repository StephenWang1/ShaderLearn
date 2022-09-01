---@class UIRolePanel_EquipTemplate:TemplateBase
local UIRolePanel_EquipTemplate = {}


--region 局部变量
---格子对应模板
---@type table<UnityEngine.GameObject,>
UIRolePanel_EquipTemplate.mGridToTemplate = nil
---装备位对应模板
---@type table<LuaEquipmentItemType,UIRolePanel_GridTemplateBase>
UIRolePanel_EquipTemplate.mEquipIndexToTemplate = nil
---装备位对应格子
UIRolePanel_EquipTemplate.mEquipIndexToGrid = nil
--endregion

--region 初始化
---@param panel UIRolePanel
function UIRolePanel_EquipTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:InitComponents()
    self:OnInit()
end

--region 属性
function UIRolePanel_EquipTemplate:GetBagInfoV2()
    if self.mBagInfoV2 == nil then
        self.mBagInfoV2 = CS.CSScene.MainPlayerInfo.BagInfo
    end
    return self.mBagInfoV2
end
--endregion

function UIRolePanel_EquipTemplate:OnInit()

end

---获取组件
function UIRolePanel_EquipTemplate:InitComponents()
    ---武器
    self.weapon = self:Get("view/equips/equips/weap", "GameObject")
    ---头盔
    self.helmet = self:Get("view/equips/equips/Helmet", "GameObject")
    ---衣服
    self.clothes = self:Get("view/equips/equips/clothes", "GameObject")
    ---项链
    self.necklace = self:Get("view/equips/equips/Necklace", "GameObject")
    ---左手镯
    self.braceletL = self:Get("view/equips/equips/BraceletL", "GameObject")
    ---右手镯
    self.braceletR = self:Get("view/equips/equips/BraceletR", "GameObject")
    ---左戒指
    self.ringL = self:Get("view/equips/equips/ringL", "GameObject")
    ---右戒指
    self.ringR = self:Get("view/equips/equips/ringR", "GameObject")
    ---腰带
    self.belt = self:Get("view/equips/equips/belt", "GameObject")
    ---鞋子
    self.shoe = self:Get("view/equips/equips/shoe", "GameObject")
    ---灯
    self.lamp = self:Get("view/equips/equips/lamp", "GameObject")
    ---魂玉
    self.souljade = self:Get("view/equips/equips/soul", "GameObject")
    ---宝石
    self.jewel = self:Get("view/equips/equips/jewel", "GameObject")
    ---灵兽
    self.rawanima = self:Get("view/equips/equips/yuanling", "GameObject")
    ---勋章
    self.medal = self:Get("view/equips/equips/medal", "GameObject")
    ---帮会相关
    self.roleoffice = self:Get("view/roleoffice", "Top_UILabel")
    ---角色名字
    self.rolename = self:Get("view/rolename", "Top_UILabel")
    ---战勋图片
    ---@type UISprite
    self.rolePrefixSp = self:Get("view/nameLeftTable/MilitaryRankTitle/Sprite", "UISprite")
    ---战勋等级
    ---@type UISprite
    self.rolePrefixLv = self:Get("view/nameLeftTable/MilitaryRankTitle/level", "UISprite")
    ---角色官阶
    self.roleofficename = self:Get("view/roleofficestate", "Top_UILabel")
    ---婚姻称谓
    self.marryname = self:Get("view/marryname", "Top_UILabel")
    ---拖拽对象
    self.DragItem_GameObject = self:Get("view/equips", "GameObject")
    ---结婚戒指
    self.marryRing = self:Get("view/equips/equips/Marryring", "GameObject")
    ---虎符
    self.hufu = self:Get("view/equips/equips/hufu", "GameObject")
    ---官印
    self.seal = self:Get("view/equips/equips/officialStamp", "GameObject")
    ---马牌
    self.maPai = self:Get("view/equips/equips/mount", "GameObject")
    ---暗器
    self.anqi = self:Get("view/equips/equips/anqi", "GameObject")
    ---主印
    self.MainSignet = self:Get("view/equips/equips/MainSignet", "GameObject")
    ---辅印
    self.SubSignet = self:Get("view/equips/equips/SubSignet", "GameObject")
    ---特戒左
    ---@type UnityEngine.GameObject
    self.specialRingL = self:Get("view/equips/equips/specialRingL", "GameObject")
    ---特戒右
    ---@type UnityEngine.GameObject
    self.specialRingR = self:Get("view/equips/equips/specialRingR", "GameObject")
    ---斗笠
    self.bambooHat = self:Get("view/equips/equips/bambooHat", "GameObject")
    ---盾牌 左手武器
    self.shield = self:Get("view/equips/equips/shield", "GameObject")
    UIRolePanel_EquipTemplate.DragItem_Teamplate = templatemanager.GetNewTemplate(self.DragItem_GameObject, luaComponentTemplates.UIBagItemDrag)
end

---传入模板
---@param template UIRolePanel_GridTemplateBase
---@param avatarInfo  CSAvaterInfo 模型信息/默认主角模型
function UIRolePanel_EquipTemplate:InitGrid(template, customData, avatarInfo)
    self.customData = customData
    self.gridTemplate = template
    self.mGridToTemplate = {}
    self.mEquipIndexToTemplate = {}
    self.mEquipIndexToGrid = {}
    self:InitParameters()
    if avatarInfo then
        self.avatarInfo = avatarInfo
        self.isMainPlayer = avatarInfo.ID == CS.CSScene.MainPlayerInfo.ID;
        if self.rolename ~= nil then
            self.rolename.text = avatarInfo.Name
        end
        if (avatarInfo.officialPosistionId ~= 0) then
            local info = clientTableManager.cfg_official_positionManager:TryGetValue(avatarInfo.officialPosistionId)
            if (info ~= nil) then
                self.roleofficename.gameObject:SetActive(true)
                self.roleofficename.text = tostring(CS.Utility_Lua.GetItemColorByQualityValue(info:GetQuality())) .. info:GetName() .. info:GetLastname()
            end
        else
            self.roleofficename.gameObject:SetActive(false)
        end
        self:RefreshUnionName()
    end
    self:RefreshMarryName()
    self:RefreshHuFuAndSealGridIsShow()
    self:RefreshMaPaiActive()
    self:RefreshAnQiActive()
    local prefixID = avatarInfo.SealMarkId
    local career = avatarInfo.Career
    if self.rolePrefixSp then
        self.rolePrefixSp.spriteName = ""
        self.rolePrefixLv.spriteName = ""
        if prefixID and career then
            local strs = CS.Cfg_PrefixTitleTableManager.Instance:GetPrefixAtlasStr(prefixID, career);
            local info = string.Split(strs, '#')
            if #info >= 2 then
                self.rolePrefixSp.spriteName = info[1]
                self.rolePrefixLv.spriteName = info[2]
            end
        end
    end
end

---绑定模板
function UIRolePanel_EquipTemplate:InitParameters()
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON), self.weapon)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_HEAD), self.helmet)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES), self.clothes)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE), self.necklace)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND), self.braceletL)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND), self.braceletR)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING), self.ringL)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING), self.ringR)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_BELT), self.belt)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_SHOES), self.shoe)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_LAMP), self.lamp)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE), self.souljade)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE), self.jewel)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA), self.rawanima)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL), self.medal)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_MARRY_RING), self.marryRing)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_SEAL), self.seal)
    self:BindTemplate(LuaEquipmentItemType.POS_MaPai, self.maPai)
    self:BindTemplate(LuaEquipmentItemType.POS_AnQi, self.anqi)
    self:BindTemplate(LuaEquipmentItemType.MainSignet, self.MainSignet)
    self:BindTemplate(LuaEquipmentItemType.SubSignet, self.SubSignet)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_SPECIALRING), self.specialRingL)
    self:BindTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_SPECIALRING), self.specialRingR)
end

---为格子绑定模板并刷新
function UIRolePanel_EquipTemplate:BindTemplate(equipIndex, grid)
    if self.gridTemplate then
        --绑定模板
        ---@type UIRolePanel_GridTemplateBase
        local tbl = templatemanager.GetNewTemplate(grid, self.gridTemplate)
        --第一次刷新
        local info = self:GetEquipInfo(equipIndex)
        --region 添加附加的额外装备显示
        local extraEquips = self:GetExtraEquipList(equipIndex);
        if (extraEquips ~= nil) then
            tbl:AddExtraEquips(extraEquips);
        end
        --endregion
        tbl:ShowEquip(info, equipIndex)
        tbl.equipIndex = equipIndex
        tbl.subType = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.EquipInfo:GetSubTypeByEquipIndex(equipIndex))
        --存储数据
        self.mGridToTemplate[grid] = tbl
        self.mEquipIndexToTemplate[equipIndex] = tbl
        self.mEquipIndexToGrid[equipIndex] = grid
        --绑定点击事件
        CS.UIEventListener.Get(grid).LuaEventTable = self
        CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnItemClicked
        self:BindEvents(tbl, grid, equipIndex)
    end
end

---按开服天数刷新虎符和官位格子，若未达到条件则隐藏装备格子
function UIRolePanel_EquipTemplate:RefreshHuFuAndSealGridIsShow()
    if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(81004)) then
        self.seal:SetActive(false)
        self.hufu:SetActive(false)
    else
        self.seal:SetActive(false)
        self.hufu:SetActive(false)
    end
end

---刷新马牌显示状态
function UIRolePanel_EquipTemplate:RefreshMaPaiActive()
    local limitIDList = LuaGlobalTableDeal.GetMaPaiOpenLimit()
    local isopen = Utility.IsOpenSystem(limitIDList)
    self.maPai:SetActive(isopen);
end
---刷新暗器显示状态
function UIRolePanel_EquipTemplate:RefreshAnQiActive()
    local limitIDList = LuaGlobalTableDeal.GetMaPaiOpenLimit()
    local isopen = Utility.IsOpenSystem(limitIDList)
    self.anqi:SetActive(isopen);
end

function UIRolePanel_EquipTemplate:RefreshHuFuGrid(emperorTokenId, isActive, isMainPlayer)
    self:RefreshHuFuTemplate(Utility.EnumToInt(CS.EEquipIndex.POS_HUFU), self.hufu, emperorTokenId, isActive, isMainPlayer)
end

---绑定虎符模板
function UIRolePanel_EquipTemplate:RefreshHuFuTemplate(equipIndex, grid, emperorTokenId, isActive, isMainPlayer)
    if self.gridTemplate == nil then
        return
    end
    ---@type UIRolePanel_GridTemplateBase
    local template = self.mGridToTemplate[grid]
    if template == nil then
        template = templatemanager.GetNewTemplate(grid, self.gridTemplate)
        --存储数据
        self.mGridToTemplate[grid] = template
    end
    template:RefreshGridByHuFu(emperorTokenId, isActive)
    template.equipIndex = equipIndex
    template.subType = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.EquipInfo:GetSubTypeByEquipIndex(equipIndex))

    --绑定点击事件
    CS.UIEventListener.Get(grid).onClick = function()
        if emperorTokenId == 0 and isMainPlayer then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Position_HuFu)
        else
            local luaTokenInfo = clientTableManager.cfg_official_emperor_tokenManager:TryGetValue(emperorTokenId)
            if luaTokenInfo then
                local itemId = luaTokenInfo:GetLinkItemId()
                if itemId then
                    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                    if res then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
                    end
                end
            end
        end
    end
end
--endregion

---@virtual 子类重写此方法 可改变显示的额外装备(灯芯, 赤炎灯)
function UIRolePanel_EquipTemplate:GetExtraEquipList(equipIndex)
    local extraEquipList = {};
    if equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LAMP) then
        local DengxinId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_DengXin
        if (DengxinId ~= 0) then
            table.insert(extraEquipList, DengxinId);
        end
        --魂玉
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE) then
        local ShengMingJingPoId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShengMingJingPo
        if (ShengMingJingPoId ~= 0) then
            table.insert(extraEquipList, ShengMingJingPoId);
        end
        --灵兽秘宝
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA) then
        local JinGongZhiYuanId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan
        local ShouHuZhiYuanId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan
        if (JinGongZhiYuanId ~= 0) then
            table.insert(extraEquipList, JinGongZhiYuanId);
        end
        if (ShouHuZhiYuanId ~= 0) then
            table.insert(extraEquipList, ShouHuZhiYuanId);
        end
        --宝石
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE) then
        local BaoshiId = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_BaoShi
        if (BaoshiId ~= 0) then
            table.insert(extraEquipList, BaoshiId);
        end
        --elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL) then
        --双倍勋章
    end
    return extraEquipList;
end

function UIRolePanel_EquipTemplate:BindEvents(tbl, grid, equipIndex)
    if tbl then
        CS.UIEventListener.Get(grid).onDragStart = function()
            self:OnRolePanelGirdStartDrag(grid, tbl.bagItemInfo, tbl.itemInfo, equipIndex)
        end
        CS.UIEventListener.Get(grid).onDrag = function(grid, delta)
            self:OnRolePanelGirdDrag(grid, delta, tbl.bagItemInfo, tbl.itemInfo)
        end
        CS.UIEventListener.Get(grid).onDragEnd = self.OnRolePanelGirdEndDrag
        CS.UIEventListener.Get(grid).onPress = function(grid, state)
            self:OnRolePanelGirdOnPress(grid, state, tbl.bagItemInfo, tbl.itemInfo, equipIndex)
        end
    end
end

---面巾装备点击事件
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 是否特殊处理,若特殊处理则不执行之前的点击事件
function UIRolePanel_EquipTemplate:OnFaceEquipClicked(bagItemInfo)
    return false
end

--region 刷新装备（重写此方法）

---刷新装备格子显示
function UIRolePanel_EquipTemplate:RefreshGrid()
    if self.mEquipIndexToTemplate then
        for k, v in pairs(self.mEquipIndexToTemplate) do
            --region 添加附加的额外装备显示
            local extraEquips = self:GetExtraEquipList(k);
            if (extraEquips ~= nil) then
                v:AddExtraEquips(extraEquips);
            end
            --endregion
            local info = self:GetEquipInfo(k)
            v:ShowEquip(info)
        end
    end
end

---获取显示装备信息
---@param equipIndex XLua.Cast.Int32 装备位index
---@return bagV2.BagItemInfo
function UIRolePanel_EquipTemplate:GetEquipInfo(equipIndex)
    return CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(equipIndex)
end

---点击装备
function UIRolePanel_EquipTemplate:OnItemClicked(go)
    local template = self.mGridToTemplate[go]
    if template then
        if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridClicked) then
            luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
        else
            self:ShowItemInfo(template);
        end
    end
end

function UIRolePanel_EquipTemplate:ShowItemInfo(template, isShowRight)
    if (isShowRight == nil) then
        isShowRight = true;
    end

    if template.bagItemInfo then
        local curBagItemInfo = ternary(template.itemInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:IsMarryRing(template.itemInfo), CS.CSScene.MainPlayerInfo.MarryInfo:GetPlayerMarryInfo(), template.bagItemInfo)
        local curItemInfo = template.itemInfo
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = curBagItemInfo, itemInfo = curItemInfo, showRight = isShowRight, showAction = true, extraEquipIdTable = self:GetExtraEquipList(template.equipIndex), showBind = true })
    else
        if template.canEquip and template.equipIndex and template.canEquip.lid then
            networkRequest.ReqPutOnTheEquip(template.equipIndex, template.canEquip.lid)
            CS.CSScene.MainPlayerInfo.BagInfo:RemoveNewItem(template.canEquip)
        elseif (template.mExtraEquipDic ~= nil) then
            for k, v in pairs(template.mExtraEquipDic) do
                local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
                if (isFindItem) then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, itemInfoSource = luaEnumItemInfoSource.UIROLEPANEL, showBind = true, showAction = true })
                    break ;
                end
            end
        end
    end

    --if template.bagItemInfo then
    --    local curBagItemInfo = ternary(template.itemInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:IsMarryRing(template.itemInfo), CS.CSScene.MainPlayerInfo.MarryInfo:GetPlayerMarryInfo(), template.bagItemInfo)
    --    local curItemInfo = template.itemInfo
    --    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = curBagItemInfo, itemInfo = curItemInfo, extraEquipIdTable = self:GetExtraEquipList(template.equipIndex) })
    --else
    --    if (template.mExtraEquipDic ~= nil) then
    --        for k, v in pairs(template.mExtraEquipDic) do
    --            local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
    --            if (isFindItem) then
    --                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
    --                break ;
    --            end
    --        end
    --    end
    --end
end

---外部调用点击某格子
---@param equipIndex XLua.Cast.Int32 装备位index
function UIRolePanel_EquipTemplate:SetItemChoose(equipIndex)
    if self.mEquipIndexToTemplate and equipIndex and self.mEquipIndexToTemplate[equipIndex] then
        self:OnItemClicked(self.mEquipIndexToGrid[equipIndex])
    end
end

---外部调用取消当前选中(用于重写)
function UIRolePanel_EquipTemplate:HideCurrentChooseItem()
end
--endregion

--region拖拽
---装备格子按下事件
function UIRolePanel_EquipTemplate:OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridPressed) then
        luaEventManager.DoCallback(LuaCEvent.Role_EquipGridPressed, itemInfo)
    else
        self:OriginEvent_OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    end
end

---装备格子开始拖拽事件
function UIRolePanel_EquipTemplate:OnRolePanelGirdStartDrag(go, bagItemInfo, itemInfo, equipIndex)
    if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridStartDrag) then
        luaEventManager.DoCallback(LuaCEvent.Role_EquipGridStartDrag, itemInfo)
    else
        self:OriginEvent_OnRolePanelGirdStartDrag(go, bagItemInfo, itemInfo, equipIndex)
    end
end

---装备格子持续拖拽事件
function UIRolePanel_EquipTemplate:OnRolePanelGirdDrag(go, delta, bagItemInfo, itemInfo)
    if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridDrag) then
        luaEventManager.DoCallback(LuaCEvent.Role_EquipGridDrag, itemInfo)
    else
        self:OriginEvent_OnRolePanelGirdDrag(go, delta, bagItemInfo, itemInfo)
    end
end

---装备格子持续拖拽事件
function UIRolePanel_EquipTemplate.OnRolePanelGirdEndDrag(go)
    if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridEndDrag) then
        luaEventManager.DoCallback(LuaCEvent.Role_EquipGridEndDrag)
    else
        UIRolePanel_EquipTemplate:OriginEvent_OnRolePanelGirdEndDrag()
    end
end

---原始装备格子按下
function UIRolePanel_EquipTemplate:OriginEvent_OnRolePanelGirdOnPress(go, state, bagItemInfo, itemInfo, equipIndex)
    self.DragItem_Teamplate:OnPress(go, state, bagItemInfo, itemInfo, equipIndex)
end

---原始装备格子开始拖拽
function UIRolePanel_EquipTemplate:OriginEvent_OnRolePanelGirdStartDrag(go, bagItemInfo, itemInfo, equipIndex)
    ---@type UIBagPanel
    local uibagpanel = uimanager:GetPanel("UIBagPanel")
    local depth
    if uibagpanel ~= nil then
        depth = uibagpanel:GetScrollView_UIPanel().depth
    end
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        if bagItemInfo ~= nil and itemInfo ~= nil then
            self.DragItem_Teamplate:OnStartDrag(bagItemInfo, itemInfo, depth, equipIndex, go, LuaEnumEndDragType.RolePanel)
        end
    end
end

---原始装备格子持续拖拽
function UIRolePanel_EquipTemplate:OriginEvent_OnRolePanelGirdDrag(go, delta, bagItemInfo, itemInfo)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        if bagItemInfo ~= nil and itemInfo ~= nil then
            self.DragItem_Teamplate:OnDrag(go, delta)
        end
    end
end

---原始装备格子结束拖拽
function UIRolePanel_EquipTemplate:OriginEvent_OnRolePanelGirdEndDrag()
    self.DragItem_Teamplate:OnEndDrag(nil)
end
--endregion

--region 称谓

function UIRolePanel_EquipTemplate:RefreshMarryName()
    if self.marryname == nil or (CS.StaticUtility.IsNull(self.marryname)) then
        return
    end
    if not self.isMainPlayer then
        self.marryname.gameObject:SetActive(self.customData.appellation ~= nil)
        self.marryname.text = self.customData.appellation == nil and '' or self.customData.appellation
        return
    end
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil then
        local appearanceData = CS.CSScene.MainPlayerInfo.Appearance.AppearanceData
        if appearanceData.AppellationDic ~= nil then
            local isFind, info = appearanceData.AppellationDic:TryGetValue(LuaEnumAppellation.Marrige)
            self.marryname.gameObject:SetActive(isFind)
            if isFind then
                self.marryname.text = info.titleDes
            end
        end
    end
end

---刷新帮会名
function UIRolePanel_EquipTemplate:RefreshUnionName()
    if self.avatarInfo ~= nil and not CS.StaticUtility.IsNullOrEmpty(self.avatarInfo.UIUnionName) then
        self.roleoffice.text = self.avatarInfo.UnionInfoV2.UnionName
        if self.avatarInfo.UnionInfoV2 ~= nil then
            local unionPos = self.avatarInfo.UnionPos
            if self.avatarInfo.ID == self.avatarInfo.UnionInfoV2.ActingPresidentRoleID then
                unionPos = LuaEnumGuildPosType.ActingPresident
            end
            local UnionPosName = uiStaticParameter.PosStringList[unionPos]
            self.roleoffice.text = self.roleoffice.text .. " " .. UnionPosName
        end
    else
        self.roleoffice.text = ""
    end
end

--endregion

function UIRolePanel_EquipTemplate:DestroyFunction()
end

return UIRolePanel_EquipTemplate