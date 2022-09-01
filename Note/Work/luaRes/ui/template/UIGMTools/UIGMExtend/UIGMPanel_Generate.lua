---GM工具分面板-生成面板
---分为3块:
---1.检索模块
---2.列表模块
---3.分页页签
local UIGMPanel_Generate = {}

--region 参数

--endregion

--region 组件
function UIGMPanel_Generate:GetBtn_Create()
    if self.mBtn_Create == nil then
        self.mBtn_Create = self:Get("Top/Events/Btn_Create", "GameObject")
    end
    return self.mBtn_Create
end

function UIGMPanel_Generate:GetBtn_Search()
    if self.mBtn_Search == nil then
        self.mBtn_Search = self:Get("Top/Events/Btn_Search", "GameObject")
    end
    return self.mBtn_Search
end

function UIGMPanel_Generate:GetBtn_CreateInBag()
    if self.mBtn_CreateInBag == nil then
        self.mBtn_CreateInBag = self:Get("Top/Events/Btn_CreateInBag", "GameObject")
    end
    return self.mBtn_CreateInBag
end

function UIGMPanel_Generate:GetBtn_DropInScene()
    if self.mBtn_DropInScene == nil then
        self.mBtn_DropInScene = self:Get("Top/Events/Btn_DropInScene", "GameObject")
    end
    return self.mBtn_DropInScene
end

function UIGMPanel_Generate:GetBtn_ClearBag()
    if self.mBtn_ClearBag == nil then
        self.mBtn_ClearBag = self:Get("Top/Events/Btn_ClearBag", "GameObject")
    end
    return self.mBtn_ClearBag
end

function UIGMPanel_Generate:GetChooseItem()
    if self.mChooseItem == nil then
        self.mChooseItem = self:Get("Top/View/ChooseItem", "GameObject")
    end
    return self.mChooseItem
end

function UIGMPanel_Generate:GetCount_Input()
    if self.mCount_Input == nil then
        self.mCount_Input = self:Get("Top/View/Count_Input", "GameObject")
    end
    return self.mCount_Input
end

function UIGMPanel_Generate:GetSearch_Input()
    if self.mSearch_Input == nil then
        self.mSearch_Input = self:Get("Top/View/Search_Input", "GameObject")
    end
    return self.mSearch_Input
end

function UIGMPanel_Generate:GetCreat_Input()
    if self.mCreat_Input == nil then
        self.mCreat_Input = self:Get("Top/View/Creat_Input/Label", "UILabel")
    end
    return self.mCreat_Input
end

function UIGMPanel_Generate:GetDrop_Input()
    if self.mDrop_Input == nil then
        self.mDrop_Input = self:Get("Top/View/Drop_Input/Label", "UILabel")
    end
    return self.mDrop_Input
end

function UIGMPanel_Generate:GetItemID_UILabel()
    if (self.mItemID == nil) then
        self.mItemID = self:Get("Top/View/Search_Input/Label", "Top_UILabel")
    end
    return self.mItemID
end

function UIGMPanel_Generate:GetItemList_UIGridContainer()
    if (self.mItemList == nil) then
        self.mItemList = self:Get("Middle/GridList/Item", "Top_UIGridContainer")
    end
    return self.mItemList
end

function UIGMPanel_Generate:GetChooseItem_GameObject()
    if (self.mChooseItemSprite == nil) then
        self.mChooseItemSprite = self:Get("Top/View/ChooseItem", "GameObject")
    end
    return self.mChooseItemSprite
end

function UIGMPanel_Generate:GetItemCount_UILabel()
    if (self.mItemCount == nil) then
        self.mItemCount = self:Get("Top/View/Count_Input/Label", "Top_UILabel")
    end
    return self.mItemCount
end

function UIGMPanel_Generate:GetItemPage_UIGridContainer()
    if (self.mItemPage == nil) then
        self.mItemPage = self:Get("Bottom/ToggleGroup/GridList/ToggleGroup", "Top_UIGridContainer")
    end
    return self.mItemPage
end
--endregion

--region 初始化
function UIGMPanel_Generate:Init(panel)
    uiStaticParameter.GMGenerateTemplate = self
    self.ItemList = {}
    self.mCurChooseItem = nil
    self.mLastChooseItem = nil
    self.ItemTemplates = {}
    self:InitData()
    self:BindUIEvents()
end

function UIGMPanel_Generate:InitData()
    local dic = CS.Cfg_ItemsTableManager.Instance.dic
    dic:Begin()
    while dic:Next() do
        table.insert(self.ItemList, dic.Value)
    end
    --for k, v in pairs(CS.Cfg_ItemsTableManager.Instance.dic) do
    --    table.insert(self.ItemList, v)
    --end
end

function UIGMPanel_Generate:Show(pos)
    self.go:SetActive(true)
    self:InitItemList()
end

function UIGMPanel_Generate:Hide()
    self.go:SetActive(false)
end

function UIGMPanel_Generate:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtn_Search()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_Search()).OnClickLuaDelegate = self.SearchBtnOnClick

    CS.UIEventListener.Get(self:GetBtn_Create()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_Create()).OnClickLuaDelegate = self.mCreateBtnOnClick

    CS.UIEventListener.Get(self:GetBtn_CreateInBag()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_CreateInBag()).OnClickLuaDelegate = self.mCreateInBagBtnOnClick

    CS.UIEventListener.Get(self:GetBtn_DropInScene()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_DropInScene()).OnClickLuaDelegate = self.mDropInSceneBtnOnClick

    CS.UIEventListener.Get(self:GetBtn_ClearBag()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetBtn_ClearBag()).OnClickLuaDelegate = self.mClearBagBtnOnClick
end

--region UIEvents
function UIGMPanel_Generate:SearchBtnOnClick()
    local condition = self:GetItemID_UILabel().text
    self.ItemList = {}
    self:InitData()
    if (CS.System.String.IsNullOrEmpty(condition)) then
        self:InitItemList()
        return
    end
    local newItemList = {}
    for k, v in pairs(self.ItemList) do
        if (CS.Utility_Lua.StringFind(v.id, condition, 0) or CS.Utility_Lua.StringFind(v.name, condition, 0)) then
            table.insert(newItemList, v)
        end
    end
    self.ItemList = newItemList
    self:InitItemList()
end

function UIGMPanel_Generate:TemplateOnClickEvent()
    local tem = uiStaticParameter.GMGenerateTemplate
    tem.mCurChooseItem = self
    if (tem.mCurChooseItem ~= tem.mLastChooseItem) then
        if (tem.mLastChooseItem ~= nil) then
            tem.mLastChooseItem.iconChoose_UISprite.gameObject:SetActive(false)
        end
        tem.mCurChooseItem.iconChoose_UISprite.gameObject:SetActive(true)
        tem.mLastChooseItem = tem.mCurChooseItem
    end
    CS.Utility_Lua.GetComponent(tem:GetChooseItem_GameObject().transform:Find("icon"), "UISprite").spriteName = tem.mCurChooseItem.info.icon
    CS.Utility_Lua.GetComponent(tem:GetChooseItem_GameObject().transform:Find("name"), "UILabel").text = tem.mCurChooseItem.info.name
end

function UIGMPanel_Generate:mCreateBtnOnClick()
    networkRequest.ReqGM("@3 " .. tostring(self.mCurChooseItem.info.id) .. " " .. tostring(self:GetItemCount_UILabel().text))
end

function UIGMPanel_Generate:mCreateInBagBtnOnClick()
    local table = string.Split(self:GetCreat_Input().text, '#')
    if (Utility.GetLuaTableCount(table) > 1) then
        for k, v in pairs(table) do
            networkRequest.ReqGM("@3 " .. tostring(v) .. " " .. 1)
        end
    else
        networkRequest.ReqGM("@3 " .. tostring(self:GetCreat_Input().text) .. " " .. 1)
    end
end

function UIGMPanel_Generate:mDropInSceneBtnOnClick()
    local table = string.Split(self:GetDrop_Input().text, '#')
    if (uiStaticParameter.GMGenerateTemplate.mCurChooseItem ~= nil) then
        networkRequest.ReqGM("@创建道具 " .. tostring(uiStaticParameter.GMGenerateTemplate.mCurChooseItem.ItemID) .. " " .. 1)
    end
    if (Utility.GetLuaTableCount(table) > 1) then
        for k, v in pairs(table) do
            networkRequest.ReqGM("@创建道具 " .. tostring(v) .. " " .. 1)
        end
    else
        networkRequest.ReqGM("@创建道具 " .. tostring(self:GetDrop_Input().text) .. " " .. 1)
    end
end

function UIGMPanel_Generate:mClearBagBtnOnClick()
    networkRequest.ReqGM("@22 ")
end
--endregion

--region 刷新界面
---初始化Item列表
function UIGMPanel_Generate:InitItemList()
    local count = Utility.GetLuaTableCount(self.ItemList)
    local page = math.ceil(count / 100)

    self:GetItemPage_UIGridContainer().MaxCount = page
    for i = 0, self:GetItemPage_UIGridContainer().controlList.Count - 1 do
        local k = i
        local v = self:GetItemPage_UIGridContainer().controlList[i]
        CS.Utility_Lua.GetComponent(v.transform:Find("label"), "UILabel").text = tostring(k + 1)
        CS.UIEventListener.Get(v).onClick = function(go)
            self:RefreshItemList(k + 1)
            if (self:GetItemPage_UIGridContainer() ~= nil and self:GetItemPage_UIGridContainer().controlList ~= nil) then
                local list = self:GetItemPage_UIGridContainer().controlList
                for k = 0, list.Count - 1 do
                    if (CS.Utility_Lua.GetComponent(list[k].transform, "Top_UIToggle").value == true) then
                        CS.Utility_Lua.GetComponent(list[k].transform, "Top_UISprite").color = CS.UnityEngine.Color.green
                    else
                        CS.Utility_Lua.GetComponent(list[k].transform, "Top_UISprite").color = CS.UnityEngine.Color.white
                    end
                end
            end
        end
    end
    self:GetItemList_UIGridContainer().MaxCount = 100

    self:RefreshItemList(1)
end

---刷新Item列表
function UIGMPanel_Generate:RefreshItemList(page)
    local count = Utility.GetLuaTableCount(self.ItemList)
    self:GetItemList_UIGridContainer().MaxCount = 100

    ---末位修正
    for i = 100 * (page - 1), (100 * page) - 1 do
        local index = math.fmod(i, 100)
        if (self.ItemList[i + 1] == nil) then
            self:GetItemList_UIGridContainer().MaxCount = index
            return
        end

        ---模板赋值
        local go = self:GetItemList_UIGridContainer().controlList[index]
        self.ItemTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMItemTemplate)
        self.ItemTemplates[go]:InitParameters(self.ItemList[i + 1])
        self.ItemTemplates[go]:ReFreshUI()
        self.ItemTemplates[go]:IconOnClickEvent(self.TemplateOnClickEvent)
    end
end
--endregion
--endregion
return UIGMPanel_Generate