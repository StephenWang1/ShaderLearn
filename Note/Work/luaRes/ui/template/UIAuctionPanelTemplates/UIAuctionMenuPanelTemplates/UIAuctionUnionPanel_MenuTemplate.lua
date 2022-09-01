---@class UIAuctionUnionPanel_MenuTemplate:UIAuctionMenuPanelTemplateBase 行会竞拍目录模板
local UIAuctionUnionPanel_MenuTemplate = {}

setmetatable(UIAuctionUnionPanel_MenuTemplate, luaComponentTemplates.UIAuctionMenuPanelTemplateBase)

function UIAuctionUnionPanel_MenuTemplate:GetFirstMenuData()
    if self.mFirstMenuData == nil then
        self.mFirstMenuData = {}
        self.mFirstMenuIdToSecondMenu = {}
        table.insert(self.mFirstMenuData, 0)
        self.mFirstMenuIdToSecondMenu[0] = {}
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22751)
        if res then
            local strs = string.Split(info.value, '#')
            for i = 1, #strs do
                local firstId = tonumber(strs[i])
                table.insert(self.mFirstMenuData, firstId)
            end
        end
    end
    return self.mFirstMenuData
end

---选中目录改变（用于发送请求）
function UIAuctionUnionPanel_MenuTemplate:ChooseMenuChange()
    local data = {}
    data.firstMenuId = self.mCurrentChooseFirstMenuId--一级目录
    data.secondMenuId = self.mCurrentChooseSecondMenuId--二级目录
    if self:GetCurrentThirdMenuTemplate() then
        data.mThirdTemplates = self:GetCurrentThirdMenuTemplate()--包括三级以上目录选中
    end
    luaEventManager.DoCallback(LuaCEvent.mAuctionUnionMenuChange, data)
end

---是否显示三级目录
function UIAuctionUnionPanel_MenuTemplate:NeedShowThirdMenu()
    return false
end

---如果狗策划要加二级目录，就把这里打开
--[[function UIAuctionUnionPanel_MenuTemplate:RefreshSecondMenu(secondMenuId)
    self.mSecondMenuToGo = {}
    if secondMenuId and self.mFirstMenuIdToSecondMenu then
        local secondMenuInfo = self.mFirstMenuIdToSecondMenu[secondMenuId]
        if secondMenuInfo then
            self:GetSecondMenu_UIGridContainer().MaxCount = #secondMenuInfo
            for i = 0, self:GetSecondMenu_UIGridContainer().controlList.Count - 1 do
                if i + 1 <= #secondMenuInfo then
                    local goS = self:GetSecondMenu_UIGridContainer().controlList[i]
                    local secondMenuId = secondMenuInfo[i + 1]
                    ---@type UILabel
                    local lb1 = CS.Utility_Lua.Get(goS.transform, "checkMark/Label", "UILabel")
                    ---@type UILabel
                    local lb2 = CS.Utility_Lua.Get(goS.transform, "checkMarkBg/Label", "UILabel")
                    local btn = CS.Utility_Lua.Get(goS.transform, "checkMarkBg", "GameObject")
                    local showLb = ""
                    local tblInfo = self:CacheTradeTypeTableInfo(secondMenuId)
                    if tblInfo then
                        showLb = tblInfo.name
                    end
                    if not CS.StaticUtility.IsNull(lb1) and not CS.StaticUtility.IsNull(lb2) then
                        lb1.text = showLb
                        lb2.text = luaEnumColorType.Gray .. showLb
                    end
                    self.mSecondMenuToGo[secondMenuId] = goS
                    self:ManageSecondMenuChoose(goS, false)
                    CS.UIEventListener.Get(btn).onClick = function()
                        self:ClickSecondMenu(secondMenuId)
                    end
                end
            end
        else
            self:GetSecondMenu_UIGridContainer().MaxCount = 0
        end
    else
        self:GetSecondMenu_UIGridContainer().MaxCount = 0
    end
end


--region 界面适配
---刷新目录位置
function UIAuctionUnionPanel_MenuTemplate:SuitMenu()
    self:GetScrollView():ResetPosition()
    if self.mCurrentChooseFirstMenuId then
        local firstMenu = self:GetFirstMenuData()
        local currentHeight = 0
        local hasAddSecond = false
        local totalHeight = 0--到选中目录高度，并不是总高度
        for i = 0, self:GetFirstMenu_UIGridContainer().controlList.Count - 1 do
            ---@type UnityEngine.GameObject
            local go = self:GetFirstMenu_UIGridContainer().controlList[i]
            if not CS.StaticUtility.IsNull(go) then
                local firstId = firstMenu[i + 1]
                local pos = go.transform.localPosition
                pos.y = currentHeight
                --设置一级目录位置
                go.transform.localPosition = pos
                --加一级目录高度
                currentHeight = currentHeight - self:GetFirstMenuHeight()
                if not hasAddSecond then
                    totalHeight = totalHeight + self:GetFirstMenuHeight()
                end

                if firstId == self.mCurrentChooseFirstMenuId and self.mHasChooseSecond then
                    local secondPos = self:GetSecondMenu_UIGridContainer().gameObject.transform.localPosition
                    secondPos.y = currentHeight + (self:GetFirstMenuHeight() - self:GetSecondMenuHeight()) / 2
                    --设置二级目录位置
                    self:GetSecondMenu_UIGridContainer().gameObject.transform.localPosition = secondPos
                    --加二级目录高度
                    local secondInfo = self.mFirstMenuIdToSecondMenu[firstId]
                    if secondInfo then
                        currentHeight = currentHeight - #secondInfo * self:GetSecondMenuHeight()
                        hasAddSecond = true
                        totalHeight = totalHeight + #secondInfo * self:GetSecondMenuHeight()
                    end
                end
            end
        end
        if self:GetScrollPanel() and self:GetScrollView() then
            local scrollHeight = self:GetScrollPanel().baseClipRegion.w
            local pos = self:GetScrollView().transform.localPosition
            if scrollHeight < totalHeight then
                pos.y = totalHeight - scrollHeight
                self:GetScrollView():Begin(pos, 10)
            end
        end
    end
end
--endregion

--]]

return UIAuctionUnionPanel_MenuTemplate