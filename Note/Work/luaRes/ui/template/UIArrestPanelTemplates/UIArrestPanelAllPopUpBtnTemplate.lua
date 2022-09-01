local UIArrestPanelAllPopUpBtnTemplate = {}

--region 初始化

function UIArrestPanelAllPopUpBtnTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIArrestPanelAllPopUpBtnTemplate:InitParameters()
    self.btnSpaceHeight = 5
    self.type = 1
    self.btnType = 1
    self.data = nil
    self.btnSpaceHeight = self.Grid.CellHeight
    self.msgFunc = function(msgId, data, csData)
        self:OnResOtherRoleInfoMessageReceived(msgId, data, csData)
    end
    local go = self.Grid.controlTemplate
    if go then
        local sprite = CS.Utility_Lua.GetComponent(self.Grid.controlTemplate.transform:Find('chakan/ditiao'), "Top_UISprite")
        self.btnBackGroundHeight = sprite.height
        self.btnSpaceHeight = self.btnSpaceHeight - self.btnBackGroundHeight
    end
    _, self.mSendFlowerTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(16)
end

function UIArrestPanelAllPopUpBtnTemplate:InitComponents()
    ---@type Top_UIGridContainer 按钮合集
    self.Grid = self:Get("Grid", "Top_UIGridContainer")
    ---@type Top_UISprite 背景
    self.bg = self:Get("bg", "Top_UISprite")
end

function UIArrestPanelAllPopUpBtnTemplate:BindUIMessage()
    -- CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    -- CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
end

function UIArrestPanelAllPopUpBtnTemplate:BindNetMessage()

end

--endregion

--region 函数监听

function UIArrestPanelAllPopUpBtnTemplate:OnBtnTypeClick(go)
    if self.btnType == 0 then
        local id = self.data.prisonerID == nil and self.data.rid or self.data.prisonerID
        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(id, LuaEnumOtherPlayerBtnType.ROLE, LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
        self.go:SetActive(false)
        --送花
    elseif self.btnType == 101 then
        self:OnClickFlowers()
        --追踪
    elseif self.btnType == 102 then
        if self.data.prisonerID == nil then
            return
        end
        networkRequest.ReqLastEnemyPosition(self.data.prisonerID)
    end
end

--endregion

--region 消息监听

--endregion

--region UI

function UIArrestPanelAllPopUpBtnTemplate:SetTemplate(info)
    if info then
        self.type = info.panelType
        self.data = info.data
    end
    self:InitGrid()
end

function UIArrestPanelAllPopUpBtnTemplate:InitGrid()
    local btnDic = CS.Cfg_GlobalTableManager.CfgInstance.ArrestTrackDic
    if btnDic.Count == 0 then
        return
    end
    local btnsInfo = btnDic[self.type]
    if btnsInfo == nil or btnsInfo.Length == 0 then
        return
    end
    self.Grid.MaxCount = btnsInfo.Length
    self:BgAdaptiveOfItemCount(btnsInfo.Length)
    for i = 0, btnsInfo.Length - 1 do
        local go = self.Grid.controlList[i].gameObject
        if go then
            local strs = string.Split(btnsInfo[i], '#')
            local label = CS.Utility_Lua.GetComponent(go.transform:Find('chakan'), "Top_UILabel")
            if label then
                label.text = strs[2]
            end
            CS.UIEventListener.Get(go).onClick = nil
            CS.UIEventListener.Get(go).onClick = function(go)
                self.btnType = tonumber(strs[3])
                self:OnBtnTypeClick(go)
            end
        end
    end
end

---背景自适应
function UIArrestPanelAllPopUpBtnTemplate:BgAdaptiveOfItemCount(count)
    local titleSpace = 10
    local totalHeight = titleSpace * 2 + self.btnSpaceHeight * (count - 1) + self.btnBackGroundHeight * count
    self.bg.height = totalHeight
end
--endregion

--region送花
---点击送花
function UIArrestPanelAllPopUpBtnTemplate:OnClickFlowers()
    local mainPlayerInfoSex = CS.CSScene.MainPlayerInfo.Sex
    local hasFlower = self:GetHasFlower(mainPlayerInfoSex == self.data.prisonerSex)
    if hasFlower then
        self:SendFlower(self.data.prisonerSex, self.data.prisonerID, self.data.arrestName)
    else
        self:FlowerNotEnough()
    end
    self.go:SetActive(false)
end

---创建送花界面
function UIArrestPanelAllPopUpBtnTemplate:SendFlower(sex, rid, name)
    local customData = {}
    customData.sex = sex
    customData.rid = rid
    customData.name = name
    uimanager:CreatePanel("UISendFlowerPanel", nil, customData)
end

---花朵不足二次弹窗
function UIArrestPanelAllPopUpBtnTemplate:FlowerNotEnough()
    if self.mSendFlowerTipsInfo then
        local TipsInfo = {
            Title = self.mSendFlowerTipsInfo.title,
            LeftDescription = self.mSendFlowerTipsInfo.leftButton,
            RightDescription = self.mSendFlowerTipsInfo.rightButton,
            Content = self.mSendFlowerTipsInfo.des,
            ID = self.mSendFlowerTipsInfo.id,
            CallBack = function()
                uimanager:CreatePanel("UIShopPanel")
                self.go:SetActive(false)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, TipsInfo)
    else
        --读表失败直接关闭Tips
        self.go:SetActive(false)
    end
end

---获取背包是否有花
function UIArrestPanelAllPopUpBtnTemplate:GetHasFlower(sameSex)
    local hasFlower1 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.FirstGoldOrchid, LuaEnumFlowerType.FirstRose))
    if hasFlower1 then
        return true
    end
    local hasFlower2 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.SecondGoldOrchid, LuaEnumFlowerType.SecondRose))
    if hasFlower2 then
        return true
    end
    local hasFlower3 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.ThirdGoldOrchid, LuaEnumFlowerType.ThirdRose))
    if hasFlower3 then
        return true
    end
    return false
end
--endregion

--region ondestroy
function UIArrestPanelAllPopUpBtnTemplate:onDestroy()

end

--endregion


return UIArrestPanelAllPopUpBtnTemplate