---@class UIStrongerMainInfoGrid:TemplateBase  设置信息
local UIStrongerMainInfoGrid = {}
function UIStrongerMainInfoGrid:Init()
    self:InitComponents()
end
function UIStrongerMainInfoGrid:InitComponents()
    self.Star = self:Get("Info/title/starGrid", "UIGridContainer")
    self.StarWidget = self:Get("Info/title/starGrid", "UIWidget")
    self.InfoTable = self:Get("Info", "Top_UITable")
    self.Title = self:Get("Info/title/name", "UILabel")
    self.Desc = self:Get("Info/decs", "UILabel")
    self.Develop = self:Get("btn_go", "GameObject")
end
function UIStrongerMainInfoGrid:ShowData(tab)
    if (self.Star ~= nil) then
        self.Star.MaxCount = tab.star
    end
    if (self.Title ~= nil) then
        self.Title.text = tab.name
    end
    if (self.StarWidget ~= nil) then
        self.StarWidget:UpdateAnchors()
    end

    local specialPar = tab.parameter
    local specialParName = ""
    local specialCond = tab.openPanel
    if (tab.jumpType == "4") then
        specialPar, specialCond = self:GetTransferToMapCondition(specialPar)
        if (specialPar ~= nil) then
            local isget, devtb = CS.Cfg_DeliverTableManager.Instance:TryGetValue(specialPar)
            if (isget) then
                specialParName = devtb.showName
            end
        end
    end
    local des
    if tab.describe ~= nil then
        des = CS.Utility_Lua.StringReplace(tab.describe, '\\n', '\n');
    end
    if (self.Desc ~= nil) then
        self.Desc.text = string.CSFormat(des, specialParName)
    end
    if not CS.StaticUtility.IsNull(self.Develop) then
        CS.UIEventListener.Get(self.Develop).onClick = function(go)
            if (tab.jumpType == 4 and specialCond ~= nil and specialCond ~= 0 and not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(specialCond)) then
                --Utility.ShowPopoTips(go.transform, "材料不足", 290)
            else
                if (specialCond == "") then
                    specialCond = nil
                end
                self.OnClickDevelop(tab.jumpType, specialPar, specialCond)
            end
        end
    end
    if self.InfoTable ~= nil then
        self.InfoTable:Reposition()
    end
end
function UIStrongerMainInfoGrid:GetTransferToMapCondition(specialPar)
    if (specialPar ~= nil) then
        local par = string.Split(specialPar, '&')
        for i = 1, #par do
            local par2 = string.Split(par[i], '#')
            if (#par2 > 2) then
                local dev = tonumber(par2[1])
                local speCond = tonumber(par2[2])
                local isCan = true
                for j = 3, #par2 do
                    local id = tonumber(par2[j])
                    isCan = isCan and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(id)
                end
                if (isCan) then
                    return dev, speCond
                end
            end

        end
    end
    return nil
end
function UIStrongerMainInfoGrid.OnClickDevelop(type, parameter, deliver)
    local typeInt = tonumber(type)
    local parInt = tonumber(parameter)
    if (typeInt == 1) then
        if (deliver ~= nil and (parInt == 1005 or parInt == 1006)) then
            deliver = {
                type = tonumber(deliver)
            }
        end
        uiTransferManager:TransferToPanel(parInt, deliver)
    elseif (typeInt == 2) then
        ---变强里寻路到NPC的方法，直接修改成私服通用的传送方式，直接飞到指定的deliver位置，不使用寻路的方式
        if (parameter == "8" and deliver ~= nil) then
            --传送员
            local par = string.Split(deliver, '#')
            if (#par > 1) then
                local mapid = tonumber(par[1])
                local deli = tonumber(par[2])
                --local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(mapid, deli)
                --if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
                --    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(parInt)
                --end

                --CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 1001, 8 }, "UInewTeleportPanel",
                --        CS.EAutoPathFindSourceSystemType.Normal,
                --        CS.EAutoPathFindType.Normal_TowardNPC,
                --        { 0, deli })
                CS.Cfg_DeliverTableManager.Instance:TryTransferByMapNpcId(1001, function(res)
                    uimanager:CreatePanel("UInewTeleportPanel", nil, { 0, deli })
                end)
            else
                CS.Cfg_DeliverTableManager.Instance:TryTransferByMapNpcId(parInt)
                --CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(parInt)
            end
            uimanager:ClosePanel("UISystemOpenMainPanel")
            return
        end
        CS.Cfg_DeliverTableManager.Instance:TryTransferByMapNpcId(parInt)
        --CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(parInt)
    elseif typeInt == 3 then
        Utility.TransferShopChooseStore(parInt)
    elseif typeInt == 4 then
        gameMgr:GetPlayerDataMgr():GetLuaAsyncOperationMgr():TryStartOperation(LuaAsyncOperationType.GoMapPosAndAutoFight, parameter)
    elseif typeInt == 5 then
        uiTransferManager:TransferToPanel(parInt)
    end
    uimanager:ClosePanel("UISystemOpenMainPanel")
end
return UIStrongerMainInfoGrid