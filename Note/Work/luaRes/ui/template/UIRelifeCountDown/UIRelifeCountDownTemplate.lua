---@class UIRelifeCountDownTemplate:TemplateBase 倒计时模板
local UIRelifeCountDownTemplate = {}

--region 数据
---@type CountDownEndPackage 倒计时结束包
UIRelifeCountDownTemplate.CountDownEndPackage = nil
--endregion

--region 初始化
function UIRelifeCountDownTemplate:Init()
    self:InitComponent()
end

function UIRelifeCountDownTemplate:InitComponent()
    ---@type UITable
    self.mUITable = self:Get("","UITable")
    ---@type UISprite
    self.FirstSprite_UISprite = self:Get("CountLable","UISprite")
    ---@type UILabel
    self.FirstLabel_UILabel = self:Get("Second","UILabel")
    ---@type UISprite
    self.SecondSprite_UISprite = self:Get("CountLable2","UISprite")
end
--endregion

--region 刷新
---刷新倒计时
---@param countDownEndPackage CountDownEndPackage 倒计时结束包
function UIRelifeCountDownTemplate:RefreshCountDown(countDownEndPackage)
    self:RefreshComponentDefaultShowState()
    self.CountDownEndPackage = countDownEndPackage
    if self.CountDownEndPackage.AnalysisState == false or self.CountDownEndPackage:IsObsoletePackage() then
        luaclass.UIRefresh:RefreshActive(self.go,false)
        return
    end
    self:RefreshCountDownType()
end

---刷新组件默认显示状态
function UIRelifeCountDownTemplate:RefreshComponentDefaultShowState()
    luaclass.UIRefresh:RefreshActive(self.FirstSprite_UISprite,false)
    luaclass.UIRefresh:RefreshActive(self.FirstLabel_UILabel,false)
    luaclass.UIRefresh:RefreshActive(self.SecondSprite_UISprite,false)
end

---刷新倒计时显示
function UIRelifeCountDownTemplate:RefreshCountDownType()
    local TimeClockType = self.CountDownEndPackage.TimeClockTbl:GetType()
    if TimeClockType == LuaEnumCountDownEndShowType.SpriteLabelSprite then
        self:RefreshCountDown_SpriteLabelSpriteType()
    end
end

---刷新倒计时显示_图片文本图片
function UIRelifeCountDownTemplate:RefreshCountDown_SpriteLabelSpriteType()
    local TimeCLockTbl = self.CountDownEndPackage.TimeClockTbl
    luaclass.UIRefresh:RefreshActive(self.FirstLabel_UILabel,true)
    if CS.StaticUtility.IsNullOrEmpty(TimeCLockTbl:GetParameter()) then
        return
    end
    local spriteNameTable = string.Split(TimeCLockTbl:GetParameter(),'#')
    local spriteNameTableCount = Utility.GetLuaTableCount(spriteNameTable)
    if type(spriteNameTable) ~= 'table' or spriteNameTableCount <= 0 then
        return
    end
    luaclass.UIRefresh:RefreshSprite(self.FirstSprite_UISprite,spriteNameTable[1],nil,true)
    luaclass.UIRefresh:RefreshActive(self.FirstSprite_UISprite,true)
    if spriteNameTableCount > 1 then
        luaclass.UIRefresh:RefreshSprite(self.SecondSprite_UISprite,spriteNameTable[2],nil,true)
        luaclass.UIRefresh:RefreshActive(self.SecondSprite_UISprite,true)
    end
    self:UpdateRefreshCountDown()
end

---逐帧刷新倒计时
function UIRelifeCountDownTemplate:UpdateRefreshCountDown()
    if self.CountDownEndPackage ~= nil then
        luaclass.UIRefresh:RefreshLabel(self.FirstLabel_UILabel,self.CountDownEndPackage:GetRemainTimeSecond())
        luaclass.UIRefresh:RefreshUITable(self.mUITable)
    end
end
--endregion

return UIRelifeCountDownTemplate