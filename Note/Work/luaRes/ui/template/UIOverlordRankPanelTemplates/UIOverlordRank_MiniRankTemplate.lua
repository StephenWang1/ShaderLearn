---@class UIOverlordRank_MiniRankTemplate  迷你排行界面
local UIOverlordRank_MiniRankTemplate = {}

--region 初始化

function UIOverlordRank_MiniRankTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIOverlordRank_MiniRankTemplate:InitParameters()
    --self.arrowPos = { -47, ,-291 }
    self.isInit = true
    self.unitTemplateDic = {}
end

function UIOverlordRank_MiniRankTemplate:InitComponents()
    ---@type Top_UISprite
    self.bg = self:Get("background", "Top_UISprite")
    ---@type UILoopScrollViewPlus
    self.firstRankMiddle = self:Get("view/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject
    self.arrow = self:Get("arrow", "GameObject")
    ---@type UnityEngine.GameObject
    self.blackbox = self:Get("blackbox", "GameObject")
end

function UIOverlordRank_MiniRankTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.bg.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.bg.gameObject).OnClickLuaDelegate = self.OnBGClick
    CS.UIEventListener.Get(self.blackbox.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.blackbox.gameObject).OnClickLuaDelegate = self.OnBGClick
end

function UIOverlordRank_MiniRankTemplate:OnBGClick()
    self:SetShowState(false)
end

--endregion

--region view

function UIOverlordRank_MiniRankTemplate:SetShowState(isopen)
    self.go:SetActive(isopen)
end

---刷新排行
function UIOverlordRank_MiniRankTemplate:RefreshRankView(info)
    if info == nil or info.Count == 0 then
        self:SetShowState(false)
        return
    end
    self.rankInfo = info
    if self.isInit then
        self.isInit = false
        self.firstRankMiddle:Init(function(go, line)
            return self:RankTempCallBack(go, line)
        end)
    else
        self.firstRankMiddle:ResetPage()
    end
    self:SetPos()
    self:SetShowState(true)
end

function UIOverlordRank_MiniRankTemplate:RankTempCallBack(go, line)
    if go == nil or CS.StaticUtility.IsNull(go) or self.rankInfo.Count - 1 < line then
        return false
    end
    local rankTemp
    if self.unitTemplateDic[go] == nil then
        rankTemp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIOverlordRank_UnitTemplate)
        self.unitTemplateDic[go] = rankTemp
    else
        rankTemp = self.unitTemplateDic[go]
    end
    local temp = {}
    temp.rankIndex = line + 1
    temp.rankInfo = self.rankInfo[line]
    --temp.ClickGoCallBack = function()
    --end
    temp.useTemplate = uiStaticParameter.UIRankManager:GetLuaUnitClassOfLeaderRankType(4)
    rankTemp:SetTemplate(temp)
    return true
end

function UIOverlordRank_MiniRankTemplate:SetPos()
    local panel = uimanager:GetPanel("UIOverlordRankPanel")
    if panel == nil or panel.curRankTbl == nil then
        return
    end

    --最高点y
    local scrollHeightPosy = panel.hightPoint.position.y
    --最低点y
    local scrollLowPosy = panel.lowPoint.position.y

    local bgheight = self.bg.transform:TransformVector({ x = 0, y = self.bg.height, z = 0 }).y

    local UnitLowposy = panel.curRankTbl.lowPoint.position.y
    local UnitHeightposy = panel.curRankTbl.hightPoint.position.y

    local targetPosx = panel.curRankTbl.lowPoint.position.x
    local targetPosy = 0

    if UnitHeightposy < scrollHeightPosy and UnitHeightposy - bgheight >= scrollLowPosy then
        --单元上方
        targetPosy = UnitHeightposy
    elseif UnitHeightposy >= scrollHeightPosy then
        --面板顶部
        targetPosy = scrollHeightPosy
    elseif UnitLowposy > scrollLowPosy and UnitLowposy + bgheight <= scrollHeightPosy then
        --单元下方顶部
        targetPosy = UnitLowposy + bgheight
    else
        --面板底部
        targetPosy = scrollLowPosy + bgheight
    end
    self.go.transform.position = { x = targetPosx, y = targetPosy, z = 0 }

    --region 箭头坐标
    local bgy = panel.curRankTbl.bg.transform:TransformVector({ x = 0, y = panel.curRankTbl.bg.height, z = 0 }).y
    local arrowy = UnitHeightposy - bgy / 2
    arrowy = arrowy <= scrollLowPosy and scrollLowPosy or arrowy
    self:SetArrorPos(UnitHeightposy - bgy / 2)
    --endregion

end

function UIOverlordRank_MiniRankTemplate:SetArrorPos(arrowy)
    local pos = self.arrow.transform.position
    self.arrow.transform.position = { x = pos.x, y = arrowy, z = 0 }
end

--endregion

--region ondestroy

function UIOverlordRank_MiniRankTemplate:onDestroy()

end

--endregion

return UIOverlordRank_MiniRankTemplate