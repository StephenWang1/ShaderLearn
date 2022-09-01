local UICrawlTowerLeftPanelStarInfoTemplate = {}

function UICrawlTowerLeftPanelStarInfoTemplate:Init(panel)
    self.panel = panel
    self:InitData()
    self:InitComponent()
end

function UICrawlTowerLeftPanelStarInfoTemplate:InitData()
    self.Startype = nil
    self.StarShowParam = 0
end

function UICrawlTowerLeftPanelStarInfoTemplate:InitComponent()
    self.StarSprite = self:Get("", "Top_UISprite")
    self.des = self:Get("Label", "Top_UILabel")
end

---@param data TABLE.IntList
---@param des string
function UICrawlTowerLeftPanelStarInfoTemplate:Refresh(data, des)
    self.des.text = des
    if (data.list[1] == 1) then
        self.StarSprite.spriteName = "star"
        self.Startype = LuaEnumTowerLeftPanelStarType.Boss
    elseif (data.list[1] == 2) then
        self.StarSprite.spriteName = "star"
        self.Startype = LuaEnumTowerLeftPanelStarType.HP
    elseif (data.list[1] == 3) then
        self.StarSprite.spriteName = "star"
        self.Startype = LuaEnumTowerLeftPanelStarType.Time
        self.StarTime = CS.CSServerTime.Now
        self.IenumRefreshTime = StartCoroutine(self.IEnumUpdataTime, self)
    end
    self.StarShowParam = data.list[2]
end

function UICrawlTowerLeftPanelStarInfoTemplate:SetStarShow(iskill, hprate, time)
    if (self.Startype == LuaEnumTowerLeftPanelStarType.Boss) then
        self:StopCortinueToRefresh()
        if (iskill ~= nil and iskill) then
            self.StarSprite.spriteName = "star1"
        else
            self.StarSprite.spriteName = "star"
        end
    elseif (self.Startype == LuaEnumTowerLeftPanelStarType.HP) then
        if (hprate ~= nil and hprate >= self.StarShowParam / 100) then
            self.StarSprite.spriteName = "star"
        else
            self.StarSprite.spriteName = "star1"
        end
    elseif (self.Startype == LuaEnumTowerLeftPanelStarType.Time) then
        if (time ~= nil and (CS.CSServerTime.Now - time).Seconds >= self.StarShowParam) then
            self.StarSprite.spriteName = "star1"
            self:StopCortinueToRefresh()
        else
            self.StarSprite.spriteName = "star"
        end
    end
end

---开启协程
function UICrawlTowerLeftPanelStarInfoTemplate:IEnumUpdataTime()
    while (true) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.5))
        self:SetStarShow(nil, nil, self.StarTime)
    end
end

---关闭协程
function UICrawlTowerLeftPanelStarInfoTemplate:StopCortinueToRefresh()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

function UICrawlTowerLeftPanelStarInfoTemplate:OnDestroy()
    self:StopCortinueToRefresh()
end

return UICrawlTowerLeftPanelStarInfoTemplate