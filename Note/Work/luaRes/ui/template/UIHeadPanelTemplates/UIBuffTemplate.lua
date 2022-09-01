---Buff
local UIBuffTemplate = {}

--region 初始化
function UIBuffTemplate:GetClientBuffDic()
    if self.playerType == LuaEnumRolePanelType.MainPlayer and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BuffInfo ~= nil then
        return CS.CSScene.MainPlayerInfo.BuffInfo.ClientBuffDic
    elseif self.playerType == LuaEnumRolePanelType.OtherPlayer and self.avater.BaseInfo ~= nil and self.avater.BaseInfo ~= nil and self.avater.BaseInfo.BuffInfo ~= nil then
        return self.avater.BaseInfo.BuffInfo.ClientBuffDic
    end
end

function UIBuffTemplate:Init()
    self:InitComponents(self.go)
    self:BindUIEvent()
    self:RefreshBuffState()
end

function UIBuffTemplate:OnEnable()
    self:BindClientEvent()
end

function UIBuffTemplate:OnDisable()
    self:RemoveClientEventHandler(CS.CEvent.Buff_RemoveBuff, self.removeBuff)
    self:RemoveClientEventHandler(CS.CEvent.Buff_AddBuff, self.addBuff)
    self:RemoveClientEventHandler(CS.CEvent.Buff_UpdateBuffList, self.refreshBuff)
    self:RemoveClientEventHandler(CS.CEvent.Buff_BuffFlash, self.startFlash)
end

function UIBuffTemplate:Show(playerType, _Avater)
    --如果刷新的为当前其他的return掉
    local id = _Avater == nil and CS.CSScene.MainPlayerInfo.ID or _Avater.BaseInfo.ID
    if id == nil then
        return
    end
    self.playerType = playerType
    if playerType == LuaEnumRolePanelType.MainPlayer then
        self.playerId = CS.CSScene.MainPlayerInfo.ID
        self.buffDic = CS.CSScene.MainPlayerInfo.BuffInfo:GetBuffDic()
        self:RefreshBuff()
    elseif playerType == LuaEnumRolePanelType.OtherPlayer then
        self.avater = _Avater
        self.playerId = _Avater.BaseInfo.ID
        self.buffDic = _Avater.BaseInfo.BuffInfo:GetBuffDic()
        self:RefreshBuff()
    end
end

function UIBuffTemplate:InitComponents(go)
    ---排版组件
    self.allBuff_UIGridContainer = CS.Utility_Lua.GetComponent(go.transform:Find("WidgetRoot/AllBuff"), "UIGridContainer")
    self.allBuff_TweenPos = CS.Utility_Lua.GetComponent(go.transform:Find("WidgetRoot/AllBuff"), "Top_TweenPosition")
    self.buffInfoList_Transform = CS.Utility_Lua.GetComponent(go.transform:Find("WidgetRoot/AllBuff/mainpart"), "Transform")
    self.AllBuff = go
end

function UIBuffTemplate:BindClientEvent()

    if self.removeBuff ~= nil then
        self:RemoveClientEventHandler(CS.CEvent.Buff_RemoveBuff, self.removeBuff)
    end
    self.removeBuff = function(eventId, buffInfo, playerID)
        if playerID == nil then
            return
        end
        if playerID and self.playerId and self.playerId ~= playerID then
            return
        end
        self:RemoveBuff(eventId, buffInfo)
    end
    self:BindClientEventHandler(CS.CEvent.Buff_RemoveBuff, self.removeBuff)

    if self.addBuff ~= nil then
        self:RemoveClientEventHandler(CS.CEvent.Buff_AddBuff, self.addBuff)
    end
    self.addBuff = function(eventId, buffInfo, playerID)
        if playerID == nil then
            return
        end
        if playerID and self.playerId and self.playerId ~= playerID then
            return
        end
        self:AddBuff(eventId, buffInfo)
    end
    self:BindClientEventHandler(CS.CEvent.Buff_AddBuff, self.addBuff)

    if self.refreshBuff ~= nil then
        self:RemoveClientEventHandler(CS.CEvent.Buff_UpdateBuffList, self.refreshBuff)
    end
    self.refreshBuff = function(eventId, playerID)
        if playerID == nil then
            return
        end
        if playerID ~= nil and self.playerId ~= nil and self.playerId ~= playerID then
            self:RefreshBuffList()
        end
    end
    self:BindClientEventHandler(CS.CEvent.Buff_UpdateBuffList, self.refreshBuff)

    if self.startFlash ~= nil then
        self:RemoveClientEventHandler(CS.CEvent.Buff_BuffFlash, self.startFlash)
    end
    self.startFlash = function(eventId, buffId, playerID)
        if playerID == nil then
            return
        end
        if playerID ~= nil and self.playerId ~= nil and self.playerId ~= playerID then
            return
        end
        self:StartFlash(eventId, buffId)
    end
    self:BindClientEventHandler(CS.CEvent.Buff_BuffFlash, self.startFlash)

    if self.playerType == LuaEnumRolePanelType.MainPlayer then
        if self.autoGatherTimeChangedCallBack ~= nil then
            self:RemoveClientEventHandler(CS.CEvent.LastAutoGatherTimesChanged, self.autoGatherTimeChangedCallBack)
        end
        self.autoGatherTimeChangedCallBack = function()
            self:RefreshBuffInfoList()
        end
        self:BindClientEventHandler(CS.CEvent.LastAutoGatherTimesChanged, self.autoGatherTimeChangedCallBack)
    end
end

function UIBuffTemplate:BindUIEvent()
    CS.UIEventListener.Get(self.allBuff_UIGridContainer.gameObject).OnClickLuaDelegate = function()
        if self.allBuff_UIGridContainer.controlList.Count > 0 then
            self:BuffOnClick()
        end
    end
    CS.UIEventListener.Get(self.buffInfoList_Transform.gameObject).OnClickLuaDelegate = function()
        --uimanager:ClosePanel('UIBuffTipsPanel')
        --UIBuffTemplate.buffInfoList_Transform.gameObject:SetActive(false)
    end
end
--endregion

--region 客户端事件
function UIBuffTemplate:RemoveBuff(eventId, buffInfo)
    self:RefreshPlayerBuff(buffInfo)
    self:RefreshBuffState()
    local bufferId = buffInfo.bufferConfigId
    if bufferId == 88000002 then
        self:CloseBubble()
    end
    self:TryRemoveRecycleBuff(buffInfo)
end

---@param buffInfo fightV2.BufferInfo
function UIBuffTemplate:AddBuff(eventId, buffInfo)
    self:RefreshPlayerBuff(buffInfo)
    self:TryShowJuBaoPenBubble(buffInfo)
    self:TryAddAutoRecycleBuff(buffInfo)
end

function UIBuffTemplate:RefreshBuffList()
end

function UIBuffTemplate:StartFlash(eventId, buffId)
    if self.buffers ~= nil then
        for k, v in pairs(self.buffers) do
            if k == buffId then
                self.buffers[k]:StartFlash()
                return
            end
        end
    end
end
--endregion

--region 功能
function UIBuffTemplate:RefreshPlayerBuff(buffInfo)
    if buffInfo.roleId == self.playerId then
        self:RefreshBuff()
    end
end

---@class CustomBuffInfo 自定义buff信息
---@field type LuaEnumBuffSourceType buff数据来演
---@field buffInfo CSBuffInfoItem c#buff数据

---刷新buff
function UIBuffTemplate:RefreshBuff()
    self.buffers = {}   ---buffid对应一个buffClass
    ---@type table<number,CustomBuffInfo>
    self.allBuff_Dic = {}
    if (self.buffDic ~= nil) then
        CS.Utility_Lua.luaForeachCsharp:Foreach(self.buffDic, function(k, v)
            if self:IsBuffAbleToShow(v) then
                ---@type CustomBuffInfo
                local template = {}
                template.type = LuaEnumBuffSourceType.ServerBuff
                template.buffInfo = v
                table.insert(self.allBuff_Dic, template)
            end
        end)
    end

    local dic = self:GetClientBuffDic();
    if (dic ~= nil) then
        CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
            ---@type CustomBuffInfo
            local temp = {}
            temp.buffInfo = v
            temp.type = LuaEnumBuffSourceType.ClientBuff
            table.insert(self.allBuff_Dic, temp)
        end)
    end

    if self.allBuff_Dic ~= nil and self.allBuff_UIGridContainer ~= nil and not CS.StaticUtility.IsNull(self.allBuff_UIGridContainer) then
        self.allBuff_UIGridContainer.MaxCount = #self.allBuff_Dic
        self:RefreshAllBuffers()
    end
    self:RefreshBuffInfoList()
end

---Buff是否可以显示
function UIBuffTemplate:IsBuffAbleToShow(buff)
    if buff and buff.tbl_buff and buff.tbl_buff.icon and buff.tbl_buff.icon ~= '' and buff.IsHide == false then
        return true
    end
    return false
end

---刷新所有的buff
function UIBuffTemplate:RefreshAllBuffers()
    local index = 0
    for k, v in pairs(self.allBuff_Dic) do
        if self.allBuff_UIGridContainer.controlList[index] ~= nil then
            local templateTemp = self:GetTemplateForSingleBuff(self.allBuff_UIGridContainer.controlList[index])
            if templateTemp then
                self.buffers[k] = templateTemp
                templateTemp:Show(v)
            end
            --self.buffers[k] = templatemanager.GetNewTemplate(self.allBuff_UIGridContainer.controlList[index], luaComponentTemplates.UIHeadPanel_SingleBuff)
            --self.buffers[k]:Show(v)
            index = index + 1
        end
    end
end

---@param go UnityEngine.GameObject
---@return UIHeadPanel_SingleBuff
function UIBuffTemplate:GetTemplateForSingleBuff(go)
    if go == nil or CS.StaticUtility.IsNull(go) then
        return
    end
    if self.mTemplateCache == nil then
        self.mTemplateCache = {}
    end
    local template = self.mTemplateCache[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIHeadPanel_SingleBuff)
        self.mTemplateCache[go] = template
    end
    return template
end

---刷新BuffInfoList
function UIBuffTemplate:RefreshBuffInfoList()
    if #self.allBuff_Dic == 0 then
        local panel = uimanager:GetPanel('UIBuffTipsPanel')
        if panel and self.playerId then
            if self.playerId == panel.taregetLid then
                uimanager:ClosePanel('UIBuffTipsPanel')
            end
        end
    else
        ---@type UIBuffTipsPanel
        local panel = uimanager:GetPanel('UIBuffTipsPanel')
        if panel then
            local index = self.playerType == LuaEnumRolePanelType.MainPlayer and 1 or 2
            if panel.showPlayerType == index then
                panel.ShowBuff(self.allBuff_Dic, index)
            end

        end
    end
end

---Buff点击事件
function UIBuffTemplate:BuffOnClick()
    local index = self.playerType == LuaEnumRolePanelType.MainPlayer and 1 or 2
    ---@param panel UIBuffTipsPanel
    uimanager:CreatePanel("UIBuffTipsPanel", function(panel)
        panel.ShowBuff(self.allBuff_Dic, index)
    end, self.playerId)
    self:CloseBubble()
end

---刷新数据
function UIBuffTemplate:RefreshTime()
    if self.RefreshTimeIenumerator ~= nil then
        StopCoroutine(self.RefreshTimeIenumerator)
    end
    self.RefreshTimeIenumerator = StartCoroutine(function()
        while true do
            if self.buffInfoList_Transform.gameObject.activeSelf then
            else
                if self.RefreshTimeIenumerator ~= nil then
                    StopCoroutine(self.RefreshTimeIenumerator)
                end
            end
            self.buffInfo:RefreshTime()
            coroutine.yield(0)
        end
    end)
end

function UIBuffTemplate:SetBuffPos(isUp)
    if not self.allBuff_TweenPos.enabled then
        self.allBuff_TweenPos.enabled = true
    end
    if isUp then
        if self.allBuff_TweenPos then
            self.allBuff_TweenPos:PlayForward()
        end
    else
        if self.allBuff_TweenPos then
            self.allBuff_TweenPos:PlayReverse()
        end
    end

end

function UIBuffTemplate:BindClientEventHandler(eventId, callBack)
    CS.CSNetwork.Instance.ClientEventHander:AddEvent(eventId, callBack)
end

function UIBuffTemplate:RemoveClientEventHandler(eventId, callBack)
    CS.CSNetwork.Instance.ClientEventHander:RemoveEvent(eventId, callBack)
end
--endregion

--region 显示buff聚宝盆提示气泡
---尝试创建聚宝盆提示气泡
---@param buffInfo fightV2.BufferInfo
function UIBuffTemplate:TryShowJuBaoPenBubble(buffInfo)
    local bufferId = buffInfo.bufferConfigId
    if bufferId == 88000002 and not self.HasBuff then
        local str = "----"
        ---@param panel UIBubbleBuffTipsPanel
        uimanager:CreatePanel("UIBubbleBuffTipsPanel", function(panel)
            panel:SetPos(uiStaticParameter.mJuBaoPenBufferPos)
        end, str)
    end
    self:RefreshBuffState()
end

---刷新状态
function UIBuffTemplate:RefreshBuffState()
    local state = Utility.IsPlayerAutoPickOpen()
    self.HasBuff = state == 3
end

---关闭聚宝盆提示
function UIBuffTemplate:CloseBubble()
    uimanager:ClosePanel("UIBubbleBuffTipsPanel")
end

--endregion

--region 限时自动回收buff
---添加自动回收buff
function UIBuffTemplate:TryAddAutoRecycleBuff(buffInfo)
    local bufferId = buffInfo.bufferConfigId
    if self:IsRecycleBuff(bufferId) then
        local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
        configInfo:SetInt(CS.EConfigOption.AutoRecycle, 1)
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():SetTimeLimitRecycleBuff(true)
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():AutoRecycle()
    end
end

---移除自动回收buff
function UIBuffTemplate:TryRemoveRecycleBuff(buffInfo)
    local bufferId = buffInfo.bufferConfigId
    if self:IsRecycleBuff(bufferId) then
        local configInfo = CS.CSScene.MainPlayerInfo.IConfigInfo
        configInfo:SetInt(CS.EConfigOption.AutoRecycle, 0)
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():SetTimeLimitRecycleBuff(false)
    end
end

---@return boolean 是否是回收buff
function UIBuffTemplate:IsRecycleBuff(bufferId)
    local tblInfo = clientTableManager.cfg_buffManager:TryGetValue(bufferId)
    if tblInfo then
        return tblInfo:GetType() == LuaEnumBuffType.AutoRecycle
    end
    return false
end
--endregion

function UIBuffTemplate:OnDestroy()
    if self.RefreshTimeIenumerator ~= nil then
        StopCoroutine(self.RefreshTimeIenumerator)
    end
    if self.buffInfo ~= nil then
        self.buffInfo:OnDestroy()
    end
end

return UIBuffTemplate