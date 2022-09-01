---@class UIBagMain_Skill:UIBagMain_Normal
local UIBagMain_Skill = {}

setmetatable(UIBagMain_Skill, luaComponentTemplates.UIBagMainNormal)

--region 字段
local Utility = Utility
local LuaEnumCareer = LuaEnumCareer
local luaEnumItemType = luaEnumItemType
local LuaEnumMainHint_BetterBagItemType = LuaEnumMainHint_BetterBagItemType

---@return CSBagItemHint
function UIBagMain_Skill:GetBagItemHint()
    if self.mBagItemHint == nil then
        self.mBagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    end
    return self.mBagItemHint
end

---主角的职业
UIBagMain_Skill.mMainPlayerCareer = nil
--endregion

--region 重写初始化方法
function UIBagMain_Skill:OnInit()
    self:RunBaseFunction("OnInit")
    self.mMainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
end
--endregion

--region 重写属性
---不使用服务器排序
function UIBagMain_Skill:IsUseServerOrder()
    return false
end
--endregion

--region 重写筛选方法
---只筛选出职业吻合的技能书
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
-- function UIBagMain_Skill:BagItemFilterFunction(bagItemInfo, itemInfo)
--     if itemInfo.type == luaEnumItemType.SkillBook and (itemInfo.career == LuaEnumCareer.Common or itemInfo.career == self.mMainPlayerCareer)  and itemInfo.subType ==0 then
--         return true
--     end
--     return false
-- end
--endregion

--region 重写格子排序方法
function UIBagMain_Skill:BagItemListSortFunction(LeftItem, RightItem)
    local leftIsSkillBook = self:IsSkillBook(LeftItem.ItemTABLE)
    local rightIsSkillBook = self:IsSkillBook(RightItem.ItemTABLE)
    if leftIsSkillBook == rightIsSkillBook and rightIsSkillBook == true then
        return false
    end
    if leftIsSkillBook == true then
        return true
    elseif rightIsSkillBook == true then
        return false
    else
        return false
    end
end

function UIBagMain_Skill:IsSkillBook(itemInfo)
    if itemInfo.type == luaEnumItemType.SkillBook and (itemInfo.career == LuaEnumCareer.Common or itemInfo.career == self.mMainPlayerCareer)
            and Utility.SkillBookCanUse(itemInfo.id) then
        return true
    end
    return false
end
--endregion

--region 重写刷新方法
---刷新所有格子之前,获取推荐学习的技能书列表
function UIBagMain_Skill:BeforeRefreshAllGrids()
    if self.mList == nil then
        self.mList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    else
        self.mList:Clear()
    end
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BagInfo:FilterUseableSkillBooks(self.mList)
    end
end

---刷新单个格子时,若为有提示的技能书,则显示推荐特效
function UIBagMain_Skill:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if not self:IsSkillBook(itemTbl) then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    else
        if self.mList ~= nil then
            for i = 1, self.mList.Count do
                if self.mList[i - 1] == bagItemInfo.lid then
                    bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
                    break
                end
            end
            --for i = 0, self.mList.Count - 1 do
            --    local temp = self.mList[i]
            --    if temp and bagItemInfo.lid == temp then
            --        bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
            --        break
            --    end
            --end
        end
    end
end
--endregion

--region 重写关闭按钮显示
---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_Skill:IsShowCloseButton()
    return false
end
--endregion

--region 重写扩展按钮显示
---@public
---@return boolean
function UIBagMain_Skill:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Skill:IsShowRecycleButton()
    return false
end
--endregion

--region 重写销毁方法
function UIBagMain_Skill:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    uimanager:ClosePanel("UISkillPanel")
end
--endregion

--region 面板关闭
---面板关闭
---@public
function UIBagMain_Skill:PanelClose(panelName)
    if panelName == "UISkillPanel" then
        uimanager:ClosePanel("UIBagPanel")
    end
end
--endregion

return UIBagMain_Skill