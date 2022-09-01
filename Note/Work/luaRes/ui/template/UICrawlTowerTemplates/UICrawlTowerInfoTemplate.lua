---爬塔信息单元模板
local UICrawlTowerInfoTemplate = {}

--region 初始化
function UICrawlTowerInfoTemplate:Init(panel)
    ---UICrawlTowerPanel
    self.panel = panel
    self:InitComponents()
    self:InitUIEvent()
end

function UICrawlTowerInfoTemplate:InitComponents()
    self.Name_UILabel = self:Get("TitleName", "Top_UILabel")
    self.BGSprite = self:Get("background", "Top_UISprite")
    self.Redpoint = self:Get("redpoint", "GameObject")
end

function UICrawlTowerInfoTemplate:InitUIEvent()
    CS.UIEventListener.Get(self.go).onClick = function(go)
        self:GoOnClick(go)
    end
end
--endregion

--region 刷新界面
---@param data TABLE.cfg_tower
function UICrawlTowerInfoTemplate:Refresh(data)
    ---@type TABLE.cfg_tower
    self.tbldata = data
    local isfind, duplicateinfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(self.tbldata.duplicateId)
    if (isfind) then
        self.Name_UILabel.text = duplicateinfo.name
    end
    self:SetIsCanCrawl()
    self:RefreshBottom()
end

---刷新底图
function UICrawlTowerInfoTemplate:RefreshBottom()
    self.IsItemGirdHight = false
    if (self.isCanCrawl and self.IsThrough or self.tbldata.storey == self.panel:GetPlayerTowerData().level + 1) then
        if (self.IsThrough) then
            self.BGSprite.spriteName = "c5"
            self.Name_UILabel.text = "[878787]" .. self.Name_UILabel.text .. "[-]  [00ff00]通关[-]"
        else
            self.BGSprite.spriteName = "c3"
            self.Name_UILabel.text = "[c3f4ff]" .. self.Name_UILabel.text
        end
    else
        self.BGSprite.spriteName = "c5"
        self.Name_UILabel.text = "[878787]" .. self.Name_UILabel.text
    end
    self.BGSprite:MakePixelPerfect()
end

---设置是否开启
function UICrawlTowerInfoTemplate:SetIsCanCrawl()
    ---是否通过
    if (self.panel:GetPlayerTowerData().level >= self.tbldata.storey) then
        self.IsThrough = true
    else
        self.IsThrough = false
    end

    if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(self.tbldata.totalLv.list)) then
        self.isCanCrawl = true
        if (self.panel:GetPlayerTowerData().level + 1 == self.tbldata.storey) then
            self.Redpoint:SetActive(true)
        else
            self.Redpoint:SetActive(false)
        end
    else
        self.isCanCrawl = false
        self.Redpoint:SetActive(false)
    end
end

function UICrawlTowerInfoTemplate:ShowTips(trans, id, des)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans
    if des ~= nil then
        TipsInfo[LuaEnumTipConfigType.Describe] = des
    end
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UISignetPanel"
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end
--endregion

--region 客户端点击事件
function UICrawlTowerInfoTemplate:GoOnClick(go)
    if (self.isCanCrawl == false) then
        self:ShowTips(go.transform, 416, self.tbldata:GetTotalDes())
    else
        if (self.IsThrough) then
            self:ShowTips(go.transform, 416)
        else
            if (self.tbldata.storey == self.panel:GetPlayerTowerData().level + 1) then
                uimanager:CreatePanel("UIPromptCrawlTowerPanel")
            else
                self:ShowTips(go.transform, 412)
            end
        end
    end
end

--endregion


return UICrawlTowerInfoTemplate