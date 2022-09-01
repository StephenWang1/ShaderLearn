---@class UIBoxRewardViewPanel
local UIBoxRewardViewPanel = {};

---@type table<UnityEngine.GameObject, UIItem>
UIBoxRewardViewPanel.mUIItemDic = nil;

function UIBoxRewardViewPanel:GetBackGround_UISprite()
    if(self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:GetCurComp("WidgetRoot/window/background","UISprite")
    end
    return self.mBackGround_UISprite;
end

function UIBoxRewardViewPanel:GetRewardGridContainer()
    if(self.mRewardGridContainer == nil) then
        self.mRewardGridContainer = self:GetCurComp("WidgetRoot/DropScrollView/DropItem","UIGridContainer");
    end
    return self.mRewardGridContainer;
end

---@public 更新UI
function UIBoxRewardViewPanel:UpdateUI()
    if(self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end
    if(self.mBoxId ~= nil) then
        local gridContainer = self:GetRewardGridContainer();
        local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(self.mBoxId);
        if(rewardList ~= nil and rewardList.Count > 0) then
            gridContainer.MaxCount = rewardList.Count;
            for i = 0, rewardList.Count - 1 do
                local gobj = gridContainer.controlList[i];
                if(self.mUIItemDic[gobj] == nil) then
                    self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardList[i].itemId);
                if(isFind) then
                    self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, rewardList[i].count);

                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
                    end
                end
            end
        end
        local minHeight = 60;
        self:GetBackGround_UISprite().height = minHeight + math.ceil(gridContainer.MaxCount / gridContainer.MaxPerLine) * gridContainer.CellHeight;
    end
end

---@private 初始化事件
function UIBoxRewardViewPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_UISprite().gameObject).onClick = function()
        uimanager:ClosePanel("UIBoxRewardViewPanel");
    end
end

function UIBoxRewardViewPanel:Init()
    self:InitEvents();
end

---@class BoxRewardViewParams
---@field boxId number
---@param customData BoxRewardViewParams
function UIBoxRewardViewPanel:Show(customData)
    self.mBoxId = customData.boxId
    self:UpdateUI();
end

return UIBoxRewardViewPanel;