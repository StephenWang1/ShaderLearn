local UIMissionRewardTemplates = {}

function UIMissionRewardTemplates:InitComponents()
    self.rewardList = CS.Utility_Lua.GetComponent(self.go, "UIGridContainer")
end
function UIMissionRewardTemplates:InitOther()

end

function UIMissionRewardTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

function UIMissionRewardTemplates:InitData(Tab_Task,isGrey)
    self.isGrey=isGrey
    self:ShowReward(Tab_Task)
end

---显示任务奖励
function UIMissionRewardTemplates:ShowReward(Tab_Task)

    if Tab_Task == nil then
        return
    end
    local rewards = Tab_Task.rewards
    local strs = string.Split(rewards, "&")

    self.uiItemTable = {}
    local showItemInfo = self:GetAwardItemList(strs)
    self.rewardList.MaxCount = #showItemInfo
    for i = 0, self.rewardList.MaxCount - 1 do
        if self.uiItemTable[i + 1] == nil then
            self.uiItemTable[i + 1] = templatemanager.GetNewTemplate(self.rewardList.controlList[i], luaComponentTemplates.UIItem)
        end
        local itemInfoTable = showItemInfo[i + 1]
        if itemInfoTable ~= nil then
            self.uiItemTable[i + 1]:GetItemIcon_UISprite().color=CS.UnityEngine.Color.white
            if self.isGrey==true then
                self.uiItemTable[i + 1]:GetItemIcon_UISprite().color=CS.UnityEngine.Color.black
            end
            self.uiItemTable[i + 1]:RefreshUIWithItemInfo(itemInfoTable.ItemInfo, itemInfoTable.showNum)
            self.uiItemTable[i + 1]:GetEventListener().onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfoTable.ItemInfo, showRight = false })
            end
        end
    end
end

---得到道具奖励列表
function UIMissionRewardTemplates:GetAwardItemList(awardTable)
    local showItemTable = {}
    for k, v in pairs(awardTable) do
        local itemIdAndCount = string.Split(v, '#')
        if #itemIdAndCount < 2 then
            return showItemTable
        end
        local itemId = itemIdAndCount[1]
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
        if itemInfoIsFind then
            ---不可叠加则显示背包内物品的使用次数
            if itemInfo.overlying == 1 then
                local useNum = ternary(itemInfo.reuseAmount == 0, 1, itemInfo.reuseAmount)
                for i = 1, tonumber(itemIdAndCount[2]) do
                    local ItemInfoTable = {
                        ItemInfo = itemInfo,
                        showNum = useNum
                    }
                    table.insert(showItemTable, ItemInfoTable)
                end
            else
                local ItemInfoTable = {
                    ItemInfo = itemInfo,
                    showNum = tonumber(itemIdAndCount[2])
                }
                table.insert(showItemTable, ItemInfoTable)
            end
        end
    end
    return showItemTable
end

---道具飞入
function UIMissionRewardTemplates:ItemFly()
    if self.uiItemTable==nil then
        return 
    end
    for i = 1, #self.uiItemTable do
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.uiItemTable[i].ItemInfo.id, from = self.uiItemTable[i].go.transform.position}) 
    end
end

return UIMissionRewardTemplates