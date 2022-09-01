---@class UIArrestPublishPromptPanel:UIBase 发布悬赏面板
local UIArrestPublishPromptPanel = {}

--region 局部变量
UIArrestPublishPromptPanel.rid = 0
UIArrestPublishPromptPanel.rName = ''
UIArrestPublishPromptPanel.isFirst = true
UIArrestPublishPromptPanel.goldTbl = nil
UIArrestPublishPromptPanel.goldName = ''
UIArrestPublishPromptPanel.mapNpcId = 0
UIArrestPublishPromptPanel.origionTxt = ''
UIArrestPublishPromptPanel.TemplateDic = {}
UIArrestPublishPromptPanel.curTemplate = nil
UIArrestPublishPromptPanel.closeCallBack = nil
UIArrestPublishPromptPanel.isRefresh = false
UIArrestPublishPromptPanel.isInitLoopPlus = true
UIArrestPublishPromptPanel.findPlayerInfoTbl = {}
--endregion

--region 初始化
function UIArrestPublishPromptPanel:Show(info)
    if info then
        UIArrestPublishPromptPanel.rid = info.id == nil or 0 and info.idList
        UIArrestPublishPromptPanel.rName = info.name == nil and "" or info.name
        UIArrestPublishPromptPanel.mapNpcId = info.mapNpcId == nil and 0 or info.mapNpcId
        UIArrestPublishPromptPanel.closeCallBack = info.closeCallBack
    end
    UIArrestPublishPromptPanel.RefershGold()
    --UIArrestPublishPromptPanel.InitDropDown()
end

function UIArrestPublishPromptPanel:Init()
    self:InitComponents()
    UIArrestPublishPromptPanel.BindUIEvents()
    UIArrestPublishPromptPanel.BindNetEvent()
end

--- 初始化组件
function UIArrestPublishPromptPanel:InitComponents()
    ---@type UnityEngine.GameObject  关闭按钮
    UIArrestPublishPromptPanel.close = self:GetCurComp("events/close", "GameObject")
    ---@type UnityEngine.GameObject  发布悬赏按钮
    UIArrestPublishPromptPanel.CenterBtn = self:GetCurComp("events/CenterBtn", "GameObject")
    ---@type UnityEngine.GameObject  搜索按钮
    UIArrestPublishPromptPanel.btn_search = self:GetCurComp("events/btn_search", "GameObject")
    ---@type UnityEngine.GameObject  帮助按钮
    UIArrestPublishPromptPanel.helpBtn = self:GetCurComp("events/help", "GameObject")
    ---@type Top_UILabel 名字显示
    UIArrestPublishPromptPanel.Label = self:GetCurComp("view/Chat Input/Label", "Top_UILabel")
    ---@type Top_UIDropDown 下拉列表
    --UIArrestPublishPromptPanel.DropDown = self:GetCurComp("view/DropDown", "Top_UIDropDown")
    ---@type Top_UIInput 输入框
    UIArrestPublishPromptPanel.chatInput = self:GetCurComp("view/Chat Input", "Top_UIInput")
    ---@type Top_UISprite 悬赏金图片
    UIArrestPublishPromptPanel.Sprite = self:GetCurComp("view/itemgold/Sprite", "Top_UISprite")
    ---@type Top_UILabel 悬赏金
    UIArrestPublishPromptPanel.itemgold = self:GetCurComp("view/itemgold", "Top_UILabel")
    ---@type UILoopScrollViewPlus 搜索列表
    UIArrestPublishPromptPanel.playerLoopPlus = self:GetCurComp("view/SearchPeople/Scroll View/playerGrid", "UILoopScrollViewPlus")
end

function UIArrestPublishPromptPanel.InitParmas()
    UIArrestPublishPromptPanel.origionTxt = UIArrestPublishPromptPanel.Label.text
end

function UIArrestPublishPromptPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIArrestPublishPromptPanel.close).onClick = UIArrestPublishPromptPanel.OnClickCloseBtn
    --点击发布悬赏事件
    CS.UIEventListener.Get(UIArrestPublishPromptPanel.CenterBtn).onClick = UIArrestPublishPromptPanel.OnClickCenterBtn
    --点击搜索
    CS.UIEventListener.Get(UIArrestPublishPromptPanel.btn_search).onClick = UIArrestPublishPromptPanel.OnClickSearchBtn

    CS.EventDelegate.Add(UIArrestPublishPromptPanel.chatInput.onChange, UIArrestPublishPromptPanel.OnUIInputValueChanged);
    --点击帮助
    CS.UIEventListener.Get(UIArrestPublishPromptPanel.helpBtn).onClick = UIArrestPublishPromptPanel.OnHelpBtnClicked
end

function UIArrestPublishPromptPanel.BindNetEvent()
    UIArrestPublishPromptPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfferMatterCodeMessage, UIArrestPublishPromptPanel.OnResOfferMatterCodeMessage)
    UIArrestPublishPromptPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfferSearchMessage, UIArrestPublishPromptPanel.OnResOfferSearchMessage)
end

--endregion

--region 消息监听
function UIArrestPublishPromptPanel.OnResOfferMatterCodeMessage(id, data)
    if data and UIArrestPublishPromptPanel.curTemplate ~= nil then
        if data.code == 1 then
            --悬赏成功
            if UIArrestPublishPromptPanel.isRefresh then
                UIArrestPublishPromptPanel.RefershGold()
            end
        elseif data.code == 10 then
            --悬赏玩家不存在
            UIArrestPublishPromptPanel.ShowBubbleTips(UIArrestPublishPromptPanel.CenterBtn, 115)
        elseif data.code == 11 then
            --货币不足z
            if UIArrestPublishPromptPanel.goldTbl then
                UIArrestPublishPromptPanel.ShowBubbleTips(UIArrestPublishPromptPanel.CenterBtn, 137, UIArrestPublishPromptPanel.goldName)
            end
        elseif data.code == 12 then
            --悬赏自己
            if UIArrestPublishPromptPanel.goldTbl then
                UIArrestPublishPromptPanel.ShowBubbleTips(UIArrestPublishPromptPanel.CenterBtn, 206, UIArrestPublishPromptPanel.goldName)
            end
        end
        UIArrestPublishPromptPanel.curTemplate = nil
    end
end

function UIArrestPublishPromptPanel.OnResOfferSearchMessage(id, data)
    if UIArrestPublishPromptPanel.curTemplate ~= nil then
        UIArrestPublishPromptPanel.curTemplate:SetHeightlightState(false)
    end
    if data == nil or data.players == nil or #data.players == 0 then
        Utility.ShowPopoTips(UIArrestPublishPromptPanel.btn_search, nil, 115, 'UIArrestPublishPromptPanel')
        return
    end
    UIArrestPublishPromptPanel.findPlayerInfoTbl = data.players
    UIArrestPublishPromptPanel.RefreshPlayerLoopPlus()
end

--endregion

--region 函数监听

--点击关闭函数
---@param go UnityEngine.GameObject
function UIArrestPublishPromptPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIArrestPublishPromptPanel')
end

--点击发布悬赏函数
---@param go UnityEngine.GameObject
function UIArrestPublishPromptPanel.OnClickCenterBtn(go)
    if UIArrestPublishPromptPanel.curTemplate == nil then
        return
    end
    UIArrestPublishPromptPanel.curTemplate:SetHeightlightState(false)
    UIArrestPublishPromptPanel.rName = UIArrestPublishPromptPanel.curTemplate.palyerInfo.name
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqPublishOfferShare(UIArrestPublishPromptPanel.curTemplate.id, nil, UIArrestPublishPromptPanel.rName, UIArrestPublishPromptPanel.mapNpcId)
    else
        networkRequest.ReqPublishOffer(UIArrestPublishPromptPanel.curTemplate.id, nil, UIArrestPublishPromptPanel.rName, UIArrestPublishPromptPanel.mapNpcId)
    end
end

--点击搜索
function UIArrestPublishPromptPanel.OnClickSearchBtn(go)
    local curValue = UIArrestPublishPromptPanel.chatInput.value
    if curValue == nil or curValue == "" or curValue == UIArrestPublishPromptPanel.origionTxt then
        Utility.ShowPopoTips(UIArrestPublishPromptPanel.btn_search, nil, 115, 'UIArrestPublishPromptPanel')
        return
    end
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqOfferShareSearch(curValue)
    else
        networkRequest.ReqOfferSearch(curValue)
    end
end

function UIArrestPublishPromptPanel.OnUIInputValueChanged()
    if UIArrestPublishPromptPanel.rid ~= 0 then
        UIArrestPublishPromptPanel.rid = 0
    end
end

function UIArrestPublishPromptPanel.OnChangeDropDown(data)
    UIArrestPublishPromptPanel.rid = tonumber(data.ExtraData)
    UIArrestPublishPromptPanel.rName = data.Label
    UIArrestPublishPromptPanel.RefreshNameLabel()
end

---系统说明按钮
function UIArrestPublishPromptPanel:OnHelpBtnClicked()
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(140)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

--endregion

--region UI

function UIArrestPublishPromptPanel.RefershGold()
    local list = CS.Cfg_GlobalTableManager.Instance:GetNeedCoinList()
    if list.Count < 3 then
        return
    end

    local needInfo = nil
    local id = nil
    if list.Count >= 4 then
        -- 判断悬赏令
        needInfo = string.Split(list[4], '#')
        id = tonumber(needInfo[2])
        local count = tonumber(needInfo[1])
        local hasCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(id)
        UIArrestPublishPromptPanel.isRefresh = true
        if count > hasCount then
            needInfo = string.Split(list[1], '#')
            id = tonumber(needInfo[2])
            UIArrestPublishPromptPanel.isRefresh = false
        end
    else
        needInfo = string.Split(list[1], '#')
        id = tonumber(needInfo[2])
        UIArrestPublishPromptPanel.isRefresh = false
    end

    local isFind = false
    isFind, UIArrestPublishPromptPanel.goldTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        UIArrestPublishPromptPanel.goldName = CS.Cfg_ItemsTableManager.Instance:GetItemName(id)
        UIArrestPublishPromptPanel.Sprite.spriteName = UIArrestPublishPromptPanel.goldTbl.icon
    end
    UIArrestPublishPromptPanel.itemgold.text = needInfo[1]
end

--[[ 废弃
function UIArrestPublishPromptPanel.InitDropDown()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    local enemyDic = CS.CSScene.MainPlayerInfo.FriendInfoV2.EnemyDic
    local namelist = {}
    local idList = {}
    for i, v in pairs(enemyDic) do
        if UIArrestPublishPromptPanel.isFirst and UIArrestPublishPromptPanel.rid == 0 then
            UIArrestPublishPromptPanel.DropDown:SetCaptionLabel(v.name, tostring(v.rid))
        end
        table.insert(idList, v.rid)
        table.insert(namelist, v.name)
    end
    UIArrestPublishPromptPanel.DropDown:SetOptions(namelist, idList)
    UIArrestPublishPromptPanel.RefreshNameLabel()
end
]]--
function UIArrestPublishPromptPanel.RefreshNameLabel()
    UIArrestPublishPromptPanel.Label.text = UIArrestPublishPromptPanel.rName == "" and '悬赏对象名称' or UIArrestPublishPromptPanel.rName
end

function UIArrestPublishPromptPanel.RefreshPlayerLoopPlus()

    if UIArrestPublishPromptPanel.curTemplate ~= nil then
        UIArrestPublishPromptPanel.curTemplate:SetHeightlightState(false)
    end

    if UIArrestPublishPromptPanel.isInitLoopPlus then
        UIArrestPublishPromptPanel.isInitLoopPlus = false
        UIArrestPublishPromptPanel.playerLoopPlus:Init(UIArrestPublishPromptPanel.RefreshTempCallBack, nil)
    else
        UIArrestPublishPromptPanel.playerLoopPlus:ResetPage()
    end
end

function UIArrestPublishPromptPanel.RefreshTempCallBack(go, line)
    if go == nil or CS.StaticUtility.IsNull(go) or line + 1 > #UIArrestPublishPromptPanel.findPlayerInfoTbl then
        return false
    end
    local template = UIArrestPublishPromptPanel.TemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIArrestPromptUnitTemplate) or UIArrestPublishPromptPanel.TemplateDic[go]
    local temp = {}
    temp.playerInfo = UIArrestPublishPromptPanel.findPlayerInfoTbl[line + 1]
    temp.callBack = function()
        if UIArrestPublishPromptPanel.curTemplate ~= nil then
            UIArrestPublishPromptPanel.curTemplate:SetHeightlightState(false)
        end
        UIArrestPublishPromptPanel.curTemplate = template
        template:SetHeightlightState(true)
    end
    template:SetTemplate(temp)
    if UIArrestPublishPromptPanel.TemplateDic[go] == nil then
        UIArrestPublishPromptPanel.TemplateDic[go] = template
    end
    return true
end
--endregion

--region otherFunction

function UIArrestPublishPromptPanel.ShowBubbleTips(go, id, ...)
    if go == nil then
        return
    end
    local str = ''
    if ... ~= nil then
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(id)
        if isfind then
            str = string.format(data.content, ...)
        end
    end
    Utility.ShowPopoTips(go, (str == '' or str == "") and nil or str, id, "UIArrestPublishPromptPanel")
end

--endregion

--region ondestroy

function ondestroy()
    if UIArrestPublishPromptPanel.closeCallBack ~= nil then
        UIArrestPublishPromptPanel.closeCallBack()
    end
end

--endregion

return UIArrestPublishPromptPanel