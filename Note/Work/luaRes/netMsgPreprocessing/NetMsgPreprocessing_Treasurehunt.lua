--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--treasurehunt.xml

--region ID:11105 ResServerHistoryMessage 历史信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.HuntHistory lua table类型消息数据
---@param csData treasureHuntV2.HuntHistory C# class类型消息数据
netMsgPreprocessing[11105] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.TreasureInfo:OnHuntHistroy(csData)
end
--endregion

--region ID:11108 ResTreasureItemChangedMessage 寻宝仓库物品变动信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.TreasureItemChangeList lua table类型消息数据
---@param csData treasureHuntV2.TreasureItemChangeList C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11108] = function(msgID, tblData, csData)
    --在此处填入预处理代码

end
--endregion

--region ID:11110 ResTreasureStorehouseMessage 寻宝仓库信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.TreasureHuntInfo lua table类型消息数据
---@param csData treasureHuntV2.TreasureHuntInfo C# class类型消息数据
netMsgPreprocessing[11110] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.TreasureInfo:OnTreasureItemChangeList(csData)
end
--endregion

--region ID:11111 ResTreasureEndMessage 寻宝结束信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[11111] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:11113 ResUseTreasureExpMessage 使用寻宝经验丹响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.ExpUseRequest lua table类型消息数据
---@param csData treasureHuntV2.ExpUseRequest C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11113] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:11115 ResTreasureIdMessage 寻宝界面宝箱响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.TreasureIdResponse lua table类型消息数据
---@param csData treasureHuntV2.TreasureIdResponse C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11115] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:11119 ResHuntCallBackMessage 寻宝仓库中回收装备响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.HuntCallbackResponse lua table类型消息数据
---@param csData treasureHuntV2.HuntCallbackResponse C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11119] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:11121 ResLimitTimeTreasureHuntPoolMessage 查看限时寻宝池响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.LimitTimeTreasureHuntPool lua table类型消息数据
---@param csData treasureHuntV2.LimitTimeTreasureHuntPool C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11121] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:11124 ResTreasureCardMessage 返回所有卡牌信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.AllCardInfo lua table类型消息数据
---@param csData treasureHuntV2.AllCardInfo C# class类型消息数据
netMsgPreprocessing[11124] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --print("服务器~~ 返回所有卡牌信息")
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.TreasureInfo ~= nil then
        CS.CSScene.MainPlayerInfo.TreasureInfo:OnAllCardInfo(csData)
    end
end
--endregion

--region ID:11130 ResHuntStorageUpdateMessage 寻宝仓库更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.StorageUpdateInfo lua table类型消息数据
---@param csData treasureHuntV2.StorageUpdateInfo C# class类型消息数据
netMsgPreprocessing[11130] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.TreasureInfo:OnStorageUpdateInfo(csData)
end
--endregion

--region ID:11132 ResReinNumMessage 返回全服转生信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.ReinNumResponse lua table类型消息数据
---@param csData treasureHuntV2.ReinNumResponse C# class类型消息数据
netMsgPreprocessing[11132] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:11136 ResDigTreasureWareHouseMessage 返回挖宝仓库信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.DigTreasureWareHouse lua table类型消息数据
---@param csData treasureHuntV2.DigTreasureWareHouse C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11136] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetDigTreasureManager() ~= nil then
        gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetNetMes(tblData)
    end
end
--endregion

--region ID:11139 ResRoleDigTreasureCountMessage 玩家挖宝次数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.RoleDigTreasureCount lua table类型消息数据
---@param csData treasureHuntV2.RoleDigTreasureCount C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11139] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetDigTreasureManager() ~= nil then
        gameMgr:GetPlayerDataMgr():GetDigTreasureManager():SetDigCount(tblData)
    end
end
--endregion

--region ID:11140 ResDigTreasureStateMessage 玩家挖宝状态数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.DigTreasureState lua table类型消息数据
---@param csData treasureHuntV2.DigTreasureState C# class类型消息数据
netMsgPreprocessing[11140] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.Sington ~= nil then
        --print("收到玩家挖宝",csData.rid,csData.state)
        --if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.rid == csData.rid then
        --    
        --end
        if (CS.CSSceneExt.Sington ~= nil) then
            local avater = CS.CSSceneExt.Sington:getAvatar(csData.rid)
            if avater ~= nil then
                avater.BaseInfo:ChangeDigState(csData.state)
            end
        end
    end
end
--endregion

--region ID:11141 ResDigTreasureItemsMessage 玩家挖宝状态数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.DigTreasureItems lua table类型消息数据
---@param csData treasureHuntV2.DigTreasureItems C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11141] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil or CS.CSScene.Sington == nil then
        return
    end
    ---收到服务器的挖宝数量包后,在场景中模拟一个道具散开的效果
    local itemExplode1 = CS.CSScene.Sington.SceneAnimationController.Animation_ItemExplode1
    local mainPlayerCoord = CS.CSScene.Sington.MainPlayer.OldCell.Coord
    local mainPlayerCoordX = mainPlayerCoord.x
    local mainPlayerCoordY = mainPlayerCoord.y
    ---散开范围就是物品列表长度的开方
    local itemCoordRange = math.ceil(math.sqrt(#tblData.item)) ---物品散开的坐标范围
    local diff = math.floor(itemCoordRange / 2) ---坐标范围的一半
    local coordTemp = { x = 0, y = 0 } ---临时变量
    local existTime = 2 ---场景中物品的存活时间
    local moveTime = 1 ---物品的移动时间
    ---existTime时间之后,执行飞入宝箱动画
    ---@type UIDiggingTreasurePanel
    local uiDiggingTreasurePanel = uimanager:GetPanel("UIDiggingTreasurePanel")
    if uiDiggingTreasurePanel == nil or uiDiggingTreasurePanel.Components == nil or uiDiggingTreasurePanel.Components.btn_warehouse == nil then
        return
    end
    local flyTargetPos = uiDiggingTreasurePanel.Components.btn_warehouse.transform.position
    flyTargetPos.z = 0
    ---在场景中创建纯客户端物体,令起从主角坐标爆炸式扩散到主角周围的矩形范围内
    local sceneCamera = CS.CSScene.Sington.Camera
    local uiCamera = CS.UICamera.mainCamera
    local maxTimeOffset = 0.5 ---最大时间偏移量
    local minOffsetDis = 1 ---从多远的距离(曼哈顿距离)开始就有偏移现象了
    local maxTimeOffsetDis = itemCoordRange ---偏移量随距离线性增加的规律到多远的格子为止终止
    for i = 1, #tblData.item do
        local bagItem = tblData.item[i]
        local dx = (i - 1) % itemCoordRange - diff
        local dy = math.floor((i - 1) / itemCoordRange) - diff
        coordTemp.x = dx + mainPlayerCoordX
        coordTemp.y = dy + mainPlayerCoordY
        local x = coordTemp.x
        local y = coordTemp.y
        local itemID = bagItem.itemId
        local timeOffset = math.clamp01((math.abs(dx) + math.abs(dy) - minOffsetDis) / (maxTimeOffsetDis)) * maxTimeOffset
        itemExplode1:AddItem(itemID, bagItem.count, mainPlayerCoord, coordTemp, 0, moveTime + timeOffset, existTime + timeOffset, 1, moveTime + timeOffset, function()
            if CS.CSScene.Sington == nil then
                return
            end
            local oldCell = CS.CSScene.Sington.Mesh:getCell({ x = x, y = y });
            if oldCell ~= nil then
                local screenPos = sceneCamera:WorldToScreenPoint(oldCell.WorldPosition)
                local worldPos = uiCamera:ScreenToWorldPoint(screenPos)
                worldPos.z = 0
                luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = itemID, from = worldPos, to = flyTargetPos })
            end
        end)
    end
end
--endregion

--region ID:11142 ResGoldDigActiveStateMessage 黄金挖宝活动状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData treasureHuntV2.GoldDigActiveState lua table类型消息数据
---@param csData treasureHuntV2.GoldDigActiveState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[11142] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    if tblData ~= nil then
        if tblData.state ~= nil then
            gameMgr:GetPlayerDataMgr():GetDigTreasureManager():SetActive(tblData.state == 1)
        end
    end
end
--endregion
