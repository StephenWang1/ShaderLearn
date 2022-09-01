local UIBossPanel_MagicBossViewTemplate = {}

setmetatable(UIBossPanel_MagicBossViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)

---初始化组件
function UIBossPanel_MagicBossViewTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type Top_UILabel
    self.title = self:Get("Title", 'Top_UILabel')
    ---@type Top_UILabel
    self.time = self:Get("Table/time", 'Top_UILabel')
    ---@type Top_UILabel
    self.number = self:Get("Table/number", 'Top_UILabel')
    ---@type UnityEngine.GameObject
    self.addBtn_GameObject = self:Get("Table/add", 'GameObject')
    ---@type Top_TweenAlpha
    self.addBtn_TweenAlpha = self:Get("Table/add", 'Top_TweenAlpha')
    ---@type UISprite
    self.addBtn_UISprite = self:Get("Table/add", 'UISprite')
    ---@type Top_UITable
    self.table_UITable = self:Get("Table", 'Top_UITable')
    ---@type Top_UIScrollView 掉落展示
    self.dropItemScrollView = self:Get("dropScroll", "Top_UIScrollView")
    ---@type Top_UIGridContainer 掉落展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "Top_UIGridContainer")
    self:BindEvents()
end

---绑定事件
function UIBossPanel_MagicBossViewTemplate:BindEvents()
    CS.UIEventListener.Get(self.addBtn_GameObject).onClick = function(go)
        luaclass.MagicBossDataInfo:TryAddKillNum(go, self.magicBossType, LuaEnumWayGetPanelArrowDirType.TopRight)
    end
end

--region 刷新
function UIBossPanel_MagicBossViewTemplate:RefreshOtherView(pageInfo)
    self:RunBaseFunction("RefreshOtherView", pageInfo)
    if pageInfo == nil then
        return
    end
    luaclass.UIRefresh:RefreshActive(self.ModelRoot, true)
    self:RefreshTitle(pageInfo.detailDes)
    if pageInfo.speDrop ~= nil then
        self:RefreshDropItems(pageInfo.type,pageInfo.speDrop)
    end
    self:RefreshMagicBossView()
end

---刷新魔之boss视图
function UIBossPanel_MagicBossViewTemplate:RefreshMagicBossView()
    luaclass.UIRefresh:RefreshActive(self.table_UITable,false)
    if self.curSelectPageId == nil then
        return
    end
    self.magicBossType = LuaGlobalTableDeal.GetMagicBossTypeByBtnSubType(self.curSelectPageId)
    if self.magicBossType == nil then
        return
    end
    self.magicBossTypeInfo = luaclass.MagicBossDataInfo:GetMagicBossTypeInfoByType(self.magicBossType)
    if self.magicBossTypeInfo == nil then
        return
    end
    --self.curKillNum = luaclass.MagicBossDataInfo:GetMagicBossTypeKillNum(self.magicBossType)+ luaclass.MagicBossDataInfo:GetBagMagicBossItemNumber(self.magicBossType)
    self.curKillNum = luaclass.MagicBossDataInfo:GetMagicBossTypeKillNum(self.magicBossType)
    self.totalKillNum = luaclass.MagicBossDataInfo:GetMagicBossTypeTotalKillNum(self.magicBossType)
    if self.maxKillNum == nil then
        self.maxKillNum = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(self.magicBossType).killNumMax
    end
    if self.maxTotalKillNum == nil then
       self.maxTotalKillNum = LuaGlobalTableDeal.GetMagicBossTotalKillNum()
    end
    if self.curKillNum == nil or self.maxKillNum == nil then
        return
    end
    luaclass.UIRefresh:RefreshActive(self.table_UITable,true)
    self.killTimeIsMax = luaclass.MagicBossDataInfo:KillTimeIsMax(self.magicBossType)
    self:RefreshKillNum()
    self:StartRefreshTime()
    self:RefreshAddBtn()
end

---刷新标题
function UIBossPanel_MagicBossViewTemplate:RefreshTitle(showStr)
    if CS.StaticUtility.IsNull(self.title) == false then
        --self.title.text = showStr
        self.title.gameObject:SetActive(false)
    end
end

---刷新掉落道具
function UIBossPanel_MagicBossViewTemplate:RefreshDropItems(type,speDrop)
    if type == nil or speDrop == nil then
        return
    end
    local list = self.curAllBossDic[type]
    if list == nil then
        self.dropItemGrid.MaxCount = 0
        return
    end
    local dropList = nil
    if(speDrop~=nil)then
        dropList =speDrop
        if dropList then
            self.dropItemGrid.MaxCount = #dropList
            for k, v in pairs(dropList) do
                local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v)

                local go = self.dropItemGrid.controlList[k - 1]
                if infobool then
                    local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                    temp:RefreshUIWithItemInfo(iteminfo, 1)
                    CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                        if temp.ItemInfo ~= nil then
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                        end
                    end

                end
            end
            if(self.dropItemScrollView~=nil) then
                self.dropItemScrollView:ResetPosition();
            end
            return
        end
    end
    for i, v in pairs(list) do
        for j = 1, #v do
            ---获取任意一个list中的boss掉落数据并显示
            dropList = Utility.GetBossPanelDropList(v[j].configId)
            if dropList then
                self.dropItemGrid.MaxCount = #dropList
                for k, v in pairs(dropList) do
                    local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v)

                    local go = self.dropItemGrid.controlList[k - 1]
                    if infobool then
                        local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                        temp:RefreshUIWithItemInfo(iteminfo, 1)
                        CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                            if temp.ItemInfo ~= nil then
                                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                            end
                        end

                    end
                end
                if(self.dropItemScrollView~=nil) then
                    self.dropItemScrollView:ResetPosition();
                end
                return
            end
        end
    end
end

---刷新击杀次数
function UIBossPanel_MagicBossViewTemplate:RefreshKillNum()
    if CS.StaticUtility.IsNull(self.number) == false then
        local NowNumber = self.totalKillNum
        local color = ternary(NowNumber <= 0, luaEnumColorType.Red, luaEnumColorType.Green)
        local des = "次数" .. color .. tostring(NowNumber) .. "[-]/" .. tostring(self.maxTotalKillNum)
        self.number.text = des
    end
end


---刷新添加按钮
function UIBossPanel_MagicBossViewTemplate:RefreshAddBtn()
    if CS.StaticUtility.IsNull(self.addBtn_GameObject) == false then
        --- local haveAddKillNumItem = luaclass.MagicBossDataInfo:HaveAddKillItem(self.magicBossType)
        if CS.StaticUtility.IsNull(self.addBtn_TweenAlpha) == false and CS.StaticUtility.IsNull(self.addBtn_UISprite) == false then
            if self.curKillNum ~= nil and self.curKillNum <= 0 then
                local haveItem = false
                local magicBossConfigInfo = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(self.magicBossType)
                if magicBossConfigInfo ~= nil then
                    local addKillNumMaterialItemId = magicBossConfigInfo.killNumRecoverItemId
                    if addKillNumMaterialItemId ~= nil then
                        local materialBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(addKillNumMaterialItemId)
                        if materialBagItemInfo ~= nil then
                            haveItem = true
                        end
                    end
                end
                if haveItem then
                    self.addBtn_UISprite.spriteName = "add_small4"
                    self.addBtn_TweenAlpha:Play()
                else
                    self.addBtn_UISprite.spriteName = "add_small3"
                    self.addBtn_TweenAlpha:ResetToBeginning()
                end
            else
                self.addBtn_UISprite.spriteName = "add_small3"
                self.addBtn_TweenAlpha:ResetToBeginning()
            end
        end
        --self.addBtn_GameObject:SetActive(self.curKillNum ~= nil and self.curKillNum <= 0)
        self.addBtn_GameObject:SetActive(false)
        self.table_UITable:Reposition()
    end
end

---开始刷新时间
function UIBossPanel_MagicBossViewTemplate:StartRefreshTime()
    ---服务器下发的时间Update
    self.addKillNumRemainTime = luaclass.MagicBossDataInfo:GetAddKillNumRemainTime(self.magicBossType,LuaEnumRemainTimeType.TotalKillNumRecoverRemainTime)
    self:RemoveUpdate()
    if self.showAddKillNumTime == false or self.addKillNumRemainTime < 0 then
        if CS.StaticUtility.IsNull(self.time) == false then
            self.time.gameObject:SetActive(false)
        end
        return
    end
    self:RefreshUpdate(function()
        self:RefreshAddKillNumTime()
    end)
    self:RefreshAddKillNumTime()
    self.table_UITable:Reposition()
end

---刷新增加击杀次数时间
function UIBossPanel_MagicBossViewTemplate:RefreshAddKillNumTime()
    local showAddKillNumTime = luaclass.MagicBossDataInfo:KillTimeIsMax(self.magicBossType) == false
    self.addKillNumRemainTime = luaclass.MagicBossDataInfo:GetAddKillNumRemainTime(self.magicBossType,LuaEnumRemainTimeType.TotalKillNumRecoverRemainTime)
    if CS.StaticUtility.IsNull(self.time) == false then
        local showRemainTime = showAddKillNumTime or self.addKillNumRemainTime < 0
        self.time.gameObject:SetActive(showRemainTime)
        if showAddKillNumTime == true and self.addKillNumRemainTime > 0 then
            local hour, minute, second = Utility.MillisecondToFormatTime(self.addKillNumRemainTime)
            local des = luaEnumColorType.Gray .. string.format("恢复倒计时%02d:%02d:%02d", Utility.RemoveEndZero(hour), Utility.RemoveEndZero(minute), Utility.GetIntPart(second))
            self.time.text = des
        else
            self:RemoveUpdate()
        end
    end
end
--endregion

--region 重写
---是否显示左侧页签
---@protected
function UIBossPanel_MagicBossViewTemplate:IsShowLeftPageView()
    return true
end

function UIBossPanel_MagicBossViewTemplate:InitTemplate(customData)
    self.mBossType = customData.bossType
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_DemonBossTemplates
end

---获取排序之后的boss列表
function UIBossPanel_MagicBossViewTemplate:GetSortedBossListInfo(type)
    if type == nil then
        return
    end
    if self.curAllSortedBossDic[type] == nil then
        local list = self.curAllBossDic[type]
        if list == nil then
            return nil
        end
        local info = {}
        for i, v in pairs(list) do
            local IsMeet = 0
            if self.curAllIsMeetBossStateDic[type] ~= nil then
                for j, allInfo in pairs(v) do
                    if self.curAllIsMeetBossStateDic[type][allInfo.bossId] then
                        IsMeet = 1
                    end
                end
            end
            local IsSurvive = 0
            if self.curAllIsMeetBossIsSurviveDic[type] ~= nil then
                if self.curAllIsMeetBossIsSurviveDic[type][i] ~= 0 then
                    IsSurvive = 1
                end
            end
            ---没有限制的魔之boss排在最前面
            local IsCanAttack = 0
            if clientTableManager.cfg_demon_bossManager:MagicBossHaveLimit(i) == false then
                IsCanAttack = 99
            else
                ---玩家满足限制的排在之后
                if i ~= nil and clientTableManager.cfg_demon_bossManager:MagicBossCanAttack(i) == true then
                    IsCanAttack = 1
                end
            end
            local data = { bossId = v[1].bossId, monsterId = i, allInfo = v, isMeet = IsMeet, isSurvive = IsSurvive, isCanAttack = IsCanAttack }
            table.insert(info, data)
        end
        if #info > 0 then
            table.sort(info, function(a, b)
                local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(a.bossId)
                if a.isMeet ~= b.isMeet then
                    return a.isMeet > b.isMeet
                end
                if a.isSurvive ~= b.isSurvive then
                    return a.isSurvive > b.isSurvive
                end
                if a.isCanAttack ~= b.isCanAttack then
                    return a.isCanAttack > b.isCanAttack
                end
                local aOrder = 0
                local bOrder = 0
                if a and b and a.bossId and b.bossId then
                    local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(a.bossId)
                    if bossInfo then
                        aOrder = bossInfo:GetOrder()
                        aOrder = aOrder == nil and 0 or aOrder
                    end
                    bossInfo = clientTableManager.cfg_bossManager:TryGetValue(b.bossId)
                    if bossInfo then
                        bOrder = bossInfo:GetOrder()
                        bOrder = bOrder == nil and 0 or bOrder
                    end
                end
                return aOrder < bOrder
            end)
            self.curAllSortedBossDic[type] = info
        end
    end
    return self.curAllSortedBossDic[type]
end

---得到默认跳转页签
function UIBossPanel_MagicBossViewTemplate:GetJumpNumber()
    if self.curAllIsMeetBossIsSurviveDic == nil then
        return 0
    end
    local index = 0
    local curJumpIndex = nil
    for i = 0, #self.pageDataList - 1 do
        local nowTab = self.pageDataList[#self.pageDataList - i]
        local SelectconditionList = nowTab.SelectconditionList
        local isMeetTabcondition = self:IsMeetTabcondition(SelectconditionList)
        local magicBossType = LuaGlobalTableDeal.GetMagicBossTypeByBtnSubType(nowTab.pageType)
        local magicBossTypeInfo = luaclass.MagicBossDataInfo:GetMagicBossTypeInfoByType(magicBossType)
        local monsterIsDead = self.curBossPageStateDic[nowTab.pageType]
        if magicBossTypeInfo ~= nil then
            if isMeetTabcondition == false or monsterIsDead == true or magicBossTypeInfo:GetCurKillNum() <= 0 then
                index = index + 1
            else
                local dic = self.curAllIsMeetBossIsSurviveDic[nowTab.pageType]
                if dic ~= nil then
                    for i, v in pairs(dic) do
                        if v >= 1 then
                            if curJumpIndex == nil then
                                curJumpIndex = index
                            end
                            luaclass.MagicBossDataInfo:SaveMagicBossHintRedPointMagicType(magicBossType)
                        end
                    end
                    index = index + 1
                end
            end
        end
    end
    gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(true)
    if curJumpIndex ~= nil then
        return curJumpIndex
    end
    return index
end

---刷新默认视图
function UIBossPanel_MagicBossViewTemplate:RefreshDefaultView()
    self:DefaultRefresh()
end

-----默认刷新
function UIBossPanel_MagicBossViewTemplate:DefaultRefresh()
    local bestMonsterId = self:GetDefaultChooseMonsterId()
    if bestMonsterId ~= nil and bestMonsterId ~= 0 then
        self:ChooseItem(bestMonsterId)
    else
        self:ChooseFirstItem()
    end
end

---获取默认自动选择的怪物id
---@return number monsterId
function UIBossPanel_MagicBossViewTemplate:GetDefaultChooseMonsterId()
    if self.curSelectPageInfo ~= nil and self.curSelectPageInfo.type ~= nil then
        local bossInfoTable = self:GetSortedBossListInfo(self.curSelectPageInfo.type)
        if bossInfoTable ~= nil then
            local bestMonsterId = 0
            local bestMonsterLevel = 0
            local orderId = 0
            for k, v in pairs(bossInfoTable) do
                local allBossInfo = v.allInfo
                if allBossInfo ~= nil and type(allBossInfo) == 'table' then
                    for a, b in pairs(allBossInfo) do
                        if b ~= nil and b.bossId ~= nil then
                            local monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(b.configId)
                            local bossTable = clientTableManager.cfg_bossManager:TryGetValue(b.bossId)
                            if monsterTable ~= nil and bossTable ~= nil then
                                --local magicBossCanBeAttack = luaclass.MagicBossDataInfo:MagicBossInfoCanAttackByBossInfo(b)
                                --local magicBossDefaultChooseCondition = clientTableManager.cfg_demon_bossManager:CheckMagicBossDefaultChooseCondition(b.configId)
                                --local demonTable =  clientTableManager.cfg_demon_bossManager:TryGetValue(b.configId)
                                --print(monsterTable:GetName() .. "--->是否可以攻击" ..  tostring(magicBossCanBeAttack) .. "---》是否满足配置condition条件" .. tostring(demonTable:GetChooseCondition()) .. tostring(magicBossDefaultChooseCondition))
                                if luaclass.MagicBossDataInfo:MagicBossInfoCanAttackByBossInfo(b) == true and clientTableManager.cfg_demon_bossManager:CheckMagicBossDefaultChooseCondition(b.configId) == true then
                                    if monsterTable:GetLevel() >= bestMonsterLevel and bossTable:GetOrder() > orderId then
                                        bestMonsterId = monsterTable:GetId()
                                        bestMonsterLevel = monsterTable:GetLevel()
                                        orderId = bossTable:GetOrder()
                                    end
                                end
                            end
                        end
                    end
                end
            end
            return bestMonsterId
        end
    end
end

---获取页签名字
---@param pageInfo table 页签数据
function UIBossPanel_MagicBossViewTemplate:GetPageName(pageInfo)
    if pageInfo ~= nil and pageInfo.type ~= nil then
        local magicBossType = pageInfo.type
        local killNum = luaclass.MagicBossDataInfo:GetMagicBossTypeKillNum(magicBossType)
        local killNumMax = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(magicBossType).killNumMax
        local stringFormat = pageInfo.typeDes .. "(%s/%s)"
        return string.format(stringFormat,tostring(killNum),tostring(killNumMax))
    end
    return pageInfo.typeDes
end
--endregion

return UIBossPanel_MagicBossViewTemplate