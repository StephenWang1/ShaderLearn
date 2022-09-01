---@class UIBuffInfoTemplate Buff信息面板
local UIBuffInfoTemplate = {}
--region 局部变量
---@type table<UnityEngine.GameObject,UISingleBuffInfoTemplate> 当前存储的buff列表
UIBuffInfoTemplate.BuffTemplate = nil
--endregion

--region 初始化
function UIBuffInfoTemplate:Init()
    self:InitComponents(self.go)
    self:BindBtnEvent()
    --this:SetDepth()
    self.IsInitBg = true
end

function UIBuffInfoTemplate:InitComponents(go)
    self.mainpart_GameObject = go.transform
    --this.mainpart_UIPanel = go.transform:GetComponent("UIPanel")
    self.root_GameObject = CS.Utility_Lua.GetComponent(go.transform:Find("root"), "GameObject")
    self.scrollView_UIPanel = CS.Utility_Lua.GetComponent(go.transform:Find("root/Scroll View"), "UIPanel")
    self.ItemGird_UIGridContainer = CS.Utility_Lua.GetComponent(go.transform:Find("root/Scroll View/itemGrid"), "UIGridContainer")
    self.CloseBtn_GameObject = CS.Utility_Lua.GetComponent(go.transform:Find("root/event/CloseBtn"), "Transform")
    self.GridTable = CS.Utility_Lua.GetComponent(go.transform:Find("root/Scroll View/itemGrid"), "UITable")
    self.bg = CS.Utility_Lua.GetComponent(go.transform:Find("root/window/background"), "Top_UISprite")
    self.downframe = CS.Utility_Lua.GetComponent(go.transform:Find("root/window/outframe1"), "Top_UISprite")
end

function UIBuffInfoTemplate:BindBtnEvent()
    CS.UIEventListener.Get(self.CloseBtn_GameObject.gameObject).onClick = function()
        self.mainpart_GameObject.gameObject:SetActive(false)
    end
end
--endregion

--region 刷新
---@param buffDic CustomBuffInfo
function UIBuffInfoTemplate:Show(buffDic, rid)
    self.lid = rid == nil and 0 or rid
    self:RefreshBuffList(buffDic)
end

function UIBuffInfoTemplate:RefreshBuffList(buffDic)
    ---@type table<UILabel,CSBuffInfoItem>
    self.TimeDic = {}
    local index = 0
    local bgAutoAdjust = Utility.GetLuaTableCount(buffDic) ~= self.lastBuffListCount
    self.lastBuffListCount = Utility.GetLuaTableCount(buffDic)
    if buffDic ~= nil then
        if #buffDic == 0 then
            return
        end
        if self.ItemGird_UIGridContainer ~= nil then
            self.ItemGird_UIGridContainer.MaxCount = #buffDic
            for k, v in pairs(buffDic) do
                if v ~= nil and v.buffInfo.tbl_buff then
                    self:SaveAllTxtAndBuffClass(self.ItemGird_UIGridContainer.controlList[index], v, #buffDic)
                    self:RefreshSingleBuffInfo(self.ItemGird_UIGridContainer.controlList[index], v.buffInfo.tbl_buff, v)
                end
                index = index + 1
            end
        end
        self.GridTable:Reposition()
        ---背景图自适应
        CS.CSListUpdateMgr.Add(100, nil, function()
            if bgAutoAdjust == true and self.GridTable and CS.StaticUtility.IsNull(self.GridTable) == false then
                self.GridTable:Reposition()
                if self.IsInitBg and self.delayRefresh == nil then
                    self.root_GameObject.transform.localPosition = CS.UnityEngine.Vector3(100000, 0, 0)
                    self.delayRefresh = CS.CSListUpdateMgr.Add(100, nil, function()
                        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
                        self.delayRefresh = nil
                        self.IsInitBg = false
                        self:BgAdaptive()
                        self.root_GameObject.transform.localPosition = CS.UnityEngine.Vector3.zero
                    end, false)
                else
                    self:BgAdaptive()
                end
            end
        end, false)
    end
end

---@param BuffClass CustomBuffInfo
function UIBuffInfoTemplate:SaveAllTxtAndBuffClass(buffInfoPanel, BuffClass, buffCount)
    if buffInfoPanel ~= nil then
        local time = CS.Utility_Lua.GetComponent(buffInfoPanel.transform:Find("baseInfo/Time"), "UILabel")
        if self.TimeDic ~= nil and BuffClass.buffInfo ~= nil then
            -- local isBloodStone = BuffClass.type == 1 and BuffClass.buffInfo.tbl_buff.type == LuaEnumBuffType.BloodStone
            local isDounbleExp = BuffClass.type == 2 and (BuffClass.buffInfo.type == LuaEnumBuffType.DounbleExp)
            local isZero = (BuffClass.type == 1 and BuffClass.buffInfo.tbl_buff.totalTime == 0) or
                    (BuffClass.type == 2 and (BuffClass.buffInfo.totalTime == 0 or BuffClass.buffInfo.totalTime == nil))
            ---自动拾取 totalTime =0表示永久的不需要倒计时，否则需要倒计时
            local isAutoPick = BuffClass.buffInfo.tbl_buff.type == LuaEnumBuffType.AutoPick and BuffClass.buffInfo.Info.totalTime ~= 0
            ---自动回收 totalTime =0表示永久的不需要倒计时，否则需要倒计时
            local isAutoRecycle = BuffClass.buffInfo.tbl_buff.type == LuaEnumBuffType.AutoRecycle and BuffClass.buffInfo.Info.totalTime ~= 0
            local needStop = (isDounbleExp or isZero)
            if isAutoPick or isAutoRecycle then
                needStop = false
            end
            if needStop then
                time.text = ''
                local panel = uimanager:GetPanel('UIBuffTipsPanel')
                if panel then
                    if buffCount == 1 then
                        panel.StopRefreshTime()
                    else
                        panel.StartRefreshTime()
                    end
                end
            else
                self.TimeDic[time] = BuffClass.buffInfo
                self:RefreshTime()
                ---@type UIBuffTipsPanel
                local panel = uimanager:GetPanel('UIBuffTipsPanel')
                if panel then
                    panel.StartRefreshTime()
                end
            end
        end
    end
end

---@param buffInfoPanel UnityEngine.GameObject
---@param buffTab TABLE.CFG_BUFF
---@param BuffClass CustomBuffInfo
function UIBuffInfoTemplate:RefreshSingleBuffInfo(buffInfoPanel, buffTab, BuffClass)
    if CS.StaticUtility.IsNull(buffInfoPanel) or buffTab == nil or BuffClass == nil then
        luaclass.UIRefresh:RefreshActive(buffInfoPanel, false)
        return
    end
    if self.BuffTemplate == nil then
        self.BuffTemplate = {}
    end
    local singleBuffTemplate = self.BuffTemplate[buffInfoPanel]
    if singleBuffTemplate == nil then
        singleBuffTemplate = templatemanager.GetNewTemplate(buffInfoPanel, luaComponentTemplates.UISingleBuffInfoTemplate)
    end
    if singleBuffTemplate ~= nil then
        singleBuffTemplate:RefreshSingleBuffInfo(buffTab, BuffClass, self.lid)
    end
end

---刷新UI时间
function UIBuffInfoTemplate:RefreshTime()
    for k, v in pairs(self.TimeDic) do
        if k ~= nil and v ~= nil then
            k.text = v:GetRemainTime()
        end
    end
end
--endregion

--region 功能
function UIBuffInfoTemplate:uILvPackPanel()
    if self.muILvPackPanel == nil then
        self.muILvPackPanel = uimanager:GetPanel("UILvPackPanel")
    end
    return self.muILvPackPanel
end

function UIBuffInfoTemplate:uILvPackPanel_UIPanel()
    if self.muILvPackPanel_UIPanel == nil then
        if self.uILvPackPanel() ~= nil then
            self.muILvPackPanel_UIPanel = CS.Utility_Lua.GetComponent(self:uILvPackPanel().go, "UIPanel")
        end
    end
    return self.muILvPackPanel_UIPanel
end

function UIBuffInfoTemplate:SetDepth()
    if self:uILvPackPanel() ~= nil then
        local uILvPackPanel_depth = self:uILvPackPanel_UIPanel().depth
        self.mainpart_UIPanel.depth = uILvPackPanel_depth
        self.scrollView_UIPanel.depth = uILvPackPanel_depth + 1
    end
end

---背景自适应
function UIBuffInfoTemplate:BgAdaptive()
    if self.bg == nil or CS.StaticUtility.IsNull(self.bg) then
        return
    end
    local totalHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self.GridTable.transform).size.y
    totalHeight = math.floor(totalHeight)
    totalHeight = tonumber(totalHeight) + 10 + 10
    totalHeight = totalHeight > 346 and 346 or totalHeight
    self.bg.height = math.floor(totalHeight)
    self.downframe:UpdateAnchors()
end
--endregion

--region OnDestroy
function UIBuffInfoTemplate:OnDestroy()
    self.mainpart_GameObject = nil
    --this.mainpart_UIPanel = nil
    self.scrollView_UIPanel = nil
    self.ItemGird_UIGridContainer = nil
    self.CloseBtn_GameObject = nil
    self.TimeDic = nil
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
    end
end
--endregion

--region 获取
---@param lid number buff唯一id
---@return UnityEngine.GameObject
function UIBuffInfoTemplate:GetBuffGameObject(lid)
    if type(self.BuffTemplate) ~= 'table' then
        return
    end
    for k, v in pairs(self.BuffTemplate) do
        ---@type UISingleBuffInfoTemplate
        local buffTemplate = v
        if buffTemplate:IsSameBuffer(lid) == true then
            return k
        end
    end
end

---@param lid number buff唯一id
---@return UISingleBuffInfoTemplate
function UIBuffInfoTemplate:GetBuffTemplate(lid)
    local buffGameObject = self:GetBuffGameObject(lid)
    if buffGameObject == nil then
        return
    end
    return self.BuffTemplate[buffGameObject]
end
--endregion

--region 查询
---当前是否拥有对应的buff
---@param lid number buff唯一id
---@return boolean
function UIBuffInfoTemplate:HaveBuff(lid)
    return self:GetBuffGameObject(lid) ~= nil
end
--endregion

return UIBuffInfoTemplate