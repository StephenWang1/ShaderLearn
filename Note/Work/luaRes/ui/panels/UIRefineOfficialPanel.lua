---@class UIRefineOfficialPanel 功勋炼制
local UIRefineOfficialPanel = {}

function UIRefineOfficialPanel:InitComponents()
    ---炼制功勋次数+描述
    self.remainTime = self:GetCurComp("WidgetRoot/remainTime", "UILabel")
    ---当前等级
    self.beforeNum = self:GetCurComp("WidgetRoot/lvChange/before/num", "UILabel")
    ---炼制后等级
    self.afterNum = self:GetCurComp("WidgetRoot/lvChange/after/num", "UILabel")
    ---炼制列表
    self.Grid = self:GetCurComp("WidgetRoot/gain/Grid", "Top_UIGridContainer")
    ---炼制按钮
    self.EnterBtn = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    ---炼制关闭
    self.CloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    ---炼制帮助
    self.btn_help = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    ---Grid
    self.Grid = self:GetCurComp("WidgetRoot/gain/Grid", "Top_UIGridContainer")
    ---成功特效
    self.succedEffect = self:GetCurComp("WidgetRoot/succedEffect", "GameObject")

end

function UIRefineOfficialPanel:InitOther()
    CS.UIEventListener.Get(self.EnterBtn).onClick = function(go)
        self:OnClickedEnterBtn(go)
    end
    CS.UIEventListener.Get(self.CloseBtn).onClick = function(go)
        self:OnClickedCloseBtn()
    end
    CS.UIEventListener.Get(self.btn_help).onClick = function(go)
        self:OnClickedbtn_help()
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterPanelMessage, UIRefineOfficialPanel.OnResRefineMasterPanel)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefineMasterResultMessage, UIRefineOfficialPanel.OnResRefineMasterResultFun)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if UIRefineOfficialPanel.datacfgId ~= nil then
            UIRefineOfficialPanel.RefreshGrid(UIRefineOfficialPanel.datacfgId)
        end
    end)
end

---初始化数据
function UIRefineOfficialPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UIRefineOfficialPanel:Show()
    UIRefineOfficialPanel.nowMaxCount = gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():GetLianZhiCount(3)
    networkRequest.ReqRefineMasterPanel(3)
end

---请求炼制
function UIRefineOfficialPanel:OnClickedEnterBtn(go)
    if (UIRefineOfficialPanel.mCount >= self.nowMaxCount) then
        Utility.ShowPopoTips(go.transform, nil, 238)
    else
        if UIRefineOfficialPanel.nowSelect ~= nil then
            if UIRefineOfficialPanel.IsMeetShowTip(go) == false then
                networkRequest.ReqRefineMaster(3, 0, UIRefineOfficialPanel.nowSelect.nowIndex + 1)
            end
        end
    end
end

---返回炼制大师面板信息
function UIRefineOfficialPanel.OnResRefineMasterPanel(id, data)
    UIRefineOfficialPanel.cfgId = data.cfgId
    UIRefineOfficialPanel.datacfgId = data.cfgId
    UIRefineOfficialPanel.RefreshGrid(data.cfgId)
    UIRefineOfficialPanel.RefreshLevel()
    UIRefineOfficialPanel.mCount = data.count
    UIRefineOfficialPanel.remainTime.text = "炼制功勋  [878787]剩[-]" .. Utility.GetBBCode(UIRefineOfficialPanel.nowMaxCount - data.count ~= 0) .. tostring(UIRefineOfficialPanel.nowMaxCount - data.count) .. "[-][878787]次[-]"
    --end
end

---炼制成功返回消息
function UIRefineOfficialPanel.OnResRefineMasterResultFun(id, data)
    UIRefineOfficialPanel.RefreshLevel()
    UIRefineOfficialPanel.succedEffect.gameObject:SetActive(false)
    UIRefineOfficialPanel.succedEffect.gameObject:SetActive(true)
    UIRefineOfficialPanel.mCount = data.count
    UIRefineOfficialPanel.remainTime.text = "炼制功勋  [878787]剩[-]" .. Utility.GetBBCode(UIRefineOfficialPanel.nowMaxCount - data.count ~= 0) .. tostring(UIRefineOfficialPanel.nowMaxCount - data.count) .. "[-][878787]次[-]"
    if Utility.IsOpenLianZhiGongXun() == false then
        UIRefineOfficialPanel:OnClickedCloseBtn()
    end

end

---关闭面板
function UIRefineOfficialPanel:OnClickedCloseBtn()
    uimanager:ClosePanel("UIRefineOfficialPanel")
end

---炼制帮助点击
function UIRefineOfficialPanel:OnClickedbtn_help()
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(190)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

UIRefineOfficialPanel.isStartRefreshGrid = false

function UIRefineOfficialPanel.RefreshGrid(id)
    ---@type table<number,checkSelectData>
    UIRefineOfficialPanel.checkList = {}
    local Grid = UIRefineOfficialPanel.Grid
    ---@type table<number,TableRefineDetailedInfo>
    local detailedInfo = clientTableManager.cfg_refine_masterManager:GetSingleRefineDetailedInfo(id, true)
    if detailedInfo == nil then
        return
    end
    Grid.MaxCount = #detailedInfo
    local index = 0
    for i, v in pairs(detailedInfo) do
        local go = Grid.controlList[index]
        ---单选框
        local Table = CS.Utility_Lua.GetComponent(go.transform:Find("Table"), "Top_UITable")
        ---单选框
        local check = CS.Utility_Lua.GetComponent(go.transform:Find("Table/check"), "GameObject")
        ---单选框选中
        local checkSelect = CS.Utility_Lua.GetComponent(go.transform:Find("Table/check/check"), "GameObject")
        ---炼制获得的道具数量
        local num = CS.Utility_Lua.GetComponent(go.transform:Find("Table/num"), "Top_UILabel")
        ---消耗道具父节点
        local costObj = CS.Utility_Lua.GetComponent(go.transform:Find("cost"), "GameObject")
        ---消耗数量
        local costnum = CS.Utility_Lua.GetComponent(go.transform:Find("cost/num"), "Top_UILabel")
        ---消耗道具Icon
        local costIcon = CS.Utility_Lua.GetComponent(go.transform:Find("cost/icon"), "Top_UISprite")
        check.gameObject:SetActive(#detailedInfo ~= 1)
        num.text = v.gain
        costObj.gameObject:SetActive(v.itemCost ~= 0)
        costnum.text = gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():GetHuaFeiDes(v.itemCost, v.itemID)
        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(v.itemID)
        if itemTable ~= nil then
            costIcon.spriteName = itemTable:GetIcon()
        end

        ---@class UIRefineOfficialPanel_checkSelectData
        local checkSelectData = {
            ---@type GameObject
            obj = check,
            ---@type GameObject
            checkSelect = checkSelect,
            ---@type number
            nowIndex = index,
            ---@type TableRefineDetailedInfo
            dataInfo = v
        }
        if UIRefineOfficialPanel.isStartRefreshGrid == false then
            if index == 0 then
                UIRefineOfficialPanel.nowSelect = checkSelectData
            end
            checkSelect.gameObject:SetActive(index == 0)
        end
        table.insert(UIRefineOfficialPanel.checkList, checkSelectData)
        CS.UIEventListener.Get(check.gameObject).onClick = function(go)
            for i, v in pairs(UIRefineOfficialPanel.checkList) do
                if v.obj == go then
                    v.checkSelect.gameObject:SetActive(true)
                    UIRefineOfficialPanel.nowSelect = checkSelectData
                else
                    v.checkSelect.gameObject:SetActive(false)
                end
            end
            UIRefineOfficialPanel.RefreshLevel()
        end
        Table:Reposition()
        index = index + 1
    end
    UIRefineOfficialPanel.isStartRefreshGrid = true
end

---刷新炼制后的等级
function UIRefineOfficialPanel.RefreshLevel()
    UIRefineOfficialPanel.beforeNum.text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
    if UIRefineOfficialPanel.nowSelect == nil or UIRefineOfficialPanel.nowSelect.dataInfo == nil then
        return
    end
    ---@type TableRefineDetailedInfo
    local dataInfo = UIRefineOfficialPanel.nowSelect.dataInfo
    if CS.CSScene.MainPlayerInfo.Exp > dataInfo.cost then
        UIRefineOfficialPanel.afterNum.text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level
    else
        UIRefineOfficialPanel.afterNum.text = CS.CSScene.Sington.MainPlayer.BaseInfo.Level - 1
    end
end

function UIRefineOfficialPanel.IsMeetShowTip(go)
    if UIRefineOfficialPanel.nowSelect == nil then
        return false
    end
    local ItemID = UIRefineOfficialPanel.nowSelect.dataInfo.itemID
    local itemNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(ItemID)
    if UIRefineOfficialPanel.nowSelect.dataInfo.itemCost > itemNumber then
        if ItemID == LuaEnumCoinType.YuanBao then
            Utility.ShowItemGetWay(ItemID, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
        else
            Utility.TryShowFirstRechargePanel()
        end
        return true
    else
        return false
    end
end

return UIRefineOfficialPanel