---@class UISkillInfoTemplate
local UISkillInfoTemplate = {}

function UISkillInfoTemplate:InitComponents()

    self.basePanel = CS.Utility_Lua.GetComponent(self.go, "Top_UIPanel")
    self.skillInfo_UIPanel = self:Get("skillInfo", "UIPanel")
    self.infoPanelBG = self:Get("bg", "Top_UISprite")
    self.infoPanelBGWidget = self:Get("bg", "UIWidget");
    ---当前技能节点
    self.currentSkill = self:Get("skillInfo/tableRoot/currentSkill", "GameObject")
    ---当前等级
    self.skillLevel = self:Get("skillInfo/tableRoot/currentSkill/skillLevel", "Top_UILabel")
    ---技能说明
    self.skillDescription = self:Get("skillInfo/tableRoot/currentSkill/skillDescription", "Top_UILabel")
    ---自动释放
    self.AutoSkill = self:Get("AutoSkill", "Top_UIToggle")
    self.AutoSkill_bg = self:Get("AutoSkill/Sprite", "Top_UISprite")
    self.AutoSkill_thumb = self:Get("AutoSkill/thumb", "GameObject")

    ---技能等级_下一等级
    self.skillLevel_next = self:Get("skillInfo/tableRoot/nextSkill/skillLevel", "Top_UILabel")
    ---技能描述_下一等级
    self.skillDescription_next = self:Get("skillInfo/tableRoot/nextSkill/skillDescription", "Top_UILabel")
    ---技能以满级_下一等级
    self.maxLevelTips_next = self:Get("skillInfo/tableRoot/nextSkill/maxLevelTips", "Top_UILabel")
    ---等级需求_下一等级
    self.requireLevel_next = self:Get("skillInfo/tableRoot/nextSkill/upgradeRequire/requireLevel", "Top_UILabel")

    self.mStateLabel = self:Get("skillIcon/stateLabel", "UILabel");

    self.mSkillIcon = self:Get("skillIcon", "UISprite");

    self.mSkillIconMatchNode = self:Get("skillIcon/matchNode", "Transform");

    self.skillName = self:Get("skillName", "UILabel");

    self.mBgSprite = self:Get("bg", "UISprite");

    self.nextSkillWidget = self:Get("nextSkill", "UIWidget");
    ---获取方式节点
    self.GetWay = self:Get("skillInfo/tableRoot/GetWay", "GameObject");
    ---获取方式列表
    self.GetWayItemGrid = self:Get("skillInfo/tableRoot/GetWay/itemGrid", "Top_UIGridContainer");
    ---交易行快捷购买
    ---@type UnityEngine.GameObject
    self.mAuctionBuyRoot = self:Get("skillInfo/tableRoot/AuctionBuy", "GameObject")
    ---交易行快捷购买列表格子
    ---@type UIGridContainer
    self.mAuctionBuyGrids = self:Get("skillInfo/tableRoot/AuctionBuy/auctionItems", "UIGridContainer")
    ---Table
    self.skillInfoUITable = self:Get("skillInfo/tableRoot", "Top_UITable");
    ---ScrollView
    self.skillInfoScrollView = self:Get("skillInfo", "Top_UIScrollView");
    ---@type UILabel 元素属性
    self.mElement = self:Get("element", "UILabel")

    ---强化技能根节点
    self.StrengthenSkillRoot = self:Get("skillInfo/tableRoot/StrengthenSkill", "GameObject");
    ---强化技能Icon
    self.StrengthenSkill_Icon = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/skillIcon", "UISprite");
    ---强化技能描述
    self.StrengthenSkill_Label = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/Label", "UILabel");
    ---强化技能按钮点击查看详情
    self.StrengthenSkill_btn = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/btn", "GameObject");
    ---强化技能按钮点击学习
    self.StrengthenSkill_Btn_Learn = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/Btn_Learn", "GameObject");
    ---强化技能按钮点击升级
    self.StrengthenSkill_Btn_Up = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/Btn_Up", "GameObject");
    ---强化技能按钮使用技能书按钮
    self.StrengthenSkill_UseSkillBookBtn = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/UseSkillBookBtn", "GameObject");
    ---强化技能顶部Icon
    self.intensifySkillIcon = self:Get("intensifySkillIcon", "UISprite");
    ---强化技能底图
    self.Checkmark = self:Get("skillInfo/tableRoot/StrengthenSkill/activityBtnTemplate/Checkmark", "GameObject");
end

function UISkillInfoTemplate:InitOther()
    ---橘黄色---灰色
    self.Orange = '[787878]'
    ---绿色---白色
    self.Green = '[dde6eb]'
    ---淡黄颜色---白色
    self.Yellowish = '[dde6eb]'
    ---白色
    self.White = luaEnumColorType.Gray
    --'[dde6eb]'
    ---红色
    self.Red = '[FF0000]'
    ---空位
    self.BLANK = '   '

    self.nowPos = self.go.transform.position

    CS.UIEventListener.Get(self.AutoSkill.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.AutoSkill.gameObject).OnClickLuaDelegate = self.OnAutoSkill
    CS.UIEventListener.Get(self.StrengthenSkill_btn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.StrengthenSkill_btn.gameObject).OnClickLuaDelegate = self.OnClickStrengthenSkill_btn
    CS.UIEventListener.Get(self.StrengthenSkill_Btn_Learn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.StrengthenSkill_Btn_Learn.gameObject).OnClickLuaDelegate = self.OnClickStrengthenSkill_Btn_Learn
    CS.UIEventListener.Get(self.StrengthenSkill_Btn_Up.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.StrengthenSkill_Btn_Up.gameObject).OnClickLuaDelegate = self.OnClickStrengthenSkill_Btn_Up
    CS.UIEventListener.Get(self.StrengthenSkill_UseSkillBookBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.StrengthenSkill_UseSkillBookBtn.gameObject).OnClickLuaDelegate = self.OnClickStrengthenSkill_UseSkillBookBtn
    CS.UIEventListener.Get(self.Checkmark.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Checkmark.gameObject).OnClickLuaDelegate = self.OnClickStrengthenSkill_btn

    if self.parentPanel ~= nil and self.parentPanel.mOwnerPanel ~= nil then
        self.parentPanel.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResQuickAuctionItemMessage, function(msgId, data)
            ---@type auctionV2.ResQuickAuctionItem
            self.mAuctionItems = data
            self:RefreshUI()
        end)
        self.parentPanel.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyAuctionItemMessage, function(msgID, data)
            ---@type auctionV2.ItemMsg
            local dataTemp = data
            if dataTemp.item ~= nil and self.mTemplateForAuctionGrids ~= nil then
                for i, v in pairs(self.mTemplateForAuctionGrids) do
                    ---@type UIWayGetQuickAuctionBuyTemplate
                    local template = v
                    if template ~= nil and CS.StaticUtility.IsNull(template.go) == false and template.go.activeInHierarchy then
                        if self.mClickedTemplate == template and template.mAuctionItemInfo ~= nil and template.mAuctionItemInfo.item ~= nil and template.mAuctionItemInfo.item.itemId == dataTemp.item.itemId then
                            self.mClickedTemplate = nil
                            template:PlayBuySucceedAnimation(dataTemp)
                            break
                        end
                    end
                end
            end
            self.mAuctionItems = nil
            self:RequestQuickAuctionItems()
        end)
    end
end

---初始化数据
function UISkillInfoTemplate:Init(parentPanel)
    ---@type UISkillInfo_UISkillPanel
    self.parentPanel = parentPanel
    self:InitComponents()
    self:InitOther()
end

---打开面板
function UISkillInfoTemplate:OpenPanel(skillID, go)
    if skillID ~= self.skillID then
        uimanager:ClosePanel("UIStrengthenSkillPanel")
    end
    if skillID == self.skillID and self.go.activeInHierarchy == true then
        self.skillID = nil
        self:ClosePanel()
        return
    else
        self.parentPanel.infoPanelmask.gameObject:SetActive(true)
    end
    self.SelectGo = go
    self.skillID = skillID
    self.mAuctionItems = nil
    self.go:SetActive(true)
    self:GetData(skillID)
    self:RequestQuickAuctionItems()
    self:RefreshUI()
end

---刷新UI数据
function UISkillInfoTemplate:RefreshUI()
    if self.skillID == nil then
        return
    end
    self:GetData(self.skillID)
    self.IsAutoSkill = CS.CSScene.MainPlayerInfo.SkillInfoV2:IsAutoSkillOpen(self.skillID);
    self:SetPanelDepth()
    self:RefreShTopSkillInfo()
    self:RefreshNowSkillInfo()
    self:RefreshNextSkillInfo()
    self:RefreShGetWay()
    self:RefreshIntensifySkill()
    self:AdaptiveSize()
end

---设置面板深度
function UISkillInfoTemplate:SetPanelDepth()
    self.skillInfo_UIPanel.depth = self.basePanel.depth + 1
end

--region 位置适配

---位置适配
function UISkillInfoTemplate:AdaptiveSize()
    self.skillInfoUITable:Reposition()
    self.skillInfoScrollView:ResetPosition()
    local Bounds = CS.NGUIMath.CalculateRelativeWidgetBounds(self.skillInfoUITable.gameObject.transform);
    if Bounds then
        self.maxHeight = 0
        if self.parentPanel ~= nil and self.parentPanel.bg ~= nil then
            self.maxHeight = self.parentPanel.bg.height - 8
        end
        local height = Bounds.size.y + 140
        if height > self.maxHeight and self.maxHeight ~= 0 then
            height = self.maxHeight
        end
        self.infoPanelBG.height = math.ceil(height)
    end
    self:SetPanelPosition()
end

---坐标适配
function UISkillInfoTemplate:SetPanelPosition()
    local topMax = 318
    local downMax = -327
    if self.SelectGo == nil then
        return
    end
    self.nowPos.y = self.SelectGo.transform.position.y
    self.go.transform.position = self.nowPos
    local nowlocalPosition = self.go.transform.localPosition
    nowlocalPosition.y = nowlocalPosition.y + 50
    if nowlocalPosition.y > topMax then
        nowlocalPosition.y = topMax
    end
    if nowlocalPosition.y - self.infoPanelBG.height < downMax then
        nowlocalPosition.y = downMax + self.infoPanelBG.height
    end
    self.go.transform.localPosition = nowlocalPosition
end
--endregion

--region 设置技能数据
---得到技能数据
function UISkillInfoTemplate:GetData(skillID)
    ---服务器技能数据
    self.SkillInfo_Servers = nil
    ---@type TABLE.cfg_skills 当前技能信息
    self.Skill = clientTableManager.cfg_skillsManager:TryGetValue(skillID)
    ---当前技能条件信息
    self.SkillsCondition_Now = nil
    ---下一级技能条件信息
    self.SkillsCondition_Next = nil

    self.SkillInfo_Servers = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic
    self.SkillList = CS.Cfg_SkillTableManager.Instance.SkillList
    ---@type table<number,LuaSkillDetailedInfo>
    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.SkillInfoDic ~= nil then
        ---@type LuaSkillDetailedInfo
        self.NowSkillInfo = self.SkillInfoDic[skillID]
    end

    local skillInfoServers = {};
    if self.SkillInfo_Servers ~= nil then
        CS.Utility_Lua.luaForeachCsharp:Foreach(self.SkillInfo_Servers, function(k, v)
            table.insert(skillInfoServers, v);
        end)
    end

    for i = 1, #skillInfoServers do
        local v = skillInfoServers[i]
        if v.skillId == skillID then
            self.SkillsCondition_Now = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(v.skillId, v.level)
            self.SkillsCondition_Next = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(v.skillId, v.level + 1)
        end
    end
end
--endregion

--region 刷新技能信息（当前、下一级）

---刷新当前技能信息
function UISkillInfoTemplate:RefreshNowSkillInfo()
    if self.SkillsCondition_Now ~= nil then
        local level = self.SkillsCondition_Now.level - 1
        if self.Skill and (self.Skill:GetCls() == 4 or self.Skill:GetCls() == 10) then
            level = level + 1
        end
        self.skillLevel.text = table.concat({ self.White, '当前等级', self.BLANK, self.White, math.max(level, 0), "级" })
        self.skillDescription.text = CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(self.SkillsCondition_Now.id, "[ffe36f]");   --table.concat({ self.Orange, self.White, self.SkillsCondition_Now.show })
        self.AutoSkill.gameObject:SetActive(self.Skill:GetAutomaticRelease() == 1)
    else
        self.skillLevel.text = ''
        self.skillDescription.text = ''
    end
    self.currentSkill.gameObject:SetActive(self.SkillsCondition_Now ~= nil)
end

---刷新下一级技能信息
function UISkillInfoTemplate:RefreshNextSkillInfo()
    local level = ''
    local show = ''
    local needLevel = 0
    local nextSkillsConditionId = 0
    local nextlevelColor = self.Green
    self.IsSkillMax = self.SkillsCondition_Next == nil and self.SkillsCondition_Now ~= nil
    self.IsStudy = self.SkillsCondition_Now ~= nil
    self.maxLevelTips_next.gameObject:SetActive(self.IsSkillMax)
    --学习了技能但是未满级
    if self.IsStudy and self.IsSkillMax == false then
        if self.SkillsCondition_Next ~= nil then
            level = self.SkillsCondition_Next.level
            show = self.SkillsCondition_Next.show
            needLevel = CS.Cfg_ConditionManager.Instance:GetCanLearnSkillLevel(self.SkillsCondition_Next.id)
            nextSkillsConditionId = self.SkillsCondition_Next.id
        end
        --未学习技能
    elseif self.IsStudy == false then
        local nowInfo = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(self.Skill:GetId(), 1)
        if nowInfo ~= nil then
            level = nowInfo.level
            show = nowInfo.show
            needLevel = CS.Cfg_ConditionManager.Instance:GetCanLearnSkillLevel(nowInfo.id)
            nextSkillsConditionId = nowInfo.id
        end
    end

    self.IsReachStudyLevel = CS.CSScene.MainPlayerInfo.Level >= needLevel and not self.IsSkillMax
    if self.IsReachStudyLevel == false then
        nextlevelColor = self.Red
    end

    if self.IsSkillMax then
        self.skillLevel_next.text = ''
        self.skillDescription_next.text = ''
        self.requireLevel_next.text = ''
        self.requireLevel_next.gameObject.transform.parent.gameObject:SetActive(false);
    else
        if self.Skill and self.Skill:GetId() then
            if (self.Skill:GetCls() == 4 or self.Skill:GetCls() == 10) then
                level = level + 1
            end
        end
        self.skillLevel_next.text = table.concat({ self.White, '下一等级', self.BLANK, math.max(level - 1, 0), "级" })
        self.skillDescription_next.text = CS.Cfg_SkillsConditionManager.Instance:GetSecretSkillShowText(nextSkillsConditionId, "[00ff00]");  --table.concat({ self.Orange, show })
        self.requireLevel_next.text = table.concat({ self.Orange, nextlevelColor, needLevel, "级" })
        self.requireLevel_next.gameObject.transform.parent.gameObject:SetActive(needLevel > CS.CSScene.MainPlayerInfo.Level);
    end
end

--endregion

--region 刷新顶部技能数据

---刷新顶部技能数据
function UISkillInfoTemplate:RefreShTopSkillInfo()
    self.mSkillIcon.spriteName = self.Skill:GetIcon()
    self.skillName.text = '[dde6eb]' .. self.Skill:GetName()
    local IsStudy = self.SkillsCondition_Now;
    self.mSkillIcon.color = not IsStudy and CS.UnityEngine.Color.black or CS.UnityEngine.Color.white
    self:RefreShAutoInfo()
    self:RefreShElementInfo()
end

---刷新元素信息
function UISkillInfoTemplate:RefreShElementInfo()
    if self.Skill and self.Skill:GetElement() and self.Skill:GetElement().list and self.Skill:GetElement().list.Count > 0 then
        local id = self.Skill:GetElement().list[0]
        local str = LuaGlobalTableDeal.GetSkillElementShowInfo(id)
        if str then
            self.mElement.text = str
        end
        self.mElement.gameObject:SetActive(true)
    else
        self.mElement.gameObject:SetActive(false)
    end
end

---刷新自动施法信息
function UISkillInfoTemplate:RefreShAutoInfo()
    if self.IsAutoSkill then
        self.AutoSkill_bg.spriteName = 'slbg2'
        self.AutoSkill_thumb.transform.localPosition = CS.UnityEngine.Vector3(-12, 10, 0)
    else
        self.AutoSkill_bg.spriteName = 'slbg'
        self.AutoSkill_thumb.transform.localPosition = CS.UnityEngine.Vector3(-45, 10, 0)
    end
    local IsStudy = self.SkillsCondition_Now
    self.mStateLabel.text = IsStudy and "自动释放" or "未学习";
    self.mStateLabel.gameObject:SetActive(IsStudy and self.Skill:GetAutomaticRelease() == 1);
    self.AutoSkill.gameObject:SetActive(IsStudy and self.Skill:GetAutomaticRelease() == 1);
end

--endregion

--region 刷新获取途径
---刷新获取途径
function UISkillInfoTemplate:RefreShGetWay()
    local isShowGetWay = self:IsShowGetWay()
    self.GetWay.gameObject:SetActive(isShowGetWay)
    if isShowGetWay then
        self:SetGetWay()
        self:RefreshAuctionGetWay()
    else
        self.mAuctionBuyRoot:SetActive(false)
    end
end

---设置获取方式
function UISkillInfoTemplate:SetGetWay()
    local data,itemList = self:GetWayIdList()
    if data == nil or #data == nil or #data == 0 then
        self.GetWay.gameObject:SetActive(false)
        return
    end
    self.GetWayItemGrid.MaxCount = #data;
    for i = 1, #data do
        local gobj = self.GetWayItemGrid.controlList[i - 1];
        ---@type UIWayGetUnitTemplate
        local temp = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIWayGetUnitTemplate);
        temp.mItemID=itemList[i].id
        temp:UpdateUnit(data[i]);
    end
end

--region 交易行快捷购买
---请求交易行快捷购买
function UISkillInfoTemplate:RequestQuickAuctionItems()
    if self.Skill == nil then
        return false
    end
    local skillBookID = self.Skill:GetSkillBook()
    local wayget_fastauctionTbl = clientTableManager.cfg_wayget_fastauctionManager:TryGetValue(skillBookID)
    if wayget_fastauctionTbl == nil or wayget_fastauctionTbl:GetItems() == nil or #wayget_fastauctionTbl:GetItems().list == 0 then
        return false
    end
    networkRequest.ReqQuickAuctionItem(wayget_fastauctionTbl:GetItems().list)
    return true
end

function UISkillInfoTemplate:RefreshAuctionGetWay()
    if self.Skill == nil then
        self.mAuctionBuyRoot:SetActive(false)
        return
    end
    local skillBookID = self.Skill:GetSkillBook()
    local wayget_fastauctionTbl = clientTableManager.cfg_wayget_fastauctionManager:TryGetValue(skillBookID)
    if wayget_fastauctionTbl == nil or self.mAuctionItems == nil or self.mAuctionItems.items == nil or #self.mAuctionItems.items == 0 then
        self.mAuctionBuyGrids.MaxCount = 0
        self.mAuctionBuyRoot:SetActive(false)
        return
    end
    self.mAuctionBuyRoot:SetActive(true)
    self.mAuctionBuyGrids.MaxCount = #self.mAuctionItems.items
    for i = 1, #self.mAuctionItems.items do
        local auctionItem = self.mAuctionItems.items[i]
        local go = self.mAuctionBuyGrids.controlList[i - 1]
        local template = self:GetTemplateForAuctionBuyGrid(go)
        template:Update(auctionItem)
    end
end

---@param go UnityEngine.GameObject
---@return UIWayGetQuickAuctionBuyTemplate
function UISkillInfoTemplate:GetTemplateForAuctionBuyGrid(go)
    if self.mTemplateForAuctionGrids == nil then
        self.mTemplateForAuctionGrids = {}
    end
    ---@type UIWayGetQuickAuctionBuyTemplate
    local template = self.mTemplateForAuctionGrids[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIWayGetQuickAuctionBuyTemplate, self.parentPanel.mOwnerPanel)
        if self.mAuctionQuickBuyCallBack == nil then
            self.mAuctionQuickBuyCallBack = function(...)
                self:OnAuctionQuickBuyButtonClicked(...)
            end
        end
        template:BindBuyButtonClickCallBack(self.mAuctionQuickBuyCallBack)
        self.mTemplateForAuctionGrids[go] = template
    end
    return template
end

---@param go UnityEngine.GameObject
---@param template UIWayGetQuickAuctionBuyTemplate
---@param auctionItem auctionV2.AuctionItemInfo
function UISkillInfoTemplate:OnAuctionQuickBuyButtonClicked(go, template, auctionItem, count)
    if auctionItem == nil or auctionItem.item == nil then
        return
    end
    template.mIsRequestedBuy = true
    self.mClickedTemplate = template
    if count == nil then
        count = 1
    end
    networkRequest.ReqBuyAuctionAuction(auctionItem.item.lid, count, 1)
end
--endregion

---得到获取途径ID列表
function UISkillInfoTemplate:GetWayIdList()
    if self.Skill == nil then
        return nil
    end
    local skillBookID = self.Skill:GetSkillBook()
    if skillBookID == nil or skillBookID == 0 then
        return nil
    end
    local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(skillBookID)
    if isfind == false then
        return nil;
    end
    if itemInfo.wayGet == nil or itemInfo.wayGet.list == nil or itemInfo.wayGet.list.Count == 0 then
        return nil
    end
    local dataList = {}
    local ItemList = {}
    for i = 0, itemInfo.wayGet.list.Count - 1 do
        local isfind, wayGetInfoTemp = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(itemInfo.wayGet.list[i])
        if isfind and wayGetInfoTemp.openType ~= 3 and wayGetInfoTemp.openType ~= 8 then
            if (wayGetInfoTemp.conditions ~= nil and wayGetInfoTemp.conditions.list.Count > 0) then
                if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(wayGetInfoTemp.conditions.list)) then
                    table.insert(dataList, itemInfo.wayGet.list[i])
                    table.insert(ItemList, itemInfo)
                end
            else
                table.insert(dataList, itemInfo.wayGet.list[i])
                table.insert(ItemList, itemInfo)
            end
        end
    end
    return dataList,ItemList
end

---@return boolean 判断当前的技能是否是XP技能
function UISkillInfoTemplate:IsCurrentXPSkill()
    if self.Skill then
        return self.Skill:GetCls() == 4
    end
    return false
end

---@return boolean 是否是高级技能
function UISkillInfoTemplate:IsHighLevelSkill(id)
    local skillDetailedInfoIsFind, skillDetailedInfo = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDetailedInfoDic:TryGetValue(id)
    if skillDetailedInfoIsFind then
        return skillDetailedInfo.IsHighSkill
    end
    return false
end

---@return boolean 是否显示获取途径
function UISkillInfoTemplate:IsShowGetWay()
    local isShowGetWay = false
    if self:IsCurrentXPSkill() then
        isShowGetWay = not self.IsSkillMax
    else
        isShowGetWay = not self:IsHighLevelSkill(self.Skill.id)
    end
    return isShowGetWay
end

--endregion

--region 刷新强化技能信息

---刷新强化技能信息
function UISkillInfoTemplate:RefreshIntensifySkill()
    if self.NowSkillInfo == nil then
        self.StrengthenSkillRoot.gameObject:SetActive(false)
        self.intensifySkillIcon.gameObject:SetActive(false)
        return
    end
    local isStudy, IntensifySkillInfo = self:IsStudyIntensifySkill()
    local ishaveSkillBook, bagItemInfo, skillID = self.NowSkillInfo:IsHaveIntensifySkillBook()
    local skillTable = clientTableManager.cfg_skillsManager:TryGetValue(skillID)
    local isSkillMax = false
    self.isExpMax = false
    ---@type LuaSkillDetailedInfo
    self.IntensifySkillInfo = IntensifySkillInfo
    if IntensifySkillInfo ~= nil then
        isSkillMax = IntensifySkillInfo:IsSkillMax()
        self.isExpMax = IntensifySkillInfo:IsSkillExpMax()
    end
    local isShow = isStudy or ishaveSkillBook
    self.IntensifySkillBook_bagItemInfo = bagItemInfo
    self.StrengthenSkillRoot.gameObject:SetActive(isShow)
    self.intensifySkillIcon.gameObject:SetActive(isStudy)
    if isShow == false then
        return
    end
    local skillLevel = 0
    local iconName = ""
    local skillName = ""
    local iconColor = LuaEnumUnityColorType.Normal

    if not isStudy and ishaveSkillBook then
        skillLevel = 0
        if skillTable ~= nil then
            skillName = skillTable:GetName()
            iconName = skillTable:GetIcon()
        end
        iconColor = LuaEnumUnityColorType.Gray
    elseif isStudy then
        skillLevel = IntensifySkillInfo.level
        if IntensifySkillInfo:GetSkillTable() ~= nil then
            skillName = IntensifySkillInfo:GetSkillTable():GetName()
            iconName = IntensifySkillInfo:GetSkillTable():GetIcon()
        end
    end
    ---是否显示学习按钮
    local isShoowBtn_Learn = not isStudy and ishaveSkillBook
    ---是否显示升级按钮
    local isShoowBtn_Up = isStudy and not isSkillMax and self.isExpMax
    ---是否显示使用技能书按钮
    local isShoowBtn_useSkillbook = isStudy and ishaveSkillBook and not isSkillMax and not self.isExpMax
    --print("是否显示使用技能书按钮", isStudy, ishaveSkillBook, isSkillMax, self.isExpMax, isShoowBtn_useSkillbook)
    ---是否显示详细信息按钮
    local isShoowBtn_Info = not isShoowBtn_Learn and not isShoowBtn_Up and not isShoowBtn_useSkillbook
    ---内容描述
    local des = skillName .. "   " .. tostring(skillLevel) .. "段"
    self.StrengthenSkill_Icon.spriteName = iconName
    self.StrengthenSkill_Icon.color = iconColor
    self.StrengthenSkill_Label.text = des
    self.intensifySkillIcon.spriteName = iconName
    self.StrengthenSkill_btn.gameObject:SetActive(isShoowBtn_Info)
    self.StrengthenSkill_Btn_Learn.gameObject:SetActive(isShoowBtn_Learn)
    self.StrengthenSkill_Btn_Up.gameObject:SetActive(isShoowBtn_Up)
    self.StrengthenSkill_UseSkillBookBtn.gameObject:SetActive(isShoowBtn_useSkillbook)
end

---是否已经学习了强化技能
---@return boolean,LuaSkillDetailedInfo
function UISkillInfoTemplate:IsStudyIntensifySkill()
    if self.NowSkillInfo == nil then
        return false
    end
    local IntensifySkillInfo = self.NowSkillInfo:GetIntensifySkillInfo()
    if IntensifySkillInfo == nil then
        return false
    end
    return true, IntensifySkillInfo
end

--function UISkillInfoTemplate

function UISkillInfoTemplate:ClosePanel()
    self.go.gameObject:SetActive(false)
    self.parentPanel.infoPanelmask.gameObject:SetActive(false)
    uimanager:ClosePanel("UIStrengthenSkillPanel")
end

--endregion

--region 点击

---自动技能
function UISkillInfoTemplate:OnAutoSkill()
    self.IsAutoSkill = not self.IsAutoSkill

    CS.CSScene.MainPlayerInfo.SkillInfoV2:SetSkillOptionsDic(self.skillID, self.IsAutoSkill);
    CS.Cfg_SkillTableManager.Instance:RefreshSkillList()
    local Skill = CS.Cfg_SkillTableManager.Instance.SkillList[self.skillID]
    local name
    if self.IsAutoSkill then
        name = "[00ff00]开启[-] [ffffff]" .. tostring(Skill.name)
    else
        name = "[ffffff]关闭[-] [ffffff]" .. tostring(Skill.name)
    end
    if self.IsAutoSkill then
        self.AutoSkill_bg.spriteName = 'slbg2'
        self.AutoSkill_thumb.transform.localPosition = CS.UnityEngine.Vector3(-12, 10, 0)
    else
        self.AutoSkill_bg.spriteName = 'slbg'
        self.AutoSkill_thumb.transform.localPosition = CS.UnityEngine.Vector3(-45, 10, 0)
    end
    CS.Utility.ShowTips(name, 1.5, CS.ColorType.White)
    local list = CS.CSScene.MainPlayerInfo.SkillInfoV2:GetSkillOptionsList()
    networkRequest.ReqSaveRoleSkillSettings(list)
    if luaEventManager.HasCallback(LuaCEvent.Skill_AutoRelease) then
        luaEventManager.DoCallback(LuaCEvent.Skill_AutoRelease)
    end
    if self.parentPanel ~= nil then
        local SkillItemTemp = self.parentPanel.SkillTemplateList[self.SelectGo]
        if SkillItemTemp ~= nil then
            SkillItemTemp.AutoObj:SetActive(self.IsAutoSkill)
        end
    end
end

---点击强化技能详细信息按钮
function UISkillInfoTemplate:OnClickStrengthenSkill_btn()
    local isStudy, IntensifySkillInfo = self:IsStudyIntensifySkill()
    if IntensifySkillInfo ~= nil then
        uimanager:CreatePanel("UIStrengthenSkillPanel", nil, IntensifySkillInfo.skillid, self.go)
    end

end

---点击技能学习
function UISkillInfoTemplate:OnClickStrengthenSkill_Btn_Learn()
    if self.IntensifySkillBook_bagItemInfo ~= nil then
        networkRequest.ReqUseItem(1, self.IntensifySkillBook_bagItemInfo.lid, 1)
    end
end

---点击技能升级
function UISkillInfoTemplate:OnClickStrengthenSkill_Btn_Up()
    if self.IntensifySkillInfo ~= nil then
        local skillID = self.IntensifySkillInfo.skillid
        networkRequest.ReqLevelUpSkill(skillID)
    end
end

---点击学习强化技能按钮
function UISkillInfoTemplate:OnClickStrengthenSkill_UseSkillBookBtn()
    if self.IntensifySkillBook_bagItemInfo ~= nil then
        networkRequest.ReqUseItem(1, self.IntensifySkillBook_bagItemInfo.lid, 1)
    end
end

--endregion

return UISkillInfoTemplate