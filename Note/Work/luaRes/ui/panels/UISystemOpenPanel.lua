---@class UISystemOpenPanel:UIBase 系统预告面板
local UISystemOpenPanel = {}

--region 初始化

function UISystemOpenPanel:Init()
    self:InitComponents()
    self:InitTemplates()
    UISystemOpenPanel.InitParameters()
    UISystemOpenPanel.BindUIEvents()
    UISystemOpenPanel.BindNetMessage()
    UISystemOpenPanel.InitUI()
end

--- 初始化变量
function UISystemOpenPanel.InitParameters()
    ---@param LuaSystemPreviewInfoMgr
    UISystemOpenPanel.systemMgr = gameMgr:GetPlayerDataMgr():GetSystemPreviewMgr()
    UISystemOpenPanel.targetId = 0
    ---@type systemPreviewInfo
    UISystemOpenPanel.curPageInfo = nil
    ---@type table<UnityEngine.GameObject,UISystemOpenPanel_BookMarkTemplate>
    UISystemOpenPanel.GoAndTemplate = {}
    ---@type table<number,UnityEngine.GameObject>
    UISystemOpenPanel.IdAndGo = {}
end

--- 初始化组件
function UISystemOpenPanel:InitComponents()
    ---@type Top_UIScrollView 列表
    UISystemOpenPanel.systemScrollView = self:GetCurComp("WidgetRoot/view/BookMark", "Top_UIScrollView")
    ---@type Top_UIGridContainer 系统列表
    UISystemOpenPanel.systemGrid = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "Top_UIGridContainer")
    ---@type CSUIEffectLoad 背景图
    UISystemOpenPanel.picLoader = self:GetCurComp("WidgetRoot/view/MainView/pic", "CSUIEffectLoad")
    ---@type Top_UILabel 超链接文本
    UISystemOpenPanel.txt = self:GetCurComp("WidgetRoot/view/MainView/txt", "Top_UILabel")
    ---@type Top_UILabel 描述文本
    UISystemOpenPanel.dexText = self:GetCurComp("WidgetRoot/view/MainView/Info/desText", "Top_UILabel")
    ---@type UnityEngine.GameObject 奖励物品
    UISystemOpenPanel.item = self:GetCurComp("WidgetRoot/view/MainView/Info/reward/UIItemTemplate", "GameObject")
    ---@type UnityEngine.GameObject 领取按钮
    UISystemOpenPanel.getBtn = self:GetCurComp("WidgetRoot/view/MainView/Info/reward/btn_get", "GameObject")
    ---@type UnityEngine.GameObject 已领取
    UISystemOpenPanel.geted = self:GetCurComp("WidgetRoot/view/MainView/Info/reward/geted", "GameObject")
    ---@type UnityEngine.GameObject 查看详情
    UISystemOpenPanel.detailBtn = self:GetCurComp("WidgetRoot/events/btn_detail", "GameObject")
end

function UISystemOpenPanel:InitTemplates()
    ---@type UIItem
    UISystemOpenPanel.rewardItem = templatemanager.GetNewTemplate(UISystemOpenPanel.item, luaComponentTemplates.UIItem)
end

function UISystemOpenPanel.BindUIEvents()
    CS.UIEventListener.Get(UISystemOpenPanel.getBtn).onClick = UISystemOpenPanel.OnClickGetBtn
    CS.UIEventListener.Get(UISystemOpenPanel.detailBtn).onClick = UISystemOpenPanel.OnClickDetailBtn
end

function UISystemOpenPanel.BindNetMessage()
    UISystemOpenPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleSystemPreviewMessage, UISystemOpenPanel.onResRoleSystemPreviewCallBack)
end
--endregion

--region 函数监听

---页签点击回调
function UISystemOpenPanel.PageClickCallBack(bookmarkTbl)
    if bookmarkTbl == nil then
        return
    end
    if bookmarkTbl.pageData == UISystemOpenPanel.curPageInfo then
        return
    end
    UISystemOpenPanel.curPageInfo = bookmarkTbl.pageData

    UISystemOpenPanel.RefreshBookMark(UISystemOpenPanel.curPageInfo.id)

    UISystemOpenPanel.RefreshMainView()
end

---点击查看详情回调
function UISystemOpenPanel.OnClickDetailBtn(go)
    if UISystemOpenPanel.curPageInfo and UISystemOpenPanel.curPageInfo.systemTblData then
        local jumpParam = UISystemOpenPanel.curPageInfo.systemTblData:GetJump()
        local canJump = UISystemOpenPanel.CanJumpTo()
        if canJump == true then
            local jumpType = UISystemOpenPanel.curPageInfo.systemTblData:GetJumpType()
            if jumpType == 1 then
                uiTransferManager:TransferToPanel(tonumber(jumpParam))
            elseif jumpType == 2 then
                local transferResult = Utility.TryTransfer(tonumber(jumpParam))
                if transferResult.resultType == CS.Enum_TransferResult.Success then
                    uimanager:ClosePanel("UISystemOpenMainPanel")
                else
                    Utility.ShowPopoTips(go, nil, 496, "UISystemOpenPanel")
                end
            end
        elseif canJump == false then
            Utility.ShowPopoTips(go, nil, UISystemOpenPanel.curPageInfo.systemTblData:GetPromptframe(), 'UISystemOpenPanel')
        end
    end
end

function UISystemOpenPanel.OnClickGetBtn()
    UISystemOpenPanel.targetId = 0
    networkRequest.ReqRewardSystemPreview(UISystemOpenPanel.curPageInfo.id)
end

--endregion

--region 网络消息处理

function UISystemOpenPanel.onResRoleSystemPreviewCallBack()
    UISystemOpenPanel.InitUI()
end

--endregion

--region UI

function UISystemOpenPanel.InitUI()
    UISystemOpenPanel.RefreshPageView()
end

---刷新页签视图
function UISystemOpenPanel.RefreshPageView()
    local tbl = UISystemOpenPanel.systemMgr:GetSystemPerviewTbl()
    UISystemOpenPanel.systemGrid.MaxCount = #tbl
    for i = 1, #tbl do
        local go = UISystemOpenPanel.systemGrid.controlList[i - 1]
        if go then
            local temp = UISystemOpenPanel.GoAndTemplate[go]
            if temp == nil then
                temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISystemOpenPanel_BookMarkTemplate)
                UISystemOpenPanel.GoAndTemplate[go] = temp
            end

            temp:SetTemplate({
                pageInfo = tbl[i],
                callBack = UISystemOpenPanel.PageClickCallBack
            })

            UISystemOpenPanel.IdAndGo[tbl[i].id] = go
            if UISystemOpenPanel.targetId == 0 then
                UISystemOpenPanel.targetId = tbl[i].id
            end
        end
    end
    UISystemOpenPanel.JumpPage(UISystemOpenPanel.targetId)
end

---刷新主视图
function UISystemOpenPanel.RefreshMainView()
    if UISystemOpenPanel.curPageInfo == nil then
        return
    end

    local tbl = UISystemOpenPanel.curPageInfo.systemTblData
    UISystemOpenPanel.txt.text = string.gsub(tbl:GetImg(), "\\n", "\n")
    --UISystemOpenPanel.picLoader:ChangeEffect(tbl:GetImg())
    UISystemOpenPanel.dexText.text = string.gsub(tbl:GetDesc(), "\\n", "\n")
    if UISystemOpenPanel.getBtn and not CS.StaticUtility.IsNull(UISystemOpenPanel.getBtn) then
        UISystemOpenPanel.getBtn:SetActive(UISystemOpenPanel.curPageInfo.rewardType == LuaEnumGetAwardType.Get)
    end
    if UISystemOpenPanel.geted and not CS.StaticUtility.IsNull(UISystemOpenPanel.geted) then
        UISystemOpenPanel.geted:SetActive(UISystemOpenPanel.curPageInfo.rewardType == LuaEnumGetAwardType.Geted)
    end
    UISystemOpenPanel.RefreshRewardView()
end

---刷新奖励视图
function UISystemOpenPanel.RefreshRewardView()
    if UISystemOpenPanel.rewardItem == nil then
        return
    end
    local tbl = UISystemOpenPanel.curPageInfo.systemTblData
    if tbl:GetReward() == nil or #tbl:GetReward().list == 0 then
        return
    end
    local reward = tbl:GetReward().list[1]
    local id, count = reward.list[1], reward.list[2]
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(id)
    if itemTbl then
        UISystemOpenPanel.rewardItem:RefreshUIWithItemInfo(itemTbl:CsTABLE(), count)
        UISystemOpenPanel.rewardItem:RefreshOtherUI({ showItemInfo = itemTbl:CsTABLE() })
    end
end


--endregion

--region otherFunction

---跳转页签 id为空时会默认跳转第一个
function UISystemOpenPanel.JumpPage(id)
    if id == nil then
        local tbl = UISystemOpenPanel.systemMgr:GetSystemPerviewTbl()
        if #tbl == 0 then
            return
        end
        id = tbl[1].id
    end
    local go = UISystemOpenPanel.IdAndGo[id]
    if go then
        UISystemOpenPanel.PageClickCallBack(UISystemOpenPanel.GoAndTemplate[go])
        return
    end
end

function UISystemOpenPanel.RefreshBookMark(id)
    for i, v in pairs(UISystemOpenPanel.GoAndTemplate) do
        v:RefreshToggleStatu(id)
    end
end

function UISystemOpenPanel.ResetView()
    UISystemOpenPanel.JumpPage()
    UISystemOpenPanel.systemScrollView:Reposition()
end

--- 判断是否可以打开界面
function UISystemOpenPanel.CanJumpTo()
    local noticeId = UISystemOpenPanel.curPageInfo.systemTblData:GetNotice()
    if noticeId == nil or noticeId == 0 then
        return true
    end
    return Utility.CheckSystemOpenState(noticeId)
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UISystemOpenPanel