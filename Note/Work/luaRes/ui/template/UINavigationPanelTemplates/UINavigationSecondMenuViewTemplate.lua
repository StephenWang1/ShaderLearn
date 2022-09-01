---导航栏二级菜单
---@class UINavigationSecondMenuViewTemplate:TemplateBase
local UINavigationSecondMenuViewTemplate = {};

UINavigationSecondMenuViewTemplate.mLayerTableList = nil;

---@type table<UINavigationUnitListTemplate>
UINavigationSecondMenuViewTemplate.mUnitListDic = nil;

UINavigationSecondMenuViewTemplate.mUnitListFadeInCallBack = nil;

UINavigationSecondMenuViewTemplate.mIsCallBacked = false;

UINavigationSecondMenuViewTemplate.mOwnerId = 0;

---是否有跳转对象
UINavigationSecondMenuViewTemplate.mTargetId = nil;

--region Component

function UINavigationSecondMenuViewTemplate:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("bg", "UISprite");
    end
    return self.mBackGround_UISprite;
end

function UINavigationSecondMenuViewTemplate:GetUnitListGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("Grid", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end
--endregion

--region Method

--region Public

function UINavigationSecondMenuViewTemplate:SelectTarget()
    if (self.mUnitListDic ~= nil) then
        for k, v in pairs(self.mUnitListDic) do
            ---@param v UINavigationUnitListTemplate
            if (v:TrySelect(self.mTargetId)) then
                break ;
            end
        end
    end
    self.mTargetId = nil;
end

function UINavigationSecondMenuViewTemplate:SelectDefault()
    if (self.mOwnerId == luaEnumNavigationType.Furnace) then
        --local selectId = self:GetSelectFurnaceNavId();
        local selectId = luaEnumNavigationType.Recast
        for k, v in pairs(self.mGobjList) do
            ---@type UINavigationUnitListTemplate
            local temp = self.mUnitListDic[v];
            if(temp ~= nil) then
                if (temp:SelectFirst(selectId)) then
                    break ;
                end
            end
        end
    elseif self.mOwnerId == luaEnumNavigationType.Forge then
        local selectId = self:GetSelectForgeNavId();
        for k, v in pairs(self.mGobjList) do
            ---@type UINavigationUnitListTemplate
            local temp = self.mUnitListDic[v];
            if(temp ~= nil) then
                if (temp:TrySelect(selectId)) then
                    break ;
                end
            end
        end
    else
        local gobj = self.mGobjList[1];
        local temp = self.mUnitListDic[gobj];
        if (temp ~= nil) then
            temp:SelectDefault();
        end
    end
end

--region 神炉根据红点默认选择打开哪个页切
function UINavigationSecondMenuViewTemplate:GetSelectFurnaceNavId()
    local redKey = CS.RedPointKey.FURNACE_CHYANLAMP;
    local hasRedChyanLamp = CS.CSUIRedPointManager:GetInstance():GetRedPointValue(CS.RedPointKey.FURNACE_CHYANLAMP);
    if (not hasRedChyanLamp) then
        local hasRedSoulBead = CS.CSUIRedPointManager:GetInstance():GetRedPointValue(CS.RedPointKey.FURNACE_SOULBEAD);
        if (hasRedSoulBead) then
            redKey = CS.RedPointKey.FURNACE_SOULBEAD;
        else
            local hasRedGem = CS.CSUIRedPointManager:GetInstance():GetRedPointValue(CS.RedPointKey.FURNACE_GEM);
            if (hasRedGem) then
                redKey = CS.RedPointKey.FURNACE_GEM;
            else
                local hasRedTheSourceOfAttack = CS.CSUIRedPointManager:GetInstance():GetRedPointValue(CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK);
                if (hasRedTheSourceOfAttack) then
                    redKey = CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK;
                else
                    local hasRedTheSourceOfDefense = CS.CSUIRedPointManager:GetInstance():GetRedPointValue(CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE);
                    if (hasRedTheSourceOfDefense) then
                        redKey = CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE;
                    end
                end
            end
        end
    end

    if (redKey == CS.RedPointKey.FURNACE_CHYANLAMP) then
        return luaEnumNavigationType.ChyanLamp;
    elseif (redKey == CS.RedPointKey.FURNACE_SOULBEAD) then
        return luaEnumNavigationType.SoulBead;
    elseif (redKey == CS.RedPointKey.FURNACE_GEM) then
        return luaEnumNavigationType.Gem;
    elseif (redKey == CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK) then
        return luaEnumNavigationType.TheSourceOfAttack;
    elseif (redKey == CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE) then
        return luaEnumNavigationType.TheSourceOfDefense;
    end
    return luaEnumNavigationType.ChyanLamp;
end
--endregion

--region 锻造根据红点默认选择打开那个页签
---如果打开锻造页签,则根据红点决定打开哪个页签,若没有红点则打开炼化
---@return 导航栏id枚举
function UINavigationSecondMenuViewTemplate:GetSelectForgeNavId()
    local redPointMgr = CS.CSUIRedPointManager:GetInstance()
    if redPointMgr:GetRedPointValue(CS.RedPointKey.Refine_HasRefineEquip) then
        ---炼化
        return luaEnumNavigationType.Refine
    elseif redPointMgr:GetRedPointValue(CS.RedPointKey.Element) then
        ---元素
        return luaEnumNavigationType.Element
    elseif redPointMgr:GetRedPointValue(CS.RedPointKey.Signet) then
        ---印记
        return luaEnumNavigationType.Signet
    elseif
    --redPointMgr:GetRedPointValue(CS.RedPointKey.Synthesis_HasRolePanelRedPoint)
    --or redPointMgr:GetRedPointValue(CS.RedPointKey.Synthesis_HasSynthesis)
    --or redPointMgr:GetRedPointValue(CS.RedPointKey.Synthesis_HasServantPanelRedPoint)
    --or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM))
    --or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX))
    --or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC))
    redPointMgr:GetRedPointValue(gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetAllPageButtonRedPointKey())
            or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement))
            or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet))
            or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM_MagicWeapon))
            or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX_MagicWeapon))
            or redPointMgr:GetRedPointValue(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC_MagicWeapon))
    then
        ---合成
        return luaEnumNavigationType.Synthesis
    end
    return nil
    ---默认取星级
    --return luaEnumNavigationType.StarLevel
end
--endregion

function UINavigationSecondMenuViewTemplate:GetButtonByNavId(navId)
    if (self.mUnitListDic ~= nil) then
        for k0, v0 in pairs(self.mUnitListDic) do
            for k1, v1 in pairs(v0.mUnitDic) do
                if (v1.mTableInfo.ID == navId) then
                    return v1;
                end
            end
        end
    end
    return nil;
end

function UINavigationSecondMenuViewTemplate:OnFadeInFinished()
    if (self.mLayerTableList == nil) then
        return ;
    end

    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        local temp = self.mUnitListDic[gobj];
        if(temp ~= nil) then
            temp:OnFadeInFinished();
        end
    end
end

function UINavigationSecondMenuViewTemplate:OnFadeOutFinished()
    if (self.mLayerTableList == nil) then
        return ;
    end

    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        local temp = self.mUnitListDic[gobj];
        if(temp ~= nil) then
            temp:OnFadeOutFinished();
        end
    end
end

function UINavigationSecondMenuViewTemplate:PlayUnitListFadeIn(mTargetId, callBack)
    self.mTargetId = mTargetId;
    if (callBack ~= nil) then
        self.mUnitListFadeInCallBack = callBack;
    end

    if (self.mCoroutineFadeIn ~= nil) then
        StopCoroutine(self.mCoroutineFadeIn);
        self.mCoroutineFadeIn = nil;
    end
    self.mCoroutineFadeIn = StartCoroutine(self.IEnumUnitListFadeIn, self);
end

--endregion

--region Private

function UINavigationSecondMenuViewTemplate:Initialize(tableList, ownerId)
    if(self.mUnitListDic == nil) then
        self.mUnitListDic = {};
    end
    self.mGobjList = {};
    self.mOwnerId = ownerId;
    self.mLayerTableList = CS.Cfg_NavigationTableManager.Instance:SplitList(tableList, 1);
    local gridContainer = self:GetUnitListGridContainer();
    gridContainer.MaxCount = self.mLayerTableList.Count;

    local gridIndex = 0
    for i = 0, self.mLayerTableList.Count - 1 do
        local gobj = gridContainer.controlList[gridIndex];
        table.insert(self.mGobjList, gobj);
        if (self.mUnitListDic[gobj] == nil) then
            local templateTemp = self:GetTemplateByGameObject(gobj)
            self.mUnitListDic[gobj] = templateTemp
        end
        ---@type UINavigationUnitListTemplate
        local temp = self.mUnitListDic[gobj]
        --temp:ShowButtons(self.mLayerTableList[i]);

        ---3级页签按钮所属是否存在4级页签/或者说是否能打开面板
        if (temp:ShowButtons(self.mLayerTableList[i]) == false) then
            gridContainer.MaxCount = gridContainer.MaxCount - 1
        else
            gridIndex = gridIndex + 1
        end
    end

    self:GetBackGround_UISprite().height = gridContainer.MaxCount * gridContainer.CellHeight + 10;
end

---@param go UnityEngine.GameObject
---@return UINavigationUnitListTemplate
function UINavigationSecondMenuViewTemplate:GetTemplateByGameObject(go)
    if self.mGoToTemplates == nil then
        self.mGoToTemplates = {}
    end
    if self.mGoToTemplates[go] == nil then
        self.mGoToTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UINavigationUnitListTemplate)
    end
    return self.mGoToTemplates[go]
end

function UINavigationSecondMenuViewTemplate:IEnumUnitListFadeIn()
    local callBackCount = 0
    self.mIsCallBacked = false;
    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        local temp = self.mUnitListDic[gobj];
        if(temp ~= nil) then
            temp:PlayUnitListFadeIn(function()
                callBackCount = callBackCount + 1;
                if (callBackCount >= self.mLayerTableList.Count) then
                    if (not self.mIsCallBacked) then
                        self.mIsCallBacked = true;
                        if (self.mUnitListFadeInCallBack ~= nil) then
                            self.mUnitListFadeInCallBack();
                        end
                    end
                end
            end);
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.05));
    end

    if (self.mTargetId ~= nil) then
        self:SelectTarget();
    else
        self:SelectDefault();
    end

    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));

    if (not self.mIsCallBacked) then
        self.mIsCallBacked = true;
        if (self.mUnitListFadeInCallBack ~= nil) then
            self.mUnitListFadeInCallBack();
        end
    end
end

function UINavigationSecondMenuViewTemplate:InitEvents()

end

function UINavigationSecondMenuViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UINavigationSecondMenuViewTemplate:Init()
    self:InitEvents();
end

function UINavigationSecondMenuViewTemplate:OnDestroy()
    self:RemoveEvents();

    if (self.mCoroutineFadeIn ~= nil) then
        StopCoroutine(self.mCoroutineFadeIn);
        self.mCoroutineFadeIn = nil;
    end
end

return UINavigationSecondMenuViewTemplate;