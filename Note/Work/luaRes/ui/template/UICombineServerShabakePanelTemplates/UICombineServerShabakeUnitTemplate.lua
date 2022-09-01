---@class UICombineServerShabakeUnitTemplate
local UICombineServerShabakeUnitTemplate = {};

UICombineServerShabakeUnitTemplate.mIndex = 0;

UICombineServerShabakeUnitTemplate.mActivityData = nil;

---@type TABLE.cfg_special_activity
UICombineServerShabakeUnitTemplate.mSpecialActivityTable = nil;

---@type table <UnityEngine.GameObject, UIItem>
UICombineServerShabakeUnitTemplate.mUIItemDic = nil;

function UICombineServerShabakeUnitTemplate:GetOver_GameObject()
    if (self.mOver_GameObject == nil) then
        self.mOver_GameObject = self:Get("over", "GameObject");
    end
    return self.mOver_GameObject;
end

function UICombineServerShabakeUnitTemplate:GetGuildName_Text()
    if (self.mGuildName_Text == nil) then
        self.mGuildName_Text = self:Get("guildname", "UILabel");
    end
    return self.mGuildName_Text;
end

function UICombineServerShabakeUnitTemplate:GetRanking_Text()
    if (self.mRanking_Text == nil) then
        self.mRanking_Text = self:Get("Total/rankingValue", "UILabel");
    end
    return self.mRanking_Text;
end

function UICombineServerShabakeUnitTemplate:GetRewardGridContainer()
    if (self.mRewardGridContainer == nil) then
        self.mRewardGridContainer = self:Get("rewardList", "UIGridContainer");
    end
    return self.mRewardGridContainer;
end

---@public 更新单元内容
---@param activityData activitiesV2.OneActivitiesInfo
function UICombineServerShabakeUnitTemplate:UpdateUnit(activityData, index)
    self.mActivityData = activityData;
    self.mIndex = index;
    self.mSpecialActivityTable = clientTableManager.cfg_special_activityManager:TryGetValue(self.mActivityData.configId);
    self:UpdateUI();
    self:UpdateReward();
end

---@public 更新UI
function UICombineServerShabakeUnitTemplate:UpdateUI()
    if (self.mActivityData ~= nil) then
        if (self.mActivityData.finish == 0) then
            self:GetGuildName_Text().text = luaEnumColorType.Gray .. "虚位以待[-]";
        else
            local name = self.mActivityData.strParam == nil and "虚位以待" or self.mActivityData.strParam;
            self:GetGuildName_Text().text = luaEnumColorType.Orange .. name .. "[-]";
        end
        self:GetRanking_Text().text = luaEnumColorType.Orange .. self.mSpecialActivityTable:GetSmallName() .. "[-]";
        self:GetOver_GameObject():SetActive(self.mActivityData.finish == 1);
    end
end

function UICombineServerShabakeUnitTemplate:UpdateReward()
    if (self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end
    local gridContainer = self:GetRewardGridContainer();
    if (self.mActivityData ~= nil) then
        ---@type TABLE.cfg_special_activity
        local specialActivityTable = self.mSpecialActivityTable;
        if (specialActivityTable ~= nil) then
            local list = specialActivityTable:GetAward();
            if (list ~= nil) then
                if (#list.list > 1) then
                    local itemId = list.list[1]
                    local count = list.list[2]

                    --local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(itemId);
                    --if (rewardList ~= nil and rewardList.Count > 0) then
                    --    gridContainer.MaxCount = rewardList.Count;
                    --    for i = 0, gridContainer.controlList.Count - 1 do
                    --        local gobj = gridContainer.controlList[i];
                    --        if (self.mUIItemDic[gobj] == nil) then
                    --            self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                    --        end
                    --
                    --        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardList[i].itemId);
                    --        if (isFind) then
                    --            self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, rewardList[i].count);
                    --
                    --            CS.UIEventListener.Get(gobj).onClick = function()
                    --                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
                    --            end
                    --        end
                    --    end
                    --end
                    gridContainer.MaxCount = 1;
                    local gobj = gridContainer.controlList[0];
                    if (self.mUIItemDic[gobj] == nil) then
                        self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                    end

                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                    if (isFind) then
                        self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, count);

                        CS.UIEventListener.Get(gobj).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
                        end
                    end
                end
            end
        end
    end
end

---@private 初始化事件
function UICombineServerShabakeUnitTemplate:InitEvents()
    --CS.UIEventListener.Get(self:Get)
end

function UICombineServerShabakeUnitTemplate:Init()

end

return UICombineServerShabakeUnitTemplate;