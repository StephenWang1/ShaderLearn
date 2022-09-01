---寻宝模板
local UITreasurePanel_SeekTreasure = {}

--region 初始化数据
function UITreasurePanel_SeekTreasure:InitComponents()
    ---@type UnityEngine.GameObject 卡牌列表GameObject
    self.ScrollView = self:Get("FlipArea/Scroll View", "Top_UIPanel")
    ---@type UnityEngine.GameObject 洗牌动画GameObject
    self.Shuffle = self:Get("FlipArea/shuffle", "Top_UIPanel")
    ---@type Top_UIGridContainer 卡牌列表
    self.Grid = self:Get("FlipArea/Scroll View/Grid", "Top_UIGridContainer")
    ---@type Top_UIGridContainer 洗牌动画列表
    self.shuffleGrid = self:Get("FlipArea/shuffle/Grid", "Top_UIGridContainer")
    ---@type Top_UIGridContainer 卡牌列表Box
    self.boxArea = self:Get("FlipArea/boxArea", "GameObject")
    ---@type Top_UIGridContainer 卡牌列表滑块
    self.slidingBlock = self:Get("FlipArea/slidingBlock", "GameObject")
    ---@type Top_UILabel 剩余时间
    self.Time = self:Get("Time", "UICountdownLabel")
    ---@type Top_UIToggle 跳过动画单选框
    self.OverVideo = self:Get("OverVideo", "Top_UIToggle")
    ---@type UnityEngine.GameObject 随机一张
    self.OneBtn = self:Get("OneBtn", "GameObject")
    ---@type UnityEngine.GameObject 随机10张
    self.TenBtn = self:Get("TenBtn", "GameObject")
    ---@type UnityEngine.GameObject 余下全部
    self.AllBtn = self:Get("AllBtn", "GameObject")
    ---@type UILabel Label
    self.Label = self:Get("Label", "Top_UILabel")
end

function UITreasurePanel_SeekTreasure:InitOther()
    self.FlipList = {}
    self.ShuffList = {}
    self.UIROOT = CS.UIManager.Instance:GetUIRoot()
    self.uiCamera = self:SetUICamera()
    self.isBeginDetection = false
    UITreasurePanel_SeekTreasure.Self = self
    self.RifflFinishIndex = 0
    self.privateCard = false

    CS.UIEventListener.Get(self.boxArea).onDragStart = self.onDragStartboxArea
    CS.UIEventListener.Get(self.boxArea).onDrag = self.OnDragboxArea
    CS.UIEventListener.Get(self.boxArea).onDragEnd = self.onDragEndArea
    CS.UIEventListener.Get(self.boxArea).onPress = self.onPressArea

    CS.UIEventListener.Get(self.OneBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.OneBtn).OnClickLuaDelegate = self.OnClickOneBtn
    CS.UIEventListener.Get(self.TenBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.TenBtn).OnClickLuaDelegate = self.OnClickTenBtn
    CS.UIEventListener.Get(self.AllBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.AllBtn).OnClickLuaDelegate = self.OnClickAllBtn
end

function UITreasurePanel_SeekTreasure:Init(treasurePanel)
    ---@type UITreasurePanel
    self.mTreasurePanel = treasurePanel
    self:InitComponents()
    self:InitOther()
    self:InitGridList(self.Grid, luaComponentTemplates.UITreasurePanel_SeekTreasureItem, self.FlipList)
    self:InitGridList(self.shuffleGrid, luaComponentTemplates.UITreasurePanel_SeekTreasureRiffleItem, self.ShuffList, self)
    networkRequest.ReqTreasureCard()
    CS.CSScene.MainPlayerInfo.TreasureInfo.IsChangePrivateCard = false
end

---初始化卡牌列表
function UITreasurePanel_SeekTreasure:InitGridList(Grid, temp, tableList, table)
    Grid.MaxCount = 21
    for index = 0, 21 - 1 do
        local item = Grid.controlList[index].gameObject
        local template = templatemanager.GetNewTemplate(item, temp, self.mTreasurePanel)
        template:InitUI(index + 1, table)
        tableList[index + 1] = template
    end
end

---设置UICamera
function UITreasurePanel_SeekTreasure:SetUICamera()
    local cameras = CS.UnityEngine.Camera.allCameras
    local cameraTransform = CS.UIManager.Instance:GetUICameraRoot();
    for i = 0, cameras.Length - 1 do
        if cameras[i].gameObject == cameraTransform.gameObject then
            return cameras[i]
        end
    end
end

--endregion
function UITreasurePanel_SeekTreasure:Update()
    if self.isBeginDetection then
        self:DetectionOpen(true)
    end
end

---刷新所有卡牌数据
---@type  data List<treasureHuntV2.CardInfo> 
function UITreasurePanel_SeekTreasure:RefreshAllCard(data)
    if CS.CSScene.MainPlayerInfo.TreasureInfo.IsChangePrivateCard and self.CardInfoList ~= nil then
        return
    end
    self.page = CS.CSScene.MainPlayerInfo.TreasureInfo.Page
    self.countDownEndS = CS.CSScene.MainPlayerInfo.TreasureInfo.CountDownEndS
    self.CardInfoList = CS.CSScene.MainPlayerInfo.TreasureInfo.CardInfoList
    self.privateCard = CS.CSScene.MainPlayerInfo.TreasureInfo.PrivateCard;
    if self.privateCard then
        self.Label.text = "私有"
    else
        self.Label.text = "共有"
    end

    self.Time:StartCountDown(nil, 2, self.countDownEndS, nil, "后将重新洗牌")
    if CS.CSScene.MainPlayerInfo.TreasureInfo.IsNeedShuffle then
        self:RiffleAll()
    else
        self:RifflSetPanel(false)
    end
    if #self.FlipList == 0 then
        self:InitGridList()
    end
    for i = 0, self.CardInfoList.Count do
        if self.CardInfoList.Count <= #self.FlipList then
            if self.FlipList[i + 1] ~= nil then
                self.FlipList[i + 1]:RefreshCardInfo(self.CardInfoList[i], self.page)
            end
        end
    end
end

function UITreasurePanel_SeekTreasure:ShuffleCallBack()
    local self = UITreasurePanel_SeekTreasure.Self
    self:RiffleAll()
end

---翻牌检测
function UITreasurePanel_SeekTreasure:DetectionOpen(isSlide)
    local mouseWorldPosition = self.uiCamera:ScreenToWorldPoint(CS.UnityEngine.Input.mousePosition)
    mouseWorldPosition.z = 0
    self.slidingBlock.transform.position = mouseWorldPosition
    -- print(self.FlipList[1].go.transform.position,self.slidingBlock.transform.position)
    --  local transform=self.FlipList[1].go.transform.position
    -- transform.z=0
    --  print(self.FlipList[1].go.name,CS.UnityEngine.Vector3.Distance(transform, self.slidingBlock.transform.position))

    for i = 1, #self.FlipList do
        local transform = self.FlipList[i].go.transform.position
        transform.z = 0
        if CS.UnityEngine.Vector3.Distance(transform, self.slidingBlock.transform.position) < 0.14 then
            if self.FlipList[i] ~= nil and self.FlipList[i].faces == CS.ETreasureFaces.Back then
                self.FlipList[i]:OnReqTreasureTurnCard()
            end
            if isSlide == false and self.FlipList[i] ~= nil and self.FlipList[i].faces == CS.ETreasureFaces.Front then
                self.FlipList[i]:CheckDetailInformation()
            end
        end
    end
end

---洗牌
function UITreasurePanel_SeekTreasure:RiffleAll()
    self.RifflFinishIndex = 0;
    self:RifflSetPanel(true)
    for i = 1, #self.ShuffList do
        self.ShuffList[i]:Riffle()
    end

end

function UITreasurePanel_SeekTreasure:RifflSetPanel(isopenRifflPanel)
    self.Shuffle.gameObject:SetActive(isopenRifflPanel)
    self.ScrollView.gameObject:SetActive(isopenRifflPanel == false)
    self.boxArea.gameObject:SetActive(isopenRifflPanel == false)
    -- if isopenRifflPanel then
    --     self.ScrollView.alpha = 0;
    --     self.Shuffle.alpha = 1;
    -- else
    --     self.ScrollView.alpha = 1;
    --     self.Shuffle.alpha = 0;
    -- end
end

function UITreasurePanel_SeekTreasure:RifflFinish()
    self.RifflFinishIndex = self.RifflFinishIndex + 1
    if self.RifflFinishIndex >= 21 then
        self.RifflFinishIndex = 0;
        self:RifflSetPanel(false)
    end
end

--region UI事件
function UITreasurePanel_SeekTreasure.onPressArea(obj, isDown)
    local self = UITreasurePanel_SeekTreasure.Self
    if isDown == true and self.isBeginDetection == false then

        self:DetectionOpen(false)
    end
end

function UITreasurePanel_SeekTreasure.onDragStartboxArea(go, delta)
    local self = UITreasurePanel_SeekTreasure.Self
    self.isBeginDetection = true
end

function UITreasurePanel_SeekTreasure.onDragEndArea(go, delta)
    local self = UITreasurePanel_SeekTreasure.Self
    self.isBeginDetection = false
end

function UITreasurePanel_SeekTreasure:BuyPrompt(number, RequestNumber, isprivate)
    if CS.CSScene.MainPlayerInfo.TreasureInfo.IsJumpTip == false then
        local data = {
            Title = "提示",
            Content = "是否花费" .. (number * 20) .. "钻石购买" .. number .. "颗小型经验丹，并获取" .. number .. "次翻牌机会",
            IsToggleVisable = true,
            OptionBtnCallBack = function()
                CS.CSScene.MainPlayerInfo.TreasureInfo.IsJumpTip = CS.CSScene.MainPlayerInfo.TreasureInfo.IsJumpTip == false
            end,
            CallBack = function()
                networkRequest.ReqTreasureHunt(RequestNumber, self.privateCard, self.page, isprivate)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, data)
    else
        networkRequest.ReqTreasureHunt(RequestNumber, self.privateCard, self.page, isprivate)
    end
end

---随机一张点击事件
function UITreasurePanel_SeekTreasure:OnClickOneBtn(go)
    if self.mTreasurePanel and self.mTreasurePanel:IsAvailableForTicket(1) then
        self:BuyPrompt(1, 1);
    else
        CS.Utility.ShowTips("钻石不足", 1.5, CS.ColorType.Yellow)
    end
end

---随机10张点击事件
function UITreasurePanel_SeekTreasure:OnClickTenBtn(go)
    local number = 0;
    if CS.CSScene.MainPlayerInfo.TreasureInfo.SurplusNumber >= 10 then
        number = 10;
    else
        number = CS.CSScene.MainPlayerInfo.TreasureInfo.SurplusNumber
    end
    if self:Showbubble(number, self.TenBtn.transform) then
        self:BuyPrompt(number, number, false);
    end
end
---余下全部点击事件
function UITreasurePanel_SeekTreasure:OnClickAllBtn(go)
    local number = CS.CSScene.MainPlayerInfo.TreasureInfo.SurplusNumber
    if self:Showbubble(number, self.AllBtn.transform) then
        self:BuyPrompt(number, number, true);
    end
end

---显示气泡
function UITreasurePanel_SeekTreasure:Showbubble(number, trans)

    --local ticketIntegral = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(6110001);
    --local needNumber = (number - ticketIntegral) * 20
    --local Diamond = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum;
    if self.mTreasurePanel == nil or self.mTreasurePanel:IsAvailableForTicket(number) == false then
        --local TipsInfo = {}
        --        --TipsInfo[LuaEnumTipConfigType.Parent] = trans
        --        --TipsInfo[LuaEnumTipConfigType.ConfigID] = 64
        --        --TipsInfo[LuaEnumTipConfigType.Describe] = "钻石不足"
        --        --TipsInfo[LuaEnumTipConfigType.DependPanel] = "UITreasurePanel"
        --        --uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
        Utility.JumpRechargePanel()
        return false
    end
    return true
end

--endregion

function UITreasurePanel_SeekTreasure:OnDestroy()
    UITreasurePanel_SeekTreasure.Self = nil
end

return UITreasurePanel_SeekTreasure