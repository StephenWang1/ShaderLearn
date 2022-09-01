local UIGuildSendBenefitsPanel_Base = {}


--region 枚举
ChoosePlayerListType = {
    ---全部
    All = 1,
    ---已选
    Choose = 2,
}

UIGuildSendBenefitsPanel_Base.SingleLineNum = 2
--endregion

--region 组件
---玩家列表scrollView组件
function UIGuildSendBenefitsPanel_Base:GetPlayerList_ScrollView()
    if self.playerList_UIScrollView == nil then
        self.playerList_UIScrollView = self:Get("Scroll View","UIScrollView")
    end
    return self.playerList_UIScrollView
end

---玩家列表组件
function UIGuildSendBenefitsPanel_Base:GetPlayerList_UILoopScrollView()
    if self.playerList_LoopScrollView == nil then
        --self.playerList_LoopScrollView = self:Get("Scroll View/player","LoopScrollView")
        self.playerList_LoopScrollView = self:Get("Scroll View/player","UILoopScrollViewPlus")
    end
    return self.playerList_LoopScrollView
end

---获取全部按钮
function UIGuildSendBenefitsPanel_Base:GetAllBtn()
    if self.allBtn_GameObject == nil then
        self.allBtn_GameObject = self:Get("btn_switch/Btn_mode1","GameObject")
    end
    return self.allBtn_GameObject
end

---获取已选按钮
function UIGuildSendBenefitsPanel_Base:GetChooseBtn()
    if self.chooseBtn_GameObject == nil then
        self.chooseBtn_GameObject = self:Get("btn_switch/Btn_mode2","GameObject")
    end
    return self.chooseBtn_GameObject
end
--endregion

--region 初始化
function UIGuildSendBenefitsPanel_Base:Init()
    self:RefreshActive(self.go,true)
    if self:GetAllBtn() ~= nil then
        CS.UIEventListener.Get(self:GetAllBtn()).onClick = function()
            self:AllBtnOnClick()
        end
    end
    if self:GetChooseBtn() ~= nil then
        CS.UIEventListener.Get(self:GetChooseBtn()).onClick = function()
            self:ChooseBtnOnClick()
        end
    end
end
--endregion

--region 刷新
function UIGuildSendBenefitsPanel_Base:RefreshPanel(commonData)
    self:AnalysisData(commonData)
    self:AllBtnOnClick()
end

function UIGuildSendBenefitsPanel_Base:AnalysisData(commonData)
    if commonData == nil then
        return
    end
    self.bagItemInfo = commonData.bagItemInfo
    self.itemInfo = commonData.itemInfo
    self.searchText = ""
end
--endregion

--region UI刷新
---控制显示
function UIGuildSendBenefitsPanel_Base:RefreshActive(obj,state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function UIGuildSendBenefitsPanel_Base:RefreshSprite(obj,spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj,"","UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---设置Label
function UIGuildSendBenefitsPanel_Base:RefreshLabel(obj,text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj,"","UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---刷新玩家列表
function UIGuildSendBenefitsPanel_Base:RefreshPlayerList()
    if self:GetPlayerList_ScrollView() == nil or self:GetPlayerList_UILoopScrollView() == nil then
        return
    end
    if self.showListType == nil then
        uimanager:ClosePanel("UIGuildSendBenefitsPanel")
        return
    end

    self:GetPlayerList_UILoopScrollView():Init(function (go, line)
        local minIndex = line * self.SingleLineNum
        local maxIndex = ((line + 1) * self.SingleLineNum) - 1
        local haveData = minIndex < self.showList.Count
        local maxCount = 0
        if haveData == true then
            for k = maxIndex,minIndex, -1 do
                if k < self.showList.Count then
                    maxIndex = k
                    maxCount = maxIndex + 1 - minIndex
                    break
                end
            end
            local player_Grid = self:GetCurComp(go,"","UIGridContainer")
            if CS.StaticUtility.IsNull(player_Grid) == false then
                player_Grid.MaxCount = maxCount
                for k = 0,player_Grid.MaxCount - 1 do
                    local index = minIndex + k
                    local data = self.showList[index]
                    local grid = player_Grid.controlList[k]
                    local playerListType = self.showListType
                    local gridTemplate = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIGuildSendBenefitsPanel_Grid)

                    gridTemplate:RefreshPanel(
                            {
                                grantPlayerInfo = data,index = index,playerListType = playerListType,chooseCallBack = function(grid)
                                self:GridOnClick(grid)
                            end}
                    )
                end
            end
            return true
        else
            return false
        end
    end)
end

--endregion

--region UI事件
function UIGuildSendBenefitsPanel_Base:GridOnClick(grid)

end

---发布按钮点击
function UIGuildSendBenefitsPanel_Base:GrantBtnOnClick(go)
    self.choosePlayerList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetAllChoosePlayerLidList()
    self.choosePlayerInfoList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetAllChoosePlayer()
end
--endregion

--region 刷新列表类型
---全部按钮点击事件（显示全部角色列表）
function UIGuildSendBenefitsPanel_Base:AllBtnOnClick()
    self.playerListType = ChoosePlayerListType.All
    self.showPlayerList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetAllGrantPlayerInfo()
    self.showList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetSearchGrantPlayerInfoList(self.showPlayerList,self.searchText)
    self.showListType = LuaEnumGuildSendBenefitsListType.ChooseList
    --self:GetPlayerList_UILoopScrollView():ResetToBegining()
    self:RefreshPlayerList()
end

---选择按钮点击事件（显示已选角色列表）
function UIGuildSendBenefitsPanel_Base:ChooseBtnOnClick()
    self.playerListType = ChoosePlayerListType.Choose
    self.showPlayerList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetAllChoosePlayer()
    self.showList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetSearchGrantPlayerInfoList(self.showPlayerList,self.searchText)
    self.showListType = LuaEnumGuildSendBenefitsListType.RemoveList
    --self:GetPlayerList_UILoopScrollView():ResetToBegining()
    self:RefreshPlayerList()
end

---刷新当前页
function UIGuildSendBenefitsPanel_Base:RefreshNowList()
    self.showPlayerList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetAllChoosePlayer()
    self.showList = CS.CSScene.MainPlayerInfo.UnionInfoV2:GetSearchGrantPlayerInfoList(self.showPlayerList,self.searchText)
    self:GetPlayerList_UILoopScrollView():RefreshCurrentPage()
end

---显示搜索角色列表
function UIGuildSendBenefitsPanel_Base:RefreshSearchList(searchText)
    self.searchText = searchText
    if self.playerListType == ChoosePlayerListType.All then
        self:AllBtnOnClick()
    elseif self.playerListType == ChoosePlayerListType.Choose then
        self:ChooseBtnOnClick()
    end
end
--endregion
return UIGuildSendBenefitsPanel_Base