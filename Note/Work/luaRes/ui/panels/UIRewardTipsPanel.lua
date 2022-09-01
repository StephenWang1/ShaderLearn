---@class UIRewardTipsPanel:UIBase
local UIRewardTipsPanel = {}

UIRewardTipsPanel.mItemToGoTempDic = nil;
UIRewardTipsPanel.panelType = LuaEnumRewardTipsType.Normal
--region 组件

---@return UIGridContainer 奖励列表
function UIRewardTipsPanel:GetRewardList_UIGridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:GetCurComp("WidgetRoot/view/Scroll/rewardList", "UIGridContainer")
    end
    return self.mGridContainer
end

---@return number 返回每行个数
function UIRewardTipsPanel:GetLineNum()
    if self.mLineNum == nil and self:GetRewardList_UIGridContainer() then
        self.mLineNum = self:GetRewardList_UIGridContainer().MaxPerLine
    end
    return self.mLineNum
end

---@return number 高度间隔
function UIRewardTipsPanel:GetCellHeight()
    if self.mCellHeight == nil and self:GetRewardList_UIGridContainer() then
        self.mCellHeight = self:GetRewardList_UIGridContainer().CellHeight
    end
    return self.mCellHeight
end

---@return UITexture 背景图片
function UIRewardTipsPanel:GetBg_UISprite()
    if self.mBGSp == nil then
        self.mBGSp = self:GetCurComp("WidgetRoot/window/bg", "UITexture")
    end
    return self.mBGSp
end

---@return CSUIEffectLoad 背景图片加载器
function UIRewardTipsPanel:GetBg_EffectLoad()
    if self.mBGEffectLoad == nil then
        self.mBGEffectLoad = self:GetCurComp("WidgetRoot/window/bg", "CSUIEffectLoad")
    end
    return self.mBGEffectLoad
end

---@return UnityEngine.GameObject 确认按钮
function UIRewardTipsPanel:GetSureBtn_GameObject()
    if self.mSureBtn == nil then
        self.mSureBtn = self:GetCurComp("WidgetRoot/event/btn_center", "GameObject")
    end
    return self.mSureBtn
end

---@return Top_UILabel 确认按钮的文本
function UIRewardTipsPanel:GetSureBtn_Label()
    if self.mGetSureBtn_Label == nil then
        self.mGetSureBtn_Label = self:GetCurComp("WidgetRoot/event/btn_center/Label", "Top_UILabel")
    end
    return self.mGetSureBtn_Label
end

---@return UnityEngine.GameObject 标题
function UIRewardTipsPanel:GetTitle_GameObject()
    if self.mTitleGo == nil then
        self.mTitleGo = self:GetCurComp("WidgetRoot/window/title", "GameObject")
    end
    return self.mTitleGo
end

---@return UnityEngine.GameObject 显示文字
function UIRewardTipsPanel:GetShowLabel_GameObject()
    if self.mShowLabel == nil then
        self.mShowLabel = self:GetCurComp("WidgetRoot/window/Label", "GameObject")
    end
    return self.mShowLabel
end

---@return UnityEngine.GameObject 显示提示文字
function UIRewardTipsPanel:GetViewLabel_GameObject()
    if self.mViewLabel == nil then
        self.mViewLabel = self:GetCurComp("WidgetRoot/view/Label", "UILabel")
    end
    return self.mViewLabel
end

function UIRewardTipsPanel:GetTitle_UISprite()
    if self.mTitle_UISprite == nil then
        self.mTitle_UISprite = self:GetCurComp("WidgetRoot/window/title", "UISprite")
    end
    return self.mTitle_UISprite
end

--endregion
---是否在界面关闭的时候,播放道具进入背包动画
UIRewardTipsPanel.IsPlayToBagEffect = true

function UIRewardTipsPanel:Init()
    self:BindEvents()
    self:AddCollider()
end

---@param rewardItemIdList activityV2.TheActivityHasRewarded 奖励列表table类型
---@alias otherData{tips:string, type:LuaEnumRewardTipsType}
function UIRewardTipsPanel:Show(rewardItemIdList, otherData)
    if otherData == nil and rewardItemIdList ~= nil then
        otherData = {}
        otherData.type = rewardItemIdList.fromModule
    end
    self:RefreshOtherInfo(otherData)

    local isSuit = otherData.type ~= LuaEnumRewardTipsType.HangHuiShouLing

    if rewardItemIdList then
        self:RefreshRewardList(rewardItemIdList.rewards, isSuit)
    end
end

function UIRewardTipsPanel:BindEvents()
    CS.UIEventListener.Get(self:GetSureBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
end

--regionUI事件
---@param rewardItemIdList activityV2.TheActivityHasRewarded 奖励列表table类型
function UIRewardTipsPanel:RefreshRewardList(data, isSuit)
    local rewardItemIdList = self:PastData(data)
    if not CS.StaticUtility.IsNull(self:GetRewardList_UIGridContainer()) and rewardItemIdList then
        self:GetRewardList_UIGridContainer().MaxCount = #rewardItemIdList
        for i = 0, self:GetRewardList_UIGridContainer().controlList.Count - 1 do
            local go = self:GetRewardList_UIGridContainer().controlList[i]
            self:RefreshSingleGrid(go, rewardItemIdList[i + 1])
        end
        if(isSuit == true) then
            self:SuitPanel(math.ceil(#rewardItemIdList / self:GetLineNum()))
        end
    end
end

---刷新单个格子(仅显示图片)
---@param go UnityEngine.GameObject 单个格子
---@param item activityV2.ActivityRewards itemId
function UIRewardTipsPanel:RefreshSingleGrid(go, item)
    if item then
        local itemId = item.itemId
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(item.itemId)
        if res then
            if itemInfo.autouse and itemInfo.autouse == 1 then
                local boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(item.itemId)
                if boxInfo then
                    itemId = boxInfo.itemId
                    ---替换宝箱
                    local res, boxItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(boxInfo.itemId)
                    if res then
                        self:ShowItemInfo(boxItemInfo, boxInfo.count, go)
                    end
                else
                    ---普通道具
                    local num = item.count
                    self:ShowItemInfo(itemInfo, num, go)
                end
            else
                ---普通道具
                local num = item.count
                self:ShowItemInfo(itemInfo, num, go)
            end
        end
        if (UIRewardTipsPanel.mItemToGoTempDic == nil) then
            UIRewardTipsPanel.mItemToGoTempDic = {};
        end
        UIRewardTipsPanel.mItemToGoTempDic[go] = itemId;
    end
end

---刷新单个格子显示
---@param info TABLE.CFG_ITEMS 道具信息
---@param num number 数目
---@param go UnityEngine.GameObject 格子
function UIRewardTipsPanel:ShowItemInfo(info, num, go)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    if not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = info.icon
    end

    ---@type UILabel
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    if not CS.StaticUtility.IsNull(count) then
        local showNum = ternary(num <= 1, "", num)
        count.text = showNum
    end

    CS.UIEventListener.Get(icon.gameObject).onClick = function()
        UIRewardTipsPanel.WaitClosePanel()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
    end
end

---界面适配
---@param line number 当前行数
function UIRewardTipsPanel:SuitPanel(line)
    if self:GetCellHeight() and self:GetLineNum() then
        if line <= 3 then
            --标题
            local titlePos = self:GetTitle_GameObject().transform.localPosition
            local starTitlePosY = titlePos.y
            local offset = 0
            if (line == 1) then
                offset = 10
            end
            local titleHeight = starTitlePosY - (4 - line) * self:GetCellHeight() / 2 + offset
            titlePos.y = titleHeight
            self:GetTitle_GameObject().transform.localPosition = titlePos

            local lbPos = titlePos
            lbPos.y = titlePos.y - self:GetTitle_UISprite().height / 2

            --背景()
            self:GetBg_UISprite().height = self:GetBgSize(line)
            --按钮
            local btnPos = self:GetShowLabel_GameObject().transform.localPosition
            local btnPosY = btnPos.y
            local btnHeight = btnPosY + (4 - line) * self:GetCellHeight() / 2
            btnPos.y = btnHeight
            self:GetShowLabel_GameObject().transform.localPosition = btnPos
            if self:GetViewLabel_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetViewLabel_GameObject()) then
                self:GetViewLabel_GameObject().transform.localPosition = lbPos
            end
        end
    end
end


function UIRewardTipsPanel:RefreshOtherInfo(otherData)
    if self:GetViewLabel_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetViewLabel_GameObject()) then
        self:GetViewLabel_GameObject().text = otherData ~= nil and otherData.tips ~= nil and otherData.tips or ""
    end
    if (otherData ~= nil) then
        if otherData.type ~= nil then
            UIRewardTipsPanel.panelType = otherData.type

            ---熔炼特殊处理
            if otherData.type == LuaEnumRewardTipsType.SmeltReWard then
                if(self:ProcessSmeltReWard()) then
                    return;
                end
            elseif(otherData.type == LuaEnumRewardTipsType.HangHuiShouLing) then
                self:ProcessHangHuiShouLing()
            end

            ---根据类型设置Title
            local sp = self:GetOtherTitleSprite(otherData.type)
            if sp then
                self:GetTitle_UISprite().spriteName = sp
                self:GetTitle_UISprite():MakePixelPerfect()
            end
            ---根据类型设置BG
            local bgTexture = self:GetOtherBGSprite(otherData.type)
            if bgTexture then
                self:GetBg_EffectLoad():ChangeEffect(bgTexture)
            end
        end
    end
end

--region 特殊来源的处理
---来源为熔炉
function UIRewardTipsPanel:ProcessSmeltReWard()
    local viewInfo = LuaGlobalTableDeal.GetSmeltRewardTipsViewInfo()
    if viewInfo ~= nil and #viewInfo > 1 then
        self:GetTitle_UISprite().spriteName = viewInfo[2]
        self:GetTitle_UISprite():MakePixelPerfect()
        self:GetBg_EffectLoad():ChangeEffect(viewInfo[1])
        return true
    end
    return false
end

---来源为行会首领
function UIRewardTipsPanel:ProcessHangHuiShouLing()
    self.IsPlayToBagEffect = false
    self:GetSureBtn_Label().text = "进入拍卖行"
    self:GetSureBtn_GameObject().gameObject:SetActive(true);
    self:GetViewLabel_GameObject().text = "参与击杀的成员可平分拍卖行所得"
    CS.UIEventListener.Get(self:GetSureBtn_GameObject()).onClick = function()
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Union, nil, nil)
        self:ClosePanel()
    end
end
--endregion


---获取图片
function UIRewardTipsPanel:GetOtherTitleSprite(group)
    if self.mOtherTitleSp == nil then
        self.mOtherTitleSp = {}
        local res, globleInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22477)
        if res then
            local strs = string.Split(globleInfo.value, '#')
            local groups = #strs / 2
            for i = 0, groups - 1 do
                if 2 * i + 2 <= #strs then
                    local spGroup = tonumber(strs[2 * i + 1])
                    local spName = strs[2 * i + 2]
                    self.mOtherTitleSp[spGroup] = spName
                end
            end
        end
    end
    return self.mOtherTitleSp[group]
end

---获取bg资源名
function UIRewardTipsPanel:GetOtherBGSprite(type)
    return LuaGlobalTableDeal.GetRewardBgTextureDic()[type]
end

--endregion


--region otherFunc

function UIRewardTipsPanel:PastData(rewardItemIdList)
    if rewardItemIdList == nil then
        return
    end
    local tbl = {}
    if rewardItemIdList.Count == nil then
        for k, v in pairs(rewardItemIdList) do
            if v.count ~= nil and v.count ~= 0 then
                self:InsertAutoUseBoxItem(tbl, v)
            end
            --luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = v, from = k.transform.position, to = toPosition });
        end
        --tbl = rewardItemIdList
    else
        for i = 0, rewardItemIdList.Count - 1 do
            if rewardItemIdList[i].count ~= nil and rewardItemIdList[i].count ~= 0 then
                self:InsertAutoUseBoxItem(tbl, rewardItemIdList[i])
            end
            --table.insert(tbl, rewardItemIdList[i])
        end
    end

    table.sort(tbl, self.Sort)
    return tbl
end

---插入自动使用宝箱的里面的内容道具
function UIRewardTipsPanel:InsertAutoUseBoxItem(tbl, item)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(item.itemId)
    if res then
        if itemInfo.autouse and itemInfo.autouse == 1 then
            local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(item.itemId);
            if rewardList then
                for i = 0, rewardList.Count - 1 do
                    table.insert(tbl, rewardList[i])
                end
            end
        else
            table.insert(tbl, item)
        end
    end
end

function UIRewardTipsPanel.Sort(a, b)
    if a == nil or b == nil then
        return false
    end

    local aCount = 0
    local bCount = 0
    local boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(a.itemId)
    if boxInfo then
        aCount = boxInfo.count
    else
        ---普通道具
        aCount = a.count
    end
    boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(b.itemId)
    if boxInfo then
        bCount = boxInfo.count
    else
        ---普通道具
        bCount = b.count
    end
    local isAFind, aItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(a.itemId)
    local isBFind, bItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(b.itemId)
    if isAFind and isBFind then
        if aItemInfo.type ~= bItemInfo.type then
            return aItemInfo.type < bItemInfo.type
        elseif aItemInfo.subType ~= bItemInfo.subType then
            return aItemInfo.subType < bItemInfo.subType
        end
    end
    return aCount < bCount
end

function UIRewardTipsPanel.WaitClosePanel()
    local time = CS.Cfg_GlobalTableManager.Instance.closeRewardPanelWaitTime
    if UIRewardTipsPanel.mClosePanelUpdateItem ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIRewardTipsPanel.mClosePanelUpdateItem)
    end
    UIRewardTipsPanel.mClosePanelUpdateItem = CS.CSListUpdateMgr.Add(time, nil, function()
        uimanager:ClosePanel('UIRewardTipsPanel')
    end, false)
end

function UIRewardTipsPanel:GetBgSize(line)
    --local size
    --if UIRewardTipsPanel.panelType ~= LuaEnumRewardTipsType.SmeltReWard then
    --else
    --    size = 238
    --end
    local size = self:GetBg_UISprite().height
    size = size - (4 - line) * self:GetCellHeight()
    return size
end

function ondestroy()
    if UIRewardTipsPanel.mClosePanelUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIRewardTipsPanel.mClosePanelUpdateItem)
        UIRewardTipsPanel.mClosePanelUpdateItem:Reset()
        UIRewardTipsPanel.mClosePanelUpdateItem = nil
    end

    if(self.IsPlayToBagEffect) then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel");
        if (mainChatPanel ~= nil) then
            local toPosition = mainChatPanel.btn_bag.transform.position;
            if (UIRewardTipsPanel.mItemToGoTempDic ~= nil) then
                for k, v in pairs(UIRewardTipsPanel.mItemToGoTempDic) do
                    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = v, from = k.transform.position, to = toPosition });
                end
            end
        end
    end
end


--endregion

return UIRewardTipsPanel