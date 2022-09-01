---GM工具分面板-生成面板
---分为3块:
---1.检索模块
---2.列表模块
---3.分页页签
local UIGMPanel_Monster = {}

--region 参数

--endregion

--region 组件
function UIGMPanel_Monster:GetBtn_Create()
    if self.mBtn_Create == nil then
        self.mBtn_Create = self:Get("Top/Events/Btn_Create", "GameObject")
    end
    return self.mBtn_Create
end

function UIGMPanel_Monster:GetBtn_AllKill()
    if self.mBtn_AllKill == nil then
        self.mBtn_AllKill = self:Get("Top/Events/Btn_AllKill", "GameObject")
    end
    return self.mBtn_AllKill
end

function UIGMPanel_Monster:GetBtn_Search()
    if self.mBtn_Search == nil then
        self.mBtn_Search = self:Get("Top/Events/Btn_Search", "GameObject")
    end
    return self.mBtn_Search
end

function UIGMPanel_Monster:GetBtn_CreateInBag()
    if self.mBtn_CreateInBag == nil then
        self.mBtn_CreateInBag = self:Get("Top/Events/Btn_CreateInBag", "GameObject")
    end
    return self.mBtn_CreateInBag
end

function UIGMPanel_Monster:GetBtn_DropInScene()
    if self.mBtn_DropInScene == nil then
        self.mBtn_DropInScene = self:Get("Top/Events/Btn_DropInScene", "GameObject")
    end
    return self.mBtn_DropInScene
end

function UIGMPanel_Monster:GetBtn_ClearBag()
    if self.mBtn_ClearBag == nil then
        self.mBtn_ClearBag = self:Get("Top/Events/Btn_ClearBag", "GameObject")
    end
    return self.mBtn_ClearBag
end

function UIGMPanel_Monster:GetChooseItem()
    if self.mChooseItem == nil then
        self.mChooseItem = self:Get("Top/View/ChooseItem", "GameObject")
    end
    return self.mChooseItem
end

function UIGMPanel_Monster:GetCount_Input()
    if self.mCount_Input == nil then
        self.mCount_Input = self:Get("Top/View/Count_Input", "GameObject")
    end
    return self.mCount_Input
end

function UIGMPanel_Monster:GetSearch_Input()
    if self.mSearch_Input == nil then
        self.mSearch_Input = self:Get("Top/View/Search_Input", "GameObject")
    end
    return self.mSearch_Input
end

function UIGMPanel_Monster:GetCreat_Input()
    if self.mCreat_Input == nil then
        self.mCreat_Input = self:Get("Top/View/Creat_Input/Label", "UILabel")
    end
    return self.mCreat_Input
end

function UIGMPanel_Monster:GetDrop_Input()
    if self.mDrop_Input == nil then
        self.mDrop_Input = self:Get("Top/View/Drop_Input/Label", "UILabel")
    end
    return self.mDrop_Input
end

function UIGMPanel_Monster:GetItemID_UILabel()
    if (self.mItemID == nil) then
        self.mItemID = self:Get("Top/View/Search_Input/Label", "Top_UILabel")
    end
    return self.mItemID
end

function UIGMPanel_Monster:GetMonsterList_UIGridContainer()
    if (self.mMonsterList == nil) then
        self.mMonsterList = self:Get("Middle/GridList/Item", "Top_UIGridContainer")
    end
    return self.mMonsterList
end

function UIGMPanel_Monster:GetChooseItem_GameObject()
    if (self.mChooseItemSprite == nil) then
        self.mChooseItemSprite = self:Get("Top/View/ChooseItem", "GameObject")
    end
    return self.mChooseItemSprite
end

function UIGMPanel_Monster:GetItemCount_UILabel()
    if (self.mItemCount == nil) then
        self.mItemCount = self:Get("Top/View/Count_Input/Label", "Top_UILabel")
    end
    return self.mItemCount
end

function UIGMPanel_Monster:GetItemPage_UIGridContainer()
    if (self.mItemPage == nil) then
        self.mItemPage = self:Get("Bottom/ToggleGroup/GridList/ToggleGroup", "Top_UIGridContainer")
    end
    return self.mItemPage
end

function UIGMPanel_Monster:GetPanel_UIPanel()
    if (self.mPanel == nil) then
        self.mPanel = self:Get("Middle/GridList", "UIPanel")
    end
    return self.mPanel
end
--endregion

--region 初始化
function UIGMPanel_Monster:Init(panel)
    uiStaticParameter.GMMonsterTemplate = self
    self.MonsterList = {}
    self.mCurChooseMonster = nil
    self.mLastChooseMonster = nil
    self.ItemTemplates = {}
    self:InitData()
    self:BindUIEvents()
end

function UIGMPanel_Monster:InitData()
    CS.Cfg_MonsterTableManager.Instance.dic:Begin()
    while CS.Cfg_MonsterTableManager.Instance.dic:Next() do
        table.insert(self.MonsterList, CS.Cfg_MonsterTableManager.Instance.dic.Value)
    end
    --for k, v in pairs(CS.Cfg_MonsterTableManager.Instance.dic) do
    --    table.insert(self.MonsterList, v)
    --end
end

function UIGMPanel_Monster:Show(pos)
    self.go:SetActive(true)
    self:InitMonsterList()
end

function UIGMPanel_Monster:Hide()
    self.go:SetActive(false)
end

function UIGMPanel_Monster:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtn_Search()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_Search()).OnClickLuaDelegate = self.SearchBtnOnClick

    CS.UIEventListener.Get(self:GetBtn_Create()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_Create()).OnClickLuaDelegate = self.mCreateBtnOnClick

    CS.UIEventListener.Get(self:GetBtn_AllKill()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_AllKill()).OnClickLuaDelegate = self.mAllKillBtnOnClick

end

--region UIEvents
function UIGMPanel_Monster:SearchBtnOnClick()
    local condition = self:GetItemID_UILabel().text
    self.MonsterList = {}
    self:InitData()
    if (CS.System.String.IsNullOrEmpty(condition)) then
        self:InitMonsterList()
        return
    end
    local newMonsterList = {}
    for k, v in pairs(self.MonsterList) do
        if (CS.Utility_Lua.StringFind(v.id, condition, 0) or CS.Utility_Lua.StringFind(v.name, condition, 0)) then
            table.insert(newMonsterList, v)
        end
    end
    self.MonsterList = newMonsterList
    self:InitMonsterList()
end

function UIGMPanel_Monster:TemplateOnClickEvent()
    local tem = uiStaticParameter.GMMonsterTemplate
    tem.mCurChooseMonster = self
    if (tem.mCurChooseMonster ~= tem.mLastChooseMonster) then
        if (tem.mLastChooseMonster ~= nil) then
            tem.mLastChooseMonster.iconChoose_UISprite.gameObject:SetActive(false)
        end
        tem.mCurChooseMonster.iconChoose_UISprite.gameObject:SetActive(true)
        tem.mLastChooseMonster = tem.mCurChooseMonster
    end
    CS.Utility_Lua.GetComponent(tem:GetChooseItem_GameObject().transform:Find("icon"), "UISprite").spriteName = tem.mCurChooseMonster.info.head
    CS.Utility_Lua.GetComponent(tem:GetChooseItem_GameObject().transform:Find("name"), "UILabel").text = tem.mCurChooseMonster.info.name
end

function UIGMPanel_Monster:mCreateBtnOnClick()
    networkRequest.ReqGM("@85 " .. tostring(self.mCurChooseMonster.info.id) .. " " .. tostring(self:GetItemCount_UILabel().text))
end

function UIGMPanel_Monster:mAllKillBtnOnClick()
    networkRequest.ReqGM("@109")
end

--endregion

--region 刷新界面
---初始化Item列表
function UIGMPanel_Monster:InitMonsterList()
    self:GetPanel_UIPanel().transform.localPosition = CS.UnityEngine.Vector3(-450, -180, 0)
    self:GetPanel_UIPanel().clipOffset = CS.UnityEngine.Vector2.zero
    self:GetPanel_UIPanel().baseClipRegion = CS.UnityEngine.Vector4(448, 173, 1270, 360)
    local count = Utility.GetLuaTableCount(self.MonsterList)
    local page = math.ceil(count / 100)

    self:GetItemPage_UIGridContainer().MaxCount = page
    for i = 0, self:GetItemPage_UIGridContainer().controlList.Count - 1 do
        local k = i
        local v = self:GetItemPage_UIGridContainer().controlList[i]
        CS.Utility_Lua.GetComponent(v.transform:Find("label"), "UILabel").text = tostring(k + 1)
        CS.UIEventListener.Get(v).onClick = function(go)
            self:RefreshMonsterList(k + 1)
            local list = self:GetItemPage_UIGridContainer().controlList
            for i = 0, list.Count - 1 do
                if (CS.Utility_Lua.GetComponent(list[i].transform, "Top_UIToggle").value == true) then
                    CS.Utility_Lua.GetComponent(list[i].transform, "Top_UISprite").color = CS.UnityEngine.Color.green
                else
                    CS.Utility_Lua.GetComponent(list[i].transform, "Top_UISprite").color = CS.UnityEngine.Color.white
                end
            end
        end
    end
    self:GetMonsterList_UIGridContainer().MaxCount = 100

    self:RefreshMonsterList(1)
end

---刷新Item列表
function UIGMPanel_Monster:RefreshMonsterList(page)
    local count = Utility.GetLuaTableCount(self.MonsterList)
    self:GetMonsterList_UIGridContainer().MaxCount = 100

    ---末位修正
    for i = 100 * (page - 1), (100 * page) - 1 do
        local index = math.fmod(i, 100)
        if (self.MonsterList[i + 1] == nil) then
            self:GetMonsterList_UIGridContainer().MaxCount = index
            return
        end

        ---模板赋值
        local go = self:GetMonsterList_UIGridContainer().controlList[index]
        self.ItemTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMMonsterTemplate)
        self.ItemTemplates[go]:InitParameters(self.MonsterList[i + 1])
        self.ItemTemplates[go]:ReFreshUI()
        self.ItemTemplates[go]:IconOnClickEvent(self.TemplateOnClickEvent)
    end
end
--endregion
--endregion
return UIGMPanel_Monster