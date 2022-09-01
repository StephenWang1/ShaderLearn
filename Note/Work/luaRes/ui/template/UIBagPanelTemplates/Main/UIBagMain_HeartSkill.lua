---@class UIBagMain_HeartSkill:UIBagMain_Normal
local UIBagMain_HeartSkill = {}

setmetatable(UIBagMain_HeartSkill, luaComponentTemplates.UIBagMainNormal)

--region 字段
local Utility = Utility
local LuaEnumCareer = LuaEnumCareer
local luaEnumItemType = luaEnumItemType
local LuaEnumMainHint_BetterBagItemType = LuaEnumMainHint_BetterBagItemType

---@return CSBagItemHint
function UIBagMain_HeartSkill:GetBagItemHint()
    if self.mBagItemHint == nil then
        self.mBagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    end
    return self.mBagItemHint
end

---主角的职业
UIBagMain_HeartSkill.mMainPlayerCareer = nil
--endregion

--region 重写初始化方法
function UIBagMain_HeartSkill:OnInit()
    self:RunBaseFunction("OnInit")
    self.mMainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
end
--endregion

--region 重写属性
---不使用服务器排序
function UIBagMain_HeartSkill:IsUseServerOrder()
    return false
end
--endregion

--region 重写筛选方法
---只筛选出职业吻合的技能书
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
-- function UIBagMain_HeartSkill:BagItemFilterFunction(bagItemInfo, itemInfo)
--     if itemInfo.type == luaEnumItemType.SkillBook and (itemInfo.career == LuaEnumCareer.Common or itemInfo.career == self.mMainPlayerCareer) and itemInfo.subType ==1 then
--         return true
--     end
--     return false
-- end
--endregion

function UIBagMain_HeartSkill:BagItemListSortFunction(LeftItem, RightItem)

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

function UIBagMain_HeartSkill:IsSkillBook(itemInfo)
    if itemInfo.type == luaEnumItemType.SkillBook and (itemInfo.career == LuaEnumCareer.Common or itemInfo.career == self.mMainPlayerCareer) and itemInfo.subType ==1 then
        return true
    end
    return false
end

--region 重写刷新方法
---刷新所有格子之前,获取推荐学习的技能书列表
function UIBagMain_HeartSkill:BeforeRefreshAllGrids()
    self.mList = self:GetBagItemHint():GetHintList(LuaEnumMainHint_BetterBagItemType.AvailableSkill)
end

---刷新单个格子时,若为有提示的技能书,则显示推荐特效
function UIBagMain_HeartSkill:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if not self:IsSkillBook(itemTbl) then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    else
        if self.mList ~= nil then
            for i = 0, self.mList.Count - 1 do
                local temp = self.mList[i]
                if temp and bagItemInfo.lid == temp then
                    bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
                    break
                end
            end
        end
    end
end
--endregion

--region 重写关闭按钮显示
---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_HeartSkill:IsShowCloseButton()
    return false
end
--endregion

--region 重写扩展按钮显示
---@public
---@return boolean
function UIBagMain_HeartSkill:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_HeartSkill:IsShowRecycleButton()
    return false
end
--endregion

--region 重写销毁方法
function UIBagMain_HeartSkill:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    --uimanager:ClosePanel("UIHeartSkillPanel")
end
--endregion

--region 面板关闭
---面板关闭
---@public
function UIBagMain_HeartSkill:PanelClose(panelName)
    if panelName == "UIHeartSkillPanel" then
        uimanager:ClosePanel("UIBagPanel")
    end
end
--endregion

return UIBagMain_HeartSkill