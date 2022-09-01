---对话框提示模板
local UIBtnListTemplate = {}
function UIBtnListTemplate:Init()
    self:InitComponents()
    self:BindEvents()
end

---通过工具生成 控件变量
function UIBtnListTemplate:InitComponents()
    --标题
    self.mTitle_UILabel = self:Get("window/Label", "UILabel")
    --按钮排版组件
    self.mbtnGird_UIGridContainer = self:Get("window/Scroll View/itemGrid", "UIGridContainer")
    --遮罩
    self.mShadow_Transform = self:Get("events", "GameObject")
    --关闭按钮
    self.mCloseBtn_GameObject = self:Get("window/btn_close", "GameObject")
    self.wayGetTable = {}
    self.wayGetCount = 0
end
---绑定事件
function UIBtnListTemplate:BindEvents()
    CS.UIEventListener.Get(self.mCloseBtn_GameObject).onClick = UIBtnListTemplate.ClosePanel
    CS.UIEventListener.Get(self.mShadow_Transform).onClick = UIBtnListTemplate.ClosePanel
end
---关闭面板
function UIBtnListTemplate.ClosePanel()
    uimanager:ClosePanel("UIFurnaceWayAndBuyPanel")
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end
---显示
function UIBtnListTemplate:Show(titleName, wayGetList)
    if titleName == nil or wayGetList == nil and wayGetList.Count == nil then
        return
    end
    self.wayGetList = wayGetList
    self:AnalysisWayGet()
    self.mTitle_UILabel.text = titleName
    self.mbtnGird_UIGridContainer.MaxCount = self.wayGetCount
    self.mTitle_UILabel.gameObject:SetActive(self.wayGetCount > 0);
    for i = 0, self.mbtnGird_UIGridContainer.MaxCount - 1 do
        local waygetInfo = self.wayGetTable[i + 1]
        self:SetSingleBtn(i, waygetInfo.name, Utility.IntToBool(waygetInfo.isRecommend), function()
            local openType = waygetInfo.openType
            if openType == LuaEnumWayGetFuncType.CreatePanel then
                uiTransferManager:TransferToPanel(tonumber(waygetInfo.openPanel))
            elseif openType == LuaEnumWayGetFuncType.FindPathAndOpenFlyShose then
                ---寻路并开启小飞鞋
                local tbl = Utility.ParseWayGetFindPathAndOpenFlyShoeOpenPanel(waygetInfo.openPanel)
                if tbl then
                    local deliverID = tbl.deliverID
                    if deliverID then
                        CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(deliverID)
                    else
                        if isOpenLog then
                            luaDebug.LogError("Way_Get表openPanel数据错误  " + waygetInfo.openPanel)
                        end
                    end
                end
            elseif openType == LuaEnumWayGetFuncType.GoAndKillMonster then
                ---前往杀怪
                CS.CSScene.MainPlayerInfo.AsyncOperationController.GoAndKillTargetMonster:DoOperation(waygetInfo.openPanel)
            end
            self.ClosePanel()
        end)
    end
end

---解析屏蔽不显示的获取途径类型
function UIBtnListTemplate:AnalysisWayGet()
    local wayGetList = self.wayGetList
    for k, v in pairs(wayGetList) do
        local waygetInfo = CS.Cfg_Way_GetTableManager.Instance:getAcquiringWay(v)
        if waygetInfo ~= nil and waygetInfo.openType ~= LuaEnumWayGetFuncType.BuyCommodity then
            table.insert(self.wayGetTable, waygetInfo)
            self.wayGetCount = self.wayGetCount + 1
        end
    end
end

---打开界面
function UIBtnListTemplate:OpenPanel(params)
    local panelParams = string.Split(params, "#")
    if panelParams[1] == "UIShopPanel" or "UIBossPanel" then
        uimanager:CreatePanel(panelParams[1], nil, tonumber(panelParams[2]))
    else
        uimanager:CreatePanel(panelParams[1])
    end
end

---设置单个按钮
function UIBtnListTemplate:SetSingleBtn(btnListIndex, btnName, openredPoint, action)
    if btnListIndex == nil or btnName == nil or action == nil then
        return
    end
    local btn = self.mbtnGird_UIGridContainer.controlList[btnListIndex]
    if btn ~= nil then
        local mbtnName = UIBtnListTemplate:GetComp(btn, "Label", "UILabel")
        mbtnName.text = btnName
        CS.UIEventListener.Get(btn.gameObject).onClick = action
    end
    ---角标
    if openredPoint ~= nil and openredPoint ~= false then
        local mbtnredPoint = UIBtnListTemplate:GetComp(btn, "redpoint", "UISprite")
        mbtnredPoint.gameObject:SetActive(true)
    end
end
---获取组件
function UIBtnListTemplate:GetComp(transform, path, componentName)
    return CS.Utility_Lua.GetComponent(transform.transform:Find(path), componentName)
end
return UIBtnListTemplate