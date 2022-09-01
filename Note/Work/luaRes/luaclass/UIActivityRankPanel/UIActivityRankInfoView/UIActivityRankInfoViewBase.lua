---@class UIActivityRankInfoViewBase
local UIActivityRankInfoViewBase = {}

--region 初始化

function UIActivityRankInfoViewBase:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIActivityRankInfoViewBase:InitParameters()
    self.BtnGap = { 15, 12 }
end

function UIActivityRankInfoViewBase:InitComponents()
    self.playername = self:Get("WidgetRoot/Root/totalTable/Top/playername", "Top_UILabel")
    self.uninname = self:Get("WidgetRoot/Root/totalTable/Top/uninname", "Top_UILabel")
    self.level = self:Get("WidgetRoot/Root/totalTable/Top/lb_lv", "Top_UILabel")
    self.headicon = self:Get("WidgetRoot/Root/totalTable/Top/headicon", "Top_UISprite")
    self.scrollViewTable = self:Get("WidgetRoot/Root/totalTable/ScrollView", "UITable")
    --self.childTable = self:Get("WidgetRoot/Root/totalTable/ScrollView/childTable", "UITable")
    self.GrildList = self:Get("WidgetRoot/Root/totalTable/ScrollView/childTable/GrildList", "Top_UIGridContainer")
    self.zhansun = self:Get("WidgetRoot/Root/totalTable/ScrollView/zhansun", "GameObject")
    self.zhansunGridContainer = self:Get("WidgetRoot/Root/totalTable/ScrollView/zhansun/Awards", "UIGridContainer")
    self.bg = self:Get("WidgetRoot/Root/window/background", 'Top_UISprite')
end

--endregion

--region Show

function UIActivityRankInfoViewBase:SetUI(data)
    if data == nil then
        return
    end
    self.go.transform.localPosition = CS.UnityEngine.Vector3(10000, 0, 0)
    self.zhansun.gameObject:SetActive(self:IsShowZhanSun())
    if data.settleInfo ~= nil then
        self.playername.text = data.settleInfo:GetName()
        self.headicon.spriteName = data.settleInfo:GetHeadIcon()
        self.level.text = tostring(data.settleInfo.level)
        self.level.gameObject:SetActive(data.settleInfo.level > 0);
        self.rid = data.settleInfo.rid
        self:RefreshChildInfo(data)
    end
    self:SetUnionInfo(data)
    self:RefreshOther(data)
    self.updataItem = CS.CSListUpdateMgr.Add(200, nil, function()
        if self.go == nil or CS.StaticUtility.IsNull(self.go) then
            return
        end
        CS.CSListUpdateMgr.Instance:Remove(self.updataItem)
        self.updataItem = nil
        self:AdaptiveOfItemCount()
        if self.scrollViewTable ~= nil then
            self.scrollViewTable:Reposition()
        end
        self.go.transform.localPosition = CS.UnityEngine.Vector3.zero
    end, false)
end
---设置行会信息
function UIActivityRankInfoViewBase:SetUnionInfo(data)
    self.uninname.text = ''
end

---设置详细子类型
function UIActivityRankInfoViewBase:RefreshChildInfo(data)
    local isFind, tabelInfo = CS.Cfg_activity_leaderboardTableManager.Instance.dic:TryGetValue(data.rankId)
    if not isFind then
        return
    end
    local des = string.Split(tabelInfo.list, '#')
    if self.GrildList ~= nil and not CS.StaticUtility.IsNull(self.GrildList.gameObject) and #des > 0 then
        self.GrildList.MaxCount = #des
        for i = 0, #des - 1 do
            local go = self.GrildList.controlList[i]
            if go ~= nil then
                CS.Utility_Lua.GetComponent(go.transform:Find("bg/Label"), "Top_UILabel").text = des[i + 1]
                local label = CS.Utility_Lua.GetComponent(go.transform:Find("information/Label"), "Top_UILabel")
                if label then
                    self:SetInfoValueUnit(label, i, data)
                end
            end
        end
    end
end

---刷新详细子类型数据
function UIActivityRankInfoViewBase:SetInfoValueUnit(lebel, index, data)
    if index == 0 then
        lebel.text = data.settleInfo.firstValue
    elseif index == 1 then
        lebel.text = data.settleInfo.secondValue
    elseif index == 2 then
        lebel.text = data.settleInfo.thirdValue
    end
end

---设置其他预留接口
function UIActivityRankInfoViewBase:RefreshOther(data)

end

---bg自适应
function UIActivityRankInfoViewBase:AdaptiveOfItemCount()
    if self.bg ~= nil and not CS.StaticUtility.IsNull(self.bg) and self.scrollViewTable ~= nil and not CS.StaticUtility.IsNull(self.scrollViewTable) then
        local totalHeight = CS.NGUIMath.CalculateRelativeWidgetBounds(self.scrollViewTable.transform).size.y
        totalHeight = math.floor(totalHeight)
        totalHeight = 80 + tonumber(totalHeight) + tonumber(self.BtnGap[1]) + tonumber(self.BtnGap[2])
        self.bg.height = math.floor(totalHeight)
    end
end

--endregion

--region otherFunction
---是否显示战勋列表
function UIActivityRankInfoViewBase:IsShowZhanSun()
    return false
end
--endregion

--region ondestroy

function UIActivityRankInfoViewBase:Clear()
    self.go = nil
    self.playername = nil
    self.uninname = nil
    self.level = nil
    self.headicon = nil
    self.totalTable = nil
    self.childTable = nil
    self.GrildList = nil
    self.zhansun = nil
    self.bg = nil
    self.BtnGap = nil
    self.rid = nil
    if self.updataItem ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.updataItem)
        self.updataItem = nil
    end
end

--endregion

return UIActivityRankInfoViewBase