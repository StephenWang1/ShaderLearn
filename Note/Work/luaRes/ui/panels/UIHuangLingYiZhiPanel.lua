--- 挖宝NPC对话界面
--- Created by Olivier.
--- DateTime: 2021/3/9 15:58
---@class UIHuangLingYiZhiPanel:UIBase
local UIHuangLingYiZhiPanel ={}


UIHuangLingYiZhiPanel.mapIds = {}
UIHuangLingYiZhiPanel.conditionsIds = {}
UIHuangLingYiZhiPanel.deliverIds = {}
UIHuangLingYiZhiPanel.descriptionId = 228
UIHuangLingYiZhiPanel.npcId = 381
UIHuangLingYiZhiPanel.globalId = 22996
UIHuangLingYiZhiPanel.minTransferLv = 22888
UIHuangLingYiZhiPanel.minTransferConditions = { } 

function UIHuangLingYiZhiPanel:Init()
    self:InitVariables()
    self:InitComponents()
    self:BindEvent()
end

function UIHuangLingYiZhiPanel:Show()
    local desCfg = clientTableManager.cfg_descriptionManager:TryGetValue(UIHuangLingYiZhiPanel.descriptionId)
    if desCfg ~= nil then
        local str = string.Split(desCfg:GetValue(), '&')
        self.Components.lb_mapName.text = str[1]
        self.Components.lb_mapDes.text = str[2]
    end
    self:RefreshItemsData()
    self:RefreshGrid()
end

function UIHuangLingYiZhiPanel:OnDestroy()
    self.Components = nil
end

function UIHuangLingYiZhiPanel:InitVariables()
    self.Components = {}
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(UIHuangLingYiZhiPanel.minTransferLv)
    if isFind then
        UIHuangLingYiZhiPanel.minTransferConditions = string.Split(tbl.value, '#')
    end
    
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(UIHuangLingYiZhiPanel.globalId)
    if isFind then
        local str = string.Split(info.value, '#')
        for i = 1, #str do
            local deliverId = tonumber(str[i])
            local deliverCfg = clientTableManager.cfg_deliverManager:TryGetValue(deliverId)
            table.insert(UIHuangLingYiZhiPanel.deliverIds,deliverId)
            if deliverCfg ~= nil then
                table.insert(UIHuangLingYiZhiPanel.mapIds,deliverCfg:GetToMapId())
                local conditions = deliverCfg:GetCondition()
                local conId = 0
                if conditions ~= nil then
                    conId = conditions.list[0].list[0]
                end
                local currentCondis = {}
                for j = 1, #UIHuangLingYiZhiPanel.minTransferConditions do
                    table.insert(currentCondis, tonumber(UIHuangLingYiZhiPanel.minTransferConditions[j]))
                end
                table.insert(currentCondis, conId)
                
                table.insert(UIHuangLingYiZhiPanel.conditionsIds, currentCondis )
            end
        end
    end

    UIHuangLingYiZhiPanel.ItemData = {}
end

function UIHuangLingYiZhiPanel:InitComponents()
    self.Components.grid_conditions = self:GetCurComp('WidgetRoot/Scroll View/SafeArea', 'Top_UIGridContainer')
    self.Components.lb_mapName = self:GetCurComp('WidgetRoot/window/title', 'Top_UILabel')
    self.Components.lb_mapDes = self:GetCurComp('WidgetRoot/introduce/labelGroup/details', 'Top_UILabel')
    self.Components.obj_closeBtn = self:GetCurComp('WidgetRoot/CloseBtn', 'GameObject')
    self.Components.grid_conditions.MaxCount = #UIHuangLingYiZhiPanel.mapIds
end

function UIHuangLingYiZhiPanel:BindEvent()
    CS.UIEventListener.Get(self.Components.obj_closeBtn).onClick = UIHuangLingYiZhiPanel.CloseBtnClick
end

function UIHuangLingYiZhiPanel.CloseBtnClick()
    uimanager:ClosePanel("UIHuangLingYiZhiPanel")
end

function UIHuangLingYiZhiPanel.ItemClick(go)
    if go ~= nil then
        local param = tonumber(CS.UIEventListener.Get(go).parameter)
        if type(param) == "number" and param > 0 then
            local data = UIHuangLingYiZhiPanel.ItemData[param]
            if data.success then
                Utility.TryTransfer(data.deliverId)
                UIHuangLingYiZhiPanel.CloseBtnClick()
            else
                Utility.ShowPopoTips(go.transform,data.txt,483)
            end
        end
    end
end

function UIHuangLingYiZhiPanel:RefreshItemsData()
    local MaxCount = #UIHuangLingYiZhiPanel.mapIds
    for i = 1, MaxCount do
        local data = {}
        data.deliverId = UIHuangLingYiZhiPanel.deliverIds[i]
        data.mapId = UIHuangLingYiZhiPanel.mapIds[i]
        data.conditionId = UIHuangLingYiZhiPanel.conditionsIds[i]
        data.tempMapCfg = clientTableManager.cfg_mapManager:TryGetValue(data.mapId)
        data.name = data.tempMapCfg ~= nil and data.tempMapCfg:GetName() or ""

        data.des = ""
        data.txt = ""
        data.success = true
        data.nameColor = data.mapId == UIHuangLingYiZhiPanel.mapIds[1] and "[fff0c2]" or "[c3f4ff]"
        data.spriteName = data.mapId == UIHuangLingYiZhiPanel.mapIds[1] and "c6" or "c3"
        for j = 1, #data.conditionId do
            if data.conditionId[j] ~= 0 then
                local tempResult = Utility.IsMainPlayerMatchCondition(data.conditionId[j])
                if not tempResult.success then
                    data.des = "[e85038]"..tempResult.txt
                    data.txt = tempResult.txt
                    data.success = false
                    if data.mapId == UIHuangLingYiZhiPanel.mapIds[1] then
                        data.nameColor = "[fff0c2]"
                    else
                        data.nameColor = data.success and "[c3f4ff]" or "[878787]"
                    end
                end
            end
        end
        table.insert(UIHuangLingYiZhiPanel.ItemData,data)
    end
end

function UIHuangLingYiZhiPanel:RefreshGrid()
    local MaxCount = #UIHuangLingYiZhiPanel.mapIds
    for i = 1, MaxCount do
        local go = self.Components.grid_conditions.controlList[i-1]
        local sp_btn = UIHuangLingYiZhiPanel.GetCom(go.transform,"background",'UISprite')
        local lb_name = UIHuangLingYiZhiPanel.GetCom(go.transform,"TitleName",'UILabel')
        local lb_con = UIHuangLingYiZhiPanel.GetCom(go.transform,"condition",'UILabel')
        local data = UIHuangLingYiZhiPanel.ItemData[i]
        sp_btn.spriteName = data.spriteName
        lb_name.text = data.nameColor..data.name
        lb_con.text = data.des
        CS.UIEventListener.Get(go,i).onClick = UIHuangLingYiZhiPanel.ItemClick
    end
end

function UIHuangLingYiZhiPanel.GetCom(trans, path, type)
    if (trans == nil) then
        return nil
    end
    trans = trans:Find(path)
    if (trans == nil) then
        return nil;
    end
    if (type == 'GameObject') then
        return trans.gameObject
    elseif (type == 'Transform') then
        return trans
    end
    return CS.Utility_Lua.GetComponent(trans, type)
end


return UIHuangLingYiZhiPanel