local registerAllClientTable = {}

function registerAllClientTable.RegisterPb(protobufMgr)
    protobufMgr.RegisterPb('table_common.proto')
    protobufMgr.RegisterPb('c_table_cfg_active.proto')
    protobufMgr.RegisterPb('c_table_cfg_activity_boss.proto')
    protobufMgr.RegisterPb('c_table_cfg_activity_current.proto')
    protobufMgr.RegisterPb('c_table_cfg_activity_goals.proto')
    protobufMgr.RegisterPb('c_table_cfg_ancient_boss.proto')
    protobufMgr.RegisterPb('c_table_cfg_animals_boss.proto')
    protobufMgr.RegisterPb('c_table_cfg_appearance.proto')
    protobufMgr.RegisterPb('c_table_cfg_attribute_show.proto')
    protobufMgr.RegisterPb('c_table_cfg_bairimen_activity.proto')
    protobufMgr.RegisterPb('c_table_cfg_bloodsuit.proto')
    protobufMgr.RegisterPb('c_table_cfg_bloodsuit_combination.proto')
    protobufMgr.RegisterPb('c_table_cfg_bloodsuit_lattice.proto')
    protobufMgr.RegisterPb('c_table_cfg_bloodsuit_level.proto')
    protobufMgr.RegisterPb('c_table_cfg_bloodsuit_resonance.proto')
    protobufMgr.RegisterPb('c_table_cfg_bloodsuit_resonance_attribute.proto')
    protobufMgr.RegisterPb('c_table_cfg_bonfire.proto')
    protobufMgr.RegisterPb('c_table_cfg_boss.proto')
    protobufMgr.RegisterPb('c_table_cfg_boss_drop_show.proto')
    protobufMgr.RegisterPb('c_table_cfg_boss_skill_describe.proto')
    protobufMgr.RegisterPb('c_table_cfg_boss_task.proto')
    protobufMgr.RegisterPb('c_table_cfg_buff.proto')
    protobufMgr.RegisterPb('c_table_cfg_collection.proto')
    protobufMgr.RegisterPb('c_table_cfg_collectionbox.proto')
    protobufMgr.RegisterPb('c_table_cfg_conditions.proto')
    protobufMgr.RegisterPb('c_table_cfg_cuilian.proto')
    protobufMgr.RegisterPb('c_table_cfg_cum_recharge.proto')
    protobufMgr.RegisterPb('c_table_cfg_daily_activity_time.proto')
    protobufMgr.RegisterPb('c_table_cfg_daily_task.proto')
    protobufMgr.RegisterPb('c_table_cfg_deliver.proto')
    protobufMgr.RegisterPb('c_table_cfg_demon_boss.proto')
    protobufMgr.RegisterPb('c_table_cfg_description.proto')
    protobufMgr.RegisterPb('c_table_cfg_divinelevelup.proto')
    protobufMgr.RegisterPb('c_table_cfg_divinesuit.proto')
    protobufMgr.RegisterPb('c_table_cfg_divinesuitattribute.proto')
    protobufMgr.RegisterPb('c_table_cfg_drop_show_group.proto')
    protobufMgr.RegisterPb('c_table_cfg_equip_proficient.proto')
    protobufMgr.RegisterPb('c_table_cfg_events.proto')
    protobufMgr.RegisterPb('c_table_cfg_expprop.proto')
    protobufMgr.RegisterPb('c_table_cfg_extra_mon_effect.proto')
    protobufMgr.RegisterPb('c_table_cfg_gather_items.proto')
    protobufMgr.RegisterPb('c_table_cfg_gather_soul.proto')
    protobufMgr.RegisterPb('c_table_cfg_godfurnace.proto')
    protobufMgr.RegisterPb('c_table_cfg_growth_weapon_class.proto')
    protobufMgr.RegisterPb('c_table_cfg_growth_weapon_level.proto')
    protobufMgr.RegisterPb('c_table_cfg_guidebook.proto')
    protobufMgr.RegisterPb('c_table_cfg_guide_bubble.proto')
    protobufMgr.RegisterPb('c_table_cfg_hidden_weapon.proto')
    protobufMgr.RegisterPb('c_table_cfg_horse_card.proto')
    protobufMgr.RegisterPb('c_table_cfg_hsrein.proto')
    protobufMgr.RegisterPb('c_table_cfg_huanshou.proto')
    protobufMgr.RegisterPb('c_table_cfg_inlay_effect.proto')
    protobufMgr.RegisterPb('c_table_cfg_intensify.proto')
    protobufMgr.RegisterPb('c_table_cfg_invest.proto')
    protobufMgr.RegisterPb('c_table_cfg_items.proto')
    protobufMgr.RegisterPb('c_table_cfg_jianding.proto')
    protobufMgr.RegisterPb('c_table_cfg_jump.proto')
    protobufMgr.RegisterPb('c_table_cfg_league.proto')
    protobufMgr.RegisterPb('c_table_cfg_lingshoutask.proto')
    protobufMgr.RegisterPb('c_table_cfg_linkeffect.proto')
    protobufMgr.RegisterPb('c_table_cfg_magicweapon.proto')
    protobufMgr.RegisterPb('c_table_cfg_map.proto')
    protobufMgr.RegisterPb('c_table_cfg_mapeffect.proto')
    protobufMgr.RegisterPb('c_table_cfg_map_events.proto')
    protobufMgr.RegisterPb('c_table_cfg_member.proto')
    protobufMgr.RegisterPb('c_table_cfg_member_task.proto')
    protobufMgr.RegisterPb('c_table_cfg_monsters.proto')
    protobufMgr.RegisterPb('c_table_cfg_mysteriousoldman.proto')
    protobufMgr.RegisterPb('c_table_cfg_notice.proto')
    protobufMgr.RegisterPb('c_table_cfg_official_emperor_token.proto')
    protobufMgr.RegisterPb('c_table_cfg_official_position.proto')
    protobufMgr.RegisterPb('c_table_cfg_pick_up.proto')
    protobufMgr.RegisterPb('c_table_cfg_potential.proto')
    protobufMgr.RegisterPb('c_table_cfg_potential_invest.proto')
    protobufMgr.RegisterPb('c_table_cfg_powerful.proto')
    protobufMgr.RegisterPb('c_table_cfg_practice_room.proto')
    protobufMgr.RegisterPb('c_table_cfg_prefix_title.proto')
    protobufMgr.RegisterPb('c_table_cfg_promptframe.proto')
    protobufMgr.RegisterPb('c_table_cfg_promptword.proto')
    protobufMgr.RegisterPb('c_table_cfg_property_name.proto')
    protobufMgr.RegisterPb('c_table_cfg_rank.proto')
    protobufMgr.RegisterPb('c_table_cfg_recast.proto')
    protobufMgr.RegisterPb('c_table_cfg_recast_skill.proto')
    protobufMgr.RegisterPb('c_table_cfg_recharge.proto')
    protobufMgr.RegisterPb('c_table_cfg_recover.proto')
    protobufMgr.RegisterPb('c_table_cfg_recoverset.proto')
    protobufMgr.RegisterPb('c_table_cfg_refine_master.proto')
    protobufMgr.RegisterPb('c_table_cfg_reincarnation.proto')
    protobufMgr.RegisterPb('c_table_cfg_sbk_donate_reward.proto')
    protobufMgr.RegisterPb('c_table_cfg_sbk_rank_reward.proto')
    protobufMgr.RegisterPb('c_table_cfg_sbk_reward_point.proto')
    protobufMgr.RegisterPb('c_table_cfg_signet.proto')
    protobufMgr.RegisterPb('c_table_cfg_skills.proto')
    protobufMgr.RegisterPb('c_table_cfg_skills_condition.proto')
    protobufMgr.RegisterPb('c_table_cfg_soul_reward.proto')
    protobufMgr.RegisterPb('c_table_cfg_soul_task.proto')
    protobufMgr.RegisterPb('c_table_cfg_special_activity.proto')
    protobufMgr.RegisterPb('c_table_cfg_special_activity_goals.proto')
    protobufMgr.RegisterPb('c_table_cfg_suit.proto')
    protobufMgr.RegisterPb('c_table_cfg_synthesis.proto')
    protobufMgr.RegisterPb('c_table_cfg_system_preview.proto')
    protobufMgr.RegisterPb('c_table_cfg_task.proto')
    protobufMgr.RegisterPb('c_table_cfg_taskgoal.proto')
    protobufMgr.RegisterPb('c_table_cfg_time_clock.proto')
    protobufMgr.RegisterPb('c_table_cfg_title.proto')
    protobufMgr.RegisterPb('c_table_cfg_tower.proto')
    protobufMgr.RegisterPb('c_table_cfg_uilogic.proto')
    protobufMgr.RegisterPb('c_table_cfg_uilogic_caches.proto')
    protobufMgr.RegisterPb('c_table_cfg_uilogic_close.proto')
    protobufMgr.RegisterPb('c_table_cfg_uilogic_hide.proto')
    protobufMgr.RegisterPb('c_table_cfg_uisets.proto')
    protobufMgr.RegisterPb('c_table_cfg_union_activity.proto')
    protobufMgr.RegisterPb('c_table_cfg_union_boss_rank.proto')
    protobufMgr.RegisterPb('c_table_cfg_video.proto')
    protobufMgr.RegisterPb('c_table_cfg_vip.proto')
    protobufMgr.RegisterPb('c_table_cfg_vip_level.proto')
    protobufMgr.RegisterPb('c_table_cfg_vip_zunxiang.proto')
    protobufMgr.RegisterPb('c_table_cfg_wayget_fastauction.proto')
    protobufMgr.RegisterPb('c_table_cfg_way_get.proto')
    protobufMgr.RegisterPb('c_table_cfg_yabiao.proto')
    protobufMgr.RegisterPb('c_table_cfg_zhenfa.proto')
end

function registerAllClientTable.RequireTableManager()
    ---@type cfg_activeManager
    clientTableManager.cfg_activeManager = require 'luaRes.table.tableManager.cfg_activeManager'
    ---@type cfg_activity_bossManager
    clientTableManager.cfg_activity_bossManager = require 'luaRes.table.tableManager.cfg_activity_bossManager'
    ---@type cfg_activity_currentManager
    clientTableManager.cfg_activity_currentManager = require 'luaRes.table.tableManager.cfg_activity_currentManager'
    ---@type cfg_activity_goalsManager
    clientTableManager.cfg_activity_goalsManager = require 'luaRes.table.tableManager.cfg_activity_goalsManager'
    ---@type cfg_ancient_bossManager
    clientTableManager.cfg_ancient_bossManager = require 'luaRes.table.tableManager.cfg_ancient_bossManager'
    ---@type cfg_animals_bossManager
    clientTableManager.cfg_animals_bossManager = require 'luaRes.table.tableManager.cfg_animals_bossManager'
    ---@type cfg_appearanceManager
    clientTableManager.cfg_appearanceManager = require 'luaRes.table.tableManager.cfg_appearanceManager'
    ---@type cfg_attribute_showManager
    clientTableManager.cfg_attribute_showManager = require 'luaRes.table.tableManager.cfg_attribute_showManager'
    ---@type cfg_bairimen_activityManager
    clientTableManager.cfg_bairimen_activityManager = require 'luaRes.table.tableManager.cfg_bairimen_activityManager'
    ---@type cfg_bloodsuitManager
    clientTableManager.cfg_bloodsuitManager = require 'luaRes.table.tableManager.cfg_bloodsuitManager'
    ---@type cfg_bloodsuit_combinationManager
    clientTableManager.cfg_bloodsuit_combinationManager = require 'luaRes.table.tableManager.cfg_bloodsuit_combinationManager'
    ---@type cfg_bloodsuit_latticeManager
    clientTableManager.cfg_bloodsuit_latticeManager = require 'luaRes.table.tableManager.cfg_bloodsuit_latticeManager'
    ---@type cfg_bloodsuit_levelManager
    clientTableManager.cfg_bloodsuit_levelManager = require 'luaRes.table.tableManager.cfg_bloodsuit_levelManager'
    ---@type cfg_bloodsuit_resonanceManager
    clientTableManager.cfg_bloodsuit_resonanceManager = require 'luaRes.table.tableManager.cfg_bloodsuit_resonanceManager'
    ---@type cfg_bloodsuit_resonance_attributeManager
    clientTableManager.cfg_bloodsuit_resonance_attributeManager = require 'luaRes.table.tableManager.cfg_bloodsuit_resonance_attributeManager'
    ---@type cfg_bonfireManager
    clientTableManager.cfg_bonfireManager = require 'luaRes.table.tableManager.cfg_bonfireManager'
    ---@type cfg_bossManager
    clientTableManager.cfg_bossManager = require 'luaRes.table.tableManager.cfg_bossManager'
    ---@type cfg_boss_drop_showManager
    clientTableManager.cfg_boss_drop_showManager = require 'luaRes.table.tableManager.cfg_boss_drop_showManager'
    ---@type cfg_boss_skill_describeManager
    clientTableManager.cfg_boss_skill_describeManager = require 'luaRes.table.tableManager.cfg_boss_skill_describeManager'
    ---@type cfg_boss_taskManager
    clientTableManager.cfg_boss_taskManager = require 'luaRes.table.tableManager.cfg_boss_taskManager'
    ---@type cfg_buffManager
    clientTableManager.cfg_buffManager = require 'luaRes.table.tableManager.cfg_buffManager'
    ---@type cfg_collectionManager
    clientTableManager.cfg_collectionManager = require 'luaRes.table.tableManager.cfg_collectionManager'
    ---@type cfg_collectionboxManager
    clientTableManager.cfg_collectionboxManager = require 'luaRes.table.tableManager.cfg_collectionboxManager'
    ---@type cfg_conditionsManager
    clientTableManager.cfg_conditionsManager = require 'luaRes.table.tableManager.cfg_conditionsManager'
    ---@type cfg_cuilianManager
    clientTableManager.cfg_cuilianManager = require 'luaRes.table.tableManager.cfg_cuilianManager'
    ---@type cfg_cum_rechargeManager
    clientTableManager.cfg_cum_rechargeManager = require 'luaRes.table.tableManager.cfg_cum_rechargeManager'
    ---@type cfg_daily_activity_timeManager
    clientTableManager.cfg_daily_activity_timeManager = require 'luaRes.table.tableManager.cfg_daily_activity_timeManager'
    ---@type cfg_daily_taskManager
    clientTableManager.cfg_daily_taskManager = require 'luaRes.table.tableManager.cfg_daily_taskManager'
    ---@type cfg_deliverManager
    clientTableManager.cfg_deliverManager = require 'luaRes.table.tableManager.cfg_deliverManager'
    ---@type cfg_demon_bossManager
    clientTableManager.cfg_demon_bossManager = require 'luaRes.table.tableManager.cfg_demon_bossManager'
    ---@type cfg_descriptionManager
    clientTableManager.cfg_descriptionManager = require 'luaRes.table.tableManager.cfg_descriptionManager'
    ---@type cfg_divinelevelupManager
    clientTableManager.cfg_divinelevelupManager = require 'luaRes.table.tableManager.cfg_divinelevelupManager'
    ---@type cfg_divinesuitManager
    clientTableManager.cfg_divinesuitManager = require 'luaRes.table.tableManager.cfg_divinesuitManager'
    ---@type cfg_divinesuitattributeManager
    clientTableManager.cfg_divinesuitattributeManager = require 'luaRes.table.tableManager.cfg_divinesuitattributeManager'
    ---@type cfg_drop_show_groupManager
    clientTableManager.cfg_drop_show_groupManager = require 'luaRes.table.tableManager.cfg_drop_show_groupManager'
    ---@type cfg_equip_proficientManager
    clientTableManager.cfg_equip_proficientManager = require 'luaRes.table.tableManager.cfg_equip_proficientManager'
    ---@type cfg_eventsManager
    clientTableManager.cfg_eventsManager = require 'luaRes.table.tableManager.cfg_eventsManager'
    ---@type cfg_exppropManager
    clientTableManager.cfg_exppropManager = require 'luaRes.table.tableManager.cfg_exppropManager'
    ---@type cfg_extra_mon_effectManager
    clientTableManager.cfg_extra_mon_effectManager = require 'luaRes.table.tableManager.cfg_extra_mon_effectManager'
    ---@type cfg_gather_itemsManager
    clientTableManager.cfg_gather_itemsManager = require 'luaRes.table.tableManager.cfg_gather_itemsManager'
    ---@type cfg_gather_soulManager
    clientTableManager.cfg_gather_soulManager = require 'luaRes.table.tableManager.cfg_gather_soulManager'
    ---@type cfg_godfurnaceManager
    clientTableManager.cfg_godfurnaceManager = require 'luaRes.table.tableManager.cfg_godfurnaceManager'
    ---@type cfg_growth_weapon_classManager
    clientTableManager.cfg_growth_weapon_classManager = require 'luaRes.table.tableManager.cfg_growth_weapon_classManager'
    ---@type cfg_growth_weapon_levelManager
    clientTableManager.cfg_growth_weapon_levelManager = require 'luaRes.table.tableManager.cfg_growth_weapon_levelManager'
    ---@type cfg_guidebookManager
    clientTableManager.cfg_guidebookManager = require 'luaRes.table.tableManager.cfg_guidebookManager'
    ---@type cfg_guide_bubbleManager
    clientTableManager.cfg_guide_bubbleManager = require 'luaRes.table.tableManager.cfg_guide_bubbleManager'
    ---@type cfg_hidden_weaponManager
    clientTableManager.cfg_hidden_weaponManager = require 'luaRes.table.tableManager.cfg_hidden_weaponManager'
    ---@type cfg_horse_cardManager
    clientTableManager.cfg_horse_cardManager = require 'luaRes.table.tableManager.cfg_horse_cardManager'
    ---@type cfg_hsreinManager
    clientTableManager.cfg_hsreinManager = require 'luaRes.table.tableManager.cfg_hsreinManager'
    ---@type cfg_huanshouManager
    clientTableManager.cfg_huanshouManager = require 'luaRes.table.tableManager.cfg_huanshouManager'
    ---@type cfg_inlay_effectManager
    clientTableManager.cfg_inlay_effectManager = require 'luaRes.table.tableManager.cfg_inlay_effectManager'
    ---@type cfg_intensifyManager
    clientTableManager.cfg_intensifyManager = require 'luaRes.table.tableManager.cfg_intensifyManager'
    ---@type cfg_investManager
    clientTableManager.cfg_investManager = require 'luaRes.table.tableManager.cfg_investManager'
    ---@type cfg_itemsManager
    clientTableManager.cfg_itemsManager = require 'luaRes.table.tableManager.cfg_itemsManager'
    ---@type cfg_jiandingManager
    clientTableManager.cfg_jiandingManager = require 'luaRes.table.tableManager.cfg_jiandingManager'
    ---@type cfg_jumpManager
    clientTableManager.cfg_jumpManager = require 'luaRes.table.tableManager.cfg_jumpManager'
    ---@type cfg_leagueManager
    clientTableManager.cfg_leagueManager = require 'luaRes.table.tableManager.cfg_leagueManager'
    ---@type cfg_lingshoutaskManager
    clientTableManager.cfg_lingshoutaskManager = require 'luaRes.table.tableManager.cfg_lingshoutaskManager'
    ---@type cfg_linkeffectManager
    clientTableManager.cfg_linkeffectManager = require 'luaRes.table.tableManager.cfg_linkeffectManager'
    ---@type cfg_magicweaponManager
    clientTableManager.cfg_magicweaponManager = require 'luaRes.table.tableManager.cfg_magicweaponManager'
    ---@type cfg_mapManager
    clientTableManager.cfg_mapManager = require 'luaRes.table.tableManager.cfg_mapManager'
    ---@type cfg_mapeffectManager
    clientTableManager.cfg_mapeffectManager = require 'luaRes.table.tableManager.cfg_mapeffectManager'
    ---@type cfg_map_eventsManager
    clientTableManager.cfg_map_eventsManager = require 'luaRes.table.tableManager.cfg_map_eventsManager'
    ---@type cfg_memberManager
    clientTableManager.cfg_memberManager = require 'luaRes.table.tableManager.cfg_memberManager'
    ---@type cfg_member_taskManager
    clientTableManager.cfg_member_taskManager = require 'luaRes.table.tableManager.cfg_member_taskManager'
    ---@type cfg_monstersManager
    clientTableManager.cfg_monstersManager = require 'luaRes.table.tableManager.cfg_monstersManager'
    ---@type cfg_mysteriousoldmanManager
    clientTableManager.cfg_mysteriousoldmanManager = require 'luaRes.table.tableManager.cfg_mysteriousoldmanManager'
    ---@type cfg_noticeManager
    clientTableManager.cfg_noticeManager = require 'luaRes.table.tableManager.cfg_noticeManager'
    ---@type cfg_official_emperor_tokenManager
    clientTableManager.cfg_official_emperor_tokenManager = require 'luaRes.table.tableManager.cfg_official_emperor_tokenManager'
    ---@type cfg_official_positionManager
    clientTableManager.cfg_official_positionManager = require 'luaRes.table.tableManager.cfg_official_positionManager'
    ---@type cfg_pick_upManager
    clientTableManager.cfg_pick_upManager = require 'luaRes.table.tableManager.cfg_pick_upManager'
    ---@type cfg_potentialManager
    clientTableManager.cfg_potentialManager = require 'luaRes.table.tableManager.cfg_potentialManager'
    ---@type cfg_potential_investManager
    clientTableManager.cfg_potential_investManager = require 'luaRes.table.tableManager.cfg_potential_investManager'
    ---@type cfg_powerfulManager
    clientTableManager.cfg_powerfulManager = require 'luaRes.table.tableManager.cfg_powerfulManager'
    ---@type cfg_practice_roomManager
    clientTableManager.cfg_practice_roomManager = require 'luaRes.table.tableManager.cfg_practice_roomManager'
    ---@type cfg_prefix_titleManager
    clientTableManager.cfg_prefix_titleManager = require 'luaRes.table.tableManager.cfg_prefix_titleManager'
    ---@type cfg_promptframeManager
    clientTableManager.cfg_promptframeManager = require 'luaRes.table.tableManager.cfg_promptframeManager'
    ---@type cfg_promptwordManager
    clientTableManager.cfg_promptwordManager = require 'luaRes.table.tableManager.cfg_promptwordManager'
    ---@type cfg_property_nameManager
    clientTableManager.cfg_property_nameManager = require 'luaRes.table.tableManager.cfg_property_nameManager'
    ---@type cfg_rankManager
    clientTableManager.cfg_rankManager = require 'luaRes.table.tableManager.cfg_rankManager'
    ---@type cfg_recastManager
    clientTableManager.cfg_recastManager = require 'luaRes.table.tableManager.cfg_recastManager'
    ---@type cfg_recast_skillManager
    clientTableManager.cfg_recast_skillManager = require 'luaRes.table.tableManager.cfg_recast_skillManager'
    ---@type cfg_rechargeManager
    clientTableManager.cfg_rechargeManager = require 'luaRes.table.tableManager.cfg_rechargeManager'
    ---@type cfg_recoverManager
    clientTableManager.cfg_recoverManager = require 'luaRes.table.tableManager.cfg_recoverManager'
    ---@type cfg_recoversetManager
    clientTableManager.cfg_recoversetManager = require 'luaRes.table.tableManager.cfg_recoversetManager'
    ---@type cfg_refine_masterManager
    clientTableManager.cfg_refine_masterManager = require 'luaRes.table.tableManager.cfg_refine_masterManager'
    ---@type cfg_reincarnationManager
    clientTableManager.cfg_reincarnationManager = require 'luaRes.table.tableManager.cfg_reincarnationManager'
    ---@type cfg_sbk_donate_rewardManager
    clientTableManager.cfg_sbk_donate_rewardManager = require 'luaRes.table.tableManager.cfg_sbk_donate_rewardManager'
    ---@type cfg_sbk_rank_rewardManager
    clientTableManager.cfg_sbk_rank_rewardManager = require 'luaRes.table.tableManager.cfg_sbk_rank_rewardManager'
    ---@type cfg_sbk_reward_pointManager
    clientTableManager.cfg_sbk_reward_pointManager = require 'luaRes.table.tableManager.cfg_sbk_reward_pointManager'
    ---@type cfg_signetManager
    clientTableManager.cfg_signetManager = require 'luaRes.table.tableManager.cfg_signetManager'
    ---@type cfg_skillsManager
    clientTableManager.cfg_skillsManager = require 'luaRes.table.tableManager.cfg_skillsManager'
    ---@type cfg_skills_conditionManager
    clientTableManager.cfg_skills_conditionManager = require 'luaRes.table.tableManager.cfg_skills_conditionManager'
    ---@type cfg_soul_rewardManager
    clientTableManager.cfg_soul_rewardManager = require 'luaRes.table.tableManager.cfg_soul_rewardManager'
    ---@type cfg_soul_taskManager
    clientTableManager.cfg_soul_taskManager = require 'luaRes.table.tableManager.cfg_soul_taskManager'
    ---@type cfg_special_activityManager
    clientTableManager.cfg_special_activityManager = require 'luaRes.table.tableManager.cfg_special_activityManager'
    ---@type cfg_special_activity_goalsManager
    clientTableManager.cfg_special_activity_goalsManager = require 'luaRes.table.tableManager.cfg_special_activity_goalsManager'
    ---@type cfg_suitManager
    clientTableManager.cfg_suitManager = require 'luaRes.table.tableManager.cfg_suitManager'
    ---@type cfg_synthesisManager
    clientTableManager.cfg_synthesisManager = require 'luaRes.table.tableManager.cfg_synthesisManager'
    ---@type cfg_system_previewManager
    clientTableManager.cfg_system_previewManager = require 'luaRes.table.tableManager.cfg_system_previewManager'
    ---@type cfg_taskManager
    clientTableManager.cfg_taskManager = require 'luaRes.table.tableManager.cfg_taskManager'
    ---@type cfg_taskgoalManager
    clientTableManager.cfg_taskgoalManager = require 'luaRes.table.tableManager.cfg_taskgoalManager'
    ---@type cfg_time_clockManager
    clientTableManager.cfg_time_clockManager = require 'luaRes.table.tableManager.cfg_time_clockManager'
    ---@type cfg_titleManager
    clientTableManager.cfg_titleManager = require 'luaRes.table.tableManager.cfg_titleManager'
    ---@type cfg_towerManager
    clientTableManager.cfg_towerManager = require 'luaRes.table.tableManager.cfg_towerManager'
    ---@type cfg_uilogicManager
    clientTableManager.cfg_uilogicManager = require 'luaRes.table.tableManager.cfg_uilogicManager'
    ---@type cfg_uilogic_cachesManager
    clientTableManager.cfg_uilogic_cachesManager = require 'luaRes.table.tableManager.cfg_uilogic_cachesManager'
    ---@type cfg_uilogic_closeManager
    clientTableManager.cfg_uilogic_closeManager = require 'luaRes.table.tableManager.cfg_uilogic_closeManager'
    ---@type cfg_uilogic_hideManager
    clientTableManager.cfg_uilogic_hideManager = require 'luaRes.table.tableManager.cfg_uilogic_hideManager'
    ---@type cfg_uisetsManager
    clientTableManager.cfg_uisetsManager = require 'luaRes.table.tableManager.cfg_uisetsManager'
    ---@type cfg_union_activityManager
    clientTableManager.cfg_union_activityManager = require 'luaRes.table.tableManager.cfg_union_activityManager'
    ---@type cfg_union_boss_rankManager
    clientTableManager.cfg_union_boss_rankManager = require 'luaRes.table.tableManager.cfg_union_boss_rankManager'
    ---@type cfg_videoManager
    clientTableManager.cfg_videoManager = require 'luaRes.table.tableManager.cfg_videoManager'
    ---@type cfg_vipManager
    clientTableManager.cfg_vipManager = require 'luaRes.table.tableManager.cfg_vipManager'
    ---@type cfg_vip_levelManager
    clientTableManager.cfg_vip_levelManager = require 'luaRes.table.tableManager.cfg_vip_levelManager'
    ---@type cfg_vip_zunxiangManager
    clientTableManager.cfg_vip_zunxiangManager = require 'luaRes.table.tableManager.cfg_vip_zunxiangManager'
    ---@type cfg_wayget_fastauctionManager
    clientTableManager.cfg_wayget_fastauctionManager = require 'luaRes.table.tableManager.cfg_wayget_fastauctionManager'
    ---@type cfg_way_getManager
    clientTableManager.cfg_way_getManager = require 'luaRes.table.tableManager.cfg_way_getManager'
    ---@type cfg_yabiaoManager
    clientTableManager.cfg_yabiaoManager = require 'luaRes.table.tableManager.cfg_yabiaoManager'
    ---@type cfg_zhenfaManager
    clientTableManager.cfg_zhenfaManager = require 'luaRes.table.tableManager.cfg_zhenfaManager'
end

function registerAllClientTable.RequireTable()
    tableLoader.TableList.cfg_active = require 'luaRes.table.clientTable.cfg_active'
    tableLoader.TableList.cfg_activity_boss = require 'luaRes.table.clientTable.cfg_activity_boss'
    tableLoader.TableList.cfg_activity_current = require 'luaRes.table.clientTable.cfg_activity_current'
    tableLoader.TableList.cfg_activity_goals = require 'luaRes.table.clientTable.cfg_activity_goals'
    tableLoader.TableList.cfg_ancient_boss = require 'luaRes.table.clientTable.cfg_ancient_boss'
    tableLoader.TableList.cfg_animals_boss = require 'luaRes.table.clientTable.cfg_animals_boss'
    tableLoader.TableList.cfg_appearance = require 'luaRes.table.clientTable.cfg_appearance'
    tableLoader.TableList.cfg_attribute_show = require 'luaRes.table.clientTable.cfg_attribute_show'
    tableLoader.TableList.cfg_bairimen_activity = require 'luaRes.table.clientTable.cfg_bairimen_activity'
    tableLoader.TableList.cfg_bloodsuit = require 'luaRes.table.clientTable.cfg_bloodsuit'
    tableLoader.TableList.cfg_bloodsuit_combination = require 'luaRes.table.clientTable.cfg_bloodsuit_combination'
    tableLoader.TableList.cfg_bloodsuit_lattice = require 'luaRes.table.clientTable.cfg_bloodsuit_lattice'
    tableLoader.TableList.cfg_bloodsuit_level = require 'luaRes.table.clientTable.cfg_bloodsuit_level'
    tableLoader.TableList.cfg_bloodsuit_resonance = require 'luaRes.table.clientTable.cfg_bloodsuit_resonance'
    tableLoader.TableList.cfg_bloodsuit_resonance_attribute = require 'luaRes.table.clientTable.cfg_bloodsuit_resonance_attribute'
    tableLoader.TableList.cfg_bonfire = require 'luaRes.table.clientTable.cfg_bonfire'
    tableLoader.TableList.cfg_boss = require 'luaRes.table.clientTable.cfg_boss'
    tableLoader.TableList.cfg_boss_drop_show = require 'luaRes.table.clientTable.cfg_boss_drop_show'
    tableLoader.TableList.cfg_boss_skill_describe = require 'luaRes.table.clientTable.cfg_boss_skill_describe'
    tableLoader.TableList.cfg_boss_task = require 'luaRes.table.clientTable.cfg_boss_task'
    tableLoader.TableList.cfg_buff = require 'luaRes.table.clientTable.cfg_buff'
    tableLoader.TableList.cfg_collection = require 'luaRes.table.clientTable.cfg_collection'
    tableLoader.TableList.cfg_collectionbox = require 'luaRes.table.clientTable.cfg_collectionbox'
    tableLoader.TableList.cfg_conditions = require 'luaRes.table.clientTable.cfg_conditions'
    tableLoader.TableList.cfg_cuilian = require 'luaRes.table.clientTable.cfg_cuilian'
    tableLoader.TableList.cfg_cum_recharge = require 'luaRes.table.clientTable.cfg_cum_recharge'
    tableLoader.TableList.cfg_daily_activity_time = require 'luaRes.table.clientTable.cfg_daily_activity_time'
    tableLoader.TableList.cfg_daily_task = require 'luaRes.table.clientTable.cfg_daily_task'
    tableLoader.TableList.cfg_deliver = require 'luaRes.table.clientTable.cfg_deliver'
    tableLoader.TableList.cfg_demon_boss = require 'luaRes.table.clientTable.cfg_demon_boss'
    tableLoader.TableList.cfg_description = require 'luaRes.table.clientTable.cfg_description'
    tableLoader.TableList.cfg_divinelevelup = require 'luaRes.table.clientTable.cfg_divinelevelup'
    tableLoader.TableList.cfg_divinesuit = require 'luaRes.table.clientTable.cfg_divinesuit'
    tableLoader.TableList.cfg_divinesuitattribute = require 'luaRes.table.clientTable.cfg_divinesuitattribute'
    tableLoader.TableList.cfg_drop_show_group = require 'luaRes.table.clientTable.cfg_drop_show_group'
    tableLoader.TableList.cfg_equip_proficient = require 'luaRes.table.clientTable.cfg_equip_proficient'
    tableLoader.TableList.cfg_events = require 'luaRes.table.clientTable.cfg_events'
    tableLoader.TableList.cfg_expprop = require 'luaRes.table.clientTable.cfg_expprop'
    tableLoader.TableList.cfg_extra_mon_effect = require 'luaRes.table.clientTable.cfg_extra_mon_effect'
    tableLoader.TableList.cfg_gather_items = require 'luaRes.table.clientTable.cfg_gather_items'
    tableLoader.TableList.cfg_gather_soul = require 'luaRes.table.clientTable.cfg_gather_soul'
    tableLoader.TableList.cfg_godfurnace = require 'luaRes.table.clientTable.cfg_godfurnace'
    tableLoader.TableList.cfg_growth_weapon_class = require 'luaRes.table.clientTable.cfg_growth_weapon_class'
    tableLoader.TableList.cfg_growth_weapon_level = require 'luaRes.table.clientTable.cfg_growth_weapon_level'
    tableLoader.TableList.cfg_guidebook = require 'luaRes.table.clientTable.cfg_guidebook'
    tableLoader.TableList.cfg_guide_bubble = require 'luaRes.table.clientTable.cfg_guide_bubble'
    tableLoader.TableList.cfg_hidden_weapon = require 'luaRes.table.clientTable.cfg_hidden_weapon'
    tableLoader.TableList.cfg_horse_card = require 'luaRes.table.clientTable.cfg_horse_card'
    tableLoader.TableList.cfg_hsrein = require 'luaRes.table.clientTable.cfg_hsrein'
    tableLoader.TableList.cfg_huanshou = require 'luaRes.table.clientTable.cfg_huanshou'
    tableLoader.TableList.cfg_inlay_effect = require 'luaRes.table.clientTable.cfg_inlay_effect'
    tableLoader.TableList.cfg_intensify = require 'luaRes.table.clientTable.cfg_intensify'
    tableLoader.TableList.cfg_invest = require 'luaRes.table.clientTable.cfg_invest'
    tableLoader.TableList.cfg_items = require 'luaRes.table.clientTable.cfg_items'
    tableLoader.TableList.cfg_jianding = require 'luaRes.table.clientTable.cfg_jianding'
    tableLoader.TableList.cfg_jump = require 'luaRes.table.clientTable.cfg_jump'
    tableLoader.TableList.cfg_league = require 'luaRes.table.clientTable.cfg_league'
    tableLoader.TableList.cfg_lingshoutask = require 'luaRes.table.clientTable.cfg_lingshoutask'
    tableLoader.TableList.cfg_linkeffect = require 'luaRes.table.clientTable.cfg_linkeffect'
    tableLoader.TableList.cfg_magicweapon = require 'luaRes.table.clientTable.cfg_magicweapon'
    tableLoader.TableList.cfg_map = require 'luaRes.table.clientTable.cfg_map'
    tableLoader.TableList.cfg_mapeffect = require 'luaRes.table.clientTable.cfg_mapeffect'
    tableLoader.TableList.cfg_map_events = require 'luaRes.table.clientTable.cfg_map_events'
    tableLoader.TableList.cfg_member = require 'luaRes.table.clientTable.cfg_member'
    tableLoader.TableList.cfg_member_task = require 'luaRes.table.clientTable.cfg_member_task'
    tableLoader.TableList.cfg_monsters = require 'luaRes.table.clientTable.cfg_monsters'
    tableLoader.TableList.cfg_mysteriousoldman = require 'luaRes.table.clientTable.cfg_mysteriousoldman'
    tableLoader.TableList.cfg_notice = require 'luaRes.table.clientTable.cfg_notice'
    tableLoader.TableList.cfg_official_emperor_token = require 'luaRes.table.clientTable.cfg_official_emperor_token'
    tableLoader.TableList.cfg_official_position = require 'luaRes.table.clientTable.cfg_official_position'
    tableLoader.TableList.cfg_pick_up = require 'luaRes.table.clientTable.cfg_pick_up'
    tableLoader.TableList.cfg_potential = require 'luaRes.table.clientTable.cfg_potential'
    tableLoader.TableList.cfg_potential_invest = require 'luaRes.table.clientTable.cfg_potential_invest'
    tableLoader.TableList.cfg_powerful = require 'luaRes.table.clientTable.cfg_powerful'
    tableLoader.TableList.cfg_practice_room = require 'luaRes.table.clientTable.cfg_practice_room'
    tableLoader.TableList.cfg_prefix_title = require 'luaRes.table.clientTable.cfg_prefix_title'
    tableLoader.TableList.cfg_promptframe = require 'luaRes.table.clientTable.cfg_promptframe'
    tableLoader.TableList.cfg_promptword = require 'luaRes.table.clientTable.cfg_promptword'
    tableLoader.TableList.cfg_property_name = require 'luaRes.table.clientTable.cfg_property_name'
    tableLoader.TableList.cfg_rank = require 'luaRes.table.clientTable.cfg_rank'
    tableLoader.TableList.cfg_recast = require 'luaRes.table.clientTable.cfg_recast'
    tableLoader.TableList.cfg_recast_skill = require 'luaRes.table.clientTable.cfg_recast_skill'
    tableLoader.TableList.cfg_recharge = require 'luaRes.table.clientTable.cfg_recharge'
    tableLoader.TableList.cfg_recover = require 'luaRes.table.clientTable.cfg_recover'
    tableLoader.TableList.cfg_recoverset = require 'luaRes.table.clientTable.cfg_recoverset'
    tableLoader.TableList.cfg_refine_master = require 'luaRes.table.clientTable.cfg_refine_master'
    tableLoader.TableList.cfg_reincarnation = require 'luaRes.table.clientTable.cfg_reincarnation'
    tableLoader.TableList.cfg_sbk_donate_reward = require 'luaRes.table.clientTable.cfg_sbk_donate_reward'
    tableLoader.TableList.cfg_sbk_rank_reward = require 'luaRes.table.clientTable.cfg_sbk_rank_reward'
    tableLoader.TableList.cfg_sbk_reward_point = require 'luaRes.table.clientTable.cfg_sbk_reward_point'
    tableLoader.TableList.cfg_signet = require 'luaRes.table.clientTable.cfg_signet'
    tableLoader.TableList.cfg_skills = require 'luaRes.table.clientTable.cfg_skills'
    tableLoader.TableList.cfg_skills_condition = require 'luaRes.table.clientTable.cfg_skills_condition'
    tableLoader.TableList.cfg_soul_reward = require 'luaRes.table.clientTable.cfg_soul_reward'
    tableLoader.TableList.cfg_soul_task = require 'luaRes.table.clientTable.cfg_soul_task'
    tableLoader.TableList.cfg_special_activity = require 'luaRes.table.clientTable.cfg_special_activity'
    tableLoader.TableList.cfg_special_activity_goals = require 'luaRes.table.clientTable.cfg_special_activity_goals'
    tableLoader.TableList.cfg_suit = require 'luaRes.table.clientTable.cfg_suit'
    tableLoader.TableList.cfg_synthesis = require 'luaRes.table.clientTable.cfg_synthesis'
    tableLoader.TableList.cfg_system_preview = require 'luaRes.table.clientTable.cfg_system_preview'
    tableLoader.TableList.cfg_task = require 'luaRes.table.clientTable.cfg_task'
    tableLoader.TableList.cfg_taskgoal = require 'luaRes.table.clientTable.cfg_taskgoal'
    tableLoader.TableList.cfg_time_clock = require 'luaRes.table.clientTable.cfg_time_clock'
    tableLoader.TableList.cfg_title = require 'luaRes.table.clientTable.cfg_title'
    tableLoader.TableList.cfg_tower = require 'luaRes.table.clientTable.cfg_tower'
    tableLoader.TableList.cfg_uilogic = require 'luaRes.table.clientTable.cfg_uilogic'
    tableLoader.TableList.cfg_uilogic_caches = require 'luaRes.table.clientTable.cfg_uilogic_caches'
    tableLoader.TableList.cfg_uilogic_close = require 'luaRes.table.clientTable.cfg_uilogic_close'
    tableLoader.TableList.cfg_uilogic_hide = require 'luaRes.table.clientTable.cfg_uilogic_hide'
    tableLoader.TableList.cfg_uisets = require 'luaRes.table.clientTable.cfg_uisets'
    tableLoader.TableList.cfg_union_activity = require 'luaRes.table.clientTable.cfg_union_activity'
    tableLoader.TableList.cfg_union_boss_rank = require 'luaRes.table.clientTable.cfg_union_boss_rank'
    tableLoader.TableList.cfg_video = require 'luaRes.table.clientTable.cfg_video'
    tableLoader.TableList.cfg_vip = require 'luaRes.table.clientTable.cfg_vip'
    tableLoader.TableList.cfg_vip_level = require 'luaRes.table.clientTable.cfg_vip_level'
    tableLoader.TableList.cfg_vip_zunxiang = require 'luaRes.table.clientTable.cfg_vip_zunxiang'
    tableLoader.TableList.cfg_wayget_fastauction = require 'luaRes.table.clientTable.cfg_wayget_fastauction'
    tableLoader.TableList.cfg_way_get = require 'luaRes.table.clientTable.cfg_way_get'
    tableLoader.TableList.cfg_yabiao = require 'luaRes.table.clientTable.cfg_yabiao'
    tableLoader.TableList.cfg_zhenfa = require 'luaRes.table.clientTable.cfg_zhenfa'
end

function registerAllClientTable.OnLoad()
    clientTableManager.cfg_activeManager:OnLoad('cfg_active', tableLoader.TableList.cfg_active)
    clientTableManager.cfg_activity_bossManager:OnLoad('cfg_activity_boss', tableLoader.TableList.cfg_activity_boss)
    clientTableManager.cfg_activity_currentManager:OnLoad('cfg_activity_current', tableLoader.TableList.cfg_activity_current)
    clientTableManager.cfg_activity_goalsManager:OnLoad('cfg_activity_goals', tableLoader.TableList.cfg_activity_goals)
    clientTableManager.cfg_ancient_bossManager:OnLoad('cfg_ancient_boss', tableLoader.TableList.cfg_ancient_boss)
    clientTableManager.cfg_animals_bossManager:OnLoad('cfg_animals_boss', tableLoader.TableList.cfg_animals_boss)
    clientTableManager.cfg_appearanceManager:OnLoad('cfg_appearance', tableLoader.TableList.cfg_appearance)
    clientTableManager.cfg_attribute_showManager:OnLoad('cfg_attribute_show', tableLoader.TableList.cfg_attribute_show)
    clientTableManager.cfg_bairimen_activityManager:OnLoad('cfg_bairimen_activity', tableLoader.TableList.cfg_bairimen_activity)
    clientTableManager.cfg_bloodsuitManager:OnLoad('cfg_bloodsuit', tableLoader.TableList.cfg_bloodsuit)
    clientTableManager.cfg_bloodsuit_combinationManager:OnLoad('cfg_bloodsuit_combination', tableLoader.TableList.cfg_bloodsuit_combination)
    clientTableManager.cfg_bloodsuit_latticeManager:OnLoad('cfg_bloodsuit_lattice', tableLoader.TableList.cfg_bloodsuit_lattice)
    clientTableManager.cfg_bloodsuit_levelManager:OnLoad('cfg_bloodsuit_level', tableLoader.TableList.cfg_bloodsuit_level)
    clientTableManager.cfg_bloodsuit_resonanceManager:OnLoad('cfg_bloodsuit_resonance', tableLoader.TableList.cfg_bloodsuit_resonance)
    clientTableManager.cfg_bloodsuit_resonance_attributeManager:OnLoad('cfg_bloodsuit_resonance_attribute', tableLoader.TableList.cfg_bloodsuit_resonance_attribute)
    clientTableManager.cfg_bonfireManager:OnLoad('cfg_bonfire', tableLoader.TableList.cfg_bonfire)
    clientTableManager.cfg_bossManager:OnLoad('cfg_boss', tableLoader.TableList.cfg_boss)
    clientTableManager.cfg_boss_drop_showManager:OnLoad('cfg_boss_drop_show', tableLoader.TableList.cfg_boss_drop_show)
    clientTableManager.cfg_boss_skill_describeManager:OnLoad('cfg_boss_skill_describe', tableLoader.TableList.cfg_boss_skill_describe)
    clientTableManager.cfg_boss_taskManager:OnLoad('cfg_boss_task', tableLoader.TableList.cfg_boss_task)
    clientTableManager.cfg_buffManager:OnLoad('cfg_buff', tableLoader.TableList.cfg_buff)
    clientTableManager.cfg_collectionManager:OnLoad('cfg_collection', tableLoader.TableList.cfg_collection)
    clientTableManager.cfg_collectionboxManager:OnLoad('cfg_collectionbox', tableLoader.TableList.cfg_collectionbox)
    clientTableManager.cfg_conditionsManager:OnLoad('cfg_conditions', tableLoader.TableList.cfg_conditions)
    clientTableManager.cfg_cuilianManager:OnLoad('cfg_cuilian', tableLoader.TableList.cfg_cuilian)
    clientTableManager.cfg_cum_rechargeManager:OnLoad('cfg_cum_recharge', tableLoader.TableList.cfg_cum_recharge)
    clientTableManager.cfg_daily_activity_timeManager:OnLoad('cfg_daily_activity_time', tableLoader.TableList.cfg_daily_activity_time)
    clientTableManager.cfg_daily_taskManager:OnLoad('cfg_daily_task', tableLoader.TableList.cfg_daily_task)
    clientTableManager.cfg_deliverManager:OnLoad('cfg_deliver', tableLoader.TableList.cfg_deliver)
    clientTableManager.cfg_demon_bossManager:OnLoad('cfg_demon_boss', tableLoader.TableList.cfg_demon_boss)
    clientTableManager.cfg_descriptionManager:OnLoad('cfg_description', tableLoader.TableList.cfg_description)
    clientTableManager.cfg_divinelevelupManager:OnLoad('cfg_divinelevelup', tableLoader.TableList.cfg_divinelevelup)
    clientTableManager.cfg_divinesuitManager:OnLoad('cfg_divinesuit', tableLoader.TableList.cfg_divinesuit)
    clientTableManager.cfg_divinesuitattributeManager:OnLoad('cfg_divinesuitattribute', tableLoader.TableList.cfg_divinesuitattribute)
    clientTableManager.cfg_drop_show_groupManager:OnLoad('cfg_drop_show_group', tableLoader.TableList.cfg_drop_show_group)
    clientTableManager.cfg_equip_proficientManager:OnLoad('cfg_equip_proficient', tableLoader.TableList.cfg_equip_proficient)
    clientTableManager.cfg_eventsManager:OnLoad('cfg_events', tableLoader.TableList.cfg_events)
    clientTableManager.cfg_exppropManager:OnLoad('cfg_expprop', tableLoader.TableList.cfg_expprop)
    clientTableManager.cfg_extra_mon_effectManager:OnLoad('cfg_extra_mon_effect', tableLoader.TableList.cfg_extra_mon_effect)
    clientTableManager.cfg_gather_itemsManager:OnLoad('cfg_gather_items', tableLoader.TableList.cfg_gather_items)
    clientTableManager.cfg_gather_soulManager:OnLoad('cfg_gather_soul', tableLoader.TableList.cfg_gather_soul)
    clientTableManager.cfg_godfurnaceManager:OnLoad('cfg_godfurnace', tableLoader.TableList.cfg_godfurnace)
    clientTableManager.cfg_growth_weapon_classManager:OnLoad('cfg_growth_weapon_class', tableLoader.TableList.cfg_growth_weapon_class)
    clientTableManager.cfg_growth_weapon_levelManager:OnLoad('cfg_growth_weapon_level', tableLoader.TableList.cfg_growth_weapon_level)
    clientTableManager.cfg_guidebookManager:OnLoad('cfg_guidebook', tableLoader.TableList.cfg_guidebook)
    clientTableManager.cfg_guide_bubbleManager:OnLoad('cfg_guide_bubble', tableLoader.TableList.cfg_guide_bubble)
    clientTableManager.cfg_hidden_weaponManager:OnLoad('cfg_hidden_weapon', tableLoader.TableList.cfg_hidden_weapon)
    clientTableManager.cfg_horse_cardManager:OnLoad('cfg_horse_card', tableLoader.TableList.cfg_horse_card)
    clientTableManager.cfg_hsreinManager:OnLoad('cfg_hsrein', tableLoader.TableList.cfg_hsrein)
    clientTableManager.cfg_huanshouManager:OnLoad('cfg_huanshou', tableLoader.TableList.cfg_huanshou)
    clientTableManager.cfg_inlay_effectManager:OnLoad('cfg_inlay_effect', tableLoader.TableList.cfg_inlay_effect)
    clientTableManager.cfg_intensifyManager:OnLoad('cfg_intensify', tableLoader.TableList.cfg_intensify)
    clientTableManager.cfg_investManager:OnLoad('cfg_invest', tableLoader.TableList.cfg_invest)
    clientTableManager.cfg_itemsManager:OnLoad('cfg_items', tableLoader.TableList.cfg_items)
    clientTableManager.cfg_jiandingManager:OnLoad('cfg_jianding', tableLoader.TableList.cfg_jianding)
    clientTableManager.cfg_jumpManager:OnLoad('cfg_jump', tableLoader.TableList.cfg_jump)
    clientTableManager.cfg_leagueManager:OnLoad('cfg_league', tableLoader.TableList.cfg_league)
    clientTableManager.cfg_lingshoutaskManager:OnLoad('cfg_lingshoutask', tableLoader.TableList.cfg_lingshoutask)
    clientTableManager.cfg_linkeffectManager:OnLoad('cfg_linkeffect', tableLoader.TableList.cfg_linkeffect)
    clientTableManager.cfg_magicweaponManager:OnLoad('cfg_magicweapon', tableLoader.TableList.cfg_magicweapon)
    clientTableManager.cfg_mapManager:OnLoad('cfg_map', tableLoader.TableList.cfg_map)
    clientTableManager.cfg_mapeffectManager:OnLoad('cfg_mapeffect', tableLoader.TableList.cfg_mapeffect)
    clientTableManager.cfg_map_eventsManager:OnLoad('cfg_map_events', tableLoader.TableList.cfg_map_events)
    clientTableManager.cfg_memberManager:OnLoad('cfg_member', tableLoader.TableList.cfg_member)
    clientTableManager.cfg_member_taskManager:OnLoad('cfg_member_task', tableLoader.TableList.cfg_member_task)
    clientTableManager.cfg_monstersManager:OnLoad('cfg_monsters', tableLoader.TableList.cfg_monsters)
    clientTableManager.cfg_mysteriousoldmanManager:OnLoad('cfg_mysteriousoldman', tableLoader.TableList.cfg_mysteriousoldman)
    clientTableManager.cfg_noticeManager:OnLoad('cfg_notice', tableLoader.TableList.cfg_notice)
    clientTableManager.cfg_official_emperor_tokenManager:OnLoad('cfg_official_emperor_token', tableLoader.TableList.cfg_official_emperor_token)
    clientTableManager.cfg_official_positionManager:OnLoad('cfg_official_position', tableLoader.TableList.cfg_official_position)
    clientTableManager.cfg_pick_upManager:OnLoad('cfg_pick_up', tableLoader.TableList.cfg_pick_up)
    clientTableManager.cfg_potentialManager:OnLoad('cfg_potential', tableLoader.TableList.cfg_potential)
    clientTableManager.cfg_potential_investManager:OnLoad('cfg_potential_invest', tableLoader.TableList.cfg_potential_invest)
    clientTableManager.cfg_powerfulManager:OnLoad('cfg_powerful', tableLoader.TableList.cfg_powerful)
    clientTableManager.cfg_practice_roomManager:OnLoad('cfg_practice_room', tableLoader.TableList.cfg_practice_room)
    clientTableManager.cfg_prefix_titleManager:OnLoad('cfg_prefix_title', tableLoader.TableList.cfg_prefix_title)
    clientTableManager.cfg_promptframeManager:OnLoad('cfg_promptframe', tableLoader.TableList.cfg_promptframe)
    clientTableManager.cfg_promptwordManager:OnLoad('cfg_promptword', tableLoader.TableList.cfg_promptword)
    clientTableManager.cfg_property_nameManager:OnLoad('cfg_property_name', tableLoader.TableList.cfg_property_name)
    clientTableManager.cfg_rankManager:OnLoad('cfg_rank', tableLoader.TableList.cfg_rank)
    clientTableManager.cfg_recastManager:OnLoad('cfg_recast', tableLoader.TableList.cfg_recast)
    clientTableManager.cfg_recast_skillManager:OnLoad('cfg_recast_skill', tableLoader.TableList.cfg_recast_skill)
    clientTableManager.cfg_rechargeManager:OnLoad('cfg_recharge', tableLoader.TableList.cfg_recharge)
    clientTableManager.cfg_recoverManager:OnLoad('cfg_recover', tableLoader.TableList.cfg_recover)
    clientTableManager.cfg_recoversetManager:OnLoad('cfg_recoverset', tableLoader.TableList.cfg_recoverset)
    clientTableManager.cfg_refine_masterManager:OnLoad('cfg_refine_master', tableLoader.TableList.cfg_refine_master)
    clientTableManager.cfg_reincarnationManager:OnLoad('cfg_reincarnation', tableLoader.TableList.cfg_reincarnation)
    clientTableManager.cfg_sbk_donate_rewardManager:OnLoad('cfg_sbk_donate_reward', tableLoader.TableList.cfg_sbk_donate_reward)
    clientTableManager.cfg_sbk_rank_rewardManager:OnLoad('cfg_sbk_rank_reward', tableLoader.TableList.cfg_sbk_rank_reward)
    clientTableManager.cfg_sbk_reward_pointManager:OnLoad('cfg_sbk_reward_point', tableLoader.TableList.cfg_sbk_reward_point)
    clientTableManager.cfg_signetManager:OnLoad('cfg_signet', tableLoader.TableList.cfg_signet)
    clientTableManager.cfg_skillsManager:OnLoad('cfg_skills', tableLoader.TableList.cfg_skills)
    clientTableManager.cfg_skills_conditionManager:OnLoad('cfg_skills_condition', tableLoader.TableList.cfg_skills_condition)
    clientTableManager.cfg_soul_rewardManager:OnLoad('cfg_soul_reward', tableLoader.TableList.cfg_soul_reward)
    clientTableManager.cfg_soul_taskManager:OnLoad('cfg_soul_task', tableLoader.TableList.cfg_soul_task)
    clientTableManager.cfg_special_activityManager:OnLoad('cfg_special_activity', tableLoader.TableList.cfg_special_activity)
    clientTableManager.cfg_special_activity_goalsManager:OnLoad('cfg_special_activity_goals', tableLoader.TableList.cfg_special_activity_goals)
    clientTableManager.cfg_suitManager:OnLoad('cfg_suit', tableLoader.TableList.cfg_suit)
    clientTableManager.cfg_synthesisManager:OnLoad('cfg_synthesis', tableLoader.TableList.cfg_synthesis)
    clientTableManager.cfg_system_previewManager:OnLoad('cfg_system_preview', tableLoader.TableList.cfg_system_preview)
    clientTableManager.cfg_taskManager:OnLoad('cfg_task', tableLoader.TableList.cfg_task)
    clientTableManager.cfg_taskgoalManager:OnLoad('cfg_taskgoal', tableLoader.TableList.cfg_taskgoal)
    clientTableManager.cfg_time_clockManager:OnLoad('cfg_time_clock', tableLoader.TableList.cfg_time_clock)
    clientTableManager.cfg_titleManager:OnLoad('cfg_title', tableLoader.TableList.cfg_title)
    clientTableManager.cfg_towerManager:OnLoad('cfg_tower', tableLoader.TableList.cfg_tower)
    clientTableManager.cfg_uilogicManager:OnLoad('cfg_uilogic', tableLoader.TableList.cfg_uilogic)
    clientTableManager.cfg_uilogic_cachesManager:OnLoad('cfg_uilogic_caches', tableLoader.TableList.cfg_uilogic_caches)
    clientTableManager.cfg_uilogic_closeManager:OnLoad('cfg_uilogic_close', tableLoader.TableList.cfg_uilogic_close)
    clientTableManager.cfg_uilogic_hideManager:OnLoad('cfg_uilogic_hide', tableLoader.TableList.cfg_uilogic_hide)
    clientTableManager.cfg_uisetsManager:OnLoad('cfg_uisets', tableLoader.TableList.cfg_uisets)
    clientTableManager.cfg_union_activityManager:OnLoad('cfg_union_activity', tableLoader.TableList.cfg_union_activity)
    clientTableManager.cfg_union_boss_rankManager:OnLoad('cfg_union_boss_rank', tableLoader.TableList.cfg_union_boss_rank)
    clientTableManager.cfg_videoManager:OnLoad('cfg_video', tableLoader.TableList.cfg_video)
    clientTableManager.cfg_vipManager:OnLoad('cfg_vip', tableLoader.TableList.cfg_vip)
    clientTableManager.cfg_vip_levelManager:OnLoad('cfg_vip_level', tableLoader.TableList.cfg_vip_level)
    clientTableManager.cfg_vip_zunxiangManager:OnLoad('cfg_vip_zunxiang', tableLoader.TableList.cfg_vip_zunxiang)
    clientTableManager.cfg_wayget_fastauctionManager:OnLoad('cfg_wayget_fastauction', tableLoader.TableList.cfg_wayget_fastauction)
    clientTableManager.cfg_way_getManager:OnLoad('cfg_way_get', tableLoader.TableList.cfg_way_get)
    clientTableManager.cfg_yabiaoManager:OnLoad('cfg_yabiao', tableLoader.TableList.cfg_yabiao)
    clientTableManager.cfg_zhenfaManager:OnLoad('cfg_zhenfa', tableLoader.TableList.cfg_zhenfa)
end

return registerAllClientTable