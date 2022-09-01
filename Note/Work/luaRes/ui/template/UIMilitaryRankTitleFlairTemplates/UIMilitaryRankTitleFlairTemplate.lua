---@class UIMilitaryRankTitleFlairTemplate:TemplateBase 天赋属性分配
local UIMilitaryRankTitleFlairTemplate = {}

---@param numberChangedCallBack func
function UIMilitaryRankTitleFlairTemplate:Init(numberChangedCallBack)
    self.mCurrentNumberChanged = numberChangedCallBack
    self:InitComponents()
    self:InitParameters()
    self:BindEvents()
end

---@private
function UIMilitaryRankTitleFlairTemplate:InitComponents()

    ---@type UIInput
    -- 数值输入
    self.mNumberInput = self:Get("inputcount", "UIInput")
    
    ---@type UILabel
    -- 数值输入
    self.mShowNum = self:Get("inputcount/value", "UILabel")

    ---@type UISprite
    -- 增加按钮
    self.mAddButtonGO = self:Get("add", "UISprite")

    ---@type UISprite
    -- 减少按钮
    self.mReduceButtonGO = self:Get("reduce", "UISprite")

    ---@type UILabel
    -- 属性名
    self.attr_name = self:Get("lb_attribute/attr_name", "UILabel")
    
    ---@type UILabel
    -- 属性值
    self.attr_value = self:Get("lb_attribute/attr_value", "UILabel")
end

---@private
function UIMilitaryRankTitleFlairTemplate:InitParameters()
    self.minNumber = 0
    self.currentNumber = 0
    self.attributeName = {"对战增伤","受战减伤","对法增伤","受法减伤","对道增伤","受道减伤"}
    self.talentData = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentData()
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22887)
    if isFind then
        self.attrMax = tonumber(tbl.value)
    end
end

---@private
function UIMilitaryRankTitleFlairTemplate:BindEvents()
    CS.UIEventListener.Get(self.mAddButtonGO.gameObject).onClick = function(go)
        self:OnAddBtnClicked(go)
    end
    CS.UIEventListener.Get(self.mReduceButtonGO.gameObject).onClick = function(go)
        self:OnReduceBtnClicked(go)
    end
    self.mNumberInput.submitOnUnselect = true;
    CS.EventDelegate.Add(self.mNumberInput.onChange, function()
        self:OnNumberInputChanged()
    end)
    CS.EventDelegate.Add(self.mNumberInput.onSubmit, function()
        self:OnNumberInputSubmit()
    end)
end

---@private
---加法
function UIMilitaryRankTitleFlairTemplate:OnAddBtnClicked()
    local curNum = self.talentData[self.curIndex]
    local changeNum = curNum + gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentTempData()[self.curIndex] + 1
    local result = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetChange(self.curIndex,changeNum,1)
    --print("加",tostring(result),changeNum)
    if result then
        self:SetCurrentNumber(changeNum)
    end
end

---@private
---减法
function UIMilitaryRankTitleFlairTemplate:OnReduceBtnClicked()
    local curNum = self.talentData[self.curIndex]
    local changeNum = curNum + gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentTempData()[self.curIndex] - 1
    local result = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetChange(self.curIndex,changeNum,2)
    --print("减",tostring(result),changeNum)
    if result then
        self:SetCurrentNumber(changeNum)
    end
end

---输入框改变
function UIMilitaryRankTitleFlairTemplate:OnNumberInputSubmit()
    if not self.mNumberInput.isSelected then
        local tempdata = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentTempData()
        local tempNum = tempdata[self.curIndex]
        gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():AddRemainPointData(tempNum)
        gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetTalentTempData(self.curIndex,0)
        local curNum = self.talentData[self.curIndex]
        local number = tonumber(self.mNumberInput.value)
        number = number == nil and  0 or number
        local changeNum = number + curNum + tempdata[self.curIndex]
        local result = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetChange(self.curIndex,changeNum,3)
        print("输入",tostring(result),changeNum)
        if result then
            self:SetCurrentNumber(changeNum)
        else
            if changeNum < curNum then
                self.mShowNum.text = curNum
            end
            local remainNum = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetRemainPointData()
            -- 剩余点数<0  输入次数>最大值  输入次数>剩余点数  
            if remainNum <= 0 then
                if curNum > 0 then
                    self.mShowNum.text = tempdata[self.curIndex] > 0 and curNum..("[00ff00]+")..tempdata[self.curIndex] or curNum
                else
                    self.mShowNum.text = tempdata[self.curIndex] > 0 and curNum..("[00ff00]+")..tempdata[self.curIndex] or 0
                end
            end
            if self.attrMax < changeNum then
                self.mShowNum.text = curNum.."[00ff00]+"..remainNum
                self:SetCurrentNumber(remainNum+curNum)
            end
            if number > remainNum then
                self.mShowNum.text = curNum.."[00ff00]+"..remainNum
                self:SetCurrentNumber(remainNum+curNum)
            end
        end
        self.mNumberInput.value = ""
    end
end
function UIMilitaryRankTitleFlairTemplate:OnNumberInputChanged()
    self.mShowNum.text = ""
end

---@private
function UIMilitaryRankTitleFlairTemplate:SetCurrentNumber(number)
    local curNum = self.talentData[self.curIndex]
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetTalentTempData(self.curIndex,number-curNum)
    if self.mCurrentNumberChanged then
        self.mCurrentNumberChanged()
    end
end

-- 设置属性值 （如：1.3%）
function UIMilitaryRankTitleFlairTemplate:SetAttrStr(sourcePercent, curPoint)
    local color = (curPoint > 0) and luaEnumColorType.Green3 or luaEnumColorType.White
    if(sourcePercent > 0) then
        sourcePercent = sourcePercent/100
    end
    local totalnum = (curPoint > 0) and sourcePercent + (curPoint/100) or sourcePercent
    self.attr_value.text = color .. (totalnum ..'%')
end

---@public
---刷新UI
---@field  index 下标
---@field  talentData 已保存的数据 
---@field  curPoint 当前点数
function UIMilitaryRankTitleFlairTemplate:RefreshUI(index, talentData, curPoint)
    self.curIndex = index
    self.talentData = talentData
    self.attr_name.text = luaEnumColorType.Gray .. self.attributeName[index]
    local pointdata = curPoint == nil and 0 or curPoint
    self:SetAttrStr(talentData[index],pointdata)
    self.mShowNum.text=  pointdata > 0 and tostring(talentData[index])..("[00ff00]+")..tostring(pointdata) or tostring(talentData[index])
    local tempdata = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentTempData()
    local canAdd = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():SetChange(self.curIndex,talentData[index]+pointdata,1)
    self.mAddButtonGO.color = canAdd and LuaEnumUnityColorType.White or LuaEnumUnityColorType.DarkGray
    self.mReduceButtonGO.color = tempdata[index] > 0 and LuaEnumUnityColorType.White or LuaEnumUnityColorType.DarkGray
end

function UIMilitaryRankTitleFlairTemplate:OnDestroy()
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():ResetTalentTempData()
end



return UIMilitaryRankTitleFlairTemplate