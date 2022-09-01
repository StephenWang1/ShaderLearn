local UISecretBookContentTemplate = {}

--region 局部变量

--endregion

--region 组件
function UISecretBookContentTemplate:GetQuestion_UILabel()
    if (self.mQuestionTitle == nil) then
        self.mQuestionTitle = self:Get("Par/GameObject/0", "UILabel")
    end
    return self.mQuestionTitle
end

function UISecretBookContentTemplate:GetQuesRoot_UITable()
    if (self.mQuestionUITable == nil) then
        self.mQuestionUITable = self:Get("", "UITable")
    end
    return self.mQuestionUITable
end
--endregion

--region 初始化
function UISecretBookContentTemplate:Init()
    self.pageNums = 0
end

function UISecretBookContentTemplate:Show()

end
--endregion

--region 客户端事件

--endregion

--region 刷新界面
function UISecretBookContentTemplate:RefreshUIPanel(info)
    self.info = info
    if (self.info ~= nil) then
        self:SetQuestData(self.go, info.questions, info.answers)
    end
end

---设置问题
---第一步:设置问题标题
---第二步:循环遍历设置回答
---第三步:把所有回答组件进行统一排序
function UISecretBookContentTemplate:SetQuestData(questRoot, question, answers)
    self:GetQuestion_UILabel().text = question
    if (CS.System.String.IsNullOrEmpty(question)) then
        self:GetQuestion_UILabel().gameObject:SetActive(false)
    else
        self:GetQuestion_UILabel().gameObject:SetActive(true)
    end
    local gridContainer = CS.Utility_Lua.GetComponent(questRoot.transform:Find("Par/Grid"), "UIGridContainer")
    local List = answers:Split("#")
    local count = #List
    gridContainer.MaxCount = count
    --2.把所有回答组件进行统一排序
    for i = 1, count do
        local go = gridContainer.controlList[i - 1]
        go.name = i
        if (self.pageNums == 2) then
            go.transform:Find("answerLabel/Sign").gameObject:SetActive(false)
        else
            go.transform:Find("answerLabel/Sign").gameObject:SetActive(true)
        end
        self:SetAnswerData(go, List[i])
    end

    --3.把所有回答组件进行统一排序
    local table = CS.Utility_Lua.GetComponent(questRoot, "UITable")
    table.IsDealy = true
    table:Reposition()
end

---设置回答
---第一步:设置回答内容文本
---第二步:设置回答可能出现的按钮功能
---第三步:将文本与按钮进行排版
function UISecretBookContentTemplate:SetAnswerData(answerRoot, data)
    if (answerRoot.transform:Find("answerLabel") ~= nil) then
        local label = CS.Utility_Lua.GetComponent(answerRoot.transform:Find("answerLabel"), "UILabel")
        if (label ~= nil) then
            label.text = CS.Cfg_SecretBookTableManager.Instance:ReplaceContentText(data)
        end
    end
    --self:SetURLBtn(answerRoot)
    local table = CS.Utility_Lua.GetComponent(answerRoot.transform.parent.gameObject, "UITable")
    table.IsDealy = true
    table:Reposition()
end

function UISecretBookContentTemplate:SetURLBtn(gom)
    local count = CS.Cfg_SecretBookTableManager.Instance:GetURLBtnInfo().Count
    local btnRoot = gom.transform:Find("BtnGrid")
    local grid = CS.Utility_Lua.GetComponent(btnRoot, "UIGridContainer")
    grid.MaxCount = count
    if (count == 0) then
        return
    end
    for i = 1, count do
        local info = CS.Cfg_SecretBookTableManager.Instance:GetURLBtnInfo()[i - 1]
        local go = grid.controlList[i - 1]
        CS.Utility_Lua.GetComponent(go.transform:Find("title"), "UILabel").text = CS.Cfg_SecretBookTableManager.Instance:GetURLBtnInfo()[i - 1].name
        CS.UIEventListener.Get(go.gameObject).LuaEventTable = self
        CS.UIEventListener.Get(go.gameObject).OnClickLuaDelegate = function()
            CS.Cfg_SecretRelationwordsTableManager.Instance:CheckPrePushState(info.id)
            --self:SetBtnOnClickEvent(info)
        end
    end
    local table = CS.Utility_Lua.GetComponent(btnRoot, "UITable")
    table.IsDealy = true
    table:Reposition()
end

function UISecretBookContentTemplate:SetBtnOnClickEvent(info)
    if (info == nil) then
        return
    end
    if (info.type == luaEnumGetSecretBookType.Item) then
        local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(info.param))
        if (infobool) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = iteminfo })
        end
    elseif (info.type == luaEnumGetSecretBookType.Panel) then
        local parms = {}
        local eventList = info.param:Split("#")
        local count = Utility.GetLuaTableCount(eventList)
        if (count > 1) then
            if (eventList[1] == "UIGuildTipsPanel") then
                eventList[3] = tonumber(eventList[3])
                if (eventList[3] == CS.CSScene.Sington.MainPlayer.BaseInfo.ID) then
                    return
                end
                -- eventList[5] = tonumber(eventList[5])
                uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                    panelType = #eventList > 4 and tonumber(eventList[5]) or 0,
                    roleId = #eventList > 2 and eventList[3] or 0,
                    roleName = #eventList > 3 and eventList[4] or "",
                })
                return
            elseif (eventList[1] == "UINavigationPanel") then
                if (luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId)) then
                    local customData = {};
                    customData.targetId = tonumber(eventList[3]);
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData);
                end
                return
            elseif (eventList[1] == "UIAuctionPanel") then
                local customData = {};
                customData.type = tonumber(eventList[3]);
                uimanager:CreatePanel(eventList[1], nil, customData)
                return
            elseif (eventList[1] == "UIActivityDuplicatePanel") then
                eventList[2] = tonumber((eventList[2]))
                eventList[3] = tonumber((eventList[3]))
            end
        end
        for i = 2, Utility.GetLuaTableCount(eventList) do
            table.insert(parms, eventList[i])
        end
        uimanager:CreatePanel(eventList[1], nil, table.unpack(parms))
    elseif (info.type == luaEnumGetSecretBookType.NPC) then
        CS.Cfg_SecretRelationwordsTableManager.Instance:FindPathOpenPanel(info.param)
    elseif (info.type == luaEnumGetSecretBookType.GameSecret) then
        CS.CSScene.MainPlayerInfo.SecretaryInfo.AddSecretaryDialogue(tonumber(info.param))
    end
end

--endregion
function ondestroy()

end

return UISecretBookContentTemplate