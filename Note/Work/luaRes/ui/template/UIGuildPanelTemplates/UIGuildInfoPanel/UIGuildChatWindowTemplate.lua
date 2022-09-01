---@class UIGuildChatWindowTemplate:TemplateBase 帮会聊天模板
local UIGuildChatWindowTemplate = {}

---PS:表情、背包、坐标、设置的代码都是写在这个脚本里，如果只是单独需要某一个部分的代码，将这部分代码单独写一个模板，不要直接继承这个！

--region 参数
UIGuildChatWindowTemplate.faceOldList = {}
UIGuildChatWindowTemplate.faceNewList = {}
UIGuildChatWindowTemplate.chatItemInfos = {}
UIGuildChatWindowTemplate.transMapInfos = {}

UIGuildChatWindowTemplate.temp_delate_x = 0
UIGuildChatWindowTemplate.accuracy = 100
UIGuildChatWindowTemplate.pattern = "\\[[0-9A-Fa-f]{6}\\]|\\[-\\]";
---@type number
---当前页数
UIGuildChatWindowTemplate.curPageIndex = 1

---@type number
---最大页数
UIGuildChatWindowTemplate.mMaxPage = 6

---@type number
---每页格子数
UIGuildChatWindowTemplate.mPrePageNum = 12

---页签名字
UIGuildChatWindowTemplate.mPageSprite = {
    [true] = "scrlight",
    [false] = "scrbg",
}

UIGuildChatWindowTemplate.switch = {
    ["tg_synthesize"] = function()
        -- 综合
        return 0
    end,
    ["tg_nearby"] = function()
        -- 附近
        return 2
    end,
    ["tg_world"] = function()
        -- 世界
        return 1
    end,
    ["tg_private"] = function()
        -- 私聊
        return 5
    end,
    ["tg_team"] = function()
        -- 组队
        return 6
    end,
    ["tg_guild"] = function()
        -- 帮会
        return 4
    end,
    ["tg_system"] = function()
        -- 系统
        return 3
    end,
}


--endregion

--region 属性
---@return CSMainPlayerInfo 角色信息
function UIGuildChatWindowTemplate:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2 背包信息
function UIGuildChatWindowTemplate:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return CSEquipInfoV2 身上装备信息
function UIGuildChatWindowTemplate:GetEquipInfoV2()
    if self.mEquipInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mEquipInfoV2 = self:GetMainPlayerInfo().EquipInfo
    end
    return self.mEquipInfoV2
end
--endregion

--region 组件
--region 语音
---@return UnityEngine.GameObject 语音父节点
function UIGuildChatWindowTemplate:GetVoiceRoot_Go()
    if self.mVoiceRoot == nil then
        self.mVoiceRoot = self:Get("ChatArea", "GameObject")
    end
    return self.mVoiceRoot
end
--endregion

--region 设置
---@return UnityEngine.GameObject 添加按钮
function UIGuildChatWindowTemplate:GetAddBtn_GO()
    if self.mAddBtn == nil then
        self.mAddBtn = self:Get("ChatArea/btn_add", "GameObject")
    end
    return self.mAddBtn
end

---@return UnityEngine.GameObject 关闭选择按钮
function UIGuildChatWindowTemplate:GetCloseGroupBtn_Go()
    if self.mCloseGroupBtn == nil then
        self.mCloseGroupBtn = self:Get("BtnGroupPanel/BtnGroup", "GameObject")
    end
    return self.mCloseGroupBtn
end

---@return UnityEngine.GameObject 坐标
function UIGuildChatWindowTemplate:GetLocationBtn_Go()
    if self.mLocationBtnGo == nil then
        self.mLocationBtnGo = self:Get("BtnGroupPanel/BtnGroup/btn_location", "GameObject")
    end
    return self.mLocationBtnGo
end

---@return UnityEngine.GameObject 表情
function UIGuildChatWindowTemplate:GetFaceBtn_Go()
    if self.mFaceBtnGo == nil then
        self.mFaceBtnGo = self:Get("BtnGroupPanel/BtnGroup/btn_emoticon", "GameObject")
    end
    return self.mFaceBtnGo
end

---@return UnityEngine.GameObject 表情界面
function UIGuildChatWindowTemplate:GetFacePanel_Go()
    if self.mFacePanelGo == nil then
        self.mFacePanelGo = self:Get("BtnGroupPanel/EmotionWindow", "GameObject")
    end
    return self.mFacePanelGo
end

---@return UnityEngine.Transform 表情节点
function UIGuildChatWindowTemplate:GetFaceRoot_Transform()
    if self.mFaceRootTrans == nil then
        self.mFaceRootTrans = self:Get("BtnGroupPanel/EmotionWindow/Grild", "Transform")
    end
    return self.mFaceRootTrans
end

---@return UnityEngine.GameObject 背包
function UIGuildChatWindowTemplate:GetBagBtn_Go()
    if self.mBagBtnGo == nil then
        self.mBagBtnGo = self:Get("BtnGroupPanel/BtnGroup/btn_bag", "GameObject")
    end
    return self.mBagBtnGo
end

---@return UnityEngine.GameObject 背包界面
function UIGuildChatWindowTemplate:GetBagPanel_Go()
    if self.mBagPanelGo == nil then
        self.mBagPanelGo = self:Get("BtnGroupPanel/ItemWindow", "GameObject")
    end
    return self.mBagPanelGo
end

---@return UnityEngine.GameObject 红包
function UIGuildChatWindowTemplate:GetRedBagBtn_Go()
    if self.mRedBagBtnGo == nil then
        self.mRedBagBtnGo = self:Get("BtnGroupPanel/BtnGroup/btn_redbag", "GameObject")
    end
    return self.mRedBagBtnGo
end

---@return UIGridContainer 背包节点Container
function UIGuildChatWindowTemplate:GetBagGrid_UIGridContainer()
    if self.mBagGridContainer == nil then
        self.mBagGridContainer = self:Get("BtnGroupPanel/ItemWindow/Scroll View/Grild", "UIGridContainer")
    end
    return self.mBagGridContainer
end

---@return UIGridContainer 背包页签
function UIGuildChatWindowTemplate:GetBagBookMark_UIGridContainer()
    if self.mBagBookMark == nil then
        self.mBagBookMark = self:Get("BtnGroupPanel/ItemWindow/ToggleGroup", "UIGridContainer")
    end
    return self.mBagBookMark
end

---@return UIScrollView 背包Scroll
function UIGuildChatWindowTemplate:GetBagScroll_UIScrollView()
    if self.mBagScroll == nil then
        self.mBagScroll = self:Get("BtnGroupPanel/ItemWindow/Scroll View", "UIScrollView")
    end
    return self.mBagScroll
end

---@return UIToggle 选中背包按钮
function UIGuildChatWindowTemplate:GetBagChoose_UIToggle()
    if self.mBagChooseGo == nil then
        self.mBagChooseGo = self:Get("BtnGroupPanel/ItemWindow/tg_bag", "UIToggle")
    end
    return self.mBagChooseGo
end

---@return UIToggle 选中身上按钮
function UIGuildChatWindowTemplate:GetBodyChoose_UIToggle()
    if self.mBodyChooseGo == nil then
        self.mBodyChooseGo = self:Get("BtnGroupPanel/ItemWindow/tg_Body", "UIToggle")
    end
    return self.mBodyChooseGo
end

---@return UnityEngine.GameObject 设置
function UIGuildChatWindowTemplate:GetSettingBtn_Go()
    if self.mSettingBtnGo == nil then
        self.mSettingBtnGo = self:Get("BtnGroupPanel/BtnGroup/btn_Setting", "GameObject")
    end
    return self.mSettingBtnGo
end

---@return UnityEngine.GameObject 设置界面
function UIGuildChatWindowTemplate:GetSettingPanel_Go()
    if self.mSettingPanelGo == nil then
        self.mSettingPanelGo = self:Get("BtnGroupPanel/SettingWindow", "GameObject")
    end
    return self.mSettingPanelGo
end

---@return UnityEngine.Transform 主界面设置
function UIGuildChatWindowTemplate:GetSettingFilter_Transform()
    if self.mSettingFilter == nil then
        self.mSettingFilter = self:Get("BtnGroupPanel/SettingWindow/Root/Filter", "Transform")
    end
    return self.mSettingFilter
end
--endregion

--region 发送消息
---@return UIInput 输入框
function UIGuildChatWindowTemplate:GetChatInput()
    if self.mChatInput == nil then
        self.mChatInput = self:Get("ChatArea/Chat Input", "UIInput")
    end
    return self.mChatInput
end

---@return UnityEngine.GameObject 发送按钮
function UIGuildChatWindowTemplate:GetSendBtn_Go()
    if self.mSendingBtnGo == nil then
        self.mSendingBtnGo = self:Get("ChatArea/btn", "GameObject")
    end
    return self.mSendingBtnGo
end
--endregion
--endregion

--region初始化
---@param panel UIGuildInfoPanel
function UIGuildChatWindowTemplate:Init(panel)
    self.HasBindEmotion = false
    self.HasRefreshBag = false
    self.HasRefreshSetting = false
    if panel then
        self.mRootPanel = panel
        self:RefreshVoice()
    end
    self:BindEvent()

end

function UIGuildChatWindowTemplate:BindEvent()
    CS.UIEventListener.Get(self:GetAddBtn_GO()).onClick = function()
        self:OnAddBtnClicked()
    end
    CS.UIEventListener.Get(self:GetCloseGroupBtn_Go()).onClick = function()
        self:OnBtnGroupClicked()
    end
    CS.UIEventListener.Get(self:GetFaceBtn_Go()).onClick = function()
        self:OnFaceBtnClicked()
    end
    CS.UIEventListener.Get(self:GetBagBtn_Go()).onClick = function()
        self:OnBagBtnClicked()
    end
    CS.UIEventListener.Get(self:GetLocationBtn_Go()).onClick = function()
        self:OnLocationBtnClicked()
    end
    CS.UIEventListener.Get(self:GetSettingBtn_Go()).onClick = function()
        self:OnSettingBtnClicked()
    end
    CS.UIEventListener.Get(self:GetRedBagBtn_Go()).onClick = function()
        self:OnRedBaggBtnClicked()
    end

    CS.UIEventListener.Get(self:GetBagPanel_Go()).onClick = function()
        self:GetBagPanel_Go():SetActive(false)
    end
    CS.UIEventListener.Get(self:GetFacePanel_Go()).onClick = function()
        self:GetFacePanel_Go():SetActive(false)
    end
    CS.UIEventListener.Get(self:GetSettingPanel_Go()).onClick = function()
        self:GetSettingPanel_Go():SetActive(false)
    end
    CS.UIEventListener.Get(self:GetSendBtn_Go()).onClick = function(go)
        self:OnClickSend(go)
    end
    CS.EventDelegate.Add(self:GetBagChoose_UIToggle().onChange, function()
        if self:GetBagChoose_UIToggle().value then
            self:SwitchBodyAndBag(1)
        end
    end)
    CS.EventDelegate.Add(self:GetBodyChoose_UIToggle().onChange, function()
        if self:GetBodyChoose_UIToggle().value then
            self:SwitchBodyAndBag(2)
        end
    end)
end
--endregion

--region 语音
function UIGuildChatWindowTemplate:RefreshVoice()
    ---@type UIGuildVoiceBaseTemplate
    self.mVoiceTemplate = templatemanager.GetNewTemplate(self:GetVoiceRoot_Go(), luaComponentTemplates.UIGuildVoiceBaseTemplate, nil, self.mRootPanel)
    if self.mVoiceTemplate then
        self.mVoiceTemplate:SetAutoPlayVoiceState(true)
        self.mRootPanel:GetClientEventHandler():AddEvent(CS.CEvent.VoiceRecordEnd, function()
            self.mVoiceTemplate:OnEnd()
        end)
    end
end

---清除数据
function UIGuildChatWindowTemplate:ClearVoice()
    if self.mVoiceTemplate then
        self.mVoiceTemplate:SetAutoPlayVoiceState(false)
    end
end
--endregion

--region 表情
---点击表情
function UIGuildChatWindowTemplate:OnFaceBtnClicked()
    if not self.HasBindEmotion then
        for i = 0, self:GetFaceRoot_Transform().childCount - 1 do
            local go = self:GetFaceRoot_Transform():GetChild(i).gameObject
            CS.UIEventListener.Get(go).onClick = function()
                self:OnEmotionGridClicked(go)
            end
        end
        self.HasBindEmotion = true
    end
    self:SwitchToSettingPanel(LuaEnumGuildChatChooseType.Emotion)
end

---选中表情
function UIGuildChatWindowTemplate:OnEmotionGridClicked(go)
    ---@type UISprite
    local sprite = CS.Utility_Lua.GetComponent(go, "UISprite")
    local spriteName = sprite.spriteName
    table.insert(self.faceOldList, spriteName)
    spriteName = CS.Cfg_EmojiTableManager.Instance:GetEmojiName(spriteName);
    table.insert(self.faceNewList, spriteName)
    if not CS.StaticUtility.IsNullOrEmpty(spriteName) then
        self:GetChatInput():InsertText(spriteName)
    end
    self:SwitchToSettingPanel(LuaEnumGuildChatChooseType.None)
end
--endregion

--region 背包
---点击背包
function UIGuildChatWindowTemplate:OnBagBtnClicked()
    if not self.HasRefreshBag then
        -- self:InitItemWinTogGroup()
        self.HasRefreshBag = true
    end
    self:SwitchToSettingPanel(LuaEnumGuildChatChooseType.Bag)
    self:GetBagChoose_UIToggle():Set(true)
end

---选中背包或者身上
function UIGuildChatWindowTemplate:SwitchBodyAndBag(index)
    if self:GetBagTemplate() then
        if index == 1 then
            self:GetBagTemplate():SwitchToBagState()
        else
            self:GetBagTemplate():SwitchToBodyState()
        end
    end
end

---发送背包消息
function UIGuildChatWindowTemplate:SendItemData(itemData)
    if itemData == nil or itemData.tbl == nil then
        return
    end
    ---@type TABLE.CFG_ITEMS
    local tbl = itemData.tbl
    local strName = tbl.name

    strName = self:MatchAndReplaceColor(strName, self.pattern)
    local strValue = "【" .. strName .. "】"
    if not CS.StaticUtility.IsNull(self:GetChatInput()) then
        self:GetChatInput():InsertText(strValue)
    end
    local count = Utility.GetLuaTableCount(self.chatItemInfos)
    self.chatItemInfos[count] = itemData
    self:SwitchToSettingPanel(LuaEnumGuildChatChooseType.None)
end

function UIGuildChatWindowTemplate:MatchAndReplaceColor(strName, pattern)
    if strName and pattern then
        local matches = CS.System.Text.RegularExpressions.Regex.Matches(strName, pattern)
        if matches.Count > 1 then
            local ms0 = string.gsub(matches[0].Value, "[%[%]]", "")
            local ms1 = string.gsub(matches[1].Value, "[%[%]]", "")
            strName = string.gsub(strName, "[%[" .. ms0 .. "%]]", "");
            strName = string.gsub(strName, "[%[" .. ms1 .. "%]]", "");
        end
    end
    return strName
end

---初始化背包页签
function UIGuildChatWindowTemplate:InitItemWinTogGroup()
    self:GetBagBookMark_UIGridContainer().MaxCount = self.mMaxPage
    for i = 0, self.mMaxPage - 1 do
        local go = self:GetBagBookMark_UIGridContainer().controlList[i]
        local sp = CS.Utility_Lua.GetComponent(go.transform, "UISprite")
        if self.mPageToSprite == nil then
            self.mPageToSprite = {}
        end
        self.mPageToSprite[i] = sp
    end
end

---设置背包页签
function UIGuildChatWindowTemplate:SelectItemWinTog(index)
    if self.mCurrentChooseIndex ~= nil then
        self:SetGridChoose(self.mCurrentChooseIndex, false)
    end
    self.mCurrentChooseIndex = index
    self:SetGridChoose(index, true)
end

---设置背包页签选中
function UIGuildChatWindowTemplate:SetGridChoose(index, isChoose)
    local sp = self.mPageToSprite[index]
    if sp then
        sp.spriteName = self.mPageSprite[isChoose]
    end
end
--endregion

--region 坐标
---点击坐标
function UIGuildChatWindowTemplate:OnLocationBtnClicked()
    self:SwitchToSettingPanel(LuaEnumGuildChatChooseType.Location)
    local mainPlayer = CS.CSScene.Sington.MainPlayer
    if mainPlayer then
        local isFind
        ---@type TABLE.CFG_MAP
        local tbl
        isFind, tbl = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mainPlayer.Info.MapID)
        if tbl ~= nil then
            local temp = string.format("我的坐标【%s %d,%d】", self:MatchAndReplaceColor(tbl.name, self.pattern), mainPlayer.NewCell.Coord.x, mainPlayer.NewCell.Coord.y)
            local tableCount = Utility.GetLuaTableCount(self.transMapInfos)
            self.transMapInfos[tableCount] = {}
            self.transMapInfos[tableCount].mapId = CS.CSScene.MainPlayerInfo.MapID
            self.transMapInfos[tableCount].mapName = tbl.name
            self.transMapInfos[tableCount].coord = mainPlayer.NewCell.Coord
            -- self:GetChatInput().SetValue = self:GetChatInput().value.Length
            self:GetChatInput():InsertText(temp)
        end
    end
end
--endregion

--region 设置
---点击设置
function UIGuildChatWindowTemplate:OnSettingBtnClicked()
    self:SwitchToSettingPanel(LuaEnumGuildChatChooseType.Setting)
    if not self.HasRefreshSetting then
        self:BindSettingTemplate()
        self:InitFiter()
        self.HasRefreshSetting = true
    end
end

function UIGuildChatWindowTemplate:BindSettingTemplate()
    ---@type UIChatPanel_Setting
    self.SettingWindowTemplate = templatemanager.GetNewTemplate(self:GetSettingPanel_Go(), luaComponentTemplates.UIChatPanel_Setting)
end

function UIGuildChatWindowTemplate:InitFiter()
    for i = 0, self:GetSettingFilter_Transform().childCount - 1 do
        ---@type UnityEngine.GameObject
        local t = self:GetSettingFilter_Transform():GetChild(i).gameObject
        ---@type UIToggle
        local tog = CS.Utility_Lua.GetComponent(t, "UIToggle")
        if tog ~= nil then
            local f = self.switch[tog.name]
            if f ~= nil then
                local index = f()
                tog.value = uiStaticParameter.UIChatPanel_FiterIndexList[index] == nil or uiStaticParameter.UIChatPanel_FiterIndexList[index]
                tog.startsActive = tog.value
                CS.EventDelegate.Add(tog.onChange, function()
                    uiStaticParameter.UIChatPanel_FiterIndexList[index] = tog.value
                    --UIChatPanel:RefreshTogGroup()
                end)
            end
        end
    end
end

--endregion

--region 红包
function UIGuildChatWindowTemplate:OnRedBaggBtnClicked()
    local customData = {}
    ---@type UIPersonSendDiamondRedPackTemplate
    customData.Template = luaComponentTemplates.UIPersonSendDiamondRedPackTemplate
    uimanager:CreatePanel("UIGuildSendRedPackPanel", nil, customData)
end
--endregion

--region 通用事件
---点击Add
function UIGuildChatWindowTemplate:OnAddBtnClicked()
    self:GetCloseGroupBtn_Go():SetActive(true)
end

---关闭显示
function UIGuildChatWindowTemplate:OnBtnGroupClicked()
    self:GetCloseGroupBtn_Go():SetActive(false)
end

---设置显示
function UIGuildChatWindowTemplate:SwitchToSettingPanel(type)
    if (not CS.StaticUtility.IsNull(self:GetSettingPanel_Go())) then
        self:GetSettingPanel_Go():SetActive(type == LuaEnumGuildChatChooseType.Setting)
    end
    if (not CS.StaticUtility.IsNull(self:GetFacePanel_Go())) then
        self:GetFacePanel_Go():SetActive(type == LuaEnumGuildChatChooseType.Emotion)
    end
    if (not CS.StaticUtility.IsNull(self:GetBagPanel_Go())) then
        self:GetBagPanel_Go():SetActive(type == LuaEnumGuildChatChooseType.Bag)
    end
    if (not CS.StaticUtility.IsNull(self:GetCloseGroupBtn_Go())) then
        self:GetCloseGroupBtn_Go():SetActive(type ~= LuaEnumGuildChatChooseType.Location and type ~= LuaEnumGuildChatChooseType.None)
    end
end
--endregion

--region 发送消息
function UIGuildChatWindowTemplate:OnClickSend(go)
    --if (self:GetMainPlayerInfo().BudowillInfo:IsChangeModelAndName(CS.CSScene.MainPlayerInfo.ID)) then
    --    CS.Utility.ShowTips("参赛选手不能发言")
    --    return
    --end
    local faceListCount = Utility.GetLuaTableCount(self.faceOldList)
    for i = 1, faceListCount do
        self:GetChatInput().value = CS.Utility_Lua.StringReplace(self:GetChatInput().value, self.faceNewList[i], self.faceOldList[i]);
    end
    self.faceOldList = {}
    self.faceNewList = {}
    local text = self:GetChatInput().value
    if text == nil or string.len(text) <= 0 then
        CS.Utility.ShowTips("[ff0000]请输入文字")
        return
    end
    if string.len(CS.NGUIText.StripSymbols(text)) >= CS.Cfg_GlobalTableManager.Instance:GetChatMaxLength() then
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
        Utility.ShowPopoTips(go, nil, 202)
        return
    end
    local chatItemCount = Utility.GetLuaTableCount(self.chatItemInfos)
    for i = 0, chatItemCount - 1 do
        local itemData = self.chatItemInfos[i]
        ---@type bagV2.BagItemInfo
        local bagItemInfo = itemData.bagItemInfo
        ---@type TABLE.CFG_ITEMS
        local tbl = itemData.tbl
        local str_new = ""
        str_new = "[url=event:open|UIItemInfoPanel|0|" .. CS.Utility_Lua.ReverseItemInfoToString(bagItemInfo, CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(CS.CSScene.MainPlayerInfo.ID) .. "|" .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) .. "][u]" .. tbl.name .. "[/u][/url]"
        str_new = string.gsub(str_new, "]", "^", 3)
        local str_old = "【" .. tbl.name .. "】"
        str_old = self:MatchAndReplaceColor(str_old, self.pattern)

        if (text == str_old) then
            text = str_new
        else
            str_old = CS.Utility_Lua.StringReplace(str_old, "(", "%(")
            str_old = CS.Utility_Lua.StringReplace(str_old, ")", "%)")
            text = string.gsub(text, str_old, str_new, 1)
        end
    end
    self.chatItemInfos = {}
    local count = Utility.GetLuaTableCount(self.transMapInfos)
    for i = 0, count - 1 do
        local mapInfo = self.transMapInfos[i]
        local str_new = string.format("我在[url=find:%d:%d:%d:%d][u][%s %d,%d][/u][/url]",
                mapInfo.mapId, mapInfo.coord.x, mapInfo.coord.y, CS.CSScene.MainPlayerInfo.Line, self:MatchAndReplaceColor(mapInfo.mapName, self.pattern), mapInfo.coord.x, mapInfo.coord.y)
        local str_old = "我的坐标【" .. self:MatchAndReplaceColor(mapInfo.mapName, self.pattern) .. " " .. mapInfo.coord.x .. "," .. mapInfo.coord.y .. "】"

        str_old = CS.Utility_Lua.StringReplace(str_old, "(", "%(")
        str_old = CS.Utility_Lua.StringReplace(str_old, ")", "%)")
        text = CS.Utility_Lua.StringReplace(text, str_old, str_new)
    end
    self.transMapInfos = {}
    text = CS.Utility_Lua.RemoveStringColor(text)
    networkRequest.ReqChat(4, text, 0, false, "", 0)
    self:GetChatInput().value = ""
end

--endregion

--region 聊天背包
---@return UIGuildInfoPanel_ChatPanel_BagPanel
---获取聊天背包模板
function UIGuildChatWindowTemplate:GetBagTemplate()
    if self.mBagTemplate == nil then
        self.mBagTemplate = templatemanager.GetNewTemplate(self:GetBagPanel_Go(), luaComponentTemplates.UIGuildInfoPanel_ChatPanel_BagPanel)
    end
    return self.mBagTemplate
end

---点击背包格子
---@param info bagV2.BagItemInfo
function UIGuildChatWindowTemplate:OnBagItemClicked(msgId, info)
    local itemData = {}
    itemData.bagItemInfo = info
    itemData.tbl = info.ItemTABLE
    self:SendItemData(itemData)
end
--endregion

return UIGuildChatWindowTemplate