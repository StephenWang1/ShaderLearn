---@class UIUnionPreselectedVotePanel_UnitTemplate  投票详情单元模板
local UIUnionPreselectedVotePanel_UnitTemplate = {}
setmetatable(UIUnionPreselectedVotePanel_UnitTemplate, luaComponentTemplates.UIRefreshTemplate)
--region 初始化

function UIUnionPreselectedVotePanel_UnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIUnionPreselectedVotePanel_UnitTemplate:InitParameters()
    self.allData = nil
end

function UIUnionPreselectedVotePanel_UnitTemplate:InitComponents()
    ---@type Top_UISprite 背景
    self.bg = self:Get("Background", "Top_UISprite")
    ---@type Top_UILabel 平台 + 行会名称
    self.unionInfo = self:Get("unionInfo", "Top_UILabel")
    ---@type Top_UILabel 繁荣度
    self.prosperity = self:Get("prosperity", "Top_UILabel")
    ---@type Top_UILabel 行会人数
    self.pepoleCount = self:Get("pepoleCount", "Top_UILabel")
    ---@type Top_UILabel 荣耀联盟人数
    self.gloryCount = self:Get("gloryCount", "Top_UILabel")
    ---@type Top_UILabel 自由联盟人数
    self.freeCount = self:Get("freeCount", "Top_UILabel")
    ---@type Top_UILabel 勇气联盟人数
    self.courageCount = self:Get("courageCount", "Top_UILabel")
    ---@type Top_UILabel 无畏联盟人数
    self.fearlessCount = self:Get("fearlessCount", "Top_UILabel")
end

function UIUnionPreselectedVotePanel_UnitTemplate:BindUIMessage()
    -- CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    -- CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
end

--endregion

--region Show

---@param data XLua.ILuaTable
---@field data.unionVoteInfo XLua.ILuaTable 自定义unionVoteInfo
---@field data.otherData     XLua.ILuaTable
---@field data.otherData.rank number
function UIUnionPreselectedVotePanel_UnitTemplate:SetTemplate(data)
    self.allData = data
    self:RefreshVoteView()
end

--endregion

---刷新视图
function UIUnionPreselectedVotePanel_UnitTemplate:RefreshVoteView()
    if self.allData == nil then
        return
    end
    if self.allData.unionVoteInfo ~= nil then

        local isMainPlayerUnion = CS.CSScene.MainPlayerInfo ~= nil and
                CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == self.allData.unionVoteInfo.unionId

        local color = isMainPlayerUnion and "[F8DEBC]" or luaEnumColorType.White

        ---获取服务器大区前缀
        local PlatformName, serverID = luaclass.RemoteHostDataClass:GetLianFuShowSInfoByHostId(self.allData.unionVoteInfo.hostId)
        local showStr = color .. PlatformName .. ' ' .. ' ' .. serverID .. ' ' .. self.allData.unionVoteInfo.unionName
        self:RefreshLabel(self.unionInfo, showStr)

        self:RefreshLabel(self.prosperity, color .. self.allData.unionVoteInfo.prosperityNum)
        self:RefreshLabel(self.pepoleCount, color .. self.allData.unionVoteInfo.unionCount)

        self:RefreshLabel(self.fearlessCount, color .. self.allData.unionVoteInfo.fearlessCount)
        self:RefreshLabel(self.courageCount, color .. self.allData.unionVoteInfo.courageCount)
        self:RefreshLabel(self.gloryCount, color .. self.allData.unionVoteInfo.gloryCount)
        self:RefreshLabel(self.freeCount, color .. self.allData.unionVoteInfo.freeCount)
    end
end

--region otherFunction

---刷新排行数据
function UIUnionPreselectedVotePanel_UnitTemplate:RefreshVoteData(data)
    if self.allData == nil then
        return
    end
    self.allData.unionVoteInfo = data
    self:RefreshVoteView()
end

--endregion

--region ondestroy

function UIUnionPreselectedVotePanel_UnitTemplate:onDestroy()

end

--endregion

return UIUnionPreselectedVotePanel_UnitTemplate