---每日目标界面 任务活动单元
local UIDayToDayPanel_MissionActivity = {}

UIDayToDayPanel_MissionActivity.mIndex = 0;

UIDayToDayPanel_MissionActivity.mActiveData = nil;

--region Components

function UIDayToDayPanel_MissionActivity:GetChooseEffect_GameObject()
    if (self.mChooseEffect_GameObject == nil) then
        self.mChooseEffect_GameObject = self:Get("root/choose", "GameObject");
    end
    return self.mChooseEffect_GameObject;
end

function UIDayToDayPanel_MissionActivity:GetRoot_GameObject()
    if (self.mRoot_GameObject == nil) then
        self.mRoot_GameObject = self:Get("root", "GameObject");
    end
    return self.mRoot_GameObject;
end

function UIDayToDayPanel_MissionActivity:GetUpdateTime_GameObject()
    if (self.mUpdateTime_GameObject == nil) then
        self.mUpdateTime_GameObject = self:Get("updateTime", "GameObject");
    end
    return self.mUpdateTime_GameObject;
end

--endregion

--region Method

--region CallFunction
---设置点击回调函数
---@param callback 参加按钮的点击回调函数
function UIDayToDayPanel_MissionActivity:SetJoinButtonClickedCallback(callback)
    self.mJoinBtnClickedCallback = callback
end

---参加按钮点击事件
---返回到每日活动界面处理
function UIDayToDayPanel_MissionActivity:OnJoinButtonClicked(go)
    if (self.mActiveData ~= nil) then
        local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(self.mActiveData.id);
        if (activeVo ~= nil) then
            if self.mJoinBtnClickedCallback then
                self.mJoinBtnClickedCallback(self.mActiveData, activeVo.mission)
            end
        end
    end
end

--endregion

--region Public

function UIDayToDayPanel_MissionActivity:RefreshMission()
    self:UpdateUI();
end

function UIDayToDayPanel_MissionActivity:RefreshData(active, i)
    if (active.id < 0) then
        self:GetRoot_GameObject():SetActive(false);
        self:GetUpdateTime_GameObject():SetActive(true);
    else
        self:GetRoot_GameObject():SetActive(true);
        self:GetUpdateTime_GameObject():SetActive(false);
        self.mActiveData = active;
        self.mIndex = i;
        self:UpdateUI();
    end
end

function UIDayToDayPanel_MissionActivity:UpdateUI()
    if (self.mActiveData ~= nil) then
        ------背景
        self.mBackGround_UISprite.gameObject:SetActive(self.mIndex % 2 == 0)
        ------图标
        self.mIcon_UISprite.spriteName = self.mActiveData.icon
        ----名字
        self.mNameLabel_UILabel.text = self.mActiveData.name
        --次数
        local activeInfo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(self.mActiveData.id);
        local count = 0;
        local isAllGet = false;
        if (activeInfo ~= nil) then
            isAllGet = activeInfo.completeCount == activeInfo.clientActiveNum;
            count = activeInfo.completeCount - activeInfo.clientActiveNum;
        end
        --local maxCount = self.mActiveData.count
        self.isComplete = CS.CSScene.MainPlayerInfo.ActiveInfo:IsComplete(self.mActiveData);
        --self.mAllCountLabel_UILabel.text = "(".. tostring(count) .. "/" .. tostring(maxCount) .. ")[-]"
        self.mJoinBtn_GO:SetActive(not self.isComplete);
        self.mComplete_Go:SetActive(self.isComplete)

        self:UpdateReward();
        self:UpdateBtnShow();
        self:UpdateChooseEffect()
    end
end

function UIDayToDayPanel_MissionActivity:UpdateChooseEffect()
    if (self.mActiveData ~= nil) then
        local currentActiveVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
        if (currentActiveVo ~= nil) then
            self:GetChooseEffect_GameObject():SetActive(currentActiveVo.id == self.mActiveData.id);
        else
            self:GetChooseEffect_GameObject():SetActive(false);
        end
    end
end

--endregion

--region Private

--设置奖励
function UIDayToDayPanel_MissionActivity:UpdateReward()
    self.mMissionReward.gameObject:SetActive(false)
    if (self.mRewardUnitDic == nil) then
        self.mRewardUnitDic = {};
    end
    ---@type IActiveMission
    local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(self.mActiveData.id);
    local stateCode = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveState(self.mActiveData.id);
    if activeVo ~= nil then
        if (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.DAILY_TASK)) then
            local showStr = "";
            local recommendStr = "";
            --region 日常任务
            if (activeVo.mission ~= nil) then
                self:RefreshMissionReward(activeVo.mission)
                --region 推荐文本
                local recommendTable = activeVo:GetMissionItemRecommend();
                if (recommendTable ~= nil) then
                    local isFindDeliver, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(recommendTable.deliverId);
                    local x = 0;
                    local y = 0;
                    if (isFindDeliver) then
                        x = deliverTable.x;
                        y = deliverTable.y;
                        local posStr = recommendTable.isVisible == 1 and "  " .. x .. "," .. y or "";
                        local isFindMap, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(deliverTable.toMapId);
                        if (isFindMap) then
                            recommendStr = luaEnumColorType.Gray2 .. "(推荐前往  [u][url=findDailyTaskRecommend:" .. mapTable.id .. ":" .. deliverTable.id .. ":" .. x .. ":" .. y .. ":" .. activeVo.mission.taskId .. "]" .. mapTable.name .. posStr .. "[/u]  " .. recommendTable.label .. ")[-]";
                        end
                    end
                end
                --endregion

                local taskItemList, type, curCount, maxCount = activeVo.mission:GetTaskTarget();
                --print(activeVo.id.."--"..type.."--"..activeVo.activeTable.name);
                if (taskItemList ~= nil) then
                    if (type == 1) then
                        --region 满足一种
                        local itemNames = "";
                        --local mAllCount = 0;
                        --for i = 0, taskItemList.Count - 1 do
                        --    local itemName = "";--CS.Cfg_ItemsTableManager.Instance:GetItemName(taskItemList[i].item);
                        --    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(taskItemList[i].item);
                        --    if(isFindItem) then
                        --        itemName = itemTable.name;
                        --    end
                        --    if(itemName ~= nil) then
                        --        local endStr = "";
                        --        if(i ~= taskItemList.Count - 1) then
                        --            endStr = "、";
                        --        end
                        --        itemNames = itemNames.."[u]".."[url=itemInfo:"..taskItemList[i].item.."]"..itemName.."[/url]".."[/u]"..endStr;
                        --    end
                        --end
                        --if(itemNames ~= "") then
                        --    itemNames = "("..itemNames.."均可)";
                        --end
                        local showCount = curCount;
                        local showMaxCount = maxCount;
                        --local colorStr = (stateCode == 1 or stateCode == 2 or activeVo.mission:CanSubmission()) and luaEnumColorType.Green or luaEnumColorType.White;
                        --local maxCountColor = (stateCode == 1 or stateCode == 2 or activeVo.mission:CanSubmission()) and luaEnumColorType.Green or "";
                        --local colorStr = showCount >= showMaxCount and luaEnumColorType.Green or luaEnumColorType.White;
                        --local maxCountColor = showCount >= showMaxCount and luaEnumColorType.Green or luaEnumColorType.White;
                        if (stateCode ~= 3) then
                            showStr = "   收集任意" .. "[u]" .. "[url=activeId:" .. self.mActiveData.id .. "]" .. "[A4CEF6]" .. self:GetItemTypeName() .. "[-]" .. "[/url]" .. "[/u]" .. "  "
                                    .. ((stateCode ~= 2 and stateCode ~= 3) and
                                    CS.Utility_Lua.SetProgressLabelColor(showCount, showMaxCount) .. "  " .. luaEnumColorType.Gray2 .. itemNames .. "[-]"
                                    or luaEnumColorType.Green .. "已完成[-]");
                        end
                        --endregion
                    elseif (type == 2) then
                        --region 满足所有条件
                        for i = 0, taskItemList.Count - 1 do
                            local itemName = "";--CS.Cfg_ItemsTableManager.Instance:GetItemName(taskItemList[i].item);
                            local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(taskItemList[i].groupId);
                            if (isFindItem) then
                                itemName = itemTable.name;
                            end
                            local endStr = "";
                            if (i ~= taskItemList.Count - 1) then
                                endStr = ",  ";
                            end
                            local showCount = taskItemList[i].count;
                            --local colorStr = (stateCode == 1 or stateCode == 2 or activeVo.mission:CanSubmission()) and luaEnumColorType.Green or luaEnumColorType.White;
                            local maxCountColor = (stateCode == 1 or stateCode == 2 or activeVo.mission:CanSubmission()) and luaEnumColorType.Green or "";
                            local maxCountColorEnd = maxCountColor == "" and "" or "[-]";
                            showStr = showStr .. "   收集 [u]" .. "[url=itemInfo:" .. taskItemList[i].groupId .. "]" .. itemName .. "[/url][/u] "
                                    .. ((stateCode ~= 2 and stateCode ~= 3) and CS.Utility_Lua.SetProgressLabelColor(showCount, taskItemList[i].maxCount) .. maxCountColorEnd
                                    .. endStr or luaEnumColorType.Green .. "已完成[-]");
                        end
                        --endregion
                    end
                end
            else
                showStr = luaEnumColorType.Green .. "   已完成[-]";
            end
            if (stateCode == 5) then
                self.mDec_UILabel.text = "";
            elseif (stateCode ~= 3) then
                self.mDec_UILabel.text = showStr .. "  " .. ((stateCode ~= 2 and stateCode ~= 3) and recommendStr or "");
            else
                self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
            end

            if (stateCode == 2) then
                self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
            elseif (stateCode == 1) then
                self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow .. '可领奖励[-]';
            elseif (stateCode == 4) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
            elseif (stateCode == 5) then
                self.mJoinBtn_Label.text = '[ffcda5]使用卷轴[-]';
            elseif (stateCode ~= 3) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
            end
            --endregion
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.KILL_BOSS)) then
            self:UpdateOtherReward();
            --region 击杀BOSS
            local activeGoal = self.mActiveData.goal;
            local recommendList;
            local showStr = activeVo:GetActiveDes();
            local mLevel = CS.CSScene.MainPlayerInfo.Data.zeroLevel;
            local mReinLevel = CS.CSScene.MainPlayerInfo.Data.zeroRein;
            if (activeGoal == LuaEnumActiveGoalType.KILL_ELITE_BOSS) then
                local vo = CS.Cfg_GlobalTableManager.Instance:GetBossRecommendedLimits(mLevel, mReinLevel);
                if (vo ~= nil) then
                    local targetValue = vo.type == 1 and vo.firstBossLevel or vo.firstBossReinLevel;
                    showStr = "击杀" .. targetValue .. (vo.type == 1 and "级" or "转") .. "以上[ff00ff]野外BOSS[-]";
                    if (vo.type == 1) then
                        recommendList = CS.Cfg_BossTableManager.Instance:GetGradeApproachingBoss(vo.firstBossLevel, LuaEnumBossType.EliteBoss);
                    end
                end

                if (recommendList == nil) then
                    recommendList = CS.Cfg_BossTableManager.Instance:GetGradeApproachingBoss(CS.CSScene.MainPlayerInfo.Level, LuaEnumBossType.EliteBoss);
                end

            elseif (activeGoal == LuaEnumActiveGoalType.KILL_BOSS) then
                --CS.Cfg_GlobalTableManager.Instance:GetBossRecommendedLimits(mLevel, mReinLevel, 1);
                local vo = CS.Cfg_GlobalTableManager.Instance:GetBossRecommendedLimits(mLevel, mReinLevel);
                if (vo ~= nil) then
                    local targetValue = vo.type == 1 and vo.secondBossLevel or vo.secondBossReinLevel;
                    showStr = "击杀" .. targetValue .. (vo.type == 1 and "级" or "转") .. "以上[ff0000]巢穴BOSS[-]";
                    if (vo.type == 1) then
                        recommendList = CS.Cfg_BossTableManager.Instance:GetGradeApproachingBoss(vo.secondBossLevel, LuaEnumBossType.WorldBoss);
                    end
                end

                if (recommendList == nil) then
                    recommendList = CS.Cfg_BossTableManager.Instance:GetGradeApproachingBoss(CS.CSScene.MainPlayerInfo.Level, LuaEnumBossType.WorldBoss);
                end
            end
            local colorStr = stateCode == 2 and luaEnumColorType.Green or luaEnumColorType.White;
            showStr = showStr .. "  " ..
                    --(stateCode ~= 2 and stateCode ~= 3 and luaEnumColorType.White..activeVo.clientActiveNum.."/1[-]" or colorStr..luaEnumColorType.Green.."已完成");
                    CS.Utility_Lua.SetProgressLabelColor(activeVo.clientActiveNum, 1)
            local endStr = "";
            if (recommendList ~= nil and recommendList.Count > 0) then
                endStr = "  " .. luaEnumColorType.Gray2 .. "(推荐击杀";
                local nameStr = "";
                for i = 0, recommendList.Count - 1 do
                    local monsterTable = recommendList[i];
                    if (monsterTable ~= nil) then
                        if (i ~= 0) then
                            nameStr = nameStr .. "  " .. "[u][url=bossInfo:" .. monsterTable.id .. "]" .. monsterTable.name .. "[/url][/u]";
                        else
                            nameStr = nameStr .. "[u][url=bossInfo:" .. monsterTable.id .. "]" .. monsterTable.name .. "[/url][/u]";
                        end
                    end
                end
                endStr = endStr .. nameStr .. ")[-]";
            end
            showStr = showStr .. ((stateCode ~= 2 and stateCode ~= 3) and endStr or "");

            if (stateCode == 5) then
                self.mDec_UILabel.text = "";
            elseif (stateCode ~= 3) then
                self.mDec_UILabel.text = showStr;
            else
                self.mDec_UILabel.text = luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
            end

            if (stateCode == 2) then
                self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. "全部领取[-]";
            elseif (stateCode ~= 3) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
            else
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. "提交[-]";
            end
            self.mNameLabel_UILabel.text = "";
            --endregion
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.ELITE_REWARD)) then
            --region 精英悬赏
            local showStr = "";
            local recommendStr = "";
            if (activeVo.mission ~= nil) then
                self:UpdateMissionReward(activeVo.mission)
                local monsterIdList = activeVo:GetEliteRewardMissionTargetRecommend();
                if (monsterIdList ~= nil and monsterIdList.Count > 0) then
                    local recommendMonsterName = "";
                    for i = 0, monsterIdList.Count - 1 do
                        local isFind, monsterTable = CS.Cfg_MonsterTableManager.Instance:TryGetValue(monsterIdList[i]);
                        if (isFind) then
                            local endStr = "";
                            if (i < monsterIdList.Count - 1) then
                                endStr = ", "
                            end
                            --if(showStr == "") then
                            --    local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
                            --    if(taskShowList ~= nil and taskShowList.Count > 0) then
                            --        local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
                            --        showStr = "击杀  [ff00ff]"..monsterTable.name.."[-]"..colorStr..taskShowList[0].CurCount.."[-]/"..taskShowList[0].MaxCount;
                            --    end
                            --end
                            recommendMonsterName = recommendMonsterName .. "[u][url=bossInfo:" .. monsterTable.id .. "]" .. monsterTable.name .. "[/url][/u]" .. endStr;
                        end
                    end
                    recommendStr = luaEnumColorType.Gray2 .. "(推荐击杀  " .. recommendMonsterName .. ")[-]";
                end
                local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
                if (taskShowList ~= nil and taskShowList.Count > 0) then
                    local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
                    showStr = taskShowList[0].Des .. " " .. colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount;
                end
            end

            if (stateCode == 5) then
                self.mDec_UILabel.text = "";
            elseif (stateCode ~= 3) then
                showStr = CS.Utility_Lua.StringReplace(showStr, "精英", "[ff00ff]精英[-]");
                self.mDec_UILabel.text = "   " .. showStr;
            else
                self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
            end

            if (stateCode == 2) then
                self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
            elseif (stateCode == 4) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
            elseif (stateCode == 5) then
                self.mJoinBtn_Label.text = '[ffcda5]可购买[-]';
            elseif (stateCode ~= 3) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
            end
            --endregion
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.BOSS_REWARD)) then
            --region Boss悬赏
            local showStr = "";
            local recommendStr = "";
            if (activeVo.mission ~= nil) then
                self:UpdateMissionReward(activeVo.mission)
                --[[                local monsterIdList = activeVo:GetBossRewardMissionTargetRecommend();
                                if (monsterIdList ~= nil and monsterIdList.Count > 0) then
                                    local recommendMonsterName = "";
                                    for i = 0, monsterIdList.Count - 1 do
                                        local isFind, monsterTable = CS.Cfg_MonsterTableManager.Instance:TryGetValue(monsterIdList[i]);
                                        if (isFind) then
                                            local endStr = "";
                                            if (i < monsterIdList.Count - 1) then
                                                endStr = ", "
                                            end
                                            --if(showStr == "") then
                                            --    local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
                                            --    if(taskShowList ~= nil and taskShowList.Count > 0) then
                                            --        local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
                                            --        showStr = "击杀  [ff0000]"..monsterTable.name.."[-]"..colorStr..taskShowList[0].CurCount.."[-]/"..taskShowList[0].MaxCount;
                                            --    end
                                            --end
                                            recommendMonsterName = recommendMonsterName .. "[u][url=bossInfo:" .. monsterTable.id .. "]" .. monsterTable.name .. "[/url][/u]" .. endStr;
                                        end
                                    end
                                    recommendStr = luaEnumColorType.Gray2 .. "(推荐击杀  " .. recommendMonsterName .. ")[-]";
                                end
                                local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
                                if (taskShowList ~= nil and taskShowList.Count > 0) then
                                    local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
                                    showStr = taskShowList[0].Des .. " " .. colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount;
                                end]]
            end

            --[[            if (stateCode == 5) then
                            self.mDec_UILabel.text = "";
                        elseif (stateCode ~= 3) then
                            showStr = CS.Utility_Lua.StringReplace(showStr, "BOSS", "[ff0000]BOSS[-]");
                            self.mDec_UILabel.text = "   " .. showStr;
                        else
                            self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
                        end]]
            self.mDec_UILabel.text = "";
            if (stateCode == 2) then
                self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
            elseif (stateCode == 4) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
            elseif (stateCode == 5) then
                self.mJoinBtn_Label.text = '[ffcda5]可购买[-]';
            elseif (stateCode ~= 3) then
                self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
            end
            self.mJoinBtn_GO.gameObject:SetActive(stateCode ~= 3)
            --endregion
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.BAIRIMEN_REWARD)) then
            self:RefreshViewForBaiRiMenType(activeVo, stateCode)
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.KILL_UNIONLEADER)) then
            self:RefreshViewForUnitLeaderType(activeVo, stateCode)
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.PERSONAL_BOSS)) then
            self:RefreshViewForPersonalBossType(activeVo, stateCode)
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.DAILY_CHALLENGE)) then
            self:RefreshViewForDailyChallengeType(activeVo, stateCode)
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.DiamondMall)) then
            self:RefreshViewForDailyChallengeType(activeVo, stateCode)
        elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.Recharge)) then
            self:RefreshViewForDailyChallengeType(activeVo, stateCode)
        end

        --region 活跃度奖励
        local rewardList = activeVo:GetActiveReward();
        if (rewardList ~= nil) then
            local otherCount = 1;
            self.mRewardGrid.MaxCount = rewardList.Count + otherCount;
            local rewardCount = rewardList.Count
            for i = 0, rewardCount - 1 do
                local gobj = self.mRewardGrid.controlList[i];
                if (self.mRewardUnitDic[gobj] == nil) then
                    self.mRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIDayToDayPanel_MissionRewardTemplate)
                end
                self.mRewardUnitDic[gobj]:UpdateUnit(rewardList[i][0], rewardList[i][1]);
            end
            if (stateCode ~= 3) then
                local gobj = self.mRewardGrid.controlList[rewardCount];
                if (self.mRewardUnitDic[gobj] == nil) then
                    self.mRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIDayToDayPanel_MissionRewardTemplate)
                end
                --self.mRewardUnitDic[gobj]:UpdateOther(tostring((activeVo.activeTable.count - (activeVo.completeCount - activeVo.clientActiveNum))));
                self.mRewardUnitDic[gobj]:UpdateOther(tostring(activeVo.activeTable.count - activeVo.getCount) .. '/' .. tostring(activeVo.activeTable.count));
            else
                local gobj = self.mRewardGrid.controlList[rewardCount];
                if (self.mRewardUnitDic[gobj] == nil) then
                    self.mRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIDayToDayPanel_MissionRewardTemplate)
                end
                --self.mRewardUnitDic[gobj]:UpdateOther(tostring((activeVo.activeTable.count - (activeVo.completeCount - activeVo.clientActiveNum))));
                self.mRewardUnitDic[gobj]:UpdateOther(tostring(activeVo.activeTable.count) .. '/' .. tostring(activeVo.activeTable.count))
            end
        end
        --endregion

        if (activeVo.clientActiveNum > 0) then
            self.mCountLabel_UILabel.gameObject:SetActive(true);
            self.mCountLabel_UILabel.text = "可领" .. luaEnumColorType.Green .. activeVo.clientActiveNum .. "[-]次";
        elseif (stateCode == 5) then
            if (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.DAILY_TASK)) then
                local buyCount = activeVo.mission == nil and 0 or activeVo.mission.BuyMaxCount - activeVo.mission.BuyCount
                --local buyCount = activeVo:GetTaskCanBuyCount();
                self.mCountLabel_UILabel.gameObject:SetActive(true);
                self.mCountLabel_UILabel.text = "可使用次数 " .. luaEnumColorType.Green .. buyCount .. "[-]次";
            elseif (activeVo.activeTable.type == Utility.EnumToInt(CS.ActiveActionType.ELITE_REWARD)) then
                local buyCount = 0
                if activeVo.mission then
                    buyCount = activeVo.mission.BuyMaxCount - activeVo.mission.BuyCount
                else
                    buyCount = CS.CSMissionManager.Instance.EliteTaskCount.CanBuyCount
                end
                --local buyCount = activeVo:GetTaskCanBuyCount();
                self.mCountLabel_UILabel.gameObject:SetActive(true);
                self.mCountLabel_UILabel.text = "可购买次数 " .. luaEnumColorType.Green .. buyCount .. "[-]次";
            else
                self.mCountLabel_UILabel.gameObject:SetActive(false);
            end
        else
            self.mCountLabel_UILabel.gameObject:SetActive(false);
        end
    end
end

function UIDayToDayPanel_MissionActivity:UpdateBtnShow()
    if (self.mActiveData ~= nil) then
        local stateCode = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveState(self.mActiveData.id);
        local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(self.mActiveData.id);
        self.mBtnEffect_GameObject:SetActive((stateCode == 1 or stateCode == 2) and stateCode ~= 3)
        if (stateCode == 5) then
            self.mJoinBtn_UISprite.spriteName = "anniu8";
        else
            self.mJoinBtn_UISprite.spriteName = ((stateCode == 1 or stateCode == 2) and stateCode ~= 3) and "anniu11" or "anniu7";
        end
        if (activeVo ~= nil and activeVo.mission ~= nil) then
            self.mBtnEffect2_GameObject:SetActive(activeVo.mission:CanSubmission() and stateCode ~= 3 and stateCode ~= 5 and not self.mBtnEffect_GameObject.activeSelf);
        else
            self.mBtnEffect2_GameObject:SetActive(false);
        end
    end
end

function UIDayToDayPanel_MissionActivity:GetItemTypeName()
    --if(self.mActiveData ~= nil) then
    --    if(self.mActiveData.goal == LuaEnumActiveGoalType.BlacksmithTask) then
    --        return "矿石"
    --    elseif (self.mActiveData.goal == LuaEnumActiveGoalType.ButcherTask) then
    --        return "肉类"
    --    elseif (self.mActiveData.goal == LuaEnumActiveGoalType.DruggistTask) then
    --        return "药材"
    --    elseif (self.mActiveData.goal == LuaEnumActiveGoalType.FishermanTask) then
    --        return "鱼类"
    --    elseif (self.mActiveData.goal == LuaEnumActiveGoalType.TrampTask) then
    --        return "水果"
    --    end
    --end
    --return "材料";
    if (self.mActiveData ~= nil) then
        return Utility.GetDailyTaskTypeItemName(self.mActiveData.goal);
    end
    return "材料";
end

---领取完成特效
function UIDayToDayPanel_MissionActivity:PlayCompleteEffect()
    local effectPanel = uimanager:GetPanel("UIEffectPanel");
    local dayToDayPanel = uimanager:GetPanel("UIDayToDayPanel");
    if (effectPanel ~= nil and dayToDayPanel ~= nil) then
        local rewardUnit;
        if (self.mRewardUnitDic ~= nil) then
            for k, v in pairs(self.mRewardUnitDic) do
                if (v.mItemTable.id == LuaEnumCoinType.ActiveCoin) then
                    rewardUnit = v;
                    break ;
                end
            end
        end
        if (rewardUnit ~= nil and not CS.StaticUtility.IsNull(rewardUnit.go)) then
            effectPanel:PlayEffect("700088", 1, rewardUnit.go.transform.position, function(gobj)
                if (gobj ~= nil and not CS.StaticUtility.IsNull(gobj)) then
                    local target = dayToDayPanel.GetMyActive_GameObject();
                    local tweenPosition = CS.Utility_Lua.GetComponent(gobj, "TweenPosition");
                    if (tweenPosition == nil) then
                        tweenPosition = gobj:AddComponent(typeof(CS.TweenPosition));
                        tweenPosition.enabled = false;
                        tweenPosition.duration = 1;
                    end
                    local wordPosition = target == nil and CS.UnityEngine.Vector3.zero or target.transform.position;
                    tweenPosition:SetOnFinished(function()
                        effectPanel:CloseEffect("700088");
                        luaEventManager.DoCallback(LuaCEvent.Active_UpdateActive);
                    end);

                    tweenPosition.from = effectPanel:GetLocalPosition(rewardUnit.go.transform.position);
                    tweenPosition.to = effectPanel:GetLocalPosition(wordPosition);

                    tweenPosition:PlayTween();
                end
            end);
        end
    end
end

function UIDayToDayPanel_MissionActivity:InitParameters()
    self.mActiveData = nil
    self.type = 0
    self.subtype = 0
    self.isComplete = false
    self.mJoinBtnClickedCallback = nil
end

function UIDayToDayPanel_MissionActivity:InitComponents()
    --bg
    self.mBackGround_UISprite = self:Get("bg", "UISprite");
    --icon
    self.mIcon_UISprite = self:Get("root/icon", "UISprite")
    --次数文字组件
    self.mCountLabel_UILabel = self:Get("root/count", "UILabel")
    --名字文字组件
    self.mNameLabel_UILabel = self:Get("root/name", "UILabel")
    --状态文字组件
    self.mStateLabel_UILabel = self:Get("root/state", "UILabel")
    --描述文字组件
    self.mDec_UILabel = self:Get("root/lb_dec", "UILabel")
    --参加按钮
    self.mJoinBtn_GO = self:Get("root/btn", "GameObject")
    --已完成文本
    self.mComplete_Go = self:Get("root/complete", "GameObject")
    --参加按钮文本
    self.mJoinBtn_Label = self:Get("root/btn/Label", "Top_UILabel")
    --奖励
    self.mRewardGrid = self:Get("root/RewardGrid", "Top_UIGridContainer")
    --按钮特效
    self.mBtnEffect_GameObject = self:Get("root/btnEffect", "GameObject");
    --按钮特效2
    self.mBtnEffect2_GameObject = self:Get("root/btnEffect2", "GameObject");
    --按钮图片
    self.mJoinBtn_UISprite = self:Get("root/btn", "UISprite")
    ---@type UIGridContainer 任务奖励
    self.mMissionReward = self:Get("root/Awards", "UIGridContainer")
end

function UIDayToDayPanel_MissionActivity:BindUIMessage()
    CS.UIEventListener.Get(self.mJoinBtn_GO).LuaEventTable = self
    CS.UIEventListener.Get(self.mJoinBtn_GO).OnClickLuaDelegate = self.OnJoinButtonClicked

    local SetCurrentActive = function()
        if (self.mActiveData ~= nil) then
            local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(self.mActiveData.id);
            if (activeVo ~= nil) then
                CS.CSScene.MainPlayerInfo.ActiveInfo:SetCurrentActive(activeVo.id);
            end
        end
    end
    CS.UIEventListener.Get(self.mDec_UILabel.gameObject).onClick = SetCurrentActive;
    CS.UIEventListener.Get(self.go).onClick = SetCurrentActive;
end

---@param mission CSMission
function UIDayToDayPanel_MissionActivity:RefreshMissionReward(mission)
    if not CS.StaticUtility.IsNull(self.mMissionReward) then
        --self.mMissionReward.gameObject:SetActive(true)
        if self.mMissionReward.gameObject.activeSelf then
            self.mMissionReward.gameObject:SetActive(false)
        end

        --[[        local taskId = mission.taskId
                local isFind, tbl_task = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(taskId)
                if isFind then
                    local isFindMission, mission = CS.CSMissionManager.Instance.mMissionDic:TryGetValue(tbl_task.id)
                    if isFindMission then
                        local isFindTab_DailyTask, tab_dailyTask = CS.Cfg_Daily_TaskTableManager.Instance:TryGetValue(mission.Tab_dailyID)
                        if isFindTab_DailyTask then
                            local list = tab_dailyTask.rewards.list
                            self.mMissionReward.MaxCount = list.Count
                            for i = 0, self.mMissionReward.controlList.Count - 1 do
                                local go = self.mMissionReward.controlList[i]
                                local rewardId = -1
                                if i < list.Count then
                                    local reward = list[i].list
                                    if reward.Count > 0 then
                                        rewardId = list[i].list[0]
                                    end
                                end
                                self:RefreshSingleMissionReward(go, rewardId)
                            end
                        end
                    end
                end]]

    end

end

function UIDayToDayPanel_MissionActivity:UpdateMissionReward(mission)
    if not CS.StaticUtility.IsNull(self.mMissionReward) then
        --self.mMissionReward.gameObject:SetActive(true)
        --[[        local taskId = mission.taskId
                local isFind, tbl_task = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(taskId)
                if (isFind) then
                    local itemIdAndNums = string.Split(tbl_task.rewards, "&")
                    if (itemIdAndNums ~= nil and #itemIdAndNums > 0) then
                        self.mMissionReward.MaxCount = #itemIdAndNums
                        local index = 0;
                        for k, v in pairs(itemIdAndNums) do
                            local gobj = self.mMissionReward.controlList[index];
                            local itemIdAndNum = string.Split(v, "#");
                            if (itemIdAndNum ~= nil and #itemIdAndNum > 0) then
                                local itemId = tonumber(itemIdAndNum[1]);
                                self:RefreshSingleMissionReward(gobj, itemId);
                            end
                            index = index + 1;
                        end
                    else
                        self.mMissionReward.MaxCount = 0;
                    end
                end]]
    end
end

---刷新单个任务奖励格子
function UIDayToDayPanel_MissionActivity:RefreshSingleMissionReward(go, rewardId)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    if not CS.StaticUtility.IsNull(icon) then
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(rewardId)
        if res then
            icon.spriteName = itemInfo.icon
            CS.UIEventListener.Get(go).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
    end
end

---刷新额外奖励
function UIDayToDayPanel_MissionActivity:UpdateOtherReward()
    if (self.mActiveData ~= nil) then
        if not CS.StaticUtility.IsNull(self.mMissionReward) then
            self.mMissionReward.gameObject:SetActive(true)
            local rewardList = self.mActiveData.extraAward;
            if (rewardList ~= nil and rewardList.list.Count > 0) then
                self.mMissionReward.MaxCount = rewardList.list.Count;
                for i = 0, self.mMissionReward.controlList.Count - 1 do
                    local go = self.mMissionReward.controlList[i];
                    if (rewardList.list[i].list.Count > 0) then
                        local rewardId = rewardList.list[i].list[0];
                        self:RefreshSingleMissionReward(go, rewardId)
                    end
                end
            end
        end
    end
end

--region NewView

---刷新白日门任务类型视图
function UIDayToDayPanel_MissionActivity:RefreshViewForBaiRiMenType(activeVo, stateCode)
    local showStr = "";
    if (activeVo.mission ~= nil) then
        self:RefreshMissionReward(activeVo.mission)
        if activeVo.mission.tbl_taskGoalS.Length > 0 then
            showStr = "   " .. activeVo.mission.tbl_taskGoalS[0].description
        end

        local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
        if (taskShowList ~= nil and taskShowList.Count > 0) then
            local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
            showStr = string.format(showStr, colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount)
        end
    end
    if (stateCode ~= 3) then
        self.mDec_UILabel.text = showStr
    else
        self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
    end

    --region BtnView
    if (stateCode == 2) then
        self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
    elseif (stateCode == 1) then
        self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow .. '可领奖励[-]';
    elseif (stateCode == 4) then
        self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
    elseif (stateCode == 5) then
        self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
    elseif (stateCode ~= 3) then
        self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
    end
    self.mJoinBtn_GO.gameObject:SetActive(stateCode ~= 3)
    --endregion
end

---刷新行会首领类型视图
function UIDayToDayPanel_MissionActivity:RefreshViewForUnitLeaderType(activeVo, stateCode)
    local showStr = "";
    if (activeVo.mission ~= nil) then
        self:RefreshMissionReward(activeVo.mission)
        if activeVo.mission.tbl_taskGoalS.Length > 0 then
            showStr = "   " .. activeVo.mission.tbl_taskGoalS[0].description
        end
    end

    local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
    if (taskShowList ~= nil and taskShowList.Count > 0) then
        local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
        showStr = string.format(showStr, colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount)
    end

    if (stateCode ~= 3) then
        self.mDec_UILabel.text = showStr
    else
        self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
    end

    --region BtnView
    if (stateCode == 2) then
        self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
    elseif (stateCode == 1) then
        self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow .. '可领奖励[-]';
    elseif (stateCode == 4) then
        self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
    elseif (stateCode == 5) then
        self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
    elseif (stateCode ~= 3) then
        self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
    end
    self.mJoinBtn_GO.gameObject:SetActive(stateCode ~= 3)
    --endregion
end

---刷新个人boss类型视图
function UIDayToDayPanel_MissionActivity:RefreshViewForPersonalBossType(activeVo, stateCode)
    local showStr = "";
    if (activeVo.mission ~= nil) then
        self:RefreshMissionReward(activeVo.mission)
        if activeVo.mission.tbl_taskGoalS.Length > 0 then
            showStr = "   " .. activeVo.mission.tbl_taskGoalS[0].description
        end

        local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
        if (taskShowList ~= nil and taskShowList.Count > 0) then
            local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
            showStr = string.format(showStr, colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount)
        end

        if (stateCode ~= 3) then
            self.mDec_UILabel.text = showStr
        else
            self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
        end

        --region BtnView
        if (stateCode == 2) then
            self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
        elseif (stateCode == 1) then
            self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow .. '可领奖励[-]';
        elseif (stateCode == 4) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
        elseif (stateCode == 5) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
        elseif (stateCode ~= 3) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
        end
        self.mJoinBtn_GO.gameObject:SetActive(stateCode ~= 3)
        --endregion
    end
end

---刷新行会首领类型视图
function UIDayToDayPanel_MissionActivity:RefreshViewForUnitLeaderType(activeVo, stateCode)
    local showStr = "";
    if (activeVo.mission ~= nil) then
        self:RefreshMissionReward(activeVo.mission)
        if activeVo.mission.tbl_taskGoalS.Length > 0 then
            showStr = "   " .. activeVo.mission.tbl_taskGoalS[0].description
        end

        local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
        if (taskShowList ~= nil and taskShowList.Count > 0) then
            local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
            showStr = string.format(showStr, colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount)
        end

        if (stateCode ~= 3) then
            self.mDec_UILabel.text = showStr
        else
            self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
        end

        --region BtnView
        if (stateCode == 2) then
            self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
        elseif (stateCode == 1) then
            self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow .. '可领奖励[-]';
        elseif (stateCode == 4) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
        elseif (stateCode == 5) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
        elseif (stateCode ~= 3) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
        end
        self.mJoinBtn_GO.gameObject:SetActive(stateCode ~= 3)
        --endregion
    end
end

---刷新日常挑战类型视图
function UIDayToDayPanel_MissionActivity:RefreshViewForDailyChallengeType(activeVo, stateCode)
    local showStr = "";
    if (activeVo.mission ~= nil) then
        self:RefreshMissionReward(activeVo.mission)
        if activeVo.mission.tbl_taskGoalS.Length > 0 then
            showStr = "   " .. activeVo.mission.tbl_taskGoalS[0].description
        end

        local taskShowList = activeVo.mission:GetDailyTaskShowInfo();
        if (taskShowList ~= nil and taskShowList.Count > 0) then
            local colorStr = taskShowList[0].CurCount < taskShowList[0].MaxCount and luaEnumColorType.Red or luaEnumColorType.Green;
            showStr = string.format(showStr, colorStr .. taskShowList[0].CurCount .. "[-]/" .. taskShowList[0].MaxCount)
        end

        if (stateCode ~= 3) then
            self.mDec_UILabel.text = showStr
        else
            self.mDec_UILabel.text = "   " .. luaEnumColorType.Gray1 .. self.mActiveData.desc .. "[-]";
        end

        --region BtnView
        if (stateCode == 2) then
            self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow1 .. '全部领取[-]';
        elseif (stateCode == 1) then
            self.mJoinBtn_Label.text = luaEnumColorType.SimpleYellow .. '可领奖励[-]';
        elseif (stateCode == 4) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '提交任务[-]';
        elseif (stateCode == 5) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
        elseif (stateCode ~= 3) then
            self.mJoinBtn_Label.text = luaEnumColorType.Blue .. '前往[-]';
        end
        self.mJoinBtn_GO.gameObject:SetActive(stateCode ~= 3)
        --endregion
    end
end

--endregion


function UIDayToDayPanel_MissionActivity:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:InitParameters()
end

return UIDayToDayPanel_MissionActivity