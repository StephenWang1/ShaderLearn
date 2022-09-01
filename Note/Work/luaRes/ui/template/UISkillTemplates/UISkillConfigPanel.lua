local UISkillConfigPanel = {}
UISkillConfigPanel.activeDrag = false
UISkillConfigPanel.mTempDragSprite = nil
UISkillConfigPanel.mUIShortcuts_List = {}
UISkillConfigPanel.SkillLearn_List = {}
UISkillConfigPanel.SkillIdList = {}
UISkillConfigPanel.ParentPanal = {}
UISkillConfigPanel.SelectScheme = 0
---键位 ->模板
UISkillConfigPanel.mKeyAndSkillShortCutConfig = {}

---得到父节点面板
function UISkillConfigPanel.GetParentComponent(ParentPanel)
    UISkillConfigPanel.ParentPanal = ParentPanel
end
---右侧设置技能Item列表
function UISkillConfigPanel.UIShortcuts_List()
    return UISkillConfigPanel.mUIShortcuts_List
end

function UISkillConfigPanel:InfoPanelBtn()
    if self.mInfoPanelBtn == nil or CS.StaticUtility.IsNull(self.mInfoPanelBtn) then
        self.mInfoPanelBtn = self:Get("shortcutsPanel/InfoPanelBtn", "GameObject");
    end
    return self.mInfoPanelBtn
end

function UISkillConfigPanel:Root()
    if self.mRoot == nil or CS.StaticUtility.IsNull(self.mRoot) then
        self.mRoot = CS.Utility_Lua.GetComponent(CS.UnityEngine.GameObject.Find("UI Root"), "UIRoot")
    end
    return self.mRoot
end

function UISkillConfigPanel.MaskPanel_GameObject()
    if UISkillConfigPanel.mMaskPanel == nil or CS.StaticUtility.IsNull(UISkillConfigPanel.mMaskPanel) then
        UISkillConfigPanel.mMaskPanel = UISkillConfigPanel:Get("shortcutsPanel/mask", "GameObject");
    end
    return UISkillConfigPanel.mMaskPanel
end
function UISkillConfigPanel:ShortcutTemplate_GameObject()
    if self.mShortcutTemplate == nil or CS.StaticUtility.IsNull(self.mShortcutTemplate) then
        self.mShortcutTemplate = self:Get("shortcutsPanel/Scroll View/shortcuttemplate", "GameObject");
    end
    return self.mShortcutTemplate
end
function UISkillConfigPanel:ItemShortcutTemplate_GameObject()
    if self.mItemShortcutTemplate == nil or CS.StaticUtility.IsNull(self.mItemShortcutTemplate) then
        self.mItemShortcutTemplate = self:Get("itemshortcutsPanel/Scroll View/shortcuttemplate", "GameObject");
    end
    return self.mItemShortcutTemplate
end

--技能ScrollView
function UISkillConfigPanel:SkillGrid_GameObject()
    if self.mSkillGrid_GameObject == nil or CS.StaticUtility.IsNull(self.mSkillGrid_GameObject) then
        self.mSkillGrid_GameObject = self:Get("skillColumn/Scroll View", "GameObject");
    end
    return self.mSkillGrid_GameObject
end
---道具ScrollView
function UISkillConfigPanel:ItemGrid_GameObject()
    if self.mItemGrid_GameObject == nil or CS.StaticUtility.IsNull(self.mItemGrid_GameObject) then
        self.mItemGrid_GameObject = self:Get("skillColumn/ItemScrollView", "GameObject");
    end
    return self.mItemGrid_GameObject
end

function UISkillConfigPanel:SkillColumn_GameObject()
    if self.mSkillColumn_GameObject == nil or CS.StaticUtility.IsNull(self.mSkillColumn_GameObject) then
        self.mSkillColumn_GameObject = self:Get("skillColumn", "GameObject");
    end
    return self.mSkillColumn_GameObject
end

function UISkillConfigPanel:Window_GameObject()
    if self.mWindow_GameObject == nil or CS.StaticUtility.IsNull(self.mWindow_GameObject) then
        self.mWindow_GameObject = self:Get("window", "GameObject");
    end
    return self.mWindow_GameObject
end

--技能UIGridContainer列表
function UISkillConfigPanel:ConfigGridContainer_UIGridContainer()
    if self.mConfigGridContainer == nil or CS.StaticUtility.IsNull(self.mConfigGridContainer) then
        self.mConfigGridContainer = self:Get("skillColumn/Scroll View/skills", "UIGridContainer");
    end
    return self.mConfigGridContainer
end

---道具UIGridContainer列表
function UISkillConfigPanel:ItemGrid_UIGridContainer()
    if self.mItemGrid == nil or CS.StaticUtility.IsNull(self.mItemGrid) then
        self.mItemGrid = self:Get("skillColumn/ItemScrollView/items", "UIGridContainer");
    end
    return self.mItemGrid
end

function UISkillConfigPanel:BtnClear_GameObject()
    if self.mBtnClear == nil or CS.StaticUtility.IsNull(self.mBtnClear) then
        self.mBtnClear = self:Get("shortcutsPanel/Btn_Clear", "GameObject");
    end
    return self.mBtnClear
end

function UISkillConfigPanel:Help_GameObject()
    if self.mhelp == nil or CS.StaticUtility.IsNull(self.mhelp) then
        self.mhelp = self:Get("help", "GameObject");
    end
    return self.mhelp
end

---技能快捷键1
function UISkillConfigPanel:Btn_mode1()
    if self.mBtn_mode1 == nil or CS.StaticUtility.IsNull(self.mBtn_mode1) then
        self.mBtn_mode1 = self:Get("shortcutsPanel/Btn_mode1", "Top_UIToggle");
    end
    return self.mBtn_mode1
end

---技能快捷键2
function UISkillConfigPanel:Btn_mode2()
    if self.mBtn_mode2 == nil or CS.StaticUtility.IsNull(self.mBtn_mode2) then
        self.mBtn_mode2 = self:Get("shortcutsPanel/Btn_mode2", "Top_UIToggle");
    end
    return self.mBtn_mode2
end
---快捷键1中心图标
function UISkillConfigPanel:SkillPanelIcon1()
    if self.mSkillPanelIcon1 == nil then
        self.mSkillPanelIcon1 = self:Get("shortcutsPanel/skillPlan1/icon", "Top_UISprite");
    end
    return self.mSkillPanelIcon1
end
---快捷键2中心图标
function UISkillConfigPanel:SkillPanelIcon2()
    if self.mSkillPanelIcon2 == nil then
        self.mSkillPanelIcon2 = self:Get("shortcutsPanel/skillPlan2/icon", "Top_UISprite");
    end
    return self.mSkillPanelIcon2
end

---技能快捷键1高亮
function UISkillConfigPanel:mode1bright()
    if self.mBtn_mode1bright == nil or CS.StaticUtility.IsNull(self.mBtn_mode1bright) then
        self.mBtn_mode1bright = self:Get("shortcutsPanel/Btn_mode1/Label2/bright", "GameObject");
    end
    return self.mBtn_mode1bright
end

---技能快捷键2高亮
function UISkillConfigPanel:mode2bright()
    if self.mBtn_mode2bright == nil or CS.StaticUtility.IsNull(self.mBtn_mode2bright) then
        self.mBtn_mode2bright = self:Get("shortcutsPanel/Btn_mode2/Label2/bright", "GameObject");
    end
    return self.mBtn_mode2bright
end

---显示技能+
function UISkillConfigPanel:btn_skill()
    if self.mbtn_skill == nil or CS.StaticUtility.IsNull(self.mbtn_skill) then
        self.mbtn_skill = self:Get("btn_skill", 'Top_UIToggle')
    end
    return self.mbtn_skill
end

---显示道具
function UISkillConfigPanel:btn_props()
    if self.mbtn_props == nil or CS.StaticUtility.IsNull(self.mbtn_props) then
        self.mbtn_props = self:Get("btn_props", 'Top_UIToggle')
    end
    return self.mbtn_props
end

---技能快捷键
function UISkillConfigPanel:shortcutsPanel()
    if self.mshortcutsPanel == nil or CS.StaticUtility.IsNull(self.mshortcutsPanel) then
        self.mshortcutsPanel = self:Get("shortcutsPanel", 'Transform')
    end
    return self.mshortcutsPanel
end

---道具快捷键
function UISkillConfigPanel:itemshortcutFrames()
    if self.mitemshortcutFrames == nil or CS.StaticUtility.IsNull(self.mitemshortcutFrames) then
        self.mitemshortcutFrames = self:Get("itemshortcutsPanel/Scroll View/ItemshortcutFrames", 'Transform')
    end
    return self.mitemshortcutFrames
end

---技能快捷键面板按键1
function UISkillConfigPanel:shortcutFrames1()
    if self.mShortcutFrames == nil or CS.StaticUtility.IsNull(self.mShortcutFrames) then
        self.mShortcutFrames = self:Get("shortcutsPanel/Scroll View/shortcutFrames", 'Transform')
    end
    return self.mShortcutFrames
end
---技能快捷键面板按键2
function UISkillConfigPanel:shortcutFrames2()
    if self.mShortcutFrames2 == nil or CS.StaticUtility.IsNull(self.mShortcutFrames2) then
        self.mShortcutFrames2 = self:Get("shortcutsPanel/Scroll View/shortcutFrames2", 'Transform')
    end
    return self.mShortcutFrames2
end

---技能快捷键面板1
function UISkillConfigPanel:shortcutskillPlan1()
    if self.mshortcutskillPlan1 == nil or CS.StaticUtility.IsNull(self.mshortcutskillPlan1) then
        self.mshortcutskillPlan1 = self:Get("shortcutsPanel/skillPlan1", 'GameObject')
    end
    return self.mshortcutskillPlan1
end

---技能快捷键面板2
function UISkillConfigPanel:shortcutskillPlan2()
    if self.mshortcutskillPlan2 == nil or CS.StaticUtility.IsNull(self.mshortcutskillPlan2) then
        self.mshortcutskillPlan2 = self:Get("shortcutsPanel/skillPlan2", 'GameObject')
    end
    return self.mshortcutskillPlan2
end

--UIpane
function UISkillConfigPanel.GetUIPanel()
    if UISkillConfigPanel.uipanel == nil or CS.StaticUtility.IsNull(UISkillConfigPanel.uipanel) then
        UISkillConfigPanel.uipanel = CS.Utility_Lua.GetComponent(CS.UIDragDropRoot.root, "UIPanel")
    end
    return UISkillConfigPanel.uipanel
end

function UISkillConfigPanel:Init(panel)
    ---@type UIConfigPanel
    self.mOwnerPanel = panel

    UISkillConfigPanel.lastChoose = nil
    UISkillConfigPanel.itemIDList = CS.Cfg_GlobalTableManagerBase.Instance:GetShortcutUseItemIDList();
    UISkillConfigPanel.go = self.go
    self.ClipArea = self:Get("skillColumn/Scroll View", "Top_ClipShaderScript")

    UISkillConfigPanel.SelectScheme = CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme
    self:shortcutFrames1().gameObject:SetActive(UISkillConfigPanel.SelectScheme == 0);
    self:shortcutFrames2().gameObject:SetActive(UISkillConfigPanel.SelectScheme == 1);
    self:shortcutskillPlan1().gameObject:SetActive(UISkillConfigPanel.SelectScheme == 0);
    self:shortcutskillPlan2().gameObject:SetActive(UISkillConfigPanel.SelectScheme == 1);
    self:btn_skill().value = true
    self:Btn_mode1().value = UISkillConfigPanel.SelectScheme == 0
    self:Btn_mode2().value = UISkillConfigPanel.SelectScheme == 1
    self:mode1bright():SetActive(UISkillConfigPanel.SelectScheme == 0);
    self:mode2bright():SetActive(UISkillConfigPanel.SelectScheme == 1);
    self:SetSkillIcon()
end

function UISkillConfigPanel:Start()
    self:BindEvent();
end

function UISkillConfigPanel:SetSkillIcon()
    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    self:SkillPanelIcon1().spriteName = 'jobkill' .. career;
    self:SkillPanelIcon2().spriteName = 'jobkill' .. career;
end

---绑定客户端事件
function UISkillConfigPanel:BindEvent()
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GirdStartDrag, UISkillConfigPanel.OnDragStartSkillByEvent)
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GirdDrag, UISkillConfigPanel.OnDragSkillByEvent)
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GirdEndDrag, UISkillConfigPanel.OnDragEndSkillByEvent)

    CS.UIEventListener.Get(self:InfoPanelBtn()).onClick = UISkillConfigPanel.OnClickInfoanelBtn
    CS.UIEventListener.Get(self:BtnClear_GameObject()).onClick = UISkillConfigPanel.OnResetTheKeys
    CS.UIEventListener.Get(self:Help_GameObject()).onClick = UISkillConfigPanel.OnHelp
    CS.UIEventListener.Get(self:Btn_mode1().gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self:Btn_mode1().gameObject).OnClickLuaDelegate = self.OnClickBtn_mode1
    CS.UIEventListener.Get(self:Btn_mode2().gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self:Btn_mode2().gameObject).OnClickLuaDelegate = self.OnClickBtn_mode2

    CS.UIEventListener.Get(self:btn_skill().gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self:btn_skill().gameObject).OnClickLuaDelegate = self.OnShowskill
    CS.UIEventListener.Get(self:btn_props().gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self:btn_props().gameObject).OnClickLuaDelegate = self.OnShowProps

    self.CllOnShowProps = function()
        self:OnShowProps();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CllOnShowProps);
end

---显示技能页签
function UISkillConfigPanel:OnShowskill()
    self:SkillGrid_GameObject():SetActive(true);
    self:Window_GameObject():SetActive(true)
    self:btn_skill().value = true
    uimanager:ClosePanel("UIBagPanel")
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_GridSingleClicked, UISkillConfigPanel.OnBagItemClicked)
    if UISkillConfigPanel.lastChoose == nil then
        UISkillConfigPanel.lastChoose = self.mKeyAndSkillShortCutConfig[2]:RefreshChoose(UISkillConfigPanel.lastChoose)
    end
end

---显示道具页签
function UISkillConfigPanel:OnShowProps()
    if (self:btn_skill() ~= nil) then
        self:btn_skill().value = false
    end
    if (self:btn_props() ~= nil) then
        self:btn_props().value = true
    end
    self:SkillGrid_GameObject():SetActive(false);
    self:Window_GameObject():SetActive(false)
    --self:ItemGrid_GameObject().gameObject:SetActive(true);

    self:itemshortcutFrames().gameObject:SetActive(true)
    -- self:shortcutsPanel().gameObject:SetActive(false)
    self:RefreshItemColumn()
end

---选择转盘模式一
function UISkillConfigPanel:OnClickBtn_mode1()
    CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill = nil;
    self:mode1bright():SetActive(true);
    self:mode2bright():SetActive(false);
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.SkillShortcutLayout, 0);
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.SkillScheme, 0);
    CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme = 0;
    UISkillConfigPanel.SelectScheme = 0;
    UISkillConfigPanel.mUIShortcuts_List = nil
    UISkillConfigPanel.mUIShortcuts_List = {}
    self:Btn_mode1().value = true
    self:shortcutFrames1().gameObject:SetActive(true)
    self:shortcutFrames2().gameObject:SetActive(false)
    self:shortcutskillPlan1().gameObject:SetActive(true);
    self:shortcutskillPlan2().gameObject:SetActive(false);

    self:MakeShortcutGos(self:shortcutFrames1(), 0)
end

---选择转盘模式二
function UISkillConfigPanel:OnClickBtn_mode2()
    CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill = nil;
    self:mode1bright():SetActive(false);
    self:mode2bright():SetActive(true);
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.SkillShortcutLayout, 1);
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.SkillScheme, 1);
    CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme = 1;
    UISkillConfigPanel.SelectScheme = 1;
    UISkillConfigPanel.mUIShortcuts_List = nil
    UISkillConfigPanel.mUIShortcuts_List = {}
    self:Btn_mode2().value = true
    self:shortcutFrames1().gameObject:SetActive(false)
    self:shortcutFrames2().gameObject:SetActive(true)
    self:shortcutskillPlan1().gameObject:SetActive(false);
    self:shortcutskillPlan2().gameObject:SetActive(true);

    self:MakeShortcutGos(self:shortcutFrames2(), 1)
end

---生成右侧道具快捷列表
function UISkillConfigPanel:ItemMakeShortcutGos()
    local trans = self:itemshortcutFrames()
    local t_Transform
    local uiShortcut_GameObject
    local itemId1 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem1);
    local itemId2 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem2);
    local itemId3 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem3);
    local itemId4 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem4);

    local list = {};
    list[0] = itemId1;
    list[1] = itemId2;
    list[2] = itemId3;
    list[3] = itemId4;
    local numberList = {};
    numberList[0] = Utility.EnumToInt(CS.EConfigOption.ShortcutItem1);
    numberList[1] = Utility.EnumToInt(CS.EConfigOption.ShortcutItem2);
    numberList[2] = Utility.EnumToInt(CS.EConfigOption.ShortcutItem3);
    numberList[3] = Utility.EnumToInt(CS.EConfigOption.ShortcutItem4);
    for i = 0, trans.childCount - 1 do
        t_Transform = trans:GetChild(i);
        if t_Transform.childCount == 0 then
            uiShortcut_GameObject = CS.UnityEngine.Object.Instantiate(self:ItemShortcutTemplate_GameObject())
            uiShortcut_GameObject.gameObject.name = i + 1
            uiShortcut_GameObject.transform:SetParent(t_Transform)
            uiShortcut_GameObject:SetActive(true)
            uiShortcut_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
            uiShortcut_GameObject.transform.localScale = CS.UnityEngine.Vector3.one
            uiShortcut_GameObject.name = "prop"
        end
        local uiShortcut = templatemanager.GetNewTemplate(t_Transform:GetChild(0).gameObject, luaComponentTemplates.UISkillShortcutConfigTemplate)
        uiShortcut:RefreshUI(list[i], numberList[i])
        uiShortcut:SetShortcutProp(true)
        UISkillConfigPanel.mUIShortcuts_List[t_Transform:GetChild(0).gameObject] = uiShortcut
        self.mKeyAndSkillShortCutConfig[uiShortcut:KEY()] = uiShortcut
    end
end

---生成右侧键位列表
function UISkillConfigPanel:MakeShortcutGos(trans, scheme)
    local t_Transform
    local uiShortcut_GameObject
    local isDefault = true
    for i = 0, trans.childCount - 1 do
        t_Transform = trans:GetChild(i);
        if t_Transform.childCount == 0 then
            uiShortcut_GameObject = CS.UnityEngine.Object.Instantiate(self:ShortcutTemplate_GameObject())
            uiShortcut_GameObject.gameObject.name = i + 1
            uiShortcut_GameObject.transform:SetParent(t_Transform)
            uiShortcut_GameObject:SetActive(true)
            uiShortcut_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
            uiShortcut_GameObject.transform.localScale = CS.UnityEngine.Vector3.one
        end
        local uiShortcut = templatemanager.GetNewTemplate(t_Transform:GetChild(0).gameObject, luaComponentTemplates.UISkillShortcutConfigTemplate)
        uiShortcut:RefreshUI(UISkillConfigPanel.GetVaue(i), i)
        uiShortcut:Key_UILabel().text = i + 1
        UISkillConfigPanel.mUIShortcuts_List[t_Transform:GetChild(0).gameObject] = uiShortcut
        self.mKeyAndSkillShortCutConfig[uiShortcut:KEY()] = uiShortcut
        if i == uiStaticParameter.mSkillConfigSelectedIndex then
            UISkillConfigPanel.lastChoose = uiShortcut:RefreshChoose(UISkillConfigPanel.lastChoose)
            uiStaticParameter.mSkillConfigSelectedIndex = nil
            isDefault = false
        end
    end
    self:ItemMakeShortcutGos()
    if isDefault then
        UISkillConfigPanel.lastChoose = self.mKeyAndSkillShortCutConfig[2]:RefreshChoose(UISkillConfigPanel.lastChoose)
    end
    self:ShowShortcutLayout()
    luaEventManager.DoCallback(LuaCEvent.Skill_Refresh)
end

---得到技能快捷按键
--技能存储位置0开始
--道具存储位置20开始
function UISkillConfigPanel.GetVaue(Key)
    local skillShortcut = CS.CSScene.MainPlayerInfo.ShortcutInfo:GetShortcut(Key)
    if (skillShortcut ~= nil) then
        return skillShortcut:GetSubShort(0)--得到技能按键下的第一个技能(当前版本,一个按键只有一个技能)
    end

    return 0
end

function UISkillConfigPanel:SaveSkillConfig(template, skillId, sprite)
    for k, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        if (v:ID() == skillId) then
            v:RefreshID(0)
        end
    end
    UISkillConfigPanel:SetSingleSKillSprite(template, skillId, sprite)
    UISkillConfigPanel:SetSkillShortcutMessage()
end

---右侧技能列表拖拽事件
function UISkillConfigPanel:ShowShortcutLayout()
    for k, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        local shortcut_gameObject = k
        CS.UIEventListener.Get(shortcut_gameObject).onDragStart = UISkillConfigPanel.OnDragStartShortcut
        CS.UIEventListener.Get(shortcut_gameObject).onDrag = UISkillConfigPanel.OnDragShortcut
        CS.UIEventListener.Get(shortcut_gameObject).onDragEnd = UISkillConfigPanel.OnDragEndSkill
        CS.UIEventListener.Get(shortcut_gameObject).onDrop = UISkillConfigPanel.OnDropShortcut
        CS.UIEventListener.Get(shortcut_gameObject).onClick = function(go)
            self:OnClickShortcut(go)
        end
    end
end

--->生成左侧技能列表
function UISkillConfigPanel:RefreshSkillColumn()
    -----@type  table<number,LuaSkillDetailedInfo>
    --self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    --self.SkillInfo_Servers = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic
    --local skillList = CS.Cfg_SkillTableManager.Instance:GetShortcutConfigSkill();
    --local index = 0
    --
    --local skill_List = {};
    --if skillList ~= nil then
    --    CS.Utility_Lua.luaForeachCsharp:Foreach(skillList, function(k, v)
    --        if v.cls ~= 4 then
    --            table.insert(skill_List, v);
    --        end
    --    end)
    --end
    local skill_List =  self:GetShowInfo()
    self:ConfigGridContainer_UIGridContainer().MaxCount = #skill_List
    local index = 0
    for i = 1, #skill_List do
        local v = skill_List[i]
        local item = self:ConfigGridContainer_UIGridContainer().controlList[index].gameObject
        local item_skillIcon = item.transform:Find("skillIcon").gameObject
        local template
        if self.SkillLearn_List[item_skillIcon] == nil then
            template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UISkillTemplate_UISkillPanel)
            ---存储左侧技能列表拖拽icon---》模板
            self.SkillLearn_List[item_skillIcon] = template
        else
            template = self.SkillLearn_List[item_skillIcon]
        end
        local skillTable=nil
        local skillData=nil
        if self.SkillInfoDic~=nil and self.SkillInfoDic[v.id]~=nil then
            skillTable= self.SkillInfoDic[v.id]:GetSkillTable()
            skillData= self.SkillInfoDic[v.id]
        else
            skillTable= clientTableManager.cfg_skillsManager:TryGetValue(v.id)
        end
        template:RefreshUI(skillTable, skillData, self, index)
        template:SkillConfigPanelResetUI(v.id)
        index = index + 1
    end
end

---得到显示需要的数据
function UISkillConfigPanel:GetShowInfo()
    ---@type  table<number,TABLE.cfg_skills>
    self.skillList = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():GetCareerSkill()
    ---@type  table<number,LuaSkillDetailedInfo>
    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.skillList == nil then
        return
    end
    local skill_List = {};

    for i, v in pairs(self.skillList) do
        if v:GetCls() == 4 then
            if self.SkillInfoDic ~= nil then
                local nowskillInfo = self.SkillInfoDic[v:GetId()]
                if nowskillInfo then
                    table.insert(skill_List, v);
                elseif CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(v:GetId()) ~= nil then
                    table.insert(skill_List, v);
                end
            end
        else
            table.insert(skill_List, v);
        end
    end
    return skill_List
end

---道具道具设置
function UISkillConfigPanel:RefreshItemColumn()
    UISkillConfigPanel.uiBagPanel = nil
    uimanager:CreatePanel("UIBagPanel", function(panel)
        UISkillConfigPanel.uiBagPanel = panel
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, UISkillConfigPanel.OnBagItemClicked)
    end, { type = LuaEnumBagType.SkillConfig })
end

---背包筛选结束
function UISkillConfigPanel.FilterBagItemFinish()
    if UISkillConfigPanel.uiBagPanel ~= nil then
        for k, v in pairs(UISkillConfigPanel.uiBagPanel.GridToItemDic) do
            if v ~= nil and v.BagItemInfo ~= nil then
                local item = v.go
                local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UISkillConfigTemplate)
                UISkillConfigPanel.SkillLearn_List[item] = template
                template:RefreshItemUI(v.ItemInfo.id);
            end
        end
    end
end

---背包格子单机事件
function UISkillConfigPanel.OnBagItemClicked(id, itemInfo)
    UISkillConfigPanel:SaveSkillConfig(UISkillConfigPanel.lastChoose, itemInfo.id, itemInfo.icon)
end

--region 右侧技能设置
function UISkillConfigPanel.OnDragStartShortcut(go)
    local skillShortcut = go
    if skillShortcut == nil then
        UISkillConfigPanel.activeDrag = false
        return
    end
    local icon = skillShortcut.transform:Find('Icon').gameObject;
    if icon == nil then
        UISkillConfigPanel.activeDrag = false
        return
    end
    if icon.activeInHierarchy == false then
        UISkillConfigPanel.activeDrag = false
        return
    end
    UISkillConfigPanel.activeDrag = true
    CS.CSScene.MainPlayerInfo.ShortcutInfo:GetCurShortcutScheme():Remove(UISkillConfigPanel.mUIShortcuts_List[go]:KEY(), 0)
    UISkillConfigPanel.InstantiateTempDragSprite(icon)
    icon:SetActive(false)
    UISkillConfigPanel.lastChoose = UISkillConfigPanel.mUIShortcuts_List[go]:RefreshChoose(UISkillConfigPanel.lastChoose)
end
function UISkillConfigPanel.OnDragShortcut(go, delta)
    if UISkillConfigPanel.mTempDragSprite ~= nil then
        UISkillConfigPanel.mTempDragSprite.transform.localPosition = UISkillConfigPanel.mTempDragSprite.transform.localPosition + CS.UnityEngine.Vector3(delta.x, delta.y, 0) * UISkillConfigPanel:Root().pixelSizeAdjustment
    end
end
function UISkillConfigPanel.OnDragEndShortcut(go)
    if CS.UICamera.lastHit.collider.gameObject == go then
        --   UISkillConfigPanel.MaskPanel_GameObject():SetActive(true)
    end
    local skillShortcut = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISkillShortcutConfigTemplate)
    UISkillConfigPanel.DestroyTempDragSprite()
    UISkillConfigPanel.SetSkillSprite(go)
    UISkillConfigPanel.activeDrag = false
    if UISkillConfigPanel.activeDrag == false then
        return
    end
end
function UISkillConfigPanel:OnClickShortcut(go)
    if go.transform.name == "prop" then
        self:OnShowProps()
    else
        self:OnShowskill()
    end
    UISkillConfigPanel.lastChoose = UISkillConfigPanel.mUIShortcuts_List[go]:RefreshChoose(UISkillConfigPanel.lastChoose)
end

--endregion
--region 左侧技能拖动
---拖动技能复制一个技能图标
function UISkillConfigPanel.OnDragStartSkill(go)
    UISkillConfigPanel.activeDrag = true
    UISkillConfigPanel.InstantiateTempDragSprite(go)
end

function UISkillConfigPanel.OnDragStartSkillByEvent(id, go)
    UISkillConfigPanel.dragItem = go.transform:Find("icon").gameObject
    UISkillConfigPanel.OnDragStartSkill(UISkillConfigPanel.dragItem)
    UISkillConfigPanel.OnPress(go, true)
end
---技能图标随指针移动
function UISkillConfigPanel.OnDragSkill(go, delta)
    if UISkillConfigPanel.mTempDragSprite ~= nil then
        UISkillConfigPanel.mTempDragSprite.transform.localPosition = UISkillConfigPanel.mTempDragSprite.transform.localPosition + CS.UnityEngine.Vector3(delta.x, delta.y, 0) * UISkillConfigPanel:Root().pixelSizeAdjustment
    end
end

function UISkillConfigPanel.OnDragSkillByEvent(id, msg)
    UISkillConfigPanel.OnDragSkill(msg.go, msg.delta)
end

---拖动结束后删除复制的技能图标，并存储信息
function UISkillConfigPanel.OnDragEndSkill(go)
    if UISkillConfigPanel.activeDrag == false then
        return
    end
    local ID = 0
    if UISkillConfigPanel.SkillLearn_List[go] then
        ID = UISkillConfigPanel.SkillLearn_List[go]:ID()
        UISkillConfigPanel.NowDragSkill = nil
    elseif UISkillConfigPanel.mUIShortcuts_List[go] then
        ID = UISkillConfigPanel.mUIShortcuts_List[go]:ID()
        UISkillConfigPanel.mUIShortcuts_List[go]:RefreshID(0)
        UISkillConfigPanel.NowDragSkill = UISkillConfigPanel.mUIShortcuts_List[go]
    end
    if UISkillConfigPanel.mTempDragSprite == nil then
        return
    end

    for k, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        if (v:ID() == ID) then
            v:RefreshID(0)
        end
    end

    UISkillConfigPanel.SetSkillSprite(UISkillConfigPanel.mTempDragSprite.transform.position, ID);
    UISkillConfigPanel:DestroyTempDragSprite()
    UISkillConfigPanel:SetSkillShortcutMessage()

    --if(UISkillConfigPanel.SetSkillSprite(UISkillConfigPanel.mTempDragSprite.transform.position, ID)) then
    --    --UISkillConfigPanel:SaveSkillConfig(UISkillConfigPanel.lastChoose,ID,UISkillConfigPanel.mTempDragSprite:GetComponent('UISprite').spriteName);
    --else
    --    --UISkillConfigPanel:SetSkillShortcutMessage()
    --end
    --UISkillConfigPanel:DestroyTempDragSprite()
end

function UISkillConfigPanel.OnDragEndSkillByEvent(id, commonData)
    local itemInfo = commonData.itemInfo
    local position = commonData.position
    for i, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        local distance = CS.UnityEngine.Vector3.Distance(position, i.transform.position)
        if distance <= 0.1 then
            UISkillConfigPanel:SaveSkillConfig(v, itemInfo.id, itemInfo.icon)
            UISkillConfigPanel.lastChoose = UISkillConfigPanel.mUIShortcuts_List[i]:RefreshChoose(UISkillConfigPanel.lastChoose)
            break
        end
    end
    --UISkillConfigPanel.OnPress(go, false)
end

---长按
function UISkillConfigPanel.OnBagGridPressEvent(id, customData)
    local go = customData.go
    local state = customData.state
    UISkillConfigPanel.uiBagPanel.GetScrollView_UIScrollView().enabled = not state
    UISkillConfigPanel.OnPress(go, state)
end

function UISkillConfigPanel.SetSkillSprite(go, ID)
    local isResetConfig = false;
    for i, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        local distance = CS.UnityEngine.Vector3.Distance(go, i.transform.position)
        if distance <= 0.1 then
            if UISkillConfigPanel.NowDragSkill ~= nil then
                UISkillConfigPanel:SetSingleSKillSprite(UISkillConfigPanel.NowDragSkill, v:ID(), v:ShortcutIcon().spriteName)
            end
            UISkillConfigPanel:SetSingleSKillSprite(v, ID, CS.Utility_Lua.GetComponent(UISkillConfigPanel.mTempDragSprite, "UISprite").spriteName)
            UISkillConfigPanel.lastChoose = UISkillConfigPanel.mUIShortcuts_List[i]:RefreshChoose(UISkillConfigPanel.lastChoose)
            if (not isResetConfig) then
                isResetConfig = true;
            end
        end
    end
    return isResetConfig;
end

function UISkillConfigPanel:SetSingleSKillSprite(skillShortCutConfigTemplate, ID, spriteName)
    ---是否是快捷栏
    if skillShortCutConfigTemplate.IsShortcutProp and UISkillConfigPanel.IsSkillOrItem(ID) == false then
        CS.Utility.ShowTips("技能无法设置", 1.5, CS.ColorType.Red)
        return
        --elseif not skillShortCutConfigTemplate.IsShortcutProp and UISkillConfigPanel.IsItem == true then
        --    CS.Utility.ShowTips("物品无法设置", 1.5, CS.ColorType.Red)
        --    return
    end
    skillShortCutConfigTemplate:DisplayIcon(true)
    skillShortCutConfigTemplate:RefreshID(ID)
    skillShortCutConfigTemplate:ShortcutIcon().spriteName = spriteName
    skillShortCutConfigTemplate:ShortcutItemIcon().spriteName = spriteName
end

---根据id判断是技能还是道具
---@return boolean true 是技能 false 是item
function UISkillConfigPanel.IsSkillOrItem(id)
    local res, tableInfo = CS.Cfg_SkillTableManager.Instance.dic:TryGetValue(id)
    if res then
        return false
    end
    return true
end

---删除拖拽的技能图标
function UISkillConfigPanel.DestroyTempDragSprite()
    if UISkillConfigPanel.mTempDragSprite ~= nil then
        CS.UnityEngine.Object.Destroy(UISkillConfigPanel.mTempDragSprite.gameObject);
        UISkillConfigPanel.mTempDragSprite = nil
    end
end
function UISkillConfigPanel.InstantiateTempDragSprite(prefab)
    if CS.UIDragDropRoot.root == nil then
        return
    end
    UISkillConfigPanel.mTempDragSprite = CS.NGUITools.AddChild(prefab, prefab);
    UISkillConfigPanel.GetUIPanel().depth = 1000;
    UISkillConfigPanel.mTempDragSprite.transform:SetParent(CS.UIDragDropRoot.root);
end

---格子长按放大
function UISkillConfigPanel.OnPress(go, state)
    ---@type TweenScale
    if CS.StaticUtility.IsNull(go) == false then
        local buttonScale = CS.Utility_Lua.GetComponent(go.transform, "TweenScale")
        if CS.StaticUtility.IsNull(buttonScale) == false then
            if state then
                buttonScale:PlayForward()
            else
                buttonScale:PlayReverse()
            end
        end
    end
end

--endregion
--->拖动技能到快捷栏，添加或替换快捷方式
function UISkillConfigPanel.OnDropShortcut(toSkill_Shortcut, fromSkill_Config)
    if UISkillConfigPanel.activeDrag == false then
        return
    end
    local toShortcut = toSkill_Shortcut
    local uiSkill = fromSkill_Config
    if uiSkill ~= nil then
    end
end
---重置键位
function UISkillConfigPanel.OnResetTheKeys()
    for i, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        v:ShortcutIcon().gameObject:SetActive(false);
        v:RefreshID(0)
        if v.IsShortcutProp == false then
            CS.CSScene.MainPlayerInfo.ShortcutInfo:GetCurShortcutScheme():Remove(v:KEY(), 0)
        else
            CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(v:KEY(), 0);
        end
    end
    local list = CS.CSScene.MainPlayerInfo.ShortcutInfo:GetShortcutData()
    networkRequest.ReqSetSkillShortcut(list)
    networkRequest.ReqSkillBasicInfo()
end
---设置技能快捷键改变信息
function UISkillConfigPanel.SetSkillShortcutMessage()
    for i, v in pairs(UISkillConfigPanel.mUIShortcuts_List) do
        local schene = CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme
        --if v:ID() ~= 0 then
        if v.go.activeInHierarchy == true then
            if v.IsShortcutProp == false then
                CS.CSScene.MainPlayerInfo.ShortcutInfo:SetShortcut(schene, v:KEY(), 0, v:ID());
            end
        end
        --end
        if v.IsShortcutProp then
            CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(v:KEY(), v:ID());
        end
    end
    local list = CS.CSScene.MainPlayerInfo.ShortcutInfo:GetShortcutData()
    networkRequest.ReqSetSkillShortcut(list)
    luaEventManager.DoCallback(LuaCEvent.Skill_Refresh)
    CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill = nil;
end

---返回INFO面板
function UISkillConfigPanel.OnClickInfoanelBtn()
    UISkillConfigPanel.ParentPanal.GetSkillInfoPanel_GameObject():SetActive(true);
    UISkillConfigPanel.ParentPanal:GetSkillConfigPanel_GameObject():SetActive(false);
    luaEventManager.DoCallback(LuaCEvent.Skill_Refresh)
end
function UISkillConfigPanel:OnDestroy()
    UISkillConfigPanel.activeDrag = false
    UISkillConfigPanel.mTempDragSprite = nil
    UISkillConfigPanel.SkillLearn_List = {}
    UISkillConfigPanel.SkillIdList = {}
    UISkillConfigPanel.ParentPanal = {}
    UISkillConfigPanel.itemIDList = nil
    UISkillConfigPanel.go = nil
    UISkillConfigPanel.lastChoose = nil
    UISkillConfigPanel.mUIShortcuts_List = {}
    UISkillConfigPanel.uiBagPanel = nil

    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_GirdStartDrag, UISkillConfigPanel.OnDragStartSkillByEvent)
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_GirdDrag, UISkillConfigPanel.OnDragSkillByEvent)
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_GirdEndDrag, UISkillConfigPanel.OnDragEndSkillByEvent)
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Bag_GridSingleClicked, UISkillConfigPanel.OnBagItemClicked)

    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CllOnShowProps);
    StopCoroutine(self.mDelayRefreSh);
    self.mDelayRefreSh = nil;
    uimanager:ClosePanel("UIBagPanel")
end

function UISkillConfigPanel.OnHelp()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(13)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

---背包筛选方法
function UISkillConfigPanel.FilterBagItem(bagItemInfo)
    if UISkillConfigPanel.itemIDList == nil then
        return false
    end
    for i = 0, UISkillConfigPanel.itemIDList .Length - 1 do
        if bagItemInfo.itemId == tonumber(UISkillConfigPanel.itemIDList[i]) then
            return true
        end
    end
    return false
end

-----入口方法
-----@param type LuaEnumSkillConfigPanelOpenType
function UISkillConfigPanel:Refresh(type)

    self.nowType = type
    if (self.mDelayRefreSh ~= nil) then
        StopCoroutine(self.mDelayRefreSh);
        self.mDelayRefreSh = nil;
    end
    self.mDelayRefreSh = StartCoroutine(self.DelayRefreSh, self);
end

function UISkillConfigPanel:DelayRefreSh()
    coroutine.yield(1)
    self:RefreshSkillColumn()
    if UISkillConfigPanel.SelectScheme == 0 then
        self:MakeShortcutGos(self:shortcutFrames1(), UISkillConfigPanel.SelectScheme)
    else
        self:MakeShortcutGos(self:shortcutFrames2(), UISkillConfigPanel.SelectScheme)
    end

    if (self.nowType == nil) then
        type = LuaEnumSkillConfigPanelOpenType.Skill;
    end

    if (self.nowType == LuaEnumSkillConfigPanelOpenType.Skill) then
        self:OnShowskill();
    elseif (self.nowType == LuaEnumSkillConfigPanelOpenType.Bag) then
        self:OnShowProps()
    end
end

return UISkillConfigPanel