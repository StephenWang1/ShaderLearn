---@class LuaRankClassLoader 排行榜相关类控制器
local LuaRankClassLoader = {}

---@param luaclass luaclass
function LuaRankClassLoader:LoadAllRankClasses(luaclass)
    --region 排行榜
    ---排行单元功能基类
    luaclass.UIRankFeatureBaseTemplate = require "luaRes.ui.template.UIRankTemplates.Base.UIRankFeatureBaseTemplate"
    ---排行榜通用榜功能
    luaclass.UIRankNormalFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankNormalFeatureTemplate"
    ---排行榜男神榜(女神榜)单元功能
    luaclass.UIRankCharmFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankCharmFeatureTemplate"
    ---排行榜拳榜单元功能
    luaclass.UIRankFistFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankFistFeatureTemplate"
    ---排行榜恩爱榜单元功能
    luaclass.UIRankLoverFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankLoverFeatureTemplate"
    ---排行榜经商榜单元功能
    luaclass.UIRankDobusinessFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankDobusinessFeatureTemplate"
    ---排行榜花榜单元功能
    luaclass.UIRankFlowerFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankFlowerFeatureTemplate"
    ---排行榜猎兽榜单元功能
    luaclass.UIRankKillMonsterFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankKillMonsterFeatureTemplate"
    ---排行榜战神榜单元功能
    luaclass.UIRankGodToWarFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankGodToWarFeatureTemplate"
    ---排行榜战损榜单元功能
    luaclass.UIRankBattleDamageFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankBattleDamageFeatureTemplate"
    ---排行榜灵兽榜单元功能
    luaclass.UIRankServantFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankServantFeatureTemplate"
    ---排行榜战勋单元功能
    luaclass.UIRankPrefixFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankPrefixFeatureTemplate"
    ---联服排行榜等级榜(攻击榜)功能
    luaclass.UIShareRankNormalFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIShareRankNormalFeatureTemplate"
    ---联服排行榜灵兽榜功能
    luaclass.UIShareRankServantFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIShareRankServantFeatureTemplate"
    ---联服排行榜灵兽榜功能
    luaclass.UIShareRankPrefixFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIShareRankPrefixFeatureTemplate"
    ---排行榜通用显示模型
    luaclass.UIRankNormalShowModelFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankNormalShowModelFeatureTemplate"
    ---排行榜阵法单元功能
    luaclass.UIRankFormationFeatureTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankFeatureTemplates.UIRankFormationFeatureTemplate"
    --endregion

    --region 活动排行榜

    --region 排行榜视图
    --排行视图基类
    luaclass.UIActivityRankViewBase = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankViewBase"
    --保卫国王排行榜视图
    luaclass.UIActivityRankDefendKingView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankDefendKingView"
    --沙巴克结算界面
    luaclass.UIActivityRankShaBaKView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankShaBaKView"
    --女神赐福结算界面
    luaclass.UIActivityRankGoddlessView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankGoddlessView"
    --幻境迷宫结算界面
    luaclass.UIActivityRankDreamLandMazeView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankDreamLandMazeView"
    --武道會结算界面
    luaclass.UIActivityRankBuDouKaiView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankBuDouKaiView"
    --行會押鏢结算界面
    luaclass.UIActivityRankUnionDartCarView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankPanelView.UIActivityRankUnionDartCarView"
    --endregion

    --region 排行榜功能单元
    --排行单元功能基类
    luaclass.UIActivityRankUnitFeatureBase = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankUnitFeatureBase"
    --保卫国王排行单元功能基类
    luaclass.UIActivityRankUnitDefendKingFeature = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankUnitDefendKingFeature"
    --女神赐福排行单元功能基类
    luaclass.UIActivityRankGoddessFeature = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankGoddessFeature"
    --武道會排行单元功能基类
    luaclass.UIActivityRankBuDouKaiFeature = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankBuDouKaiFeature"
    --行會押鏢排行单元功能基类
    luaclass.UIActivityRankUnionDartCarFeature = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankUnionDartCarFeature"
    --沙巴克排行单元功能基类
    luaclass.UIActivityRankUnitShaBaKFeature = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankUnitShaBaKFeature"
    --幻境迷宫排行单元功能基类
    luaclass.UIActivityRankUnionDreamLandMazeFeature = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankUnit.Feature.UIActivityRankUnitDreamLandMazeFeature"
    --endregion

    --region 排行榜信息
    ---详细信息base类
    luaclass.UIActivityRankInfoViewBase = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankInfoView.UIActivityRankInfoViewBase"
    ---详细信息保卫国王
    luaclass.UIActivityRankInfoDefendKingView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankInfoView.UIActivityRankInfoDefendKingView"
    ---详细信息行会押镖
    luaclass.UIActivityRankInfoUnionCarView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankInfoView.UIActivityRankInfoUnionCarView"
    ---详细信息沙巴克
    luaclass.UIActivityRankInfoShaBaKView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankInfoView.UIActivityRankInfoShaBaKView"
    ---详细信息女神赐福
    luaclass.UIActivityRankInfoGoddessView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankInfoView.UIActivityRankInfoGoddessView"
    ---详细信息幻境迷宫
    luaclass.UIActivityRankInfoDreamLandView = require "luaRes.luaclass.UIActivityRankPanel.UIActivityRankInfoView.UIActivityRankInfoDreamLandView"
    --endregion
    --endregion

    --region 夺榜排行榜单元

    --夺榜排行榜单元基类
    luaclass.UIContendRank_UnitFeatureClass = require "luaRes.ui.template.UIContendRankPanel.Feature.UIContendRank_UnitFeatureClass"
    --夺榜排行榜通用模板（及赋值都为param）
    luaclass.UIContendRank_UnitNormalFeatureClass = require "luaRes.ui.template.UIContendRankPanel.Feature.UIContendRank_UnitNormalFeatureClass"
    --夺榜排行榜等级榜
    luaclass.UIContendRank_UnitLevelFeatureClass = require "luaRes.ui.template.UIContendRankPanel.Feature.UIContendRank_UnitLevelFeatureClass"
    --夺榜排行榜灵兽榜
    luaclass.UIContendRank_UnitServantlFeatureClass = require "luaRes.ui.template.UIContendRankPanel.Feature.UIContendRank_UnitServantlFeatureClass"
    --夺榜排行榜经商模
    luaclass.UIContendRank_UnitDobusinessFeatureClass = require "luaRes.ui.template.UIContendRankPanel.Feature.UIContendRank_UnitDobusinessFeatureClass"
    --endregion

    --region 霸业视图
    --霸业-行会之争视图
    luaclass.UIOverlordRank_UnionViewClass = require "luaRes.luaclass.UIOverlordRankPanelClass.View.UIOverlordRank_UnionViewClass"
    --霸业-领袖之路视图
    luaclass.UIOverlordRank_LeaderViewClass = require "luaRes.luaclass.UIOverlordRankPanelClass.View.UIOverlordRank_LeaderViewClass"
    --霸业-建功立业视图
    luaclass.UIOverlordRank_MeritViewClass = require "luaRes.luaclass.UIOverlordRankPanelClass.View.UIOverlordRank_MeritViewClass"

    --endregion

    --region 霸业单元
    --霸业-基类单元
    luaclass.UIOverlordRank_BaseUnitClass = require "luaRes.luaclass.UIOverlordRankPanelClass.Unit.UIOverlordRank_BaseUnitClass"
    --霸业-行会之争单元
    luaclass.UIOverlordRank_UnionUnitClass = require "luaRes.luaclass.UIOverlordRankPanelClass.Unit.UIOverlordRank_UnionUnitClass"
    --霸业-领袖之路单元
    luaclass.UIOverlordRank_LeaderUnitClass = require "luaRes.luaclass.UIOverlordRankPanelClass.Unit.UIOverlordRank_LeaderUnitClass"
    --霸业-建功立业单元
    luaclass.UIOverlordRank_MeritUnitClass = require "luaRes.luaclass.UIOverlordRankPanelClass.Unit.UIOverlordRank_MeritUnitClass"
    --霸业-mini单元
    luaclass.UIOverlordRank_MiniUnitClass = require "luaRes.luaclass.UIOverlordRankPanelClass.Unit.UIOverlordRank_MiniUnitClass"
    --endregion
end


return LuaRankClassLoader