---@class UIBossUnit:luacopyobject
local UIBossUnit = {};

setmetatable(UIBossUnit, luaclass.luacopyobject)

UIBossUnit.mBossVOs = nil

function UIBossUnit:GetPrefabGO()
    if self.mOwnerPanel then
        return self.mOwnerPanel:GetCurComp("WidgetRoot/view/scroll/template", "GameObject")
    end
end

function UIBossUnit:GetRootGO()
    return self.go
end

--region Components
function UIBossUnit:AddCompName()
    self.mChooseGO = "choose"
    self.mBossHead = "bossHead"
    self.mRecommend = "recommend"
    self.mName = "name"
    self.mLb_Lv = "lb_lv"
    self.mProgressValue_Text = "ancient"
    self.mBackGround_UISprite = "backGround"
    self.mGoBtnMapGo = "selectMap"
    self.mAllKilled_GameObject = "AllKilled"
    self.mProgressSlider_UISlider = "Slider"
    self.dropListGridContainer = "DropItem"
end

--region GameObject
--[[function UIBossUnit:GetChoose_GameObject()
    if (self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:Get("choose", "GameObject");
    end
    return self.mChoose_GameObject;
end]]

function UIBossUnit:GetBossHead_GameObject()
    --[[    if (self.mBossHead_GameObject == nil) then
            self.mBossHead_GameObject = self:Get("bossHead", "GameObject");
        end
        return self.mBossHead_GameObject;]]
    return self:GetUIComponentController():GetCustomType(self.mBossHead, "GameObject")
end

--[[function UIBossUnit:GetBossRecommend_GameObject()
    if (self.mBossRecommend_GameObject == nil) then
        self.mBossRecommend_GameObject = self:Get("recommend", "GameObject");
    end
    return self.mBossRecommend_GameObject;
end]]
--endregion

--region UILabel
--[[
function UIBossUnit:GetBossName_Text()
    if (self.mBossName_Text == nil) then
        self.mBossName_Text = self:Get("name", "UILabel");
    end
    return self.mBossName_Text;
end

function UIBossUnit:GetBossLevel_Text()
    if (self.mBossLevel_Text == nil) then
        self.mBossLevel_Text = self:Get("lb_lv", "UILabel");
    end
    return self.mBossLevel_Text;
end


function UIBossUnit:GetBossDetails_Text()
    if (self.mBossDetails_Text == nil) then
        self.mBossDetails_Text = self:Get("lb", "UILabel");
    end
    return self.mBossDetails_Text;
end
--]]
function UIBossUnit:GetDropList_UIGridContainer()
    --[[    if (self.dropListGridContainer == nil) then
            self.dropListGridContainer = self:Get("DropItem", "UIGridContainer")
        end
        return self.dropListGridContainer]]
    return self:GetUIComponentController():GetCustomType("DropItem", "UIGridContainer")
end
function UIBossUnit:GetDropList_TiledBg()
    if (self.dropListTiledBg == nil) and not CS.StaticUtility.IsNull(self:GetDropList_UIGridContainer()) then
        --self.dropListTiledBg = self:Get("DropItem/tiledbg", "Top_UITiledSprite")
        self.dropListTiledBg = CS.Utility_Lua.Get(self:GetDropList_UIGridContainer().gameObject.transform, "tiledbg", "Top_UITiledSprite")
    end
    return self.dropListTiledBg
end
function UIBossUnit:GetDropList_TiledItem()
    if (self.dropListTiledItem == nil) then
        --self.dropListTiledItem = self:Get("DropItem/tileditem", "Top_UITiledSameAtlasSprite")
        self.dropListTiledItem = CS.Utility_Lua.Get(self:GetDropList_UIGridContainer().gameObject.transform, "tileditem", "Top_UITiledSameAtlasSprite")
    end
    return self.dropListTiledItem
end
--[[
function UIBossUnit:GetProgressValue_Text()
    if (self.mProgressValue_Text == nil) then
        self.mProgressValue_Text = self:Get("ancient", "UILabel");
    end
    return self.mProgressValue_Text;
end
--]]

function UIBossUnit:GetSliderValue_Text()
    if (self.mSliderValue_Text == nil) then
        self.mSliderValue_Text = self:Get("Slider/num", "UILabel");
    end
    return self.mSliderValue_Text;
end
--endregion

--region UISprite

function UIBossUnit:GetBossHeadIcon_UISprite()
    if (self.mBossHeadIcon_UISprite == nil and self:GetBossHead_GameObject()) then
        --self.mBossHeadIcon_UISprite = self:Get("bossHead/headIcon", "UISprite");
        self.mBossHeadIcon_UISprite = CS.Utility_Lua.Get(self:GetBossHead_GameObject().transform, "headIcon", "UISprite")
    end
    return self.mBossHeadIcon_UISprite;
end

function UIBossUnit:GetBossHeadIconmb_UISprite()
    if (self.mBossHeadIcon_UISpritemb == nil) then
        -- self.mBossHeadIcon_UISpritemb = self:Get("bossHead/headIcon (1)", "UISprite");
        self.mBossHeadIcon_UISpritemb = CS.Utility_Lua.Get(self:GetBossHead_GameObject().transform, "headIcon (1)", "UISprite")
    end
    return self.mBossHeadIcon_UISpritemb;
end

--[[
function UIBossUnit:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("backGround", "UISprite");
    end
    return self.mBackGround_UISprite;
end
--]]
--endregion

function UIBossUnit:GetGoBtnMap_GameObject()
    --[[    if (self.mGoBtnMapGo == nil) then
            self.mGoBtnMapGo = self:Get("selectMap", "GameObject");
        end
        return self.mGoBtnMapGo;]]
    return self:GetUIComponentController():GetCustomType(self.mGoBtnMapGo, "GameObject")
end

--[[
function UIBossUnit:GetAllKilled_GameObject()
    if (self.mAllKilled_GameObject == nil) then
        self.mAllKilled_GameObject = self:Get("AllKilled", "GameObject");
    end
    return self.mAllKilled_GameObject;
end

---已刷新文本(或者击杀进度文本)
---@return UILabel
function UIBossUnit:GetAllKilled_Label()
    if self.mAllKilled_Label == nil then
        self.mAllKilled_Label = self:Get("AllKilled", "UILabel")
    end
    return self.mAllKilled_Label
end
--]]

---@return UIGoMapBtnView
function UIBossUnit:GetGoBtnMapViewTemplate()
    if (self.mGoBtnMapViewTemplate == nil) and self:GetGoBtnMap_GameObject() and not CS.StaticUtility.IsNull(self:GetGoBtnMap_GameObject()) then
        self.mGoBtnMapViewTemplate = luaclass.UIGoMapBtnView:NewWithGO(self:GetGoBtnMap_GameObject())
        --self.mGoBtnMapViewTemplate = templatemanager.GetNewTemplate(self:Get("selectMap", "GameObject"), luaComponentTemplates.UIGoMapBtnViewTemplate);
    end
    return self.mGoBtnMapViewTemplate;
end
--[[
function UIBossUnit:GetProgressSlider_UISlider()
    if (self.ProgressSlider_UISlider == nil) then
        self.mProgressSlider_UISlider = self:Get("Slider", "UISlider");
    end
    return self.mProgressSlider_UISlider;

end]]

--endregion

--region CallFunction
function UIBossUnit:OnBtnClickBossHead()
    --luaDebug.Log("点击怪物头像")
    --uimanager:CreatePanel("UIBossPreviewPanel",nil, self.mBossVOs)
end

--endregion

--region Method

---@public
---@param bossVo table
---@param index number 索引
function UIBossUnit:ShowWithData(bossVos, index, isContains)
    self.isAllKilled = true
    self.mBossVOs = bossVos;
    --[[    if (self:GetChoose_GameObject().activeSelf) then
            self:GetChoose_GameObject():SetActive(false);
        end]]
    self:GetUIComponentController():SetObjectActive(self.mChooseGO, false)

    --self:GetGoBtnMap_GameObject():SetActive(true);
    self:GetUIComponentController():SetObjectActive(self.mGoBtnMapGo, true)

    --self:GetAllKilled_GameObject():SetActive(false)
    self:GetUIComponentController():SetObjectActive(self.mAllKilled_GameObject, false)

    if (self.mBossVOs.Count > 0) then
        local isGetValue, tableValue = CS.Cfg_MonsterTableManager.Instance:TryGetValue(self.mBossVOs[0].configId);
        if (isGetValue and tableValue) then
            --[[            if CS.StaticUtility.IsNull(self:GetBossName_Text()) == false then
                            self:GetBossName_Text().text = tableValue.name;
                        end]]
            self:GetUIComponentController():SetLabelContent(self.mName, tableValue.name)
            if not CS.StaticUtility.IsNull(self:GetBossHeadIcon_UISprite()) then
                self:GetBossHeadIcon_UISprite().spriteName = tableValue.head;
            end

            ---转生等级大于0时，显示转生等级，否则显示等级
            if tableValue.reinLv > 0 then
                --self:GetBossLevel_Text().text = tostring(tableValue.reinLv) .. "转"
                self:GetUIComponentController():SetLabelContent(self.mLb_Lv, tostring(tableValue.reinLv) .. "转")
            else
                -- self:GetBossLevel_Text().text = tableValue.showLevel
                self:GetUIComponentController():SetLabelContent(self.mLb_Lv, tableValue.showLevel)
            end
        end
        --[[        local bgSprite = self:GetBackGround_UISprite()
                if index % 2 == 1 then
                    bgSprite.spriteName = 'bo6'
                elseif index % 2 == 0 then
                    bgSprite.spriteName = ''
                end]]
        local spriteName = index % 2 == 1 and 'bo6' or ''
        self:GetUIComponentController():SetSpriteName(self.mBackGround_UISprite, spriteName)

        local bossType = self.mBossVOs[0].type
        -- if (isFind) then
        --self:GetBossDetails_Text().text = '' --CS.Cfg_BossTableManager.Instance:GetDropTips(self.mBossVOs[0]);
        self:ShowDropItemList(self.mBossVOs[0].configId);
        -- end
        if not CS.StaticUtility.IsNull(self:GetBossHeadIconmb_UISprite()) then
            if bossType == LuaEnumBossType.WorldBoss or bossType == LuaEnumBossType.FinalBoss then
                self:GetBossHeadIconmb_UISprite().spriteName = 'g3'
            elseif bossType == LuaEnumBossType.EliteBoss then
                self:GetBossHeadIconmb_UISprite().spriteName = 'g2'
            end
        end
        ---boss刷新时间
        local isGray = true;
        local ancientBossMapID
        for i = 0, self.mBossVOs.Count - 1 do
            if (self.mBossVOs[i].freshTime <= 0 and self.mBossVOs[i].id ~= 0) then
                isGray = false;
                self.isAllKilled = false
                if self.mBossVOs[i].mapId ~= nil then
                    ancientBossMapID = self.mBossVOs[i].mapId
                end
            end
        end

        --if (self.isAllKilled) then
        --    self:GetGoBtnMap_GameObject():SetActive(false)
        --    self:GetAllKilled_GameObject():SetActive(true)
        --else
        --    self:GetGoBtnMap_GameObject():SetActive(true)
        --self:GetAllKilled_GameObject():SetActive(false)
        --end
        -- self:GetBackGround_UISprite().color = isGray and CS.UnityEngine.Color.gray or CS.UnityEngine.Color.white;
        local color = isGray and CS.UnityEngine.Color.gray or CS.UnityEngine.Color.white;
        self:GetUIComponentController():SetSpriteColor(self.mBackGround_UISprite, color)
        --region 远古BOSS
        --self:GetProgressSlider_UISlider().gameObject:SetActive(bossType == LuaEnumBossType.AncientBoss);
        --self:GetProgressSlider_UISlider().gameObject:SetActive(false)
        self:GetUIComponentController():SetObjectActive(self.mProgressSlider_UISlider, false)
        --self:GetProgressValue_Text().gameObject:SetActive(bossType == LuaEnumBossType.AncientBoss);
        --self:GetProgressValue_Text().gameObject:SetActive(false);
        self:GetUIComponentController():SetObjectActive(self.mProgressValue_Text, false)
        if (bossType == LuaEnumBossType.FinalBoss) then
            local maxValue = 0;
            ---@type TABLE.CFG_ANCIENT_BOSS
            local ancientBossTable
            ___, ancientBossTable = CS.Cfg_AncientBossTableManager.Instance:TryGetValue(self.mBossVOs[0].configId);
            local needMonsterName = ""
            if ancientBossTable ~= nil then
                maxValue = ancientBossTable.num;
                --self:GetProgressValue_Text().text = ancientBossTable.tips;
                if ancientBossTable.need ~= nil and ancientBossTable.need.list.Count > 0 then
                    ---暂时只取第1个
                    ---@type TABLE.CFG_MONSTERS
                    local monsterTblTemp
                    ___, monsterTblTemp = CS.Cfg_MonsterTableManager.Instance:TryGetValue(ancientBossTable.need.list[0])
                    if monsterTblTemp ~= nil then
                        needMonsterName = monsterTblTemp.name
                    end
                end
            end
            local showCount = not self.isAllKilled and maxValue or self.mBossVOs[0].killCount;
            --self:GetProgressSlider_UISlider().value = showCount / maxValue;
            --self:GetSliderValue_Text().text = showCount .. "/" .. maxValue;
            if showCount >= maxValue and ancientBossMapID ~= nil then
                local mapName = "";
                if ancientBossMapID ~= nil then
                    ---@type TABLE.CFG_MAP
                    local mapTbl
                    ___, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(ancientBossMapID)
                    if mapTbl ~= nil then
                        mapName = mapTbl.name
                    end
                end
                --self:GetAllKilled_Label().text = "[00ff00]出现在" .. mapName .. "[-]"
                local lb = "[00ff00]出现在" .. mapName .. "[-]"
                self:GetUIComponentController():SetLabelContent(self.mAllKilled_GameObject, lb)
                -- self:GetAllKilled_GameObject():SetActive(true)
                self:GetUIComponentController():SetObjectActive(self.mAllKilled_GameObject, true)
            else
                -- self:GetAllKilled_Label().text = "[dde6eb]击杀 [e85038]" .. tostring(showCount) .. "[-]/" .. tostring(maxValue) .. "只 " .. needMonsterName .. "[-]"
                local lb = "[dde6eb]击杀 [e85038]" .. tostring(showCount) .. "[-]/" .. tostring(maxValue) .. "只 " .. needMonsterName .. "[-]"
                self:GetUIComponentController():SetLabelContent(self.mAllKilled_GameObject, lb)
                -- self:GetAllKilled_GameObject():SetActive(true)
                self:GetUIComponentController():SetObjectActive(self.mAllKilled_GameObject, true)
            end
        else
            ---非远古boss显示未刷新
            -- self:GetAllKilled_Label().text = "未刷新"
            self:GetUIComponentController():SetLabelContent(self.mAllKilled_GameObject, "未刷新")
        end
        --endregion

        if (bossType ~= LuaEnumBossType.FinalBoss) then
            -- self:GetBossRecommend_GameObject():SetActive(isContains);
            self:GetUIComponentController():SetObjectActive(self.mRecommend, isContains)
        else
            -- self:GetBossRecommend_GameObject():SetActive(false);
            self:GetUIComponentController():SetObjectActive(self.mRecommend, false)
        end

        --region 设置跳转地图按钮
        -- if (self:GetGoBtnMap_GameObject().activeSelf) then
        if bossType ~= LuaEnumBossType.FinalBoss then
            self:SetGoMapButton();
        else
            ---远古boss隐藏按钮
            --self:GetGoBtnMap_GameObject():SetActive(false);
            self:GetUIComponentController():SetObjectActive(self.mGoBtnMapGo, false)
        end
        -- end
        --endregion
    end
    self:GetUIComponentController():Apply()
end
function UIBossUnit:ShowDropItemList(bossId)
    --[[    if (self:GetDropList_UIGridContainer().gameObject.activeSelf == false) then
            self:GetDropList_UIGridContainer().gameObject:SetActive(true)
        end]]
    self:GetUIComponentController():SetObjectActive(self.dropListGridContainer, true)
    local list = Utility.GetBossPanelDropList(bossId)
    if (list == nil) then
        return
    end
    local dic = CS.Cfg_ItemsTableManager.Instance
    local num = #list <= 9 and #list or 9
    if self:GetDropList_UIGridContainer() and CS.StaticUtility.IsNull(self:GetDropList_UIGridContainer()) == false then
        self:GetDropList_TiledBg().count_x = num
        self:GetDropList_TiledItem().MaxCount = num
        for k, v in pairs(list) do
            if (k - 1 <= 8) then
                local infobool, iteminfo = dic:TryGetValue(v)
                self:GetDropList_TiledItem():SetSpriteName(k-1,iteminfo.icon)
                self:GetDropList_TiledItem():SetOnClick(k-1,function(index,indexX,indexY)
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = iteminfo, nil, showRight = false })
                end)
            end
        end
        self:GetDropList_TiledItem():Apply()

        --self:GetDropList_UIGridContainer().MaxCount = num
        --for k, v in pairs(list) do
        --    if (k - 1 > 8) then
        --        return
        --    end
        --    local infobool, iteminfo = dic:TryGetValue(v)
        --
        --    local go = self:GetDropList_UIGridContainer().controlList[k - 1]
        --    if infobool then
        --        local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
        --        temp:RefreshUIWithItemInfo(iteminfo, 1)
        --        CS.UIEventListener.Get(go.gameObject).onClick = function(go)
        --            if temp.ItemInfo ~= nil then
        --                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, nil, showRight = false })
        --            end
        --        end
        --
        --    end
        --end
    end
end
function UIBossUnit:GetCustomData()
    return self.mBossVOs;
end

function UIBossUnit:CreatBossInfoTips(id, type)

    if id ~= nil and type ~= nil then
        local lv
        local color

        local isGetValue, tableValue = CS.Cfg_MonsterTableManager.Instance:TryGetValue(id);
        if isGetValue then
            lv = tableValue.level;
        end

        if type == LuaEnumBossType.WorldBoss or type == LuaEnumBossType.FinalBoss or type == LuaEnumBossType.WanderBoss then
            color = CS.UnityEngine.Color(1, 0, 0)
        elseif type == LuaEnumBossType.EliteBoss then
            --color = CS.UnityEngine.Color(119.0 / 255.0, 136.0 / 255.0, 255.0 / 255.0)
            color = CS.UnityEngine.Color(1, 0, 1)
        end
        if lv ~= nil and color ~= nil then
            local customData = {};
            customData.id = id;
            customData.level = lv
            customData.color = color;
            uimanager:CreatePanel("UIBossinfoPanel", function(panel)
                --判断界限
                self:SetTipsPos(panel)
            end, customData)
        end
    end

end

function UIBossUnit:SetTipsPos(panel)
    --判断y
    local bossPanel = uimanager:GetPanel('UIBossPanel')
    if panel and bossPanel then
        local scroll = bossPanel:GetCurComp("WidgetRoot/view/scroll", "UIPanel")
        local bg = panel:GetCurComp("WidgetRoot/window/background", "UISprite")
        if bg == nil or scroll == nil then
            return
        end
        --暂时写法
        --最高点y
        local heightLocalPosy = 260
        --最低点y
        local lowLocalPointy = -260

        --tips背景高度
        local bghight = bg.height
        local Unitpos = self.go.transform:Find('point').position
        panel.go.transform.position = CS.UnityEngine.Vector3(Unitpos.x, Unitpos.y, 0)

        local tipsLocalpos = panel.go.transform.localPosition
        local meetpoint = tipsLocalpos.y - bghight

        local y = tipsLocalpos.y > heightLocalPosy and heightLocalPosy or meetpoint < lowLocalPointy and lowLocalPointy + bghight or tipsLocalpos.y
        panel.go.transform.localPosition = CS.UnityEngine.Vector3(tipsLocalpos.x, y, 0)
        local type = meetpoint < lowLocalPointy and 2 or 1
        panel.ChangeProcessType(type)
    end
end

function UIBossUnit:SetGoMapButton()
    if (self.mBossVOs == nil) then
        return ;
    end

    if (self.mBossVOs.Count <= 0) then
        return ;
    end
    self:GetGoBtnMapViewTemplate().go:SetActive(false);

    local mapIds = {};
    local deliverIds = {};
    local freshTimes = {};
    local orders = {}
    local count = self.mBossVOs.Count;

    for i = 0, self.mBossVOs.Count - 1 do
        if (self.mBossVOs[i].type == LuaEnumBossType.FinalBoss) then
            --table.insert(mapIds, self.mBossVOs[i].mapId);
            --local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(self.mBossVOs[i].mapId);
            --if (isFind) then
            --    table.insert(deliverIds, mapTable.announceDeliver);
            --end
            --table.insert(orders, i + 1);
        else
            local isFind, bossTable = CS.Cfg_BossTableManager.Instance:TryGetValue(self.mBossVOs[i].id);
            if (isFind) then
                table.insert(mapIds, bossTable.mapId);
                table.insert(deliverIds, bossTable.deliverId);
                table.insert(orders, bossTable.order);
            end
        end
        table.insert(freshTimes, self.mBossVOs[i].freshTime);
    end
    --region 挑战状态排序
    local SortValue = {
        canChallenge = 1,
        notChallenge = 2
    }

    local sortData = {};
    sortData[SortValue.canChallenge] = {};
    sortData[SortValue.notChallenge] = {};

    for i = 0, count - 1, 1 do
        local data = {};
        data.parent = self;
        data.freshTime = freshTimes[i + 1];
        data.mapId = mapIds[i + 1];
        data.deliverId = deliverIds[i + 1];
        data.type = self.mBossVOs[0].type;
        data.order = orders[i + 1]
        data.bossVo = self.mBossVOs[i]
        if (freshTimes[i + 1] <= 0) then
            table.insert(sortData[SortValue.canChallenge], data)
        else
            table.insert(sortData[SortValue.notChallenge], data)
        end
    end

    table.sort(sortData[SortValue.canChallenge], function(a, b)
        if a.order ~= b.order then
            return a.order < b.order
            --return tonumber(a.order) < tonumber(b.order)
        end
    end)
    table.sort(sortData[SortValue.notChallenge], function(a, b)
        if a.order ~= b.order then
            return a.order < b.order
            --return tonumber(a.order) < tonumber(b.order)
        end
    end)
    --endregion
    self:GetGoBtnMapViewTemplate():ShowBtnWithMapIds(sortData, count > 3 and 3 or count);
    self:GetGoBtnMapViewTemplate().go:SetActive(true);
end

function UIBossUnit:IsChoose(targetMonsterId)
    if (self.mBossVOs ~= nil and self.mBossVOs.Count > 0) then
        local isChoose = self.mBossVOs[0].configId == targetMonsterId;
        --[[        if (isChoose) then
                    if (not self:GetChoose_GameObject().activeSelf) then
                        self:GetChoose_GameObject():SetActive(isChoose);
                    end
                else
                    if (self:GetChoose_GameObject().activeSelf) then
                        self:GetChoose_GameObject():SetActive(isChoose);
                    end
                end]]
        self:GetUIComponentController():SetObjectActiveImmediately(self.mChooseGO, isChoose)
        return isChoose;
    end
    return false;
end

function UIBossUnit:InitEvents()
    if self:GetBossHead_GameObject() and CS.StaticUtility.IsNull(self:GetBossHead_GameObject() == false) then
        CS.UIEventListener.Get(self:GetBossHead_GameObject()).onClick = function()
            if (self.mBossVOs ~= nil and self.mBossVOs.Count > 0) then
                local bossVo = self.mBossVOs[0];
                self:CreatBossInfoTips(bossVo.configId, bossVo.type);
            end
        end;
    end
end

function UIBossUnit:Clear()
    self.mBtnGo_GameObject = nil;
    self.mChoose_GameObject = nil;
    self.mBossHead_GameObject = nil
    self.mBossName_Text = nil
    self.mBossLevel_Text = nil
    self.mBossDetails_Text = nil
    self.mProgressValue_Text = nil
    self.mSliderValue_Text = nil
    self.mBossHeadIcon_UISprite = nil
    self.mBossHeadIcon_UISpritemb = nil
    self.mBackGround_UISprite = nil
    self.mGoBtnMapGo = nil
    self.mAllKilled_GameObject = nil
    self.mGoBtnMapViewTemplate = nil
    self.ProgressSlider_UISlider = nil

end
--endregion

---@param panel UIBossView
function UIBossUnit:Init(panel)
    self:AddCompName()
    self.mRootPanel = panel
    self.mOwnerPanel = panel.mOwnerPanel
    --luaDebug.LogError("UIBossUnit Init")
    self:InitEvents();
end

function UIBossUnit:OnDestruct()
    self:Clear();
    --luaDebug.Log("UIBossUnit OnDestruct")
end

return UIBossUnit;