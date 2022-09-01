---模板
local UIOurRankTemplate = {}

--region 初始化

function UIOurRankTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIOurRankTemplate:InitParameters()
    self.myRankID = 0
    self.myRankBtnCallBack = nil
end

function UIOurRankTemplate:InitComponents()

    -----@type Top_UILabel   第一个值  排行
    --self.firstValue = self:Get("firstValue", "Top_UILabel")
    -----@type Top_UILabel   第二个值  名称
    --self.secondValue = self:Get("secondValue", "Top_UILabel")
    -----@type Top_UILabel   第三个值
    --self.thirdValue = self:Get("thirdValue", "Top_UILabel")
    -----@type Top_UISprite  第三个值 图片
    --self.thirdsprite = self:Get("thirdsprite", "Top_UISprite")
    -----@type Top_UILabel   第四个值 等级
    --self.fourthValue = self:Get("fourthValue", "Top_UILabel")

    ---@type UnityEngine.GameObject 我的排名
    self.btn_myrank = self:Get("btn_myrank", "GameObject")
    ---@type Top_UISprite 排名图片
    self.rank = self:Get("btn_myrank/rank", "Top_UISprite")
    ---@type UnityEngine.GameObject 箭头
    self.arrow = self:Get("btn_myrank/arrow", "GameObject")

end

function UIOurRankTemplate:BindUIMessage()
    --点击事件
    CS.UIEventListener.Get(self.btn_myrank.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_myrank.gameObject).OnClickLuaDelegate = self.OnClickbtn_myrank
end

function UIOurRankTemplate:BindNetMessage()

end

--endregion

--region Show
---{
---@param data table
---@field data.firstValue       string   第一个数值 （一般为排行）
---@field data.secondValue      string   第二个数值
---@field data.thirdValue       string   第三个数值
---@field data.thirdsprite      string   第三个图片
---@field data.fourthValue      string   第四个数值
---@field data.callBack         function 点击回调
---@field data.rankId           number   自己排行名次
---@field data.myRankBtnCallBack function 点击自己排行回调
---@field data.isShowMyRankBtn   boolean  是否显示我的排名
---}
function UIOurRankTemplate:SetTemplate(data)
    if data then
        self.myRankID = data.rankId
        self.myRankBtnCallBack = data.myRankBtnCallBack
        self.rank.spriteName = self.myRankID == 0 and 'unmyrank' or 'myrank'
        --self:SetArrowState(false)
        --self.btn_myrank:SetActive(data.isShowMyRankBtn)
        --self.firstValue.text = data.firstValue
        --self.secondValue.text = data.secondValue
        --self.thirdValue.text = data.thirdValue
        --self.thirdsprite.spriteName = data.thirdsprite
        --self.fourthValue .text = data.fourthValue
    end
end

function UIOurRankTemplate:SetArrowState(isOpen)
    --self.arrow:SetActive(isOpen)
end

function UIOurRankTemplate:SetRankBtnState()

end

--endregion


--region UI函数监听
--点击函数
---@param go UnityEngine.GameObject
function UIOurRankTemplate:OnClickbtn_myrank(go)
    if self.myRankID == 0 or self.myRankID == nil or self.myRankBtnCallBack == nil then
        return
    end
    self.myRankBtnCallBack()
end

--endregion


--region otherFunction



--endregion


return UIOurRankTemplate