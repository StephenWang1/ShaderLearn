---@class UIChallengeBoss_ShengXiaoBossTemplate:UIChallengeBossBaseTemplates 终极boss基础模板
local UIChallengeBoss_ShengXiaoBossTemplate = {}

setmetatable(UIChallengeBoss_ShengXiaoBossTemplate, luaComponentTemplates.UIChallengeBossBaseTemplates)

--region 初始化
function UIChallengeBoss_ShengXiaoBossTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---地图信息按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---地图名称
    self.lab_name = self:Get("btn_go/lab_name", "UILabel")
    ---地图怪物数量
    self.lab_num = self:Get("btn_go/lab_num", "UILabel")
    ---掉落道具展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "UIGridContainer")
    ---@type UIGridSpriteTiled bg平铺替换
    self.dropItemTiled = self:Get("dropScroll/DropItem", "UIGridSpriteTiled")
    ---UIScrollView
    self.UIScrollView = self:Get("dropScroll", "UIScrollView")
    ---@type UISprite
    self.BlackModel_UISprite = self:Get("BlackModel", "Top_UISprite")
    ---@type UILabel
    self.BossRoomNum_UILabel = self:Get("RoomNum", "UILabel")
    ---@type UISprite 按钮背景图
    self.backGround_UISprite = self:Get("btn_go/backGround", "UISprite")
    ---@type Top_UILabel 怪物进度条文本
    self.bossNumSlider_UIlabel = self:Get("Slider/Num", "UILabel")
end

function UIChallengeBoss_ShengXiaoBossTemplate:InitOther()
    self:RunBaseFunction("InitOther")
end

function UIChallengeBoss_ShengXiaoBossTemplate:UIEvent()

end
--endregion

--region 刷新
---@param data table<number,bossV2.FieldBossInfo>
---@alias commonData {bossSubtype LuaEnumFinalBossType}
function UIChallengeBoss_ShengXiaoBossTemplate:RefreshUI(data, ClipShader)
    gameMgr:GetPlayerDataMgr():GetBossDataManager():SaveIsOpen()
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_ShengXiao))
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    self:RefreshBtnName()
    self:RefreshBossDrop()
end

function UIChallengeBoss_ShengXiaoBossTemplate:RefreshBtnName()
    if self.mapBtnInfoList == nil then
        return
    end
    local monsterInfo = self.mapBtnInfoList[1]
    local mapNameList = _fSplit(monsterInfo.Info:GetMapName(), "#")
    local name = ""
    local numberColor = ""
    local spriteName = ""
    local bossNum = monsterInfo.number
    local mainPlayerCanMeet = self:IsMeetCondition(monsterInfo.Info)
    if bossNum > 0 and mainPlayerCanMeet == true then
        ---有存活且可进入
        numberColor = "[00ff00]"
        spriteName = "bo1"
        name = tostring(mapNameList[1])
    elseif bossNum > 0 and mainPlayerCanMeet == false then
        ---有存货且不可进
        numberColor = "[00ff00]"
        spriteName = "bo1"
        name = tostring(mapNameList[3])
    elseif bossNum <= 0 then
        ---没有存活
        numberColor = "[878787]"
        spriteName = "bo2"
        name = tostring(mapNameList[2])
    end
    self.lab_name.text = name
    self.lab_num.text = numberColor .. monsterInfo.number .. "只"
    self.backGround_UISprite.spriteName = spriteName
    CS.UIEventListener.Get(self.btn_go).OnClickLuaDelegate = function()
        self:ClickOperation(monsterInfo.Info, self.btn_go)
    end
end

function UIChallengeBoss_ShengXiaoBossTemplate:RefreshBossDrop()
    if self.monsterTable == nil then
        return
    end
    local monsterTbl = self.monsterTable
    local itemList = Utility.GetBossPanelDropList(monsterTbl.id)
    if itemList == nil then
        return
    end
    self.dropItemGrid.MaxCount = #itemList
    if self.dropItemTiled~=nil then
        self.dropItemTiled.MaxCount = #itemList
    end
    for k, v in pairs(itemList) do
        if v ~= nil then
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v)
            local go = self.dropItemGrid.controlList[k - 1]
            if infobool then
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, 1)
                temp:RefreshOtherUI({ showItemInfo = iteminfo })
            end
        end
    end

end

return UIChallengeBoss_ShengXiaoBossTemplate