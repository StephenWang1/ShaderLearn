local UIItemInfoPanel_Info_OpenCloseBtnList ={}

---背景图额外增加的宽度
UIItemInfoPanel_Info_OpenCloseBtnList.BgWeight = 10
---背景图额外增加的高度
UIItemInfoPanel_Info_OpenCloseBtnList.BgHeight = 20
---关闭打开按钮离底部的距离
UIItemInfoPanel_Info_OpenCloseBtnList.showCloseDownDistance = 10

function UIItemInfoPanel_Info_OpenCloseBtnList:Init(commonData)
    self:AnalysisCommonData(commonData)
    self:InitComponent()
    self:calculateData()
    self:ChangeBenState(false)
    self:BindClick()
end

function UIItemInfoPanel_Info_OpenCloseBtnList:AnalysisCommonData(commonData)
    self.defaultShowBtnNum = 1
    if commonData ~= nil then
        self.defaultShowBtnNum = ternary( commonData.defaultShowBtnNum == nil,1,commonData.defaultShowBtnNum)
    end
end

function UIItemInfoPanel_Info_OpenCloseBtnList:InitComponent()
    self.bg_UISprite = self:Get("bg","UISprite")
    self.bts_UIGridContainer = self:Get("","UIGridContainer")
    self.showclose = self:Get("showclose","BoxCollider")
    self.showclose_Label = self:Get("showclose/Label","UILabel")
    self.arrow = self:Get("showclose/backGround","TweenRotation")
    self.btns_UIPanel = self:Get("","UIPanel")
end

function UIItemInfoPanel_Info_OpenCloseBtnList:BindClick()
    CS.UIEventListener.Get(self.showclose.gameObject).onClick = function()
        self:ChangeBenState(not self.isOpen)
    end
end

function UIItemInfoPanel_Info_OpenCloseBtnList:ChangeBenState(IsOpen)
    if IsOpen then
        self.bg_UISprite:SetDimensions(self.bgOpenSpriteWeight,self.bgOpenSpriteHeight)
        --self.bg_UISprite.transform.localPosition = CS.UnityEngine.Vector3(self.bgOpenPosition_x,self.bgOpenPosition_y,0)
        self.showclose.transform.localPosition = self.showcloseBtnOpenLocalPosition
        for i = self.defaultShowBtnNum,self.bts_UIGridContainer.controlList.Count - 1 do
            self.bts_UIGridContainer.controlList[i]:SetActive(true)
        end
        self.arrow:PlayForward()
        self.showclose_Label.text = "收起"
    else
        self.bg_UISprite:SetDimensions(self.bgCloseSpriteWeight,self.bgCloseSpriteHeight)
        --self.bg_UISprite.transform.localPosition = CS.UnityEngine.Vector3(self.bgClosePosition_x,self.bgClosePosition_y,0)
        self.showclose.transform.localPosition = self.showcloseBtnCloseLocalPosition
        for i = self.defaultShowBtnNum,self.bts_UIGridContainer.controlList.Count - 1 do
            self.bts_UIGridContainer.controlList[i]:SetActive(false)
        end
        self.arrow:PlayReverse()
        self.showclose_Label.text = "展开"
    end
    self.isOpen = IsOpen
end

---计算背景图自适应数据
function UIItemInfoPanel_Info_OpenCloseBtnList:calculateData()
    --region 计算开启和关闭的背景图的大小和位置
    ---展开收缩按钮
    local shocloseBoxSize = self.showclose_Label.localSize

    ---第一个按钮
    local firstBtnUISprite = CS.Utility_Lua.GetComponent(self.bts_UIGridContainer.controlList[0].transform:Find("backGround"),"UISprite")

    ---最后一个按钮
    local lastBtnUISprite = CS.Utility_Lua.GetComponent(self.bts_UIGridContainer.controlList[self.bts_UIGridContainer.controlList.Count - 1].transform:Find("backGround"),"UISprite")
    local singleBtn_Size = lastBtnUISprite.localSize

    ---按钮间隔
    local btnHeightIntervals = self.bts_UIGridContainer.CellHeight - singleBtn_Size.y

    ---计算关闭的背景图大小
    self.bgCloseSpriteHeight = (singleBtn_Size.y * self.defaultShowBtnNum) + (self.defaultShowBtnNum - 1) * btnHeightIntervals + self.BgHeight + shocloseBoxSize.y + self.showCloseDownDistance
    self.bgCloseSpriteWeight = singleBtn_Size.x + self.BgWeight

    ---计算关闭的背景图位置
    --self.bgClosePosition_y = firstBtnUISprite.transform.parent.localPosition.y * 0.5 + -1 * (shocloseBoxSize.y * 0.5) - self.showCloseDownDistance * 0.5
    --self.bgClosePosition_x = firstBtnUISprite.transform.localPosition.x + -1 * (self.BgWeight / 2)

    ---计算打开的背景图大小
    self.bgOpenSpriteHeight = self.bts_UIGridContainer.controlList.Count * singleBtn_Size.y + (self.bts_UIGridContainer.controlList.Count - 1) * btnHeightIntervals + self.BgHeight + shocloseBoxSize.y + self.showCloseDownDistance
    self.bgOpenSpriteWeight = singleBtn_Size.x + self.BgWeight

    ---计算打开的背景图的位置
    --self.bgOpenPosition_y = lastBtnUISprite.transform.parent.localPosition.y * 0.5 + -1 * (shocloseBoxSize.y * 0.5) - self.showCloseDownDistance * 0.5
    --self.bgOpenPosition_x = lastBtnUISprite.transform.localPosition.x + -1 * (self.BgWeight / 2)
    --endregion

    --region 计算展示按钮的位置
    ---关闭的显示展示按钮的位置
    local firstBtnLocalPsotion = self.bts_UIGridContainer.controlList[self.defaultShowBtnNum - 1].transform.localPosition
    firstBtnLocalPsotion.y = firstBtnLocalPsotion.y - 40
    self.showcloseBtnCloseLocalPosition = firstBtnLocalPsotion

    ---开启的显示展示按钮的位置
    local lastBtnLocalPsotion = self.bts_UIGridContainer.controlList[self.bts_UIGridContainer.controlList.Count - 1].transform.localPosition
    lastBtnLocalPsotion.y = lastBtnLocalPsotion.y - 40
    self.showcloseBtnOpenLocalPosition = lastBtnLocalPsotion
    --endregion
end
return UIItemInfoPanel_Info_OpenCloseBtnList