---@class UIFastItemUseViewTemplate:TemplateBase
local UIFastItemUseViewTemplate = {};

---@type table<number,UIFastItemUseUnitTemplate>
UIFastItemUseViewTemplate.mUnitDic = nil;

UIFastItemUseViewTemplate.mItemCount = 0;

--region Components

--region GameObject

--endregion

function UIFastItemUseViewTemplate:GetUnitGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("itemList", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end

--endregion

--region Method

--region CallFunction

function UIFastItemUseViewTemplate:OnResBagItemChange()
    for k, v in pairs(self.mUnitDic) do
        v:UpdateUI();
    end
end

function UIFastItemUseViewTemplate:OnResUseItemMessage(msgId, msgData)

    for k, v in pairs(self.mUnitDic) do
        v:TryStartCDTime(msgData.itemId, msgData.cdTime)
    end

    --if CS.CSScene.MainPlayerInfo.BagInfo:IsItemIDUsingRelated(msgData.itemId, self.mItemId) then
    --    if (self.mCoroutineCDTime ~= nil) then
    --        StopCoroutine(self.mCoroutineCDTime);
    --        self.mCoroutineCDTime = nil;
    --    end
    --    self.mCoroutineCDTime = StartCoroutine(UIFastItemUseUnitTemplate.IEnumCDTime, self, msgData.cdTime);
    --else
    --    if(self.mCoroutineCDTime == nil) then
    --        self:GetCDMask_UISprite().fillAmount = 0;
    --        self:GetCDMask_UISprite().gameObject:SetActive(false);
    --        self:GetUSeBtn_UIButtonScale().enabled = true;
    --    end
    --end
end


--endregion

--region Public

function UIFastItemUseViewTemplate:ShowView()

    if (self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    local value = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShowItemShortcut);
    local isShow = value == 1;
    self.go:SetActive(isShow)

    local itemId1 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem1);
    local itemId2 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem2);
    local itemId3 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem3);
    local itemId4 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem4);

    local list = {};
    table.insert(list, itemId1)
    table.insert(list, itemId2)
    table.insert(list, itemId3)
    table.insert(list, itemId4)
    self.mItemCount = 0;

    local showList = {};
    for k, v in pairs(list) do
        if (v ~= 0) then
            table.insert(showList, v);
            self.mItemCount = self.mItemCount + 1;
        end
    end

    local gridContainer = self:GetUnitGridContainer();
    gridContainer.MaxCount = self.mItemCount <= 0 and 1 or self.mItemCount;
    if (self.mItemCount > 0) then
        local length = gridContainer.controlList.Count;
        if (length > 0) then
            for k = 0, length - 1 do
                local key = k + 1;
                local v = gridContainer.controlList[k]
                if (self.mUnitDic[v] == nil) then
                    self.mUnitDic[v] = templatemanager.GetNewTemplate(v, luaComponentTemplates.UIFastItemUseUnitTemplate, self.mUIMainSkillPanel)
                end
                local itemId = showList[key];
                itemId = itemId == nil and 0 or itemId;
                self.mUnitDic[v]:ShowUnit(itemId);
            end
        end
    else
        local v = gridContainer.controlList[0]
        if (self.mUnitDic[v] == nil) then
            self.mUnitDic[v] = templatemanager.GetNewTemplate(v, luaComponentTemplates.UIFastItemUseUnitTemplate, self.mUIMainSkillPanel)
        end
        self.mUnitDic[v]:ShowUnit(0);
    end


    --local index = 0;
    --for k,v in pairs(showList) do
    --    index = index + 1;
    --end
end

function UIFastItemUseViewTemplate:GetShowItemCount()
    return self:GetUnitGridContainer().MaxCount;
end

--endregion

--region Private

function UIFastItemUseViewTemplate:InitEvents()
    self.CallOnResUseItemMessage = function(msgId, msgData)
        self:OnResUseItemMessage(msgId, msgData);
    end
end

function UIFastItemUseViewTemplate:OnEnable()
    self:BindEvents()
end

function UIFastItemUseViewTemplate:OnDisable()
    self:RemoveEvents()
end

function UIFastItemUseViewTemplate:BindEvents()
    self.mUIMainSkillPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUseItemMessage, self.CallOnResUseItemMessage)
end

function UIFastItemUseViewTemplate:RemoveEvents()
    self.mUIMainSkillPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResUseItemMessage, self.CallOnResUseItemMessage)
end

function UIFastItemUseViewTemplate:Clear()
    self.mUnitGridContainer = nil;
    self.mUnitDic = nil;
end

--endregion

--endregion

---@param UIMainSkillPanel UIMainSkillPanel
function UIFastItemUseViewTemplate:Init(UIMainSkillPanel)
    self.mUIMainSkillPanel = UIMainSkillPanel
    self:InitEvents()
end

function UIFastItemUseViewTemplate:Show()

end

function UIFastItemUseViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

---血量变化刷新药品特效显示（低血量显示特效）
function UIFastItemUseViewTemplate:RefreshEffectShowByBlood(isShow, type)
    if self.mUnitDic then
        for k, v in pairs(self.mUnitDic) do
            if v.ShowMedicineEffect then
                v:ShowMedicineEffect(isShow, type)
            end
        end
    end
end

function UIFastItemUseViewTemplate:RefreshShowZhaoHuanLingEffect(isShow)
    if self.mUnitDic then
        for k, v in pairs(self.mUnitDic) do
            v:ShowZhaoHuanLingEffect(isShow)
        end
    end
end

function UIFastItemUseViewTemplate:RefreshRandomStoneEffect(isShow)
    if (self.mUnitDic ~= nil) then
        for k, v in pairs(self.mUnitDic) do
            if v.ShowRandomStoneEffect ~= nil then
                v:ShowRandomStoneEffect(isShow)
            end
        end
    end
end

return UIFastItemUseViewTemplate;