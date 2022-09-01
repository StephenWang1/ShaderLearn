---@class CompleteTemplate:TemplateBase 扫荡模块
local CompleteTemplate = {}

--region 初始化
function CompleteTemplate:Init()
    self:InitComponent()
    self:BindClientEvents()
end

function CompleteTemplate:InitComponent()
    ---@type UnityEngine.GameObject 前往按钮
    self.JoinBtn_GameObject = self:Get("btn_gokill","GameObject")
    ---@type UnityEngine.GameObject 前往花费
    self.JoinCost_GameObject = self:Get("cost1","GameObject")
    ---@type UnityEngine.GameObject 扫荡按钮
    self.ClearBtn_GameObject = self:Get("btn_complete","GameObject")
    ---@type UnityEngine.GameObject 扫荡花费
    self.ClearCost_GameObject = self:Get("cost2","GameObject")
    ---@type UISprite 前往按钮图片
    self.JoinBtn_UISprite = self:Get("btn_gokill/backGround","UISprite")
    ---@type UILabel 前往按钮上文本
    self.JoinBtn_UILabel = self:Get("btn_gokill/Label","UILabel")
    ---@type UnityEngine.GameObject 前往按钮特效
    self.JoinBtnEffect_GameObject = self:Get("btn_gokill/effect","GameObject")
end

function CompleteTemplate:BindClientEvents()
    luaclass.UIRefresh:BindClickCallBack(self.JoinBtn_GameObject,function(go)
        if self.JoinBtnCallBack ~= nil then
            self.JoinBtnCallBack(go)
        end
    end)
    luaclass.UIRefresh:BindClickCallBack(self.ClearBtn_GameObject,function(go)
        if self.ClearCostTemplate ~= nil and self.ClearCostTemplate:CostIsEnough() == false then
            Utility.ShowPopoTips(go, self.ClearCostTemplate.costItemInfo:GetName()  .. "不足", 481)
            return
        end
        if self.JointCostTemplate ~= nil and self.JointCostTemplate.costItemInfo ~= nil and self.JointCostTemplate:CostIsEnough() == false then
            Utility.ShowPopoTips(go, self.JointCostTemplate.costItemInfo:GetName() .. "不足", 481)
            return
        end
        if self.ClearBtnCallBack ~= nil then
            self.ClearBtnCallBack(go)
        end
    end)
end
--endregion

---@class CompleteTemplateCommonData 扫荡模板通用模板
---@field JoinBtnCallBack function 前往按钮点击回调
---@field ClearBtnCallBack function 扫荡按钮回调
---@field JointCost Cost 参加花费
---@field ClearCost Cost 扫荡花费
---@field JoinBtnSpriteName string 加入按钮图片名字
---@field JoinBtnLabelName string 加入按钮上文本

--region 刷新
---@param commonData CompleteTemplateCommonData
function CompleteTemplate:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        luaclass.UIRefresh:RefreshActive(self.go,false)
    end
    self:RefreshCost()
    self:RefreshJoinBtn(self.JoinBtnLabelName,self.JoinBtnSpriteName)
end

---解析参数
---@param commonData CompleteTemplateCommonData
---@return boolean 解析结果
function CompleteTemplate:AnalysisParams(commonData)
    if type(commonData) ~= 'table' or commonData.JoinBtnCallBack == nil or commonData.ClearBtnCallBack == nil or commonData.ClearCost == nil then
        return false
    end
    self.commonData = commonData
    self.JoinBtnCallBack = commonData.JoinBtnCallBack
    self.ClearBtnCallBack = commonData.ClearBtnCallBack
    self.JointCost = commonData.JointCost
    self.ClearCost = commonData.ClearCost
    self.JoinBtnSpriteName = commonData.JoinBtnSpriteName
    self.JoinBtnLabelName = commonData.JoinBtnLabelName
    return true
end

---刷新花费
function CompleteTemplate:RefreshCost()
    ---前往花费刷新
    if self.JointCostTemplate == nil then
        self.JointCostTemplate = templatemanager.GetNewTemplate(self.JoinCost_GameObject,luaComponentTemplates.CostTemplate)
    end
    if self.JointCostTemplate ~= nil then
        self.JointCostTemplate:RefreshPanel({Cost = self.JointCost})
    end

    ---扫荡花费刷新
    if self.ClearCostTemplate == nil then
        self.ClearCostTemplate = templatemanager.GetNewTemplate(self.ClearCost_GameObject,luaComponentTemplates.CostTemplate)
    end
    if self.ClearCostTemplate ~= nil then
        self.ClearCostTemplate:RefreshPanel({Cost = self.ClearCost})
    end
end

---刷新加入按钮
---@param text string
---@param spriteName string
function CompleteTemplate:RefreshJoinBtn(text,spriteName)
    if CS.StaticUtility.IsNullOrEmpty(text) == false then
        luaclass.UIRefresh:RefreshLabel(self.JoinBtn_UILabel,text)
    end
    if CS.StaticUtility.IsNullOrEmpty(spriteName) == false then
        luaclass.UIRefresh:RefreshSprite(self.JoinBtn_UISprite,spriteName)
    end
end

---切换加入按钮特效状态
---@param state boolean
function CompleteTemplate:ChangeJoinBtnEffect(state)
    if type(state) == 'boolean' then
        luaclass.UIRefresh:RefreshActive(self.JoinBtnEffect_GameObject,state)
    end
end
--endregion
return CompleteTemplate