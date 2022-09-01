local UISendFlowerPanel = {}

--region局部变量定义
---当前选中玩家信息
UISendFlowerPanel.playerInfo = nil
---当前选中花朵id
UISendFlowerPanel.curFlowerId = nil

UISendFlowerPanel.flowerItemTabelInfo = nil
---本玩家信息
UISendFlowerPanel.mainPlayerInfo = nil
---送花好友是否是同性
UISendFlowerPanel.mIsSameSex = false
---送花种类
UISendFlowerPanel.mSendFlowerType = 3
---存储ID对应模板
UISendFlowerPanel.mIDToTemplate = {}
---存储格子对应模板
UISendFlowerPanel.mGridToTemplate = {}
---存储当前选中物品ItemID对应模板
UISendFlowerPanel.currentChooseFlowerInfo = nil
---存储当前选中花数量
UISendFlowerPanel.mFlowerNum = 1
---存储当前选中花总数量
UISendFlowerPanel.curMaxCount = 0
---送花数量不足时候显示tips
UISendFlowerPanel.mSendFlowerTipsInfo = nil

UISendFlowerPanel.flowerItemIdArray = {}
--endregion

--region 初始化

function UISendFlowerPanel:Init()
    self:AddCollider()
    self:InitComponents()
    self:BindEvents()
    self:BindMessage()
    self:InitData()
end

---@param customData XLua.ILuaTable
---@field customData.rid XLua.Cast.Int64 送花对象ID
---@field customData.name string 送花对象名字
---@field customData.sex XLua.Cast.Int32 送花对象性别
---@field customData.isSharePlayer boolean 是否联服 (默认不是联服)
---@field customData.hostId  number 服务器主机id
function UISendFlowerPanel:Show(customData)
    if customData and customData.rid and customData.name and customData.sex then
        UISendFlowerPanel.playerInfo = customData
        UISendFlowerPanel.InitUI()
    else
        UISendFlowerPanel.OnCloseButtonClicked()
    end
end

--- 初始化组件
function UISendFlowerPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UISendFlowerPanel.mCloseBtn = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    ---@type UnityEngine.GameObject 送花按钮
    UISendFlowerPanel.mSendBtn = self:GetCurComp("WidgetRoot/events/CenterBtn", "GameObject")
    ---@type UISprite
    UISendFlowerPanel.mSendBtnSprite = self:GetCurComp("WidgetRoot/events/CenterBtn/Background", "UISprite")
    ---@type UILabel
    UISendFlowerPanel.mSendBtnLabel = self:GetCurComp("WidgetRoot/events/CenterBtn/Label", "UILabel")
    ---@type UnityEngine.GameObject 增加按钮
    UISendFlowerPanel.addBtn = self:GetCurComp("WidgetRoot/events/add", "GameObject")
    ---@type UnityEngine.GameObject 减少按钮
    UISendFlowerPanel.reduceButton = self:GetCurComp("WidgetRoot/events/reduce", "GameObject")
    ---@type UIInput 输入数量
    UISendFlowerPanel.InputNum = self:GetCurComp("WidgetRoot/events/inputcount", "UIInput")
    ---@type UILabel 送花描述
    UISendFlowerPanel.sendname = self:GetCurComp("WidgetRoot/view/sendname", "UILabel")
    ---@type UILabel 锚点
    UISendFlowerPanel.sendAnchorsLabel = UISendFlowerPanel:GetCurComp("WidgetRoot/view/sendname/Label", "UILabel")
    ---@type UILabel 亲密度描述
    UISendFlowerPanel.dec = UISendFlowerPanel:GetCurComp("WidgetRoot/view/dec", "UILabel")
    ---@type UILabel 最大道具数量
    UISendFlowerPanel.bagNum = UISendFlowerPanel:GetCurComp("WidgetRoot/events/inputcount/bag", "UILabel")
    ---@type Top_UIGridContainer 所有花GridContainer
    UISendFlowerPanel.allFlowerGrid = UISendFlowerPanel:GetCurComp("WidgetRoot/view/ScrollView/Grid", "Top_UIGridContainer")
end

function UISendFlowerPanel:BindEvents()
    CS.UIEventListener.Get(UISendFlowerPanel.mCloseBtn).onClick = UISendFlowerPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UISendFlowerPanel.mSendBtn).onClick = UISendFlowerPanel.OnSendButtonClicked
    CS.UIEventListener.Get(UISendFlowerPanel.addBtn).onClick = UISendFlowerPanel.OnAddButtonClicked
    CS.UIEventListener.Get(UISendFlowerPanel.reduceButton).onClick = UISendFlowerPanel.OnReduceButtonClicked

    -- CS.EventDelegate.Add(UISendFlowerPanel.InputNum.onChange, function()
    --local inputNum = tonumber(UISendFlowerPanel.InputNum.value)
    --if inputNum then
    --    inputNum = inputNum < 0 and 0 or inputNum
    --    if inputNum > UISendFlowerPanel.curMaxCount then
    --        UISendFlowerPanel.InputNum.value = UISendFlowerPanel.curMaxCount
    --    end
    --else
    --    UISendFlowerPanel.InputNum.value = UISendFlowerPanel.curMaxCount
    --end
    --UISendFlowerPanel.RefreshFlowerDes()
    --end)

    UISendFlowerPanel.InputNum.submitOnUnselect = true

    CS.EventDelegate.Add(UISendFlowerPanel.InputNum.onSubmit, function()
        local inputNum = tonumber(UISendFlowerPanel.InputNum.value)
        if CS.StaticUtility.IsNullOrEmpty(inputNum) then
            UISendFlowerPanel.InputNum.value = UISendFlowerPanel.curMaxCount == 0 and 0 or 1
        else
            if inputNum < 0 then
                UISendFlowerPanel.InputNum.value = UISendFlowerPanel.curMaxCount == 0 and 0 or 1
            elseif inputNum > UISendFlowerPanel.curMaxCount then
                UISendFlowerPanel.InputNum.value = UISendFlowerPanel.curMaxCount
            end
        end
        UISendFlowerPanel.RefreshFlowerDes()
    end)

    --CS.UIEventListener.Get(UISendFlowerPanel.GetFlowerItem_GameObject()).onClick = UISendFlowerPanel.OnFlowerItemClicked
    --CS.UIEventListener.Get(UISendFlowerPanel.GetHidChooseButton_GameObject()).onClick = UISendFlowerPanel.CloseChooseFlower
end

function UISendFlowerPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendFlowersMessage, UISendFlowerPanel.OnResSendFlowersMessageReceived)
end

---初始化数据
function UISendFlowerPanel:InitData()
    UISendFlowerPanel.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    UISendFlowerPanel.InputNum.value = 0
    ___, UISendFlowerPanel.mSendFlowerTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(16)
end

--endregion

--region 服务器消息

---送花返回信息
function UISendFlowerPanel.OnResSendFlowersMessageReceived()
    UISendFlowerPanel.OnCloseButtonClicked()
end
--endregion

--region UI函数监听

---点击关闭按钮
function UISendFlowerPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UISendFlowerPanel")
end

---点击送花按钮
function UISendFlowerPanel.OnSendButtonClicked(go)
    local sendNum = tonumber(UISendFlowerPanel.InputNum.value)
    if sendNum ~= 0 and sendNum <= UISendFlowerPanel.curMaxCount and UISendFlowerPanel.playerInfo and UISendFlowerPanel.curFlowerId then
        if CS.CSScene.MainPlayerInfo.BagInfo:MainPlayerCanUseItem(UISendFlowerPanel.curFlowerId) == false then
            Utility.ShowPopoTips(go, nil, 27, "UISendFlowerPanel")
            return
        end
        ---是否联服
        --if UISendFlowerPanel.playerInfo.isSharePlayer then
        --    networkRequest.ReqShareSendFlowers(UISendFlowerPanel.playerInfo.rid, sendNum, UISendFlowerPanel.curFlowerId)
        --else
        --
        --end
        networkRequest.ReqSendFlowers(UISendFlowerPanel.playerInfo.rid, sendNum, UISendFlowerPanel.curFlowerId)
        --if UISendFlowerPanel.mIsSameSex then
        --    uiStaticParameter.LastGoldOrchidType = UISendFlowerPanel.curFlowerId
        --else
        --    uiStaticParameter.LastRoseFlowerType = UISendFlowerPanel.curFlowerId
        --end
        networkRequest.ReqGetTheFlowerCount(UISendFlowerPanel.curFlowerId)
    elseif UISendFlowerPanel.IsAllFlowerIsNull() then
        if UISendFlowerPanel.mSendFlowerTipsInfo then
            --二次弹框确认前往商城
            local TipsInfo = {
                Title = UISendFlowerPanel.mSendFlowerTipsInfo.title,
                LeftDescription = UISendFlowerPanel.mSendFlowerTipsInfo.leftButton,
                RightDescription = UISendFlowerPanel.mSendFlowerTipsInfo.rightButton,
                Content = UISendFlowerPanel.mSendFlowerTipsInfo.des,
                ID = UISendFlowerPanel.mSendFlowerTipsInfo.id,
                CallBack = function()
                    if UISendFlowerPanel.curFlowerId == LuaEnumFlowerType.FirstGoldOrchid or UISendFlowerPanel.curFlowerId == LuaEnumFlowerType.FirstRose then
                        local temp = {}
                        temp.type = LuaEnumBossType.WorldBoss
                        uimanager:CreatePanel("UIBossPanel", nil, temp)
                    else
                        local isFind, jumpId = CS.Cfg_GlobalTableManager.Instance.allFlowerTransShopDic:TryGetValue(UISendFlowerPanel.curFlowerId)
                        if isFind then
                            uiTransferManager:TransferToPanel(tonumber(jumpId))
                        end
                    end
                    UISendFlowerPanel.OnCloseButtonClicked()
                end
            }
            uimanager:CreatePanel("UIPromptPanel", nil, TipsInfo)
        end
    else
        Utility.ShowPopoTips(go, nil, 228, "UISendFlowerPanel")
    end

end

---点击增加按钮
function UISendFlowerPanel.OnAddButtonClicked()
    local curValue = tonumber(UISendFlowerPanel.InputNum.value)
    if curValue and curValue + 1 <= UISendFlowerPanel.curMaxCount then
        UISendFlowerPanel.InputNum.value = curValue + 1
    elseif curValue == UISendFlowerPanel.curMaxCount then
        UISendFlowerPanel.InputNum.value = 1
    end
end

---点击减少按钮
function UISendFlowerPanel.OnReduceButtonClicked()
    local curValue = tonumber(UISendFlowerPanel.InputNum.value)
    if curValue and curValue - 1 > 0 then
        UISendFlowerPanel.InputNum.value = curValue - 1
    elseif curValue == 1 or curValue == 0 then
        UISendFlowerPanel.InputNum.value = tostring(UISendFlowerPanel.curMaxCount)
    end
end

---点击花朵类型回调
function UISendFlowerPanel.OnSelectFlowerCallBack()
    UISendFlowerPanel.RefreshTabelData()
    UISendFlowerPanel.RefreshCurFlowerView()
    networkRequest.ReqGetTheFlowerCount(UISendFlowerPanel.curFlowerId)
end

--endregion

--region UI

---刷新显示面板
function UISendFlowerPanel.InitUI()
    if UISendFlowerPanel.playerInfo and UISendFlowerPanel.mainPlayerInfo then
        UISendFlowerPanel.mIsSameSex = UISendFlowerPanel.playerInfo.sex == Utility.EnumToInt(UISendFlowerPanel.mainPlayerInfo.Sex)
        UISendFlowerPanel.curFlowerId = UISendFlowerPanel.SelectFlowerType(UISendFlowerPanel.mIsSameSex)
        --UISendFlowerPanel.curFlowerId = ternary(UISendFlowerPanel.mIsSameSex, uiStaticParameter.LastGoldOrchidType, uiStaticParameter.LastRoseFlowerType)
        UISendFlowerPanel.RefreshTabelData()
        UISendFlowerPanel.RefreshCurFlowerView()
        UISendFlowerPanel.InitSelectState()
        UISendFlowerPanel.InitFlowerGrid()
        UISendFlowerPanel.SetFlowerTemplateInfo()
    end
end

---初始化选中状态
function UISendFlowerPanel.InitSelectState()
    if UISendFlowerPanel.mGridToTemplate == nil then
        return
    end
    local currentTemplate = UISendFlowerPanel.mGridToTemplate[UISendFlowerPanel.curFlowerId]
    if currentTemplate then
        currentTemplate:ChooseItem(true)
    end
end

---初始化花列表
function UISendFlowerPanel.InitFlowerGrid()
    UISendFlowerPanel.mIDToTemplate = {}
    UISendFlowerPanel.mGridToTemplate = {}
    UISendFlowerPanel.allFlowerGrid.MaxCount = UISendFlowerPanel.mSendFlowerType
    for i = 0, UISendFlowerPanel.mSendFlowerType - 1 do
        local grid = UISendFlowerPanel.allFlowerGrid.controlList[i]
        ---@type UISendFlowerPanelGridTemplate
        local itemTemplate = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UISendFlowerPanelGridTemplate)
        UISendFlowerPanel.mIDToTemplate[i] = itemTemplate
        CS.UIEventListener.Get(grid).onClick = function()
            --当前已经被选中弹出tips
            if UISendFlowerPanel.curFlowerId == itemTemplate.flowerType then
                if UISendFlowerPanel.flowerItemTabelInfo then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UISendFlowerPanel.flowerItemTabelInfo, showRight = false })
                end
                return
            end

            --已经选中模板
            if UISendFlowerPanel.curFlowerId then
                local currentTemplate = UISendFlowerPanel.mGridToTemplate[UISendFlowerPanel.curFlowerId]
                if currentTemplate then
                    currentTemplate:ChooseItem(false)
                end
            end
            --当前选中模板
            UISendFlowerPanel.curFlowerId = itemTemplate.flowerType
            itemTemplate:ChooseItem(true)
            UISendFlowerPanel.OnSelectFlowerCallBack()
        end
    end
end

---设置模板（将花ID传给模板，在点击的时候从模板取值）
function UISendFlowerPanel.SetFlowerTemplate(template, Id)
    if template then
        template:RefreshGrid(Id)
        UISendFlowerPanel.mGridToTemplate[Id] = template
        template:ChooseItem(Id == UISendFlowerPanel.curFlowerId)
    end
end

---刷新选中花信息显示
function UISendFlowerPanel.RefreshCurFlowerView()
    if UISendFlowerPanel.curFlowerId and UISendFlowerPanel.curFlowerId then
        UISendFlowerPanel.RefreshFlowerLowView()
        UISendFlowerPanel.RefreshFlowerDes()
    end
end

---刷新中部
function UISendFlowerPanel.RefreshFlowerDes()
    local intimate = 0
    if UISendFlowerPanel.flowerItemTabelInfo == nil then
        return
    end
    if UISendFlowerPanel.flowerItemTabelInfo and UISendFlowerPanel.flowerItemTabelInfo.useParam then
        intimate = UISendFlowerPanel.flowerItemTabelInfo.useParam.list[0]
    end
    local sendCount = UISendFlowerPanel.InputNum.value
    if UISendFlowerPanel.dec then
        local addInfo = ternary(intimate == 1, "", "并公告全服")
        if sendCount == "" or sendCount == '' then
            sendCount = "1"
        end
        ---是否为联服玩家
        if UISendFlowerPanel.playerInfo.isSharePlayer then
            UISendFlowerPanel.dec.text = "增加" .. intimate * tonumber(sendCount) .. "点魅力值" .. addInfo
        else
            UISendFlowerPanel.dec.text = "增加" .. intimate * tonumber(sendCount) .. "点亲密度" .. addInfo
        end
    end

    if UISendFlowerPanel.playerInfo ~= nil and UISendFlowerPanel.InputNum ~= nil then
        ---是否为联服玩家非本服
        if UISendFlowerPanel.playerInfo.hostId ~= nil and not luaclass.RemoteHostDataClass:SameMainPlayerHostId(UISendFlowerPanel.playerInfo.hostId) then
            local prefixStr = luaclass.RemoteHostDataClass:GetLianFuShowSocialInfoByHostId(UISendFlowerPanel.playerInfo.hostId)
            UISendFlowerPanel.sendname.text = prefixStr .. UISendFlowerPanel.playerInfo.name .. '  ' .. UISendFlowerPanel.flowerItemTabelInfo.name .. 'x' .. sendCount
        else
            UISendFlowerPanel.sendname.text = UISendFlowerPanel.playerInfo.name .. '  ' .. UISendFlowerPanel.flowerItemTabelInfo.name .. 'x' .. sendCount
        end
    end
    if UISendFlowerPanel.sendAnchorsLabel then
        UISendFlowerPanel.sendAnchorsLabel:UpdateAnchors()
    end
end

---刷新底部
function UISendFlowerPanel.RefreshFlowerLowView()
    UISendFlowerPanel.curMaxCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UISendFlowerPanel.curFlowerId)
    UISendFlowerPanel.bagNum.text = UISendFlowerPanel.curMaxCount
    if UISendFlowerPanel.curMaxCount and UISendFlowerPanel.curMaxCount > 0 then
        UISendFlowerPanel.mFlowerNum = 1
    else
        UISendFlowerPanel.mFlowerNum = 0
    end
    UISendFlowerPanel.InputNum.value = UISendFlowerPanel.mFlowerNum
    UISendFlowerPanel.mSendBtnSprite.alpha = UISendFlowerPanel.mFlowerNum == 0 and 0.5 or 1
    UISendFlowerPanel.mSendBtnLabel.alpha = UISendFlowerPanel.mFlowerNum == 0 and 0.5 or 1
end

---点击选择花种类
function UISendFlowerPanel.SetFlowerTemplateInfo()
    -- UISendFlowerPanel.GetChooseFlowerRoot_GameObject():SetActive(true)
    if UISendFlowerPanel.mIDToTemplate then
        local ID0 = ternary(UISendFlowerPanel.mIsSameSex, LuaEnumFlowerType.FirstGoldOrchid, LuaEnumFlowerType.FirstRose)
        UISendFlowerPanel.SetFlowerTemplate(UISendFlowerPanel.mIDToTemplate[0], ID0)
        table.insert(UISendFlowerPanel.flowerItemIdArray, ID0)
        local ID1 = ternary(UISendFlowerPanel.mIsSameSex, LuaEnumFlowerType.SecondGoldOrchid, LuaEnumFlowerType.SecondRose)
        UISendFlowerPanel.SetFlowerTemplate(UISendFlowerPanel.mIDToTemplate[1], ID1)
        table.insert(UISendFlowerPanel.flowerItemIdArray, ID1)
        local ID2 = ternary(UISendFlowerPanel.mIsSameSex, LuaEnumFlowerType.ThirdGoldOrchid, LuaEnumFlowerType.ThirdRose)
        UISendFlowerPanel.SetFlowerTemplate(UISendFlowerPanel.mIDToTemplate[2], ID2)
        table.insert(UISendFlowerPanel.flowerItemIdArray, ID2)
    end
end

---关闭选择
function UISendFlowerPanel.CloseChooseFlower()
    UISendFlowerPanel.GetChooseFlowerRoot_GameObject():SetActive(false)
end
--endregion

--region otherFunc

---筛选根据花的优先级筛选花类型
function UISendFlowerPanel.SelectFlowerType(isSameSex)
    if CS.CFg_GlobalTableManager.Instance.mAllFlowerDic ~= nil then
        local key = isSameSex and 2 or 1
        local isFind, flowerList = CS.Cfg_GlobalTableManager.CfgInstance.mAllFlowerDic:TryGetValue(key)
        if isFind then
            local length = flowerList.Length - 1
            --从第二位开始遍历 第一位为类型
            for i = 1, length do
                local flowerId = tonumber(flowerList[i])
                local isHad = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(flowerId)
                if isHad then
                    return flowerId
                end
            end
        end
    end
    return ternary(UISendFlowerPanel.mIsSameSex, LuaEnumFlowerType.FirstGoldOrchid, LuaEnumFlowerType.FirstRose)
end

function UISendFlowerPanel.RefreshTabelData()
    local isFind
    isFind, UISendFlowerPanel.flowerItemTabelInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UISendFlowerPanel.curFlowerId)
end

function UISendFlowerPanel.IsAllFlowerIsNull()
    for i = 1, #UISendFlowerPanel.flowerItemIdArray do
        local ishas = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(UISendFlowerPanel.flowerItemIdArray[i])
        if ishas then
            return false
        end
    end
    return true
end

--endregion

--region onDestroy
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSendFlowersMessage, UISendFlowerPanel.OnResSendFlowersMessageReceived)
end
--endregion

return UISendFlowerPanel