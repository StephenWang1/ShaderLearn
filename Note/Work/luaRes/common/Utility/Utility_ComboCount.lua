---@type Utility
local Utility = Utility

--region 通用监听器注册和移除
---进入游戏注册连击监听器
function Utility.EnterGameRegisterCombatHitListener()
    uiStaticParameter.HintUseCrazyDrugNum = 0
    Utility.RegisterCombatHitNum_CrazyDrug()
end

---退出游戏移除连击监听器
function Utility.ExitGameRemoveCombatHitListener()
    --狂暴药剂
    Utility.CrazyDrugListenerList = {}
    Utility.RemoveCombatHintListenerByCreateTimeTable(Utility.CrazyDrugListenerList)
end

---单个灵兽数据变化处理
---@param tblData servantV2.ServantInfo lua table类型消息数据
function Utility.CombatHit_SingleServantInfoChange(tblData)
    if tblData == nil then
        return
    end
    local servantLid = tblData.servantId
    if type(servantLid) ~= 'number' then
        return
    end
    if servantLid > 0 then
        --上阵
        Utility.RegisterSingleServantCombatHitListener_CrazyDrug(tblData.servantId)
    else
        --召回
        local servantInfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantInfoByServantIndex(tblData.type)
        if servantInfo ~= nil then
            Utility.RemoveCombatHintListenerByMonitorObjLid(servantInfo.servantId)
        end
    end
end

---背包物品变化
function Utility.CombatHit_BagItemChange()
    Utility.RegisterCombatHitNum_CrazyDrug()
end

---移除buff
---@param buffInfo fightV2.BufferInfo
---@param lid number 移除buff的对象的lid
function Utility.CombatHit_RemoveBuff(buffInfo, lid)
    if buffInfo ~= nil then
        if gameMgr:GetLuaMainPlayer() ~= nil and
                lid == gameMgr:GetLuaMainPlayer():GetID() and LuaGlobalTableDeal.IsRemoveBuffIdListCrazyDrugHintParams(buffInfo.bufferConfigId) then
            Utility.RegisterCombatHitNum_CrazyDrug()
        end
    end
end
--endregion

--region 狂暴药剂
---战斗击打次数（狂暴药剂）
---@param ignoreHintNum boolean 是否忽略连击次数
function Utility.RegisterCombatHitNum_CrazyDrug(ignoreHintNum)
    if Utility.CrazyDrugListenerList == nil then
        Utility.CrazyDrugListenerList = {}
    end
    ---提示次数限制
    if ignoreHintNum ~= true and (CS.CSSceneExt.Sington == nil or uiStaticParameter.HintUseCrazyDrugNum >= uiStaticParameter.HintUseCrazyDrugMaxNum) then
        return
    end
    ---是否有灵兽
    local bodyHaveServant = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():BodyHaveServant()

    if bodyHaveServant == false then
        return
    end
    ---是否有狂暴药剂
    local bagHaveCrazyDrug = Utility.BagHaveCrazyDrug()
    if bagHaveCrazyDrug == false then
        return
    end
    ---是否已经注册监听器
    if type(Utility.CrazyDrugListenerList) == 'table' and Utility.GetLuaTableCount(Utility.CrazyDrugListenerList) > 0 then
        return
    end
    local servantInfoList = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantInfoList()
    if type(servantInfoList) ~= 'table' then
        return
    end
    for k, v in pairs(servantInfoList) do
        ---@type servantV2.ServantInfo
        local servantInfo = v
        if servantInfo ~= nil and servantInfo.servantId ~= nil then
            Utility.RegisterSingleServantCombatHitListener_CrazyDrug(servantInfo.servantId)
        end
    end
end

---狂暴药剂连击次数触发
function Utility.CombatHitNum_CrazyDrugCallBack(obj)
    local crazyDrugBagItemInfo = LuaGlobalTableDeal.GetCrazyDrugHintBagItemInfo()
    if crazyDrugBagItemInfo == nil then
        return
    end
    ---@type TABLE.CFG_ITEMS
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(crazyDrugBagItemInfo.itemId)
    ---提示次数检测
    if itemInfo == nil or type(uiStaticParameter.HintUseCrazyDrugNum) ~= 'number' or uiStaticParameter.HintUseCrazyDrugNum >= uiStaticParameter.HintUseCrazyDrugMaxNum then
        return
    end
    ---提示条件检测
    local conditionLimit = Utility.IsMainPlayerMatchConditionList_OR(LuaGlobalTableDeal.GetCrazyDrugHintConditionIdList()).success
    if conditionLimit == true then
        return
    end
    if type(Utility.CrazyDrugListenerList) == 'table' then
        for k, v in pairs(Utility.CrazyDrugListenerList) do
            if type(v) == 'number' then
                Utility.RemoveCombatHintListenerByCreateTime(v)
            end
        end
    end
    Utility.CrazyDrugListenerList = {}
    ---@type UtilityPromptPanelInfo
    local commonData = {}
    commonData.PromptWordId = 151
    commonData.iconSpriteName = itemInfo.icon
    commonData.ToggleStartState = uiStaticParameter.HintUseCrazyDrugNum ~= 0
    commonData.ComfireAucion = function()
        networkRequest.ReqUseItem(crazyDrugBagItemInfo.count, crazyDrugBagItemInfo.lid)
    end
    commonData.IconClickCallBack =  function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
    end
    commonData.ToggleOnClick = function(chooseState)
        if chooseState == true then
            uiStaticParameter.HintUseCrazyDrugNum = uiStaticParameter.HintUseCrazyDrugMaxNum
        else
            uiStaticParameter.HintUseCrazyDrugNum = 0
        end
    end
    Utility.ShowSecondConfirmPanel(commonData)
end

---注册单个灵兽连击监听器
---@param servantLid number
function Utility.RegisterSingleServantCombatHitListener_CrazyDrug(servantLid)
    if type(servantLid) ~= 'number' or servantLid <= 0 or type(uiStaticParameter.HintUseCrazyDrugNum) ~= 'number' or uiStaticParameter.HintUseCrazyDrugNum >= uiStaticParameter.HintUseCrazyDrugMaxNum then
        return
    end
    ---是否有狂暴药剂
    local bagHaveCrazyDrug = Utility.BagHaveCrazyDrug()
    if bagHaveCrazyDrug == false then
        return
    end
    if Utility.CrazyDrugListenerList == nil then
        Utility.CrazyDrugListenerList = {}
    end
    local crazyDrugHintCreateTime = CS.CSSceneExt.Sington.CombatHitCountManager:RegisterCombatHintListenerByLid(servantLid, LuaGlobalTableDeal.GetHintCrazyDrugComboAttackNum(), Utility.CombatHitNum_CrazyDrugCallBack)
    if crazyDrugHintCreateTime > 0 then
        table.insert(Utility.CrazyDrugListenerList, crazyDrugHintCreateTime)
    end
end

---背包中是否有狂暴药剂
---@return boolean
function Utility.BagHaveCrazyDrug()
    local crazyDrugItemIdList = LuaGlobalTableDeal.GetCrazyDrugItemIdList()
    if type(crazyDrugItemIdList) ~= 'table' then
        return
    end
    for k, v in pairs(crazyDrugItemIdList) do
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr().GetItemListByItemId ~= nil then
            local crazyDrugCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(v)
            if type(crazyDrugCount) == 'number' and crazyDrugCount > 0 then
                return true
            end
        end
    end
    return false
end
--endregion

--region 通用
---移除击打次数监听器
---@param lid number
function Utility.RemoveCombatHintListenerByMonitorObjLid(lid)
    if CS.CSSceneExt.Sington == nil or lid == nil then
        return
    end
    CS.CSSceneExt.Sington.CombatHitCountManager:RemoveCombatHintListenerByMonitorObjLid(lid)
end

---移除击打次数监听器
---@param createTime number
function Utility.RemoveCombatHintListenerByCreateTime(createTime)
    if CS.CSSceneExt.Sington == nil or createTime == nil then
        return
    end
    CS.CSSceneExt.Sington.CombatHitCountManager:RemoveCombatHintListenerByCreateTime(createTime)
end

---移除击打次数监听器
---@param createTimeTable table<number>
function Utility.RemoveCombatHintListenerByCreateTimeTable(createTimeTable)
    if type(createTimeTable) ~= 'table' then
        return
    end
    for k, v in pairs(createTimeTable) do
        if type(v) == 'number' then
            Utility.RemoveCombatHintListenerByCreateTime(v)
        end
    end
end
--endregion

