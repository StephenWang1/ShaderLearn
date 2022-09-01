local UIRolePanel_GridTemplateSignet = {}
setmetatable(UIRolePanel_GridTemplateSignet, luaComponentTemplates.UIRolePanel_GridTemplateBase)

function UIRolePanel_GridTemplateSignet:RedPoint()
    if self.red == nil then
        self.red = self:Get('background/Red', 'Top_UIRedPoint')
    end
    return self.red
end

---初始化格子
function UIRolePanel_GridTemplateSignet:ShowEquip(bagItemInfo, equipIndex)
    self.bagItemInfo = bagItemInfo
    self.equipIndex = equipIndex
    self.ItemInfo = nil
    self.NowImprintItemInfo = nil
    self.IsMayInlay = false
    self.ImprintInfoDic = CS.CSScene.MainPlayerInfo.SignetV2.ImprintInfoDic
    self.NowImprintInfo = self:GetNowImprintInfo()
    self:RefreshGrid(bagItemInfo)
    if self:RedPoint() ~= nil then
        self:RedPoint():RemoveRedPointKey();
        local temp = self:GetRedPointKey(equipIndex)
        if temp then
            self:RedPoint():AddRedPointKey(temp)
        end
    end

    if bagItemInfo ~= nil then
        self.ItemInfo = bagItemInfo.ItemTABLE
        self.IsMayInlay = self.ItemInfo.useLv >= CS.Cfg_GlobalTableManager.Instance.InlaySignetminLevel or self.ItemInfo.reinLv ~= 0
        self:GetIcon_UISprite().gameObject:SetActive(true)
        self:GetIcon_UISprite().spriteName = bagItemInfo.ItemTABLE.icon
        self:GetIcon_UISprite().transform:Find("quality").gameObject:SetActive(false)
        if not self.IsMayInlay then
            self:GetIcon_UISprite().color = CS.UnityEngine.Color(0, 0, 0);
        else
            self:GetIcon_UISprite().color = CS.UnityEngine.Color(1, 1, 1);
        end
    end
    self:GetYinJiK_UISprite().gameObject:SetActive(false)
    self:GetYinJi_GameObject():SetActive(true)
    -- self:SetAdd(false)
    -- self:SetSignetInlayIconBg(false)
    -- self:SetBg(true)
end

function UIRolePanel_GridTemplateSignet:GetRedPointKey(index)
    if index == Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON) then
        return CS.RedPointKey.Signet_weap
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES) then
        return CS.RedPointKey.Signet_clothes
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND) then
        return CS.RedPointKey.Signet_BraceletL
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING) then
        return CS.RedPointKey.Signet_ringL
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_BELT) then
        return CS.RedPointKey.Signet_belt
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_SHOES) then
        return CS.RedPointKey.Signet_shoe
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING) then
        return CS.RedPointKey.Signet_ringR
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND) then
        return CS.RedPointKey.Signet_BraceletR
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE) then
        return CS.RedPointKey.Signet_Necklace
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_HEAD) then
        return CS.RedPointKey.Signet_Helmet
    end
end

function UIRolePanel_GridTemplateSignet:GetNowImprintInfo()
    if self.bagItemInfo == nil then
        return nil
    end
    if self.ImprintInfoDic == nil then
        return nil
    end
    local isfind, ImprintInfo = self.ImprintInfoDic:TryGetValue(self.equipIndex)
    return ImprintInfo
end

---自己的刷新方法
function UIRolePanel_GridTemplateSignet:RefreshGrid(imprint)

    self:GetYinJiIcon_UISprite().gameObject:SetActive(self.NowImprintInfo ~= nil)
    if self.NowImprintInfo ~= nil then
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.NowImprintInfo.id);
        self.NowImprintItemInfo = itemTable
        if isFind then
            self:GetYinJiIcon_UISprite().spriteName = itemTable.icon;
        end
    end

    -- self.bagItemInfo = imprint
    -- local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(imprint.id)
    -- if self:GetIcon_UISprite() and CS.StaticUtility.IsNull(self:GetIcon_UISprite()) == false then
    --     self:GetIcon_UISprite().gameObject:SetActive(false)
    -- end
    -- if self:GetYinJi_GameObject() and CS.StaticUtility.IsNull(self:GetYinJi_GameObject()) == false then
    --     self:GetYinJi_GameObject():SetActive(true)
    -- end
    -- if self:GetChoose_GameObject() then
    --     self:GetChoose_GameObject():SetActive(false)
    -- end
    -- local name=""
    -- if itemInfo~=nil then
    --     name=itemInfo.icon
    -- end
    -- if imprint.index == self.equipIndex then
    --     ---印记镶嵌Icon
    --     self:GetYinJiIcon_UISprite().spriteName = name
    --     self:GetYinJiAdd_GameObject().gameObject:SetActive(false)
    --     self:GetYinJiIcon_UISprite().gameObject:SetActive(true)
    --     self:GetYinJiK_UISprite().gameObject:SetActive(true);
    --     self:GetYinJiK_UISprite().spriteName = 'yinjidi'
    --     if imprint.isValid == false then
    --         --self:GetYinJiK_UISprite().spriteName = 'chongtudi'
    --         self:GetYinJiK_UISprite().spriteName = 'yinjidi'
    --     end
    -- end
    --if not (self.equipIndex ~= LuaEnumEquiptype.Light and self.equipIndex ~= LuaEnumEquiptype.SoulJade
    --        and self.equipIndex ~= LuaEnumEquiptype.TheSecretTreasureOfYuanling and self.equipIndex ~= LuaEnumEquiptype.Baoshishoutao
    --        and self.equipIndex ~= LuaEnumEquiptype.Medal) then
    --    self:GetIcon_UISprite().gameObject:SetActive(true);
    --    if(imprint ~= nil) then
    --        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(imprint.itemId);
    --        if(isFind) then
    --            self:GetIcon_UISprite().spriteName = itemTable.icon;
    --        end
    --    end
    --end
end

---设置icon
function UIRolePanel_GridTemplateSignet:SetIcon(info)
    -- if self:GetYinJiIcon_UISprite() and CS.StaticUtility.IsNull(self:GetYinJiIcon_UISprite()) == false then
    --     self:GetYinJiIcon_UISprite().gameObject:SetActive(true)
    --     -- print("设置Icon："..info.." 名称：".. self:GetYinJiIcon_UISprite().gameObject.name)
    --     -- self:GetYinJiIcon_UISprite().spriteName = "17"
    -- end
end

---设置添加icon
function UIRolePanel_GridTemplateSignet:SetAdd(isShow)
    if self:GetYinJiAdd_GameObject() and CS.StaticUtility.IsNull(self:GetYinJiAdd_GameObject()) == false then
        self:GetYinJiAdd_GameObject():SetActive(isShow)
    end
end

---设置印记已添加图标底图
function UIRolePanel_GridTemplateSignet:SetSignetInlayIconBg(isShow, name)
    if self:GetYinJiK_UISprite() and CS.StaticUtility.IsNull(self:GetYinJiK_UISprite()) == false then
        self:GetYinJiK_UISprite().gameObject:SetActive(isShow)
        if name then
            self:GetYinJiK_UISprite().spriteName = name
        end
    end
end

function UIRolePanel_GridTemplateSignet:SetBg(isShow)
    if self:GetBackGroundEquipIcon_GameObject() and CS.StaticUtility.IsNull(self:GetBackGroundEquipIcon_GameObject()) == false then
        self:GetBackGroundEquipIcon_GameObject():SetActive(isShow)
    end
end

function UIRolePanel_GridTemplateSignet:RefreshStart()

    -- local nowSignetList, nowUnableSignetList = CS.CSScene.MainPlayerInfo.BagInfo:GetSignetList(self.ItemInfo)
    -- self:GetYinJi_GameObject().gameObject:SetActive(true)
    -- self:GetYinJiIcon_UISprite().gameObject:SetActive(false)
    -- self:GetYinJi1_UISprite().gameObject:SetActive(false)
    -- self:GetChoose_GameObject().gameObject:SetActive(false)
    -- self:GetBackGroundEquipIcon_GameObject().gameObject:SetActive(false)
    -- local isBetterSignet= CS.CSScene.MainPlayerInfo.BagInfo:IsHaveBetterSignet(self.equipIndex)
    -- self:GetYinJiTiSheng_GameObject().gameObject:SetActive(isBetterSignet)
    -- local isAdd = self.ItemInfo ~= nil
    -- if self.equipIndex ~= LuaEnumEquiptype.Light and self.equipIndex ~= LuaEnumEquiptype.SoulJade
    --         and self.equipIndex ~= LuaEnumEquiptype.TheSecretTreasureOfYuanling and self.equipIndex ~= LuaEnumEquiptype.Baoshishoutao
    --         and self.equipIndex ~= LuaEnumEquiptype.Medal then
    --     self:GetIcon_UISprite().gameObject:SetActive(false)
    --     self:GetYinJiAdd_UISprite().gameObject:SetActive(true)
    --     self:GetYinJiAdd_UISprite().enabled = isAdd and nowSignetList.Count > 0;
    --     self:GetYinJiChongTu_GameObject().gameObject:SetActive(not isAdd)
    -- else
    --     --self:GetIcon_UISprite().gameObject:SetActive(true)
    -- end
    -- self:SetBg(true)
end

---重写加号显示
function UIRolePanel_GridTemplateSignet:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then

        self:GetAdd_GameObject():SetActive(false)
    end
end

return UIRolePanel_GridTemplateSignet