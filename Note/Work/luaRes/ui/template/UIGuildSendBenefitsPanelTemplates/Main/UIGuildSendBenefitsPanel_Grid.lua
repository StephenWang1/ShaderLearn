local UIGuildSendBenefitsPanel_Grid = {}
--region 初始化
function UIGuildSendBenefitsPanel_Grid:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIGuildSendBenefitsPanel_Grid:InitComponent()
    self.background_GameObject = self:Get("background","GameObject")
    self.head_UISprite = self:Get("headicon","UISprite")
    self.name_UILabel = self:Get("name","UILabel")
    self.choose_GameObject = self:Get("tg_choose","GameObject")
    self.choose_UISprite = self:Get("tg_choose/check","GameObject")
    self.level_UILabel = self:Get("headicon/level","UILabel")
    self.btn_delete_GameObject = self:Get("btn_delete","GameObject")
end

function UIGuildSendBenefitsPanel_Grid:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self.playerListType == LuaEnumGuildSendBenefitsListType.ChooseList then
            self:ChooseOnClick()
        end
    end

    CS.UIEventListener.Get(self.btn_delete_GameObject).onClick = function()
        self:ChooseOnClick()
    end
end
--endregion

--region 刷新
function UIGuildSendBenefitsPanel_Grid:RefreshPanel(commonData)
    self:AnalysisData(commonData)
    self:Refresh()
end

---解析数据
function UIGuildSendBenefitsPanel_Grid:AnalysisData(commonData)
    self.grantPlayerInfo = commonData.grantPlayerInfo
    self.isChoose = ternary(self.grantPlayerInfo ~= nil and self.grantPlayerInfo:GetChooseState() ~= nil,self.grantPlayerInfo:GetChooseState(),false)
    self.playerInfo = ternary(self.grantPlayerInfo ~= nil and self.grantPlayerInfo.playerInfo ~= nil,self.grantPlayerInfo.playerInfo,nil)
    self.name = ternary(self.playerInfo ~= nil,self.grantPlayerInfo.playerInfo.name,"")
    self.career = ternary(self.playerInfo ~= nil,self.grantPlayerInfo.playerInfo.career,1)
    self.sex = ternary(self.playerInfo ~= nil,self.grantPlayerInfo.playerInfo.sex,1)
    self.level = ternary(self.playerInfo ~= nil,self.grantPlayerInfo.playerInfo.level,1)
    self.index = ternary(commonData.index ~= nil,commonData.index,0)
    self.headIconName = "headicon" ..tostring(self.sex) .. tostring(self.career)
    self.chooseCallBack = ternary(commonData.chooseCallBack == nil,function() end,commonData.chooseCallBack)
    self.playerListType = commonData.playerListType
end

---刷新面板
function UIGuildSendBenefitsPanel_Grid:Refresh()
    --self.background_GameObject:SetActive(self.index %2 == 0)
    self.head_UISprite.spriteName = self.headIconName
    self.name_UILabel.text = self.name
    self.level_UILabel.text = tostring(self.level)
    if self.playerListType == LuaEnumGuildSendBenefitsListType.ChooseList then
        self:RefreshChooseListGrid()
    elseif self.playerListType == LuaEnumGuildSendBenefitsListType.RemoveList then
        self:RefreshRemoveListGrid()
    end
end

function UIGuildSendBenefitsPanel_Grid:RefreshChooseListGrid()
    self.choose_UISprite.gameObject:SetActive(self.isChoose)
    if self.btn_delete_GameObject ~= nil then
        self.btn_delete_GameObject:SetActive(false)
    end
end

function UIGuildSendBenefitsPanel_Grid:RefreshRemoveListGrid()
    self.choose_UISprite.gameObject:SetActive(false)
    if self.btn_delete_GameObject ~= nil then
        self.btn_delete_GameObject:SetActive(true)
    end
end
--endregion

--region UI事件
function UIGuildSendBenefitsPanel_Grid:ChooseOnClick()
    if self.chooseCallBack ~= nil then
        self:chooseCallBack()
    end
    self:ChangeChoose(not self.isChoose)
end

function UIGuildSendBenefitsPanel_Grid:ChangeChoose(choose)
    self.isChoose = choose
    self.choose_UISprite.gameObject:SetActive(self.isChoose)
    CS.CSScene.MainPlayerInfo.UnionInfoV2:ChangeChoose(self.grantPlayerInfo,self.isChoose)
end
--endregion

return UIGuildSendBenefitsPanel_Grid