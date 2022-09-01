local UITreasurePanel_SeekTreasureRiffleItem = {}

function UITreasurePanel_SeekTreasureRiffleItem:InitComponents()
    ---@type UnityEngine.GameObject 背面图片
    self.backFrameUISprite = self:Get("backFrame", "UISprite")
    ---移动
    self.cardsItemTweenPosition = CS.Utility_Lua.GetComponent(self.go, "Top_TweenPosition")

end
function UITreasurePanel_SeekTreasureRiffleItem:InitOther()
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
end

function UITreasurePanel_SeekTreasureRiffleItem:Init(treasurePanel)
    self.mTreasurePanel = treasurePanel
    self:InitComponents()
    self:InitOther()
end

---初始化UI信息
function UITreasurePanel_SeekTreasureRiffleItem:InitUI(id, SeekTreasurePanel)
    self.id = id
    self.delayTime = math.random(10) * 0.02
    self.cardsItemTweenPosition.delay = self.delayTime
    self.backFrameUISprite.spriteName = "card_closed" .. tostring(id)
    self.backFrameUISprite.depth = id
    self.cardsItemTweenPosition.to = self.ToVector3 + CS.UnityEngine.Vector3(-id * 0.5, id * 0.5, 0)
    self.SeekTreasurePanel = SeekTreasurePanel
end

---洗牌
function UITreasurePanel_SeekTreasureRiffleItem:Riffle()
    self.cardsItemTweenPosition:ResetToBeginning()
    self.cardsItemTweenPosition:PlayForward()
    self.cardsItemTweenPosition:SetOnFinished(function()
        self.SeekTreasurePanel:RifflFinish()
    end);
end

return UITreasurePanel_SeekTreasureRiffleItem