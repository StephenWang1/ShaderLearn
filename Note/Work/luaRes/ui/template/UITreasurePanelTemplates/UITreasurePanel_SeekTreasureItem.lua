local UITreasurePanel_SeekTreasureItem = {}

function UITreasurePanel_SeekTreasureItem:InitComponents()
    ---@type UnityEngine.GameObject 背面
    self.backFrame = self:Get("backFrame", "GameObject")
    ---@type UnityEngine.GameObject 背面图片
    self.backFrameUISprite = self:Get("backFrame", "UISprite")
    ---@type UnityEngine.GameObject 正面
    self.checkFrame = self:Get("checkFrame", "GameObject")
    ---正面道具Item
    self.checkFrameItemTemplates = templatemanager.GetNewTemplate(self.checkFrame, luaComponentTemplates.UITreasurePanel_Item)

    ---@type UnityEngine.GameObject 背面
    self.backFrame_TweenRotation = self:Get("backFrame", "Top_TweenRotation")
    ---@type UnityEngine.GameObject 正面
    self.checkFrame_TweenRotation = self:Get("checkFrame", "Top_TweenRotation")
    ---移动
    self.cardsItemTweenPosition = CS.Utility_Lua.GetComponent(self.go, "Top_TweenPosition")

    ---@type TweenPosition 飞入动画
    self.flyInto = self:Get("FlyInto", "GameObject")
    ---@type UISprite 飞入icon
    self.flyInto_UISprite = self:Get("FlyInto", "Top_UISprite")
    ---@type TweenPosition 飞入动画
    self.flyInto_TweenPosition = self:Get("FlyInto", "Top_TweenTransform")
    ---@type TweenAlpha 飞入动画
    self.flyInto_TweenAlpha = self:Get("FlyInto", "Top_TweenAlpha")
    ---@type TweenScale 飞入动画
    self.flyInto_TweenScale = self:Get("FlyInto", "Top_TweenScale")
    ---特效节点
    self.effectLoad = self:Get("effectLoad", "GameObject")


end

function UITreasurePanel_SeekTreasureItem:InitOther()
    --卡牌ID
    self.id = 0
    --洗牌等待时间
    self.delayTime = 0
    --洗牌等待固定间隔
    self.riffleDelayTime = 0.3
    self.faces = CS.ETreasureFaces.Back
    --初始化卡牌动画起始洗位置
    self.cardsItemTweenPosition.from = self.go.transform.localPosition
    --记录卡牌动画结束位置
    self.ToVector3 = self.cardsItemTweenPosition.to
    --道具ID
    self.ItemID = nil
    --卡牌信息
    self.cardInfo = nil
    --主角ID
    self.PlayerRoleID = nil
end

---@param treasurePanel UITreasurePanel
function UITreasurePanel_SeekTreasureItem:Init(treasurePanel)
    self.mTreasurePanel = treasurePanel
    self:InitComponents()
    self:InitOther()

end

---初始化UI信息
function UITreasurePanel_SeekTreasureItem:InitUI(id)
    self.id = id
    self.backFrameUISprite.spriteName = "card_closed" .. tostring(id)
    self.delayTime = math.random(10) * 0.02
    self.cardsItemTweenPosition.delay = self.delayTime
    self.backFrameUISprite.depth = id
    self.cardsItemTweenPosition.to = self.ToVector3 + CS.UnityEngine.Vector3(-id * 0.5, id * 0.5, 0)
    self.mainPlayerID = CS.CSScene.Sington.MainPlayer.ID
    self.IsSelfItem = false;
end

---刷新卡牌信息
---@param cardInfo treasureHuntV2.CardInfo
function UITreasurePanel_SeekTreasureItem:RefreshCardInfo(cardInfo, page)
    self.page = page

    self.IsStartInit = self.ItemIDList == nil
    self.ItemIDList = cardInfo.HuntItemList
    if self.PlayerRoleID == nil then
        self.PlayerRoleID = CS.CSScene.MainPlayerInfo.ID
    end

    self.ItemID = 0
    self.bagItemInfo = 0
    self.IsShoweffect = false
    if self.ItemIDList ~= nil and self.ItemIDList.Count >= 1 then
        self.bagItemInfo = self.ItemIDList[0].item
        self.IsShoweffect = self.ItemIDList[0].effect
        self.IsSelfItem = self.mainPlayerID == self.ItemIDList[0].roleId
        if self.bagItemInfo ~= nil then
            self.ItemID = self.bagItemInfo.itemId
        end
        self.tabItem = CS.Cfg_ItemsTableManager.Instance:GetItems(self.ItemID)
        self.checkFrameItemTemplates:RefreshUI(self.ItemID, self.bagItemInfo)
    end
    self.cardInfo = cardInfo
    if cardInfo.front and cardInfo ~= nil then
        if self.faces ~= CS.ETreasureFaces.Front then
            self.faces = CS.ETreasureFaces.Front
            self:OnTurnover()
        end
    else
        self.faces = CS.ETreasureFaces.Back
        self:Riffle_EmptyData()
    end
end

---初始化牌面数据
function UITreasurePanel_SeekTreasureItem:Riffle_EmptyData()
    self.backFrame.gameObject.transform.localEulerAngles = CS.UnityEngine.Vector3.zero
    self.backFrame.gameObject:SetActive(true)
    self.checkFrame.gameObject:SetActive(false)
    self.backFrame_TweenRotation.enabled = false
    self.checkFrame_TweenRotation.enabled = false
    self.effectLoad.gameObject:SetActive(false)
end

---请求翻牌
function UITreasurePanel_SeekTreasureItem:OnReqTreasureTurnCard()
    --if self.faces ~= nil then
    --    self.faces = nil
    --
    --    self:BuyPrompt()
    --    -- networkRequest.ReqTreasureTurnCard(self.page, self.id - 1)
    --end
    self:BuyPrompt()
end

function UITreasurePanel_SeekTreasureItem:BuyPrompt()
    local number = 1
    if CS.CSScene.MainPlayerInfo.TreasureInfo.IsJumpTip == false then
        local data = {
            Title = "提示",
            Content = "是否花费" .. (number * 20) .. "钻石购买" .. number .. "颗小型经验丹，并获取" .. number .. "次翻牌机会",
            IsToggleVisable = true,
            OptionBtnCallBack = function()
                CS.CSScene.MainPlayerInfo.TreasureInfo.IsJumpTip = CS.CSScene.MainPlayerInfo.TreasureInfo.IsJumpTip == false
            end,
            CallBack = function()
                if self.mTreasurePanel and self.mTreasurePanel:IsAvailableForTicket(1) then
                    networkRequest.ReqTreasureTurnCard(self.page, self.id - 1)
                end
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, data)
    else
        if self.mTreasurePanel and self.mTreasurePanel:IsAvailableForTicket(1) then
            networkRequest.ReqTreasureTurnCard(self.page, self.id - 1)
        else
            local currentTime = CS.UnityEngine.Time.time
            if UITreasurePanel_SeekTreasureItem.mLatestTipTime == nil or currentTime - UITreasurePanel_SeekTreasureItem.mLatestTipTime > 3 then
                ---限制下提示频率
                UITreasurePanel_SeekTreasureItem.mLatestTipTime = currentTime
                CS.Utility.ShowTips("钻石不足", 1.5, CS.ColorType.Yellow)
            end
        end
    end
end

---播放飞入动画
function UITreasurePanel_SeekTreasureItem:PlayflyInto_Tween()
    if self.IsStartInit then
        return
    end
    if self.tabItem ~= nil then
        self.flyInto_UISprite.spriteName = self.tabItem.icon
    end
    self.delayTime = math.random(10) * 0.1
    self.flyInto_TweenPosition.delay = self.delayTime
    self.flyInto_TweenAlpha.delay = self.delayTime
    self.flyInto_TweenScale.delay = self.delayTime
    self.flyInto.gameObject:SetActive(true)
    self.flyInto_TweenPosition:ResetToBeginning()
    self.flyInto_TweenAlpha:ResetToBeginning()
    self.flyInto_TweenScale:ResetToBeginning()
    self.flyInto_TweenPosition:PlayForward()
    self.flyInto_TweenAlpha:PlayForward()
    self.flyInto_TweenScale:PlayForward()

end
---飞入动画初始化
function UITreasurePanel_SeekTreasureItem:InitPlayflyInto_Tween()
    self.flyInto.gameObject:SetActive(false)
    self.flyInto_TweenPosition.enabled = false;
    self.flyInto_TweenAlpha.enabled = false
    self.flyInto_TweenScale.enabled = false
end

--region 点击事件
---点击自身
function UITreasurePanel_SeekTreasureItem:OnTurnover()
    self.backFrame_TweenRotation:ResetToBeginning()
    self.backFrame_TweenRotation:PlayForward()
    self.backFrame_TweenRotation.enabled = true
    self.backFrame_TweenRotation:SetOnFinished(function()
        self.backFrame.gameObject:SetActive(false)
        self.checkFrame.gameObject:SetActive(true)
        self.backFrame_TweenRotation:ResetToBeginning()
        self.checkFrame_TweenRotation:ResetToBeginning()
        self.checkFrame_TweenRotation:PlayForward()
        self.checkFrame_TweenRotation:SetOnFinished(function()
            self.effectLoad.gameObject:SetActive(self.IsShoweffect)
            if self.cardInfo ~= nil then
                if self.PlayerRoleID == self.cardInfo.roleId then
                    self:PlayflyInto_Tween()
                end
            end
        end);
    end);
end

---查看物体详细信息
function UITreasurePanel_SeekTreasureItem:CheckDetailInformation()
    if self.bagItemInfo ~= nil then
        self.bagItemInfo.index = 0
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.bagItemInfo, showRight = false })
    elseif self.tabItem ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.tabItem, showRight = false })
    end

end

--endregion

return UITreasurePanel_SeekTreasureItem