---@class UICityWarRankRewardTemplate:TemplateBase
local UICityWarRankRewardTemplate = {};

---@type UICityWarRankRewardPanel
UICityWarRankRewardTemplate.mOwnerPanel = nil;

---@type table<CS.UnityEngine.GameObject, UIItem>
UICityWarRankRewardTemplate.mUIItemUnitDic = nil;

UICityWarRankRewardTemplate.mRankType = nil;

--function UICityWarRankRewardTemplate:GetState_GameObject()
--    if(self.mState_GameObject == nil) then
--        self.mState_GameObject = self:Get("geted","GameObject");
--    end
--    return self.mState_GameObject;
--end

function UICityWarRankRewardTemplate:GetRankSprite_UISprite()
    if(self.mRankSprite_UISprite == nil) then
        self.mRankSprite_UISprite = self:Get("Total/rankingSprite","UISprite");
    end
    return self.mRankSprite_UISprite;
end

function UICityWarRankRewardTemplate:GetRankValue_UIText()
    if(self.mRankValue_UIText == nil) then
        self.mRankValue_UIText = self:Get("Total/rankingValue","UILabel");
    end
    return self.mRankValue_UIText;
end

function UICityWarRankRewardTemplate:GetUIItemGridContainer()
    if(self.mUIItemGridContainer == nil) then
        self.mUIItemGridContainer = self:Get("quiteDropGrid","UIGridContainer");
    end
    return self.mUIItemGridContainer;
end

---@public 根据积分排行显示奖励
---@param tbl TABLE.cfg_sbk_rank_reward
function UICityWarRankRewardTemplate:UpdateUIToScoreRankReward(tbl)
    if(tbl == nil) then
        return;
    end
    self.mRankType = LuaEnumCityWarRankRewardType.ScoreRankReward
    local ranks = tbl:GetRank();
    if(ranks ~= nil) then
        local length = #ranks.list;
        if(length > 1) then
            local min = ranks.list[1];
            local max = ranks.list[2];
            self:GetRankSprite_UISprite().gameObject:SetActive(false);
            self:GetRankValue_UIText().gameObject:SetActive(true);
            self:GetRankValue_UIText().text = "第"..min.."-"..max.."名";
        elseif(length == 1) then
            local rank = ranks.list[1];
            if(rank <= 3) then
                self:GetRankSprite_UISprite().gameObject:SetActive(true);
                self:GetRankValue_UIText().gameObject:SetActive(false);
                self:GetRankSprite_UISprite().spriteName = rank;
            else
                self:GetRankSprite_UISprite().gameObject:SetActive(false);
                self:GetRankValue_UIText().gameObject:SetActive(true);
                self:GetRankValue_UIText().text = "第"..rank.."名";
            end
        end
    end
    local rewards = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetScoreRewardItems(tbl);
    self:UpdateReward(rewards);
end

---@public 根据个人积分显示奖励
---@param tbl TABLE.cfg_sbk_reward_point
function UICityWarRankRewardTemplate:UpdateUIToPersonalReward(tbl)
    if(tbl == nil) then
        return;
    end
    self.mRankType = LuaEnumCityWarRankRewardType.PersonalReward
    local point = tbl:GetPoint();
    if(point ~= nil) then
        self:GetRankSprite_UISprite().gameObject:SetActive(false);
        self:GetRankValue_UIText().gameObject:SetActive(true);
        self:GetRankValue_UIText().text = point;
    end

    local rewards = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetPersonalRewardItems(tbl);
    self:UpdateReward(rewards, point);
end

---@public 更新奖励UI
---@param rewards table<number, table<number,number>>
function UICityWarRankRewardTemplate:UpdateReward(rewards, point)
    if(self.mUIItemUnitDic == nil) then
        self.mUIItemUnitDic = {};
    end


    local gridContainer = self:GetUIItemGridContainer();
    if(rewards ~= nil) then
        gridContainer.MaxCount = #rewards;
        for k,v in pairs(rewards) do
            local index = k - 1;
            local gobj = gridContainer.controlList[index];
            if(self.mUIItemUnitDic[gobj] == nil) then
                self.mUIItemUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
            end
            if(v ~= nil and #v > 1) then
                local geted = CS.Utility_Lua.GetComponent(gobj.transform:Find("geted"), "GameObject")
                if(self.mRankType == LuaEnumCityWarRankRewardType.PersonalReward) then
                    geted:SetActive(gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetShaBaKScore() >= point);
                else
                    geted:SetActive(false);
                end

                local itemId = v[1];
                local num = v[2];
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                if(isFind) then
                    self.mUIItemUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, num);
                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, nil, showRight = false })
                    end
                end
            end
        end
    end
end


function UICityWarRankRewardTemplate:Init(panel)
    self.mOwnerPanel = panel;
end

return UICityWarRankRewardTemplate;