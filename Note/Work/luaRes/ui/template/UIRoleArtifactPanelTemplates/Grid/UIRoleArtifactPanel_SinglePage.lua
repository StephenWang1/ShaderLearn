---@class UIRoleArtifactPanel_SinglePage:TemplateBase 单个页签模板
local UIRoleArtifactPanel_SinglePage = {}
--region 数据
---@type table 页签数据
UIRoleArtifactPanel_SinglePage.pageConfigInfo = nil
---@type string 页签名字
UIRoleArtifactPanel_SinglePage.btnName = nil
---@type LuaEnumMagicEquipSuitType 套装类型
UIRoleArtifactPanel_SinglePage.suitType = nil
--endregion

--region 组件
---按钮toggle
---@return UIToggle
function UIRoleArtifactPanel_SinglePage:GetBtn_UIToggle()
    if CS.StaticUtility.IsNull(self.Btn_UIToggle) then
        self.Btn_UIToggle = self:Get("", "UIToggle")
    end
    return self.Btn_UIToggle
end

---背景按钮名字
---@return UILabel
function UIRoleArtifactPanel_SinglePage:GetBackGroundBtnName_UILabel()
    if CS.StaticUtility.IsNull(self.BackGroundBtnName_UILabel) then
        self.BackGroundBtnName_UILabel = self:Get("Background/Label", "UILabel")
    end
    return self.BackGroundBtnName_UILabel
end

---按钮名字
---@return UILabel
function UIRoleArtifactPanel_SinglePage:GetBtnName_UILabel()
    if CS.StaticUtility.IsNull(self.BtnName_UILabel) then
        self.BtnName_UILabel = self:Get("Foreground/Label", "UILabel")
    end
    return self.BtnName_UILabel
end

---红点
---@return UnityEngine.GameObject
function UIRoleArtifactPanel_SinglePage:GetRedPoint_RedPoint()
    if CS.StaticUtility.IsNull(self.RedPoint_RedPoint) then
        self.RedPoint_RedPoint = self:Get("redpoint", "UIRedPoint")
    end
    return self.RedPoint_RedPoint
end
--endregion

--region 初始化
function UIRoleArtifactPanel_SinglePage:Init()
    self:BindEvents()
    self:InitParams()
end

function UIRoleArtifactPanel_SinglePage:BindEvents()
    CS.EventDelegate.Add(self:GetBtn_UIToggle().onChange, function()
        if self:GetBtn_UIToggle().value then
            self:PageOnClick()
        end
    end)
end

function UIRoleArtifactPanel_SinglePage:InitParams()

end

---页签按钮点击
function UIRoleArtifactPanel_SinglePage:PageOnClick()
    luaEventManager.DoCallback(LuaCEvent.MagicEquipPageClicked, { pageConfigInfo = self.pageConfigInfo })
end
--endregion

--region 刷新
---刷新面板
---@param commonData table 通用数据
---@param commonData.pageConfigInfo table 策划表数据
---@param commonData.chooseState boolean 默认选择状态
function UIRoleArtifactPanel_SinglePage:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshBtnName(self.btnName)
    self:BindLuaRedPoint()
    if commonData.chooseState ~= nil then
        self:SetBtnState(commonData.chooseState)
    end
end

---解析参数
---@param commonData table 通用参数
---@return boolean 解析状态
function UIRoleArtifactPanel_SinglePage:AnalysisParams(commonData)
    if commonData == nil or commonData.pageConfigInfo == nil or commonData.pageConfigInfo.pageName == nil then
        return false
    end
    self.pageConfigInfo = commonData.pageConfigInfo
    self.btnName = commonData.pageConfigInfo.pageName
    self.suitType = commonData.pageConfigInfo.type
    return true
end

---刷新按钮名字
---@param btnName string 按钮名字
function UIRoleArtifactPanel_SinglePage:RefreshBtnName(btnName)
    if CS.StaticUtility.IsNull(self:GetBtnName_UILabel()) == false then
        self:GetBtnName_UILabel().text = btnName
    end
    if CS.StaticUtility.IsNull(self:GetBackGroundBtnName_UILabel()) == false then
        self:GetBackGroundBtnName_UILabel().text = btnName
    end
end

---设置按钮状态
---@param state boolean 按钮状态
function UIRoleArtifactPanel_SinglePage:SetBtnState(state)
    if CS.StaticUtility.IsNull(self:GetBtn_UIToggle()) == false then
        self:GetBtn_UIToggle():Set(state, false)
    end
end

---绑定lua红点
---@private
function UIRoleArtifactPanel_SinglePage:BindLuaRedPoint()
    local magicEquipRedEnum = uiStaticParameter.magicEquipRedPointDic[self.suitType]
    local magicEquip_AllKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(magicEquipRedEnum);
    self:GetRedPoint_RedPoint():AddRedPointKey(magicEquip_AllKey)
end

--endregion

return UIRoleArtifactPanel_SinglePage