---@class UIHatredPanelViewTemplate:TemplateBase 仇人面板视图模板
local UIHatredPanelViewTemplate = {}

--region 初始化

function UIHatredPanelViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIHatredPanelViewTemplate:InitParameters()
    self.templateDic = {}
    self.hatredTemplateDic = {}
    self.mapNpcId = 0
    self.isInitLoop = true
    self.sort = function(a, b)
        if a == nil or b == nil then
            return false
        end
        if (a.isOnline and b.isOnline) or (not a.isOnline and not b.isOnline) then
            return a.friendLove < b.friendLove
        else
            return a.isOnline
        end
    end
end

function UIHatredPanelViewTemplate:InitComponents()
    ---@type UILoopScrollViewPlus
    self.players = self:Get("Scroll View/player", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject 无仇人背景
    self.wards1 = self:Get("wards1", "GameObject")
end

function UIHatredPanelViewTemplate:SetTemplate(customData)
    if customData then
        self.mapNpcId = customData.mapNpcId == nil and 0 or customData.mapNpcId
    end
end

--endregion

--region UI

function UIHatredPanelViewTemplate:RefreshGrid()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil or self.players == nil then
        return
    end

    ---@type table<number,friendV2.FriendInfo>
    local enemyDic = CS.CSScene.MainPlayerInfo.FriendInfoV2.EnemyDic
    self.wards1:SetActive(enemyDic.Count == 0)
    self.enemyList = self:SortList(enemyDic)
    --self.allArrestList = CS.CSScene.MainPlayerInfo.FriendInfoV2.AllArrestVOList
    if self.isInitLoop then
        self.isInitLoop = false
        self.players:Init(function(go, line)
            return self:RefreshTemplate(go, line)
        end)
    else
        self.players:RefreshCurrentPage()
    end
end

function UIHatredPanelViewTemplate:RefreshTemplate(go, line)
    if go == nil or #self.enemyList < line + 1 then
        return false
    end
    local value = self.enemyList[line + 1]
    local temp = self.hatredTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIHatredPlayerUnitTemplate) or self.hatredTemplateDic[go]
    local callBack = function()
        self:RefreshBtnShow(go)
    end
    temp:SetTemplate(value, line + 1, callBack, self.mapNpcId)
    if self.hatredTemplateDic[go] == nil then
        self.hatredTemplateDic[go] = temp
    end
    self.templateDic[value.rid] = temp
    return true
end

--endregion

--region UI函数监听

--endregion

--region otherFunction

function UIHatredPanelViewTemplate:SetPanelState(isOpen)
    self.go:SetActive(isOpen)
end

--仇人列表排序
function UIHatredPanelViewTemplate:SortList(enemyDic)
    local enemyList = {}
    if enemyDic ~= nil and enemyDic.Count ~= 0 then
        for i, v in pairs(enemyDic) do
            ---@type friendV2.FriendInfo
            local friendInfo = v
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                if friendInfo.level >= 70 then
                    table.insert(enemyList, v)
                end
            else
                table.insert(enemyList, v)
            end
        end
        table.sort(enemyList, self.sort)
    end
    return enemyList
end

function UIHatredPanelViewTemplate:RefreshPlayFriendLove(info)
    local unitTemp = self.templateDic[info.targetId]
    if unitTemp then
        unitTemp:ChangeFriendLove(info.friendLove)
    end
end

--刷新按钮列表
function UIHatredPanelViewTemplate:RefreshBtnShow(go)
    for i, v in pairs(self.hatredTemplateDic) do
        v:SetShowTemplate(i == go)
    end
end

--endregion

return UIHatredPanelViewTemplate