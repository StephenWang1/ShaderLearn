---@class UIBossPanel_NormalViewTemplate:UIBossPanel_BaseViewTemplate 游荡boss视图
local UIBossPanel_NormalViewTemplate = {}

setmetatable(UIBossPanel_NormalViewTemplate, luaComponentTemplates.UIBossPanel_BaseViewTemplate)

--region override
function UIBossPanel_NormalViewTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type Top_UILabel
    self.title = self:Get("Title", 'Top_UILabel')
    ---@type Top_UIScrollView 掉落展示
    self.dropItemScrollView = self:Get("dropScroll", "Top_UIScrollView")
    ---@type Top_UIGridContainer 掉落展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "Top_UIGridContainer")
end

function UIBossPanel_NormalViewTemplate:InitTemplate(customData)
    self:RunBaseFunction('InitTemplate', customData)
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_WildBossTemplates
end

function UIBossPanel_NormalViewTemplate:RefreshOtherView(pageInfo)
    self:RunBaseFunction("RefreshOtherView", pageInfo)
    if pageInfo == nil then
        return
    end
    self:RefreshTitle(pageInfo.detailDes)
    self:RefreshDropList(pageInfo.type, pageInfo.speDrop)
end

---是否显示左侧页签
---@protected
function UIBossPanel_NormalViewTemplate:IsShowLeftPageView()
    return true
end

--endregion

---刷新标题
function UIBossPanel_NormalViewTemplate:RefreshTitle(showStr)
    if not CS.StaticUtility.IsNull(self.title) then
        self.title.text = showStr
    end
end

---刷新掉落列表
function UIBossPanel_NormalViewTemplate:RefreshDropList(type, speDrop)
    local list = self.curAllBossDic[type]
    if list == nil then
        self.dropItemGrid.MaxCount = 0
        return
    end
    local dropList = nil
    if (speDrop ~= nil) then
        dropList = speDrop
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
            if (self.dropItemScrollView ~= nil) then
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
                        if temp then
                            temp:RefreshUIWithItemInfo(iteminfo, 1)
                            CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                                if temp.ItemInfo ~= nil then
                                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                                end
                            end
                        end
                    end
                end
                if (self.dropItemScrollView ~= nil) then
                    self.dropItemScrollView:ResetPosition();
                end
                return
            end
        end
    end
end

return UIBossPanel_NormalViewTemplate
