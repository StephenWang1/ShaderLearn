---@class UIBossPanel_LeftPageTemplate 左侧页签
local UIBossPanel_LeftPageTemplate = {}

--region 初始化

function UIBossPanel_LeftPageTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIBossPanel_LeftPageTemplate:InitParameters()
    self.selectPageType = nil
    self.allPageCheckMarkDic = {}
    ---每一页的数据对应的页数Obj
    self.mPageDataToGo = {}
end

function UIBossPanel_LeftPageTemplate:InitComponents()
    ---@type UILoopScrollViewPlus
    self.BookMarkLoopScrollViewPlus = self:Get("ScorllView/BookMark", "UILoopScrollViewPlus")
    ---@type Top_UIScrollView
    self.ScorllView = self:Get("ScorllView", "Top_UIScrollView")
    ---@type Top_UIScrollView
    self.springPanel = self:Get("ScorllView", "Top_SpringPanel")
end


--endregion

--region Show
---@param dataList table List
---@param OtherData table
---@alias{ShowStr:string,pageType:number,pageAllMonsterIsDead:boolean,ClickCallBack:Function,isShowRedPoint:boolean,RedPointEnum:number}
---ps:clickCallBack 为附带返回是否可跳转的回调
function UIBossPanel_LeftPageTemplate:SetTemplate(dataList, OtherData)
    self:InitParameters()
    if OtherData then
        ---用于跳转接口，暂不做处理
        self.selectType = OtherData.targetTyp
        ---@type LuaEnumBossType
        self.bossType = OtherData.bossType
    else
        self.selectType = nil
    end
    self.pageDataList = dataList

    self.ScorllView:ResetPosition()

    self.BookMarkLoopScrollViewPlus:ResetPage()

    if self.Initialized == nil then
        self.Initialized = true
        self:Init()
        self.BookMarkLoopScrollViewPlus:Init(function(go, line)
            return self:UpdataUnitTemplate(go, line)
        end)
    else
        self.BookMarkLoopScrollViewPlus:RefreshCurrentPage()
    end
end

--endregion

--region UI

---刷新单个模板
function UIBossPanel_LeftPageTemplate:UpdataUnitTemplate(go, line)
    if self.pageDataList == nil or go == nil or #self.pageDataList < line + 1 then
        return false
    end
    if line == 0 then
        if self.selectType == nil then
            self.selectType = self.pageDataList[line + 1].pageType
        end
    end
    local checkMark = CS.Utility_Lua.GetComponent(go.transform:Find("checkmark"), "GameObject")
    local checkMarkLabel = CS.Utility_Lua.GetComponent(go.transform:Find("checkmark/Label"), "Top_UILabel")
    local originMark = CS.Utility_Lua.GetComponent(go.transform:Find("background"), "GameObject")
    local originLabel = CS.Utility_Lua.GetComponent(go.transform:Find("background/Label"), "Top_UILabel")
    local darkMark = CS.Utility_Lua.GetComponent(go.transform:Find("noboss"), "GameObject")
    local darkLabel = CS.Utility_Lua.GetComponent(go.transform:Find("noboss/Label"), "Top_UILabel")

    darkLabel.text = luaEnumColorType.Gray4 .. self.pageDataList[line + 1].ShowStr

    originLabel.text = luaEnumColorType.Gray .. self.pageDataList[line + 1].ShowStr

    darkMark:SetActive(self.pageDataList[line + 1].pageAllMonsterIsDead)
    originMark:SetActive(not self.pageDataList[line + 1].pageAllMonsterIsDead)

    checkMarkLabel.text = self.pageDataList[line + 1].ShowStr

    checkMark:SetActive(self.targetType ~= nil and self.pageDataList[line + 1].pageType == self.targetType)

    if self.allPageCheckMarkDic[tonumber(self.pageDataList[line + 1].pageType)] == nil then
        self.allPageCheckMarkDic[tonumber(self.pageDataList[line + 1].pageType)] = checkMark
    end

    if self.mPageDataToGo[self.pageDataList[line + 1]] == nil then
        self.mPageDataToGo[self.pageDataList[line + 1]] = go
    end

    local redPoint = CS.Utility_Lua.GetComponent(go.transform:Find("redPoint"), "Top_UIRedPoint")
    if self.pageDataList[line + 1].RedPointEnum ~= nil then
        if redPoint then
            redPoint:RemoveRedPointKey()
            redPoint:AddRedPointKey(self.pageDataList[line + 1].RedPointEnum)
        end
    else
        redPoint:RemoveRedPointKey()
    end
    CS.UIEventListener.Get(go).onClick = function(go)
        self:OnClickPageCallBack(go, self.pageDataList[line + 1].pageType, self.pageDataList[line + 1].ClickCallBack)
    end

    if self.pageDataList[line + 1].pageType == self.selectType then
        self:OnClickPageCallBack(go, self.pageDataList[line + 1].pageType, self.pageDataList[line + 1].ClickCallBack)
    end
    return true
end

--endregion

function UIBossPanel_LeftPageTemplate:OnClickPageCallBack(go, type, callback)
    if callback ~= nil and callback(go) then
        ---页签处理
        local checkMarkGo = self.allPageCheckMarkDic[self.selectType]
        if checkMarkGo ~= nil and not CS.StaticUtility.IsNull(checkMarkGo) then
            checkMarkGo:SetActive(false)
        end
        checkMarkGo = self.allPageCheckMarkDic[type]
        if checkMarkGo ~= nil and not CS.StaticUtility.IsNull(checkMarkGo) then
            checkMarkGo:SetActive(true)
        end
        self.selectType = type
    end
end

--region ondestroy

function UIBossPanel_LeftPageTemplate:onDestroy()

end

--endregion

--region  页签选中
---@param subType number monster表中boss面板的副类型 CFG_MONSTERS/bossPosition
function UIBossPanel_LeftPageTemplate:ChooseSubTypeBookMark(subType)
    if self.pageDataList then
        for i = 1, #self.pageDataList do
            local pageData = self.pageDataList[i]
            if pageData.pageType == subType then
                local line = i - 5
                if line < 0 then
                    line = 0
                end
                if line >= #self.pageDataList - 10 then
                    line = #self.pageDataList - 9
                end
                self.BookMarkLoopScrollViewPlus:JumpToLine(line)
                if self.mPageDataToGo then
                    local go = self.mPageDataToGo[pageData]
                    if go then
                        self:OnClickPageCallBack(go, pageData.pageType, pageData.ClickCallBack)
                    end
                end
                return
            end
        end
    end
end

--region 查询
---@param bossType LuaEnumBossType boss类型
---@return boolean 是否是同一个boss类型
function UIBossPanel_LeftPageTemplate:IsSameBossType(bossType)
    return self.bossType == bossType
end
--endregion

--region 数据清理
---数据清理
function UIBossPanel_LeftPageTemplate:ResetData()
    self.bossType = nil
end
--endregion

return UIBossPanel_LeftPageTemplate