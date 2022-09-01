--Boss信息面板
---@class UIBossinfoPanel:UIBase
local UIBossinfoPanel = {}

--region 临时变量
UIBossinfoPanel.mBossID = nil
UIBossinfoPanel.mBossName = nil
UIBossinfoPanel.mBossLevel = nil
UIBossinfoPanel.mBossDetails = nil
UIBossinfoPanel.mBossNameColor = nil
UIBossinfoPanel.mBossTypeName = nil

UIBossinfoPanel.itemMaxCount = 0
UIBossinfoPanel.curItemPage = 6
--总显示个数
UIBossinfoPanel.showItemCount = 6
--每列显示个数
UIBossinfoPanel.showRowItemCount = 2

UIBossinfoPanel.GridToItemDic = {}
UIBossinfoPanel.idList = CS.System.Collections.Generic["List`1[System.Int32]"]()
--处理方式为1时为居上显示 2为居下（默认居上）
UIBossinfoPanel.processType = 1
--endregion

--region 组件
function UIBossinfoPanel.GetBossName_UILabel()
    if (UIBossinfoPanel.mBossNameUILabel == nil) then
        UIBossinfoPanel.mBossNameUILabel = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_name", "Top_UILabel")
    end
    return UIBossinfoPanel.mBossNameUILabel
end

function UIBossinfoPanel.GetBossLevel_UILabel()
    if (UIBossinfoPanel.mBossLevelUILabel == nil) then
        UIBossinfoPanel.mBossLevelUILabel = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_level", "Top_UILabel")
    end
    return UIBossinfoPanel.mBossLevelUILabel
end

function UIBossinfoPanel.GetBossLevel_Anchor()
    if (UIBossinfoPanel.mBossLevelUIAnchor == nil) then
        UIBossinfoPanel.mBossLevelUIAnchor = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_level", "Top_UIAnchor")
    end
    return UIBossinfoPanel.mBossLevelUIAnchor
end

function UIBossinfoPanel.GetBossDetails_UILabel()
    if (UIBossinfoPanel.mBossDetailsUILabel == nil) then
        UIBossinfoPanel.mBossDetailsUILabel = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_details", "Top_UILabel")
    end
    return UIBossinfoPanel.mBossDetailsUILabel
end

function UIBossinfoPanel.GetDropList_UIGridContainer()
    if (UIBossinfoPanel.dropListGridContainer == nil) then
        UIBossinfoPanel.dropListGridContainer = UIBossinfoPanel:GetCurComp("WidgetRoot/DropScroll View/DropItem", "UIGridContainer")
    end
    return UIBossinfoPanel.dropListGridContainer
end

function UIBossinfoPanel.GetMapList_UIGridContainer()
    if (UIBossinfoPanel.mapGridContainer == nil) then
        UIBossinfoPanel.mapGridContainer = UIBossinfoPanel:GetCurComp("WidgetRoot/MapScroll View/MapItem", "UIGridContainer")
    end
    return UIBossinfoPanel.mapGridContainer
end

--function UIBossinfoPanel.GetDropList_SpringPanel()
--    if (UIBossinfoPanel.dropListspring == nil) then
--        UIBossinfoPanel.dropListspring = UIBossinfoPanel:GetCurComp("WidgetRoot/DropScroll View", "SpringPanel")
--    end
--    return UIBossinfoPanel.dropListspring
--end

--function UIBossinfoPanel.GeRightHide_GameObject()
--    if (UIBossinfoPanel.mRightHideObj == nil) then
--        UIBossinfoPanel.mRightHideObj = UIBossinfoPanel:GetCurComp("WidgetRoot/view/btn_next", "GameObject")
--    end
--    return UIBossinfoPanel.mRightHideObj
--end
--
--function UIBossinfoPanel.GeLeftHide_GameObject()
--    if (UIBossinfoPanel.mLeftHideObj == nil) then
--        UIBossinfoPanel.mLeftHideObj = UIBossinfoPanel:GetCurComp("WidgetRoot/view/btn_before", "GameObject")
--    end
--    return UIBossinfoPanel.mLeftHideObj
--end

function UIBossinfoPanel.GetBtnDisplay_GameObject()
    if (UIBossinfoPanel.mBtnDisplay_GameObject == nil) then
        UIBossinfoPanel.mBtnDisplay_GameObject = UIBossinfoPanel:GetCurComp("WidgetRoot/window/btnDisplay", "GameObject");
    end
    return UIBossinfoPanel.mBtnDisplay_GameObject;
end

function UIBossinfoPanel.GetBG_Sprite()
    if (UIBossinfoPanel.mBG_Sprite == nil) then
        UIBossinfoPanel.mBG_Sprite = UIBossinfoPanel:GetCurComp("WidgetRoot/window/background", "UISprite")
    end
    return UIBossinfoPanel.mBG_Sprite;
end

function UIBossinfoPanel.GetDropDes_Label()
    if (UIBossinfoPanel.mDropDes_Label == nil) then
        UIBossinfoPanel.mDropDes_Label = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_drop", "Top_UILabel")
    end
    return UIBossinfoPanel.mDropDes_Label;
end

function UIBossinfoPanel.GetDes_Label()
    if (UIBossinfoPanel.mDes_Label == nil) then
        UIBossinfoPanel.mDes_Label = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_dec", "Top_UILabel")
    end
    return UIBossinfoPanel.mDes_Label;
end

function UIBossinfoPanel.GetBossType_Label()
    if (UIBossinfoPanel.mBossType_Label == nil) then
        UIBossinfoPanel.mBossType_Label = UIBossinfoPanel:GetCurComp("WidgetRoot/view/lab_typename", "Top_UILabel")
    end
    return UIBossinfoPanel.mBossType_Label;
end

function UIBossinfoPanel:GetBackGround_UISprite()
    return self.GetBG_Sprite()
end
--endregion

--region 初始化
function UIBossinfoPanel:Init()
    self:AddCollider()
    UIBossinfoPanel.BindUIEvents()
    UIBossinfoPanel.BindMessage()
end

function UIBossinfoPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    local avater, id, level, color;
    avater = customData.avater
    id = customData.id;
    level = customData.level;
    color = customData.color;
    if (color == nil) then
        color = CS.UnityEngine.Color(254.0 / 255.0, 0, 0);
    end
    if (customData.isShowDisplayBtn == nil) then
        customData.isShowDisplayBtn = false;
    end
    if id and level then
        UIBossinfoPanel.mBossID = id
        local res, bossinfo = CS.Cfg_BossTableManager.Instance.BossDic:TryGetValue(id)
        if (res) then
            local info = bossinfo[0]
            local monsres, monsinfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(info.confId)
            if monsres then
                UIBossinfoPanel.mBossName = monsinfo.name
            end
            if avater ~= nil then
                UIBossinfoPanel.mBossTypeName = CS.Cfg_GlobalTableManager.Instance:GetMonsterTypeNameByTypeId(avater.BaseInfo.Type)
            end
            UIBossinfoPanel.mBossDetails = info.monsterTips
            --设置怪物tips信息
            UIBossinfoPanel.GetDes_Label().text = info.monsterTips == nil and '' or info.monsterTips
            UIBossinfoPanel.GetDes_Label().gameObject:SetActive(info.monsterTips ~= nil and info.monsterTips ~= "")
        else
            local monsres, monsinfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(id)
            UIBossinfoPanel.mBossName = ""
            if monsres then
                UIBossinfoPanel.mBossName = monsinfo.name
            end
            if avater ~= nil then
                UIBossinfoPanel.mBossTypeName = CS.Cfg_GlobalTableManager.Instance:GetMonsterTypeNameByTypeId(avater.BaseInfo.Type)
            end
            UIBossinfoPanel.GetDes_Label().gameObject:SetActive(false)
        end
        UIBossinfoPanel.mBossLevel = level
        UIBossinfoPanel.mBossNameColor = color
        UIBossinfoPanel.GetBossTableID()
        UIBossinfoPanel.GetRewardInfo()
        UIBossinfoPanel.RefreshUIPanel()
    end
    local btnAct = UIBossinfoPanel:SetBtnDisplayAct()
    UIBossinfoPanel.GetBtnDisplay_GameObject():SetActive(customData.isShowDisplayBtn and btnAct);
end

--- @param monsterInfo  monsterData
function UIBossinfoPanel.SetPanel(monsterData)
    if monsterData then
        UIBossinfoPanel.mBossName = monsterData.name
        UIBossinfoPanel.mBossLevel = monsterData.level
        UIBossinfoPanel.GetMonsterRewardInfo(monsterData.RewardID)
        UIBossinfoPanel.RefreshUIPanel()
    end
end

function UIBossinfoPanel.BindUIEvents()
    --CS.UIEventListener.Get(UIBossinfoPanel.GeRightHide_GameObject()).onClick = UIBossinfoPanel.OnClickRightHideBtn
    --CS.UIEventListener.Get(UIBossinfoPanel.GeLeftHide_GameObject()).onClick = UIBossinfoPanel.OnClickLeftHideBtn
    CS.UIEventListener.Get(UIBossinfoPanel.GetBtnDisplay_GameObject()).onClick = UIBossinfoPanel.OnClickBtnDisplay
end

function UIBossinfoPanel.BindMessage()
    UIBossinfoPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetBossInfoMessage, UIBossinfoPanel.ResGetBossInfoMessage)
end

---背景自适应
function UIBossinfoPanel.BgAdaptiveOfItemCount(count)
    if UIBossinfoPanel.GetBG_Sprite() == nil then
        return
    end
    local UpSpace = 12
    local nameSpace = 10
    local otherSpace = 10
    local downSpace = 0
    local nameHeight = UIBossinfoPanel.GetBossName_UILabel().height
    local detailsHeight = 0
    if UIBossinfoPanel.GetDes_Label().gameObject.activeSelf then
        detailsHeight = UIBossinfoPanel.GetDes_Label().height
    end
    local dropHeight = UIBossinfoPanel.GetDropDes_Label().height
    local itemHeight = 66
    if UIBossinfoPanel.GetDropList_UIGridContainer() ~= nil and UIBossinfoPanel.GetDropList_UIGridContainer().controlTemplate ~= nil then
        local iconTrans = UIBossinfoPanel.GetDropList_UIGridContainer().controlTemplate.transform:Find('icon')
        if iconTrans ~= nil then
            local icon = iconTrans:GetComponent('Top_UISprite')
            if icon then
                itemHeight = icon.height
            end
        end
    end
    local Rows, last = math.modf(count / 4)
    --last = last > 0 and 1 or 0;
    local totalRow = math.ceil(Rows + last) --> 2 and 2 or Rows + last
    local totalHeight = UpSpace + nameHeight + nameSpace + dropHeight + (totalRow * (itemHeight + otherSpace)) + downSpace
    if UIBossinfoPanel.GetDes_Label().gameObject.activeSelf then
        totalHeight = totalHeight + otherSpace + detailsHeight
        local num = totalRow - 2 > 0 and (itemHeight * (totalRow - 2)) or 0
        UIBossinfoPanel.GetDes_Label().transform.localPosition = CS.UnityEngine.Vector3(UIBossinfoPanel.GetDes_Label().transform.localPosition.x, UIBossinfoPanel.GetDes_Label().transform.localPosition.y - num, UIBossinfoPanel.GetDes_Label().transform.localPosition.z)
    end
    UIBossinfoPanel.GetBG_Sprite().height = math.ceil(totalHeight)
end
--endregion

--region UIEvent

--function UIBossinfoPanel.OnClickRightHideBtn()
--    UIBossinfoPanel.curItemPage = UIBossinfoPanel.curItemPage + (UIBossinfoPanel.showRowItemCount * 3)
--    local dropItemV3 = UIBossinfoPanel.GetDropList_SpringPanel().transform.localPosition
--    local itemSize = UIBossinfoPanel.GetDropList_UIGridContainer().CellWidth
--    dropItemV3.x = dropItemV3.x - (itemSize * 3)
--    -- UIBossinfoPanel.ShowHideObj()
--    UIBossinfoPanel.GetDropList_SpringPanel().target = dropItemV3
--    UIBossinfoPanel.GetDropList_SpringPanel().enabled = true
--end
--
--function UIBossinfoPanel.OnClickLeftHideBtn()
--    UIBossinfoPanel.curItemPage = UIBossinfoPanel.curItemPage - (UIBossinfoPanel.showRowItemCount * 3)
--    local dropItemV3 = UIBossinfoPanel.GetDropList_SpringPanel().transform.localPosition
--    local itemSize = UIBossinfoPanel.GetDropList_UIGridContainer().CellWidth
--    dropItemV3.x = dropItemV3.x + (itemSize * 3)
--    --UIBossinfoPanel.ShowHideObj()
--    UIBossinfoPanel.GetDropList_SpringPanel().target = dropItemV3
--    UIBossinfoPanel.GetDropList_SpringPanel().enabled = true
--end

function UIBossinfoPanel.OnClickBtnDisplay()
    local isFindBossTable, bossList = UIBossinfoPanel:SetBtnDisplayAct()
    if (isFindBossTable) then
        local customData = {};
        if (bossList.Count > 0) then
            customData.type = bossList[0].type;
            customData.targetMonsterId = bossList[0].confId;
        end

        uimanager:CreatePanel("UIBossPanel", nil, customData);
    end
end

--endregion

--region 界面逻辑
function UIBossinfoPanel.RefreshUIPanel()
    if (UIBossinfoPanel.mBossName ~= nil) then
        UIBossinfoPanel.GetBossName_UILabel().text = UIBossinfoPanel.mBossName
        --UIBossinfoPanel.GetBossType_Label().text = UIBossinfoPanel.mBossTypeName
        UIBossinfoPanel.GetBossType_Label().gameObject:SetActive(false)
        if UIBossinfoPanel.mBossNameColor then
            UIBossinfoPanel.GetBossName_UILabel().color = UIBossinfoPanel.mBossNameColor
        end
    end
    if (UIBossinfoPanel.mBossLevel ~= nil) then
        UIBossinfoPanel.GetBossLevel_UILabel().text = "Lv." .. UIBossinfoPanel.mBossLevel
    end
    if (UIBossinfoPanel.mBossDetails ~= nil) then
        UIBossinfoPanel.GetBossDetails_UILabel().text = UIBossinfoPanel.mBossDetails
    end
    UIBossinfoPanel.ShowDropItemList()
    -- UIBossinfoPanel.ShowHideObj()
end

--显示物品掉落信息
function UIBossinfoPanel.ShowDropItemList()

    if (UIBossinfoPanel.mdropList == nil) then
        UIBossinfoPanel.itemMaxCount = 0
        UIBossinfoPanel.BgAdaptiveOfItemCount(UIBossinfoPanel.itemMaxCount)
        return
    else
        UIBossinfoPanel.itemMaxCount = #UIBossinfoPanel.mdropList
        UIBossinfoPanel.BgAdaptiveOfItemCount(UIBossinfoPanel.itemMaxCount)
    end

    if #UIBossinfoPanel.mdropList == 0 then
        return
    end
    if (UIBossinfoPanel.GetDropList_UIGridContainer().gameObject.activeSelf == false) then
        UIBossinfoPanel.GetDropList_UIGridContainer().gameObject:SetActive(true)
    end

    --local quotient = tonumber(UIBossinfoPanel.itemMaxCount) / tonumber(UIBossinfoPanel.showItemCount)
    --local a, b = math.modf(quotient)
    --local remainder = tonumber(UIBossinfoPanel.itemMaxCount) % tonumber(UIBossinfoPanel.showItemCount)
    --remainder = remainder > 3 and 3 or remainder
    --local lineCount = a * (UIBossinfoPanel.showItemCount / 2) + remainder
    --
    --UIBossinfoPanel.GetDropList_UIGridContainer().MaxPerLine = lineCount

    UIBossinfoPanel.GetDropList_UIGridContainer().MaxCount = #UIBossinfoPanel.mdropList

    for i = 1, #UIBossinfoPanel.mdropList do
        local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(UIBossinfoPanel.mdropList[i]:GetItemId())

        local go = UIBossinfoPanel.GetDropList_UIGridContainer().controlList[i - 1]
        if infobool then
            local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
            temp:RefreshUIWithItemInfo(iteminfo, 1)
            temp:RefreshOtherUI({ tag = UIBossinfoPanel.mdropList[i]:GetTag() })
            CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                if temp.ItemInfo ~= nil then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, refreshEndFunc = function(panel)
                        --UIBossinfoPanel:SetItemInfoPos(panel)
                    end, showRight = false })
                end
            end

        end
    end

end

--附件格子点击事件
function UIBossinfoPanel.OnCheckItemClicked(go)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        local itemTemp = UIBossinfoPanel.GridToItemDic[go]
        if itemTemp ~= nil and itemTemp.ItemInfo ~= nil and itemTemp.ItemInfo ~= nil then
            --打开物品信息界面
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTemp.ItemInfo })
        end
    end
end

function UIBossinfoPanel:GetPlayerInfo()
    return CS.CSScene.MainPlayerInfo
end

--根据职业性别筛选
--function UIBossinfoPanel.GetItemWithCareerAndSex(data)
--
--    local list = CS.Cfg_BossDropShowTableManager.Instance:GetMeetDropItemList(data.id)
--    for i = 0, list.Count - 1 do
--        table.insert(UIBossinfoPanel.mdropList, list[i])
--    end

----print("条件：" .. tonumber(data.displayConditionParameter.list[0]))
--if (UIBossinfoPanel.GetPlayerInfo().Level >= tonumber(data.displayConditionParameter.list[0])) then
--    --读表获取dropShow 职业#性别#itemID(职业：1战士2法师3道士；性别1男2女)
--    local items = data.dropShow.list
--    local length = items.Count - 1
--    for i = 0, length do
--        local v = items[i]
--        local careritems = v.list
--        --找到对应职业和性格的道具
--        if (careritems ~= nil and Utility.EnumToInt(UIBossinfoPanel.GetPlayerInfo().Career) == tonumber(careritems[0]) and Utility.EnumToInt(UIBossinfoPanel.GetPlayerInfo().Sex) == tonumber(careritems[1])) then
--            for i = 2, careritems.Count - 1 do
--                table.insert(UIBossinfoPanel.mdropList, careritems[i])
--            end
--            break
--        end
--    end
--end
--end

--region ShowHide

--function UIBossinfoPanel.ShowHideObj()
--    if UIBossinfoPanel.itemMaxCount <= UIBossinfoPanel.showItemCount then
--        UIBossinfoPanel.GeRightHide_GameObject():SetActive(false)
--        UIBossinfoPanel.GeLeftHide_GameObject():SetActive(false)
--        return
--    end
--    if UIBossinfoPanel.curItemPage <= UIBossinfoPanel.showItemCount then
--        UIBossinfoPanel.GeLeftHide_GameObject():SetActive(false)
--    else
--        UIBossinfoPanel.GeLeftHide_GameObject():SetActive(true)
--    end
--
--    if UIBossinfoPanel.curItemPage >= UIBossinfoPanel.itemMaxCount then
--        UIBossinfoPanel.GeRightHide_GameObject():SetActive(false)
--    else
--        UIBossinfoPanel.GeRightHide_GameObject():SetActive(true)
--    end
--
--end
--endregion


--endregion

--region 客户端消息处理
function UIBossinfoPanel.GetBossTableID()
    for k, v in pairs(CS.Cfg_BossTableManager.Instance.BossDic) do
        if (k == UIBossinfoPanel.mBossID) then
            for i = 0, v.Count - 1 do
                UIBossinfoPanel.idList:Add(v[i].id)
            end
        end
    end
    UIBossinfoPanel.ReqGetInfo()
end
--endregion

--region 服务器消息处理
function UIBossinfoPanel.ReqGetInfo()
    networkRequest.ReqGetBossInfo(UIBossinfoPanel.idList)
end

function UIBossinfoPanel.ResGetBossInfoMessage(id, data, csdata)
    if (UIBossinfoPanel.GetMapList_UIGridContainer() ~= nil) then
        UIBossinfoPanel.GetMapList_UIGridContainer().MaxCount = Utility.GetLuaTableCount(data.bosses)
        for i = 1, UIBossinfoPanel.GetMapList_UIGridContainer().MaxCount do
            local map = UIBossinfoPanel.GetMapList_UIGridContainer().controlList[i - 1].transform:Find("map")
            local isFindMap, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(data.bosses[i].mapId)
            if (isFindMap) then
                CS.Utility_Lua.GetComponent(map, "UILabel").text = mapTable.name
                map.gameObject:SetActive(true)
                if (data.bosses[i].isAlive) then
                    CS.Utility_Lua.GetComponent(map:Find("die"), "UISprite").spriteName = "alive"
                else
                    CS.Utility_Lua.GetComponent(map:Find("die"), "UISprite").spriteName = "dead"
                end
                CS.Utility_Lua.GetComponent(map:Find("die"), "UISprite"):MakePixelPerfect()
            end
        end
    end
end
--endregion

--region otherFunction

function UIBossinfoPanel.GetRewardInfo()
    UIBossinfoPanel.mdropList = clientTableManager.cfg_monstersManager:GetDropShowList(UIBossinfoPanel.mBossID)
end

function UIBossinfoPanel.GetMonsterRewardInfo(rewards)
    UIBossinfoPanel.mdropList = {}
    for k, v in pairs(rewards) do
        local tbl = clientTableManager.cfg_boss_drop_showManager:GetMeetDropItemInfoList(v)
        for i = 1, #tbl do
            table.insert(UIBossinfoPanel.mdropList, tbl[i])
        end
    end
end

function UIBossinfoPanel:SetItemInfoPos(panel)
    local backGroundLocalSize = self:GetBackGround_UISprite().localSize
    --上对齐
    if UIBossinfoPanel.processType == 1 then
        self:AdjustAdaption({ panel = panel, adaptionType = LuaEnumAdjustAdaptionType.RightUp, horizontalInterval = 1, verticalInterval = backGroundLocalSize.y * -0.5 })
    elseif UIBossinfoPanel.processType == 2 then
        self:AdjustAdaption({ panel = panel, adaptionType = LuaEnumAdjustAdaptionType.RightDown, horizontalInterval = 1, verticalInterval = backGroundLocalSize.y * -0.5 })
    end
end
---判断是否BS表中有
function UIBossinfoPanel:SetBtnDisplayAct()
    if (UIBossinfoPanel.mBossID == nil) then
        return false, nil
    end
    local isFindBossTable, bossList = CS.Cfg_BossTableManager.Instance.BossDic:TryGetValue(UIBossinfoPanel.mBossID)
    return isFindBossTable, bossList
end
---改变处理状态
function UIBossinfoPanel.ChangeProcessType(type)
    UIBossinfoPanel.processType = type
end

--endregion

function ondestroy()
    uimanager:ClosePanel('UIItemInfoPanel')
end

return UIBossinfoPanel