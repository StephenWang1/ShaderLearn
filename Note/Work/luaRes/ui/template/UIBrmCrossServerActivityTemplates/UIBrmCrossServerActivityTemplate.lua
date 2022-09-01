---@class UIBrmCrossServerActivityTemplate
local UIBrmCrossServerActivityTemplate = {}

---@param data TABLE.cfg_bairimen_activity
function UIBrmCrossServerActivityTemplate:Init(data)
    self.data = data
    self.id = data:GetId()
    self:InitParam()
    self:BindEvents()
end

function UIBrmCrossServerActivityTemplate:InitParam()
    self.lb_title = self:Get("LF/lb_title", "UILabel")
    self.lb_server = self:Get("LF/lb_server", "UILabel")
    self.backGround = self:Get("backGround", "CSUIEffectLoad")
    self.LabelTime = self:Get("LabelTime", "UICountdownLabel")
    self.EnterBtn = self:Get("btn_go", "GameObject")
    self.des = self:Get("ZJB/lb_des", "Top_UILabel")
    self.CrossServerdes = self:Get("GWGC/lb_des", "Top_UILabel")
end

function UIBrmCrossServerActivityTemplate:BindEvents()
    CS.UIEventListener.Get(self.EnterBtn).onClick = function(go)
        self:ClickOperation(go)
    end
end

function UIBrmCrossServerActivityTemplate:Refresh()
    self.lb_title.gameObject:SetActive(false)
    self.lb_server.gameObject:SetActive(false)
    self.backGround:ChangeEffect(self.data:GetBackground())
    if (self.id == 50001 or self.id == 50002 or self.id == 50003) then
        if (gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()) then
            self.EnterBtn:SetActive(true)
            self.LabelTime.gameObject:SetActive(false)
        else
            self.EnterBtn:SetActive(false)
            self.LabelTime.gameObject:SetActive(true)
            self:RefreshLabelTime()
        end
        self:RefreshDes(self.id)
    else
        if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(self.data:GetAdvanceTime().list)) then
            self.EnterBtn:SetActive(true)
            self.LabelTime.gameObject:SetActive(false)
        else
            self.EnterBtn:SetActive(false)
            self.LabelTime.gameObject:SetActive(true)
            self:RefreshLabelTime()
        end
    end
end

---@param des string 跨在一起的服务器， 格式：1001,1003
function UIBrmCrossServerActivityTemplate:GetCrossServerHistoryDes(des)
    local stab = string.Split(des, ',')
    local text = ""
    for i = 1, #stab do
        local serverId = tonumber(stab[i]) / 1000
        ---@type CS.CSServerItem
        local serverItem = CS.HttpRequest.Instance.ServerFile:GetServerItem(serverId);
        if(serverItem ~= nil) then
            text = text .. serverItem.ServerName .. 's' .. tostring(math.floor(tonumber(stab[i]) / 1000)) .. '\n'
        else
            text = text .. 's' .. tostring(math.floor(tonumber(stab[i]) / 1000)) .. '\n'
        end
    end
    text = string.sub(text, 1, -2)
    return text
end

function UIBrmCrossServerActivityTemplate:RefreshDes(id)
    if (id == 50001) then
        self.CrossServerdes.gameObject:SetActive(true)
        self.des.gameObject:SetActive(false)
        self.CrossServerdes.gameObject:SetActive(false)
        local OpenKuaFuNum = gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum()
        if (gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetShareMapInfo() ~= nil
                and gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetCrossServerHistory() ~= nil
                and gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetCrossServerHistory()[OpenKuaFuNum] ~= nil) then

            ---得到当前合服次数的合服数据
            ---@type string 跨在一起的服务器， 格式：1001,1003
            local shareServers = gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetCrossServerHistory()[OpenKuaFuNum].shareServers
            --local shareServers = "2000,3000,4000,5000"
            self.lb_title.gameObject:SetActive(true)
            self.LabelTime.gameObject:SetActive(true)
            self.lb_server.gameObject:SetActive(true)
            self.lb_server.fontSize = 18;
            self.lb_server.text = "[FFFAB3]" .. self:GetCrossServerHistoryDes(shareServers) .. "[-]"
        else
            self.LabelTime.gameObject:SetActive(false)
            self.LabelTime:StopCountDown()
            self.lb_server.gameObject:SetActive(true)
            self.lb_server.fontSize = 20;
            self.lb_server.text = "[dde6eb]等待其他服务器联通[-]"
        end
    else
        self.CrossServerdes.gameObject:SetActive(false)
        self.des.gameObject:SetActive(true)
        self.des.text = string.gsub(self.data:GetDescribe(), "\\n", "\n")
    end
end

function UIBrmCrossServerActivityTemplate:RefreshLabelTime()
    if (self.id == 50001 or self.id == 50002 or self.id == 50003) then
        self.LabelTime:StartCountDown(100, 3, gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetShareOpenTime(), "", "后开启", nil, function()
            self.LabelTime:StopCountDown()
            self.EnterBtn:SetActive(true)
            self.LabelTime.gameObject:SetActive(false)
        end)
    elseif (self.id == 50004) then
        local isGetTable, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(self.data:GetAdvanceTime().list[1])
        if (isGetTable) then
            local time = CS.CSScene.MainPlayerInfo.OpenServerTime * 1000 + conditionTable.conditionParam.list[0] * 24 * 60 * 60 * 1000
            self.LabelTime:StartCountDown(100, 3, time, "", "后开启", nil, function()
                self.LabelTime:StopCountDown()
                self.EnterBtn:SetActive(true)
                self.LabelTime.gameObject:SetActive(false)
            end)
        end
    end
end

--region OnClick
---点击操作
function UIBrmCrossServerActivityTemplate:ClickOperation(go)
    local confirmType, confirmParam, failType, failParam = self:ParseData(self.data:GetEventParameters())
    --if true then
    if confirmType == 1 then
        ---副本寻找对应npc
        if confirmParam ~= nil then
            if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(
                    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(confirmParam))
                    >= 0 then
                uimanager:ClosePanel("UIWhiteSunGatePanel")
            end
        end
    elseif confirmType == 2 then
        ---气泡id
        Utility.ShowPopoTips(go, nil, failParam, "UIBrmCrystalPanel")
    elseif confirmType == 3 then
        ---跳转界面
        if confirmParam then
            uiTransferManager:TransferToPanel(confirmParam)
        end
    elseif confirmType == 4 then
        ---直接传送
        if confirmParam ~= nil then
            local deliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(confirmParam)
            if deliverTbl then
                local toMapID = deliverTbl:GetToMapId()
                ---@type TABLE.CFG_MAP
                local mapTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(toMapID)
                if mapTbl then
                    local conditionList = mapTbl.conditionId
                    if conditionList ~= nil and conditionList.list.Count > 0 then
                        local res, failConditionID = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionListAndReturnReason(conditionList.list)
                        if res == false then
                            if failConditionID ~= 0 then
                                ---@type TABLE.CFG_CONDITIONS
                                local conditionTblExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(failConditionID)
                                if conditionTbl then
                                    local conditionType = conditionTbl.conditionType
                                    if conditionType == 1 then
                                        Utility.ShowPopoTips(go, "等级不足", 290, "UIBrmCrystalPanel")
                                    elseif conditionType == 3 then
                                        Utility.ShowPopoTips(go, "转生不足", 290, "UIBrmCrystalPanel")
                                    end
                                end
                            end
                            return
                        end
                    end
                    networkRequest.ReqDeliverByConfig(confirmParam)
                    uimanager:ClosePanel("UIWhiteSunGatePanel")
                end
            end
        end
    end
end

---解析数据
---@public
---@param eventParams string
---@return number, number, number|nil, number|nil
function UIBrmCrossServerActivityTemplate:ParseData(eventParams)
    local confirmType, confirmData, failType, failData
    if eventParams ~= nil and eventParams ~= "" then
        local strs1 = string.Split(eventParams, '&')
        if strs1 ~= nil then
            local confirmParams = strs1[1]
            if confirmParams ~= nil then
                local strs1Strs1 = string.Split(confirmParams, '#')
                if #strs1Strs1 >= 1 then
                    confirmType = tonumber(strs1Strs1[1])
                end
                if #strs1Strs1 >= 2 then
                    confirmData = tonumber(strs1Strs1[2])
                end
                local failParams = strs1[2]
                local strs2Strs1 = string.Split(failParams, '#')
                if #strs2Strs1 >= 1 then
                    failType = tonumber(strs2Strs1[1])
                end
                if #strs2Strs1 >= 2 then
                    failData = tonumber(strs2Strs1[2])
                end
            end
        end
    end
    return confirmType, confirmData, failType, failData
end
--endregion
return UIBrmCrossServerActivityTemplate