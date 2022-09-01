---@class UIOtherRolePanel:UIRolePanel
local UIOtherRolePanel = {}

setmetatable(UIOtherRolePanel, luaPanelModules.UIRolePanel)

---藏品按钮
---@return UnityEngine.GameObject
function UIOtherRolePanel:GetCollectionButtonGo()
    if self.mCollectionBtnGo == nil then
        self.mCollectionBtnGo = self:GetCurComp("WidgetRoot/left/events/btn_collection", "GameObject")
    end
    return self.mCollectionBtnGo
end

function UIOtherRolePanel:Init()
    self:RunBaseFunction("Init")
    if CS.StaticUtility.IsNull(self:GetCollectionButtonGo()) == false then
        CS.UIEventListener.Get(self:GetCollectionButtonGo()).onClick = function(go)
            self:OnCollectionButtonClicked(go)
        end
    end
end

function UIOtherRolePanel:Show(customData)
    --设置数据
    self.customData = customData
    if customData ~= nil and customData.monthCard ~= nil then
        self.monthCard = self.customData.monthCard
    end
    if customData ~= nil and customData.vipLevel ~= nil then
        self.vipLevel = self.customData.vipLevel
    else
        self.vipLevel = 0
    end
    self.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.ByOtherRole
    self.isShowCloseBtn = true
    self.isShowArrowBtn = false
    self.mIsMainPlayer = false
    self.playerAvatarInfo = customData.avatarInfo
    self.equipInfo = customData.equipInfo
    self.mEquipTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateOtherPlayer
    self.mEquipGridTemplate = luaComponentTemplates.UIRolePanel_GridTemplateOtherPlayer
    --绑定模板
    if CS.StaticUtility.IsNull(self.left) == false then
        self.equipShow = templatemanager.GetNewTemplate(self.left.gameObject, self.mEquipTemplate)
        self.equipShow:InitGrid(self.mEquipGridTemplate, customData, self.playerAvatarInfo)
        local tokenId = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo.emperorTokenId
        self.equipShow:RefreshHuFuGrid(tokenId, true, false)
    end

    self:ReCheckComponents()
    --加载模型
    self:LoadModel()
    self:InitBtnState()
    self:RefreshFaceButtonState()
    self:RefreshLeftWeaponButtonState()
    self:RefreshDouLiButtonState()
    self:RefreshMonthCardSprite()
    --self:RefreshVipInfo(self.vipLevel)
    self:RefreshMemberIcon()
    self:RefreshMagicEquip();
    --刷新套装相关的页签开关
    self:UpdateSuitPageToggle()
    self:RefreshCollectionBtn()
    self:RefreshFaZhen()
end

---得到背包数据, 其他玩家查看面板的时候,返回nil
function UIOtherRolePanel:GetBagMgrData()
    return nil
end

---@return table<LuaPlayerEquipmentListData>
function UIOtherRolePanel:GetAllSLEquipmentList()
    return gameMgr:GetOtherPlayerDataMgr():GetAllSLEquipmentList();
end

---检测是否显示法宝栏栏显示
function UIOtherRolePanel:RefreshMagicEquip()
    --刷新法宝按钮状态
    if CS.StaticUtility.IsNull(self:GetMagicEquipBtn_GameObject()) == false then
        self:GetMagicEquipBtn_GameObject():SetActive(LuaGlobalTableDeal:IsOpenPlayerMagicEquipBtn(gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo.level, false))
    end
end

---法宝按钮点击
function UIOtherRolePanel:MagicEquipBtnOnClick()
    uimanager:CreatePanel("UIOtherRoleArtifactPanel")
end

--展示会员等级Icon
function UIOtherRolePanel:RefreshMemberIcon()
    --local memberLevel = self.customData.vipMember
    local memberLevel = gameMgr:GetOtherPlayerDataMgr():GetVipLevel()
    if memberLevel > 0 then
        self:GetMemberSprite().gameObject:SetActive(true)
        local memberData = clientTableManager.cfg_memberManager:TryGetValue(memberLevel)
        local spriteName = memberData:GetSpirit()
        self:GetMemberSprite().spriteName = spriteName
        self:GetMemberSprite():MakePixelPerfect()
    else
        self:GetMemberSprite().gameObject:SetActive(false)
    end
end
---刷新Vip信息
function UIOtherRolePanel:RefreshVipInfo(viplevel)
    self:RefreshVipIcon(viplevel)
    if (viplevel >= 13) then
        self:GetVipLevel_Sprite().spriteName = "svip"
        self:GetVipLevel_Sprite():MakePixelPerfect()
    end
    self:GetVipLevel_UILabel().text = viplevel >= 13 and "" or viplevel
    self:GetVipLevel_UILabel().color = viplevel == 0 and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
    self:GetVipLevel_Sprite().color = viplevel == 0 and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white

    --self:GetVipLevel_UILabel().text = viplevel
    --self:GetVipLevel_UILabel().color = viplevel == 0 and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
    --self:GetVipLevel_Sprite().color = viplevel == 0 and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
end

---刷新VIPIcon信息
function UIOtherRolePanel:RefreshVipIcon(viplevel)
    self:GetVipLevel_Sprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId(viplevel)[1]
    self:GetVipLevel_Sprite():MakePixelPerfect()
end

function UIOtherRolePanel:RefreshCollectionBtn()
    local collectionInfo = gameMgr:GetOtherPlayerDataMgr():GetCollectionInfo()
    if CS.StaticUtility.IsNull(self:GetCollectionButtonGo()) == false then
        local isShowBtn = false
        if collectionInfo ~= nil and Utility.GetTableCount(collectionInfo:GetCollectionDic()) > 0 then
            isShowBtn = true
        end
        self:GetCollectionButtonGo():SetActive(isShowBtn)
    end
end

---藏品按钮点击事件
---@param go UnityEngine.GameObject
function UIOtherRolePanel:OnCollectionButtonClicked(go)
    local collectionInfo = gameMgr:GetOtherPlayerDataMgr():GetCollectionInfo()
    if collectionInfo ~= nil then
        uimanager:CreatePanel("UIOtherCollectionPanel")
    end
end

--region 法阵
---@return LuaZhenFaInfo
function UIOtherRolePanel:GetFaZhenInfo()
    return gameMgr:GetOtherPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo()
end
--endregion
--region onDestroy
function ondestroy()
    UIOtherRolePanel:OnDestroy()
end

---面巾按钮被点击事件
function UIOtherRolePanel:OnFaceButtonClicked(go)
    if self.playerAvatarInfo ~= nil then
        local equipBagItemID
        if self.equipInfo ~= nil then
            if self.playerAvatarInfo.GetEquipItemID ~= nil then
                equipBagItemID = self.playerAvatarInfo:GetEquipItemID(LuaEnumEquiptype.Face)
            end
        elseif self.playerAvatarInfo.FaceItemID ~= nil then
            equipBagItemID = self.playerAvatarInfo.FaceItemID
        end
        if equipBagItemID ~= nil and equipBagItemID ~= 0 then
            uiStaticParameter.UIItemInfoManager:CreatePanel(
                    {
                        itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(equipBagItemID),
                        showRight = false,
                        showAssistPanel = true,
                        showMoreAssistData = true,
                        itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL
                    }
            )
        end
    end
end
---盾牌按钮被点击事件
function UIOtherRolePanel:OnLeftWeaponButtonClicked(go)
    local ItemInfo
    if self.equipInfo ~= nil then
        local data = self.equipInfo[LuaEnumEquiptype.LeftWeapon]
        if data ~= nil then
            ItemInfo = data.ItemTABLE
        end
    end
    if ItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel(
                {
                    itemInfo = ItemInfo,
                    showRight = false,
                    showAssistPanel = true,
                    showMoreAssistData = true,
                    itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL
                }
        )
    end
end

---斗笠按钮被点击事件
function UIOtherRolePanel:OnDouLiButtonClicked(go)
    local ItemInfo
    if self.equipInfo ~= nil then
        local data = self.equipInfo[LuaEnumEquiptype.DouLi]
        if data ~= nil then
            ItemInfo = data.ItemTABLE
        end
    end
    if ItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel(
                {
                    itemInfo = ItemInfo,
                    showRight = false,
                    showAssistPanel = true,
                    showMoreAssistData = true,
                    itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL
                }
        )
    end
end

function UIOtherRolePanel:BindLuaRedPoint()

end

function UIOtherRolePanel:OnDestroy()
    self:RunBaseFunction("OnDestroy")
end
--endregion

return UIOtherRolePanel