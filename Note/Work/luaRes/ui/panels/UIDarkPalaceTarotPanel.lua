---@class UIDarkPalaceTarotPanel:UIBase 塔罗暗殿
local UIDarkPalaceTarotPanel = {}

--region 数据
---@class DarkPalaceTarotRewardConfigParams
---@field itemId number 道具id
---@field career LuaEnumCareer 职业
---@field sex LuaEnumSex 性别

---获取奖励列表
---@return table<DarkPalaceTarotRewardConfigParams> 需要显示的奖励itemId列表
function UIDarkPalaceTarotPanel:GetRewardItemList()
    if self.activityTblInfo == nil then
        return
    end
    if self.rewardItemList ~= nil then
        return self.rewardItemList
    end
    local rewardStrList = self.activityTblInfo:GetAward().list
    local paramsCount = Utility.GetLuaTableCount(rewardStrList)
    if paramsCount % 3 ~= 0 then
        return {}
    end
    ---@type table<DarkPalaceTarotRewardConfigParams> 配置的所有奖励列表
    local configItemParamsTable = {}
    ---@type DarkPalaceTarotRewardConfigParams
    local curItem = {}
    for k = 1,paramsCount do
        local remainder = k % 3
        if remainder == 1 then
            curItem.itemId = rewardStrList[k]
        elseif remainder == 2 then
            curItem.career = rewardStrList[k]
        elseif remainder == 0 then
            curItem.sex = rewardStrList[k]
            table.insert(configItemParamsTable,curItem)
            curItem = {}
        end
    end
    for k,v in pairs(configItemParamsTable) do
        local mainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        local mainPlayerSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
        ---@type DarkPalaceTarotRewardConfigParams
        local configItemParams = v
        if (configItemParams.career == LuaEnumCareer.Common or configItemParams.career == mainPlayerCareer) and
                (configItemParams.sex == LuaEnumSex.Common or configItemParams.sex == mainPlayerSex) then
            if self.rewardItemList == nil then
                self.rewardItemList = {}
            end
            table.insert(self.rewardItemList,configItemParams)
        end
    end
    return self.rewardItemList
end
--endregion

--region 初始化
function UIDarkPalaceTarotPanel:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIDarkPalaceTarotPanel:InitComponent()
    ---@type UILabel
    self.remainTime_UILabel = self:GetCurComp("WidgetRoot/view/remainTime","UILabel")
    ---@type UIGridContainer
    self.rewardList_UIGridContainer = self:GetCurComp("WidgetRoot/view/scroll/reward","UIGridContainer")
    ---@type UnityEngine.GameObject
    self.TowerCardBtn = self:GetCurComp("WidgetRoot/view/btn_TarotCard","GameObject")
    ---@type UnityEngine.GameObject
    self.TowerEnterBtn = self:GetCurComp("WidgetRoot/view/btn_MrTarot","GameObject")
    ---@type UILabel
    self.UseTowerCardNum_UILabel = self:GetCurComp("WidgetRoot/view/TarotCardNum","UILabel")
    ---@type UILabel
    self.BlessedNum = self:GetCurComp("WidgetRoot/view/BlessedNum","UILabel")
end

---绑定事件
function UIDarkPalaceTarotPanel:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.TowerCardBtn,function(go)
        uimanager:CreatePanel("UITreasurePanel")
        uimanager:ClosePanel("UIActivityCurrentPanel")
    end)
    luaclass.UIRefresh:BindClickCallBack(self.TowerEnterBtn,function(go)
        if type(self.tarotTokenNum) == 'number' and self.tarotTokenNum <= 0 then
            Utility.ShowPopoTips(go.transform,nil,467)
            return
        end
        local deliverId = 230001
        ---策划说先不管
        --if clientTableManager.cfg_deliverManager:CheckMainPlayerCanEnterMap(deliverId) == false then
        --    Utility.ShowPopoTips(go.transform,nil,467)
        --    return
        --end
        local mapId = clientTableManager.cfg_deliverManager:GetToMapId(deliverId)
        networkRequest.ReqEnterDuplicate(mapId)
        uimanager:ClosePanel("UIActivityCurrentPanel")
    end)
end
--endregion

--region 刷新
---@param activityData SpecialActivityPanelData
function UIDarkPalaceTarotPanel:Show(activityData)
    if self:AnalysisPanel(activityData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshPanel()
end

---解析参数
---@param activityData SpecialActivityPanelData
---@return boolean 解析状态
function UIDarkPalaceTarotPanel:AnalysisPanel(activityData)
    self.activityType = activityData.mEventID
    if self.activityType ~= nil then
        self.serverActivityInfo = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(self.activityType)
    end
    self.activitiesPartInfo = self.serverActivityInfo.extInfo
    self.specialActivityId = activityData.mActivityID
    self.activityTblInfo = clientTableManager.cfg_special_activityManager:TryGetValue(self.specialActivityId)
    if self.activityType == nil or self.serverActivityInfo == nil or self.specialActivityId == nil or self.activityTblInfo == nil then
        return false
    end
    ---@type number 翻牌次数
    self.tarotHuntNum = 0
    if self.activitiesPartInfo ~= nil and type(self.activitiesPartInfo.tarotHuntNum) == 'number' then
        self.tarotHuntNum = self.activitiesPartInfo.tarotHuntNum
    end
    ---@type number 圣光庇护层数
    self.tarotTokenNum = 0
    if self.activitiesPartInfo ~= nil and type(self.activitiesPartInfo.tarotTokenNum) == 'number' then
        self.tarotTokenNum = self.activitiesPartInfo.tarotTokenNum
    end
    self.endTime = activityData.mFinishTime * 1000
    if type(self.endTime) ~= 'number' then
        return false
    end
    return true
end

function UIDarkPalaceTarotPanel:RefreshPanel()
    self:RefreshRemainTime()
    self:RefreshRewardItemList()
    self:RefreshUseTowerNum()
    self:RefreshBlessedNum()
end

---刷新剩余时间
function UIDarkPalaceTarotPanel:RefreshRemainTime()
    local remainTimeDes = gameMgr:GetLuaTimeMgr():GetRemainTimeDes1(self.endTime)
    luaclass.UIRefresh:RefreshLabel(self.remainTime_UILabel,remainTimeDes)
end

---刷新奖励列表
function UIDarkPalaceTarotPanel:RefreshRewardItemList()
    if type(self:GetRewardItemList()) ~= 'table' or Utility.GetLuaTableCount(self:GetRewardItemList()) <= 0 then
        luaclass.UIRefresh:RefreshGridContainer(self.rewardList_UIGridContainer,{})
        return
    end
    luaclass.UIRefresh:RefreshGridContainer(self.rewardList_UIGridContainer,self:GetRewardItemList(),function(grid,info)
        if CS.StaticUtility.IsNull(grid) == false and info ~= nil then
            local itemTemplate = templatemanager.GetNewTemplate(grid,luaComponentTemplates.UIItem)
            if itemTemplate ~= nil then
                ---@type DarkPalaceTarotRewardConfigParams
                local configItemParams = info
                local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(configItemParams.itemId)
                if itemInfoIsFind == false then
                    luaclass.UIRefresh:RefreshActive(grid,false)
                else
                    itemTemplate:RefreshUIWithItemInfo(itemInfo, 1)
                    itemTemplate.OnClickIconCallBack = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                    end
                end
            end
        end
    end)
end

---刷新使用塔罗牌次数
function UIDarkPalaceTarotPanel:RefreshUseTowerNum()
    local numColor = ternary(self.tarotHuntNum <= 0,luaEnumColorType.Red,luaEnumColorType.Green)
    local tarotHuntNumDes = numColor .. tostring(self.tarotHuntNum) .. "[-]"
    local useTowerNumDes = string.format(LuaGlobalTableDeal.GetUseTowerCardNumDes(),tarotHuntNumDes)
    luaclass.UIRefresh:RefreshLabel(self.UseTowerCardNum_UILabel,useTowerNumDes)
end

---刷新圣光庇护次数
function UIDarkPalaceTarotPanel:RefreshBlessedNum()
    local numColor = ternary(self.tarotTokenNum <= 0,luaEnumColorType.Red,luaEnumColorType.Green)
    local tarotTokenNumDes = numColor .. tostring(self.tarotTokenNum) .. "[-]"
    local blessedNumDes = string.format(LuaGlobalTableDeal.GetBlessedNumDes(),tarotTokenNumDes)
    luaclass.UIRefresh:RefreshLabel(self.BlessedNum,blessedNumDes)
end
--endregion

--region update
function update()
    UIDarkPalaceTarotPanel:RefreshRemainTime()
end
--endregion

return UIDarkPalaceTarotPanel