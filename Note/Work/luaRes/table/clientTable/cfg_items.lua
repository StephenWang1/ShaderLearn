--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_items
local cfg_items = {}

cfg_items.__index = cfg_items

function cfg_items:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  第1位：道具类型（后期可加到2位）；第23位：子类型(技能经验除外)；第4567位代表编号(衣服第4位为性别)
function cfg_items:GetId()
    if self.id ~= nil then
        return self.id
    else
        if self:CsTABLE() ~= nil then
            self.id = self:CsTABLE().id
            return self.id
        else
            return nil
        end
    end
end

---@return number 关联道具id#客户端#C  同个道具不同id互相关联字段
function cfg_items:GetLinkItemId()
    if self.linkItemId ~= nil then
        return self.linkItemId
    else
        if self:CsTABLE() ~= nil then
            self.linkItemId = self:CsTABLE().linkItemId
            return self.linkItemId
        else
            return nil
        end
    end
end

---@return string 道具名称#客户端#C
function cfg_items:GetName()
    if self.name ~= nil then
        return self.name
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().name
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具模型#客户端#C  配置模型ID
function cfg_items:GetModel()
    if self.model ~= nil then
        return self.model
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().model
        else
            return nil
        end
    end
end

---@return string 道具图标#客户端#C  配置Icon名称
function cfg_items:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return string 道具获取途径说明文本#客户端#C  用于配置道具tips上获取途径，索引read表id  id
function cfg_items:GetWayGetRead()
    if self.wayGetRead ~= nil then
        return self.wayGetRead
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().wayGetRead
        else
            return nil
        end
    end
end

---@return number 组别#客户端#C  具体划分按实际需求改
function cfg_items:GetGroup()
    if self.group ~= nil then
        return self.group
    else
        if self:CsTABLE() ~= nil then
            self.group = self:CsTABLE().group
            return self.group
        else
            return nil
        end
    end
end

---@return string 道具固定转化#客户端#C  itemid#count&itemid#count回收固定受益
function cfg_items:GetEqual()
    if self.equal ~= nil then
        return self.equal
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().equal
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具概率转化#客户端#C  itemid#count#rate回收概率受益
function cfg_items:GetExtraEqual()
    if self.extraEqual ~= nil then
        return self.extraEqual
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraEqual
        else
            return nil
        end
    end
end

---@return number 绑定道具对应非绑定道具#客户端#C#不存在共同参与合并的字段  填与绑定道具对应的非绑定道具的id
function cfg_items:GetBindEqualItem()
    if self.bindEqualItem ~= nil then
        return self.bindEqualItem
    else
        if self:CsTABLE() ~= nil then
            self.bindEqualItem = self:CsTABLE().bindEqualItem
            return self.bindEqualItem
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 获得途径#客户端#C  对应cfg_way_get表里的id（未知用途）
function cfg_items:GetWayGet()
    if self.wayGet ~= nil then
        return self.wayGet
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().wayGet
        else
            return nil
        end
    end
end

---@return number 道具叠加数量#客户端#C#不存在共同参与合并的字段
function cfg_items:GetOverlying()
    if self.overlying ~= nil then
        return self.overlying
    else
        if self:CsTABLE() ~= nil then
            self.overlying = self:CsTABLE().overlying
            return self.overlying
        else
            return nil
        end
    end
end

---@return number 左侧按钮#客户端#C  关联到cfg_items_operate表
function cfg_items:GetLeftOperate()
    if self.leftOperate ~= nil then
        return self.leftOperate
    else
        if self:CsTABLE() ~= nil then
            self.leftOperate = self:CsTABLE().leftOperate
            return self.leftOperate
        else
            return nil
        end
    end
end

---@return number 右侧按钮#客户端#C  关联到cfg_items_operate表
function cfg_items:GetRightOperate()
    if self.rightOperate ~= nil then
        return self.rightOperate
    else
        if self:CsTABLE() ~= nil then
            self.rightOperate = self:CsTABLE().rightOperate
            return self.rightOperate
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 使用的参数，不同的道具不一样#客户端#C  1、经验药：增加经验数量。2、技能书：技能ID#经验数量。3、瞬间回血回蓝药：回血数#回蓝数（不回填0）4、传送石：1随机传送；2回城传送。5、召唤boss：monstersID(#分隔，随机选取)。6、角色升级药：等级限制#提升等级#经验。7、聚灵珠：经验获取倍数#经验获取上限#vip领取经验倍数（百分比）。8、红包卷：奖池增加红包金额。9、幻兽蛋：幻兽id；10、改名卡：1角色改名；2行会改名；11、神力值卷轴：#增加经验量；22勋章佩戴神力值限制 神力值id#数量 ； 12 碎片 ：合成物品id#碎片数量；23使用后加亲密度点数（魅力值#亲密度)；13、定点传送石：地图id#X坐标#Y坐标；15魂玉穿戴限制；21宝石手套穿戴限制；20防守之源等级；19进攻之源等级；18灵兽秘宝穿戴限制；17宝石等级；16玉魂等级；14灯芯等级；13赤焰灯穿戴限制  时装 道具及可以触发时装的道具  如神力：时装表id  限时外观 这里配置的是永久外观的道具id 22：烟花道具使用后增加的剩余梦境时间（秒） 婚戒：增加的亲密度上限    火药桶：mapeventid  红包： 元宝数量  面纱 ：物品掉落后返还几率  万分数  穿戴中/背包中   人物法宝：magicweapon id#装备位id  狂暴药剂：生效buffid#禁止使用buffid
function cfg_items:GetUseParam()
    if self.useParam ~= nil then
        return self.useParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().useParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 使用的参数，不同的道具不一样#客户端#C  11-1碎片合成参数；11-2精魄合成参数；2-15魂玉合成参数；灯芯：灯座暴击伤害加成万分比；元石：宝饰攻击加成万分比；进攻之源：灵兽秘宝回血速度加成万分比
function cfg_items:GetCompoundParam()
    if self.compoundParam ~= nil then
        return self.compoundParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().compoundParam
        else
            return nil
        end
    end
end

---@return number 宝箱是否自动打开#客户端#C  0不打开，1打开
function cfg_items:GetAutouse()
    if self.autouse ~= nil then
        return self.autouse
    else
        if self:CsTABLE() ~= nil then
            self.autouse = self:CsTABLE().autouse
            return self.autouse
        else
            return nil
        end
    end
end

---@return string 道具描述2#客户端#C  道具描述可配置文字和颜色   根据是否配置 职业type#，决定是否针对不同职业显示不同tips
function cfg_items:GetTips2()
    if self.tips2 ~= nil then
        return self.tips2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips2
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 元石吸血#客户端#C  攻击概率将伤害万分比转化部分为自身血量 万分比#万分比血量
function cfg_items:GetSuckBlood()
    if self.suckBlood ~= nil then
        return self.suckBlood
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().suckBlood
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 假元石吸血显示#客户端#C  假概率，假血量显示用，万分比
function cfg_items:GetSuckBloodFake()
    if self.suckBloodFake ~= nil then
        return self.suckBloodFake
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().suckBloodFake
        else
            return nil
        end
    end
end

---@return number 最大物理攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetPhyAttackMax()
    if self.phyAttackMax ~= nil then
        return self.phyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMax = self:CsTABLE().phyAttackMax
            return self.phyAttackMax
        else
            return nil
        end
    end
end

---@return number 最小物理攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetPhyAttackMin()
    if self.phyAttackMin ~= nil then
        return self.phyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMin = self:CsTABLE().phyAttackMin
            return self.phyAttackMin
        else
            return nil
        end
    end
end

---@return number 最大魔法#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetMagicAttackMax()
    if self.magicAttackMax ~= nil then
        return self.magicAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMax = self:CsTABLE().magicAttackMax
            return self.magicAttackMax
        else
            return nil
        end
    end
end

---@return number 最小魔法#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetMagicAttackMin()
    if self.magicAttackMin ~= nil then
        return self.magicAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMin = self:CsTABLE().magicAttackMin
            return self.magicAttackMin
        else
            return nil
        end
    end
end

---@return number 最大道术#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetTaoAttackMax()
    if self.taoAttackMax ~= nil then
        return self.taoAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMax = self:CsTABLE().taoAttackMax
            return self.taoAttackMax
        else
            return nil
        end
    end
end

---@return number 最小道术#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetTaoAttackMin()
    if self.taoAttackMin ~= nil then
        return self.taoAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMin = self:CsTABLE().taoAttackMin
            return self.taoAttackMin
        else
            return nil
        end
    end
end

---@return number 最大物理防御#客户端#C#不存在共同参与合并的字段  生成道具时
function cfg_items:GetPhyDefenceMax()
    if self.phyDefenceMax ~= nil then
        return self.phyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMax = self:CsTABLE().phyDefenceMax
            return self.phyDefenceMax
        else
            return nil
        end
    end
end

---@return number 最小物理防御#客户端#C#不存在共同参与合并的字段  生成道具时
function cfg_items:GetPhyDefenceMin()
    if self.phyDefenceMin ~= nil then
        return self.phyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMin = self:CsTABLE().phyDefenceMin
            return self.phyDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大魔法防御#客户端#C#不存在共同参与合并的字段  生成道具时
function cfg_items:GetMagicDefenceMax()
    if self.magicDefenceMax ~= nil then
        return self.magicDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMax = self:CsTABLE().magicDefenceMax
            return self.magicDefenceMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 不同职业道具属性加成#客户端#C  职业#最大物理防御#最小物理防御#最大魔防#最小魔防#血量&职业#最大物理防御#最小物理防御#最大魔防#最小魔防#血量  （职业 1 战士 2法师 3 道士）
function cfg_items:GetValueCareerClient()
    if self.valueCareerClient ~= nil then
        return self.valueCareerClient
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().valueCareerClient
        else
            return nil
        end
    end
end

---@return number 血量继承千分比#客户端#C  元灵秘宝属性 血量继承千分比
function cfg_items:GetHpPercentage()
    if self.hpPercentage ~= nil then
        return self.hpPercentage
    else
        if self:CsTABLE() ~= nil then
            self.hpPercentage = self:CsTABLE().hpPercentage
            return self.hpPercentage
        else
            return nil
        end
    end
end

---@return number 攻击继承千分比#客户端#C  元灵秘宝属性 攻击继承 千分比
function cfg_items:GetAttackPercentage()
    if self.attackPercentage ~= nil then
        return self.attackPercentage
    else
        if self:CsTABLE() ~= nil then
            self.attackPercentage = self:CsTABLE().attackPercentage
            return self.attackPercentage
        else
            return nil
        end
    end
end

---@return number 防御继承千分比#客户端#C  元灵秘宝属性 防御继承 千分比
function cfg_items:GetDefensePercentage()
    if self.defensePercentage ~= nil then
        return self.defensePercentage
    else
        if self:CsTABLE() ~= nil then
            self.defensePercentage = self:CsTABLE().defensePercentage
            return self.defensePercentage
        else
            return nil
        end
    end
end

---@return number 灵兽血量#客户端#C#不存在共同参与合并的字段  灵兽血量
function cfg_items:GetHsmaxHp()
    if self.hsmaxHp ~= nil then
        return self.hsmaxHp
    else
        if self:CsTABLE() ~= nil then
            self.hsmaxHp = self:CsTABLE().hsmaxHp
            return self.hsmaxHp
        else
            return nil
        end
    end
end

---@return number 灵兽最大物理防御#客户端#C#不存在共同参与合并的字段  灵兽最大物理防御
function cfg_items:GetHsphyDefenceMax()
    if self.hsphyDefenceMax ~= nil then
        return self.hsphyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.hsphyDefenceMax = self:CsTABLE().hsphyDefenceMax
            return self.hsphyDefenceMax
        else
            return nil
        end
    end
end

---@return number 灵兽最小物理防御#客户端#C#不存在共同参与合并的字段  灵兽最小物理防御
function cfg_items:GetHsphyDefenceMin()
    if self.hsphyDefenceMin ~= nil then
        return self.hsphyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.hsphyDefenceMin = self:CsTABLE().hsphyDefenceMin
            return self.hsphyDefenceMin
        else
            return nil
        end
    end
end

---@return number 灵兽最大魔法防御#客户端#C#不存在共同参与合并的字段  灵兽最大魔法防御
function cfg_items:GetHsmagicDefenceMax()
    if self.hsmagicDefenceMax ~= nil then
        return self.hsmagicDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.hsmagicDefenceMax = self:CsTABLE().hsmagicDefenceMax
            return self.hsmagicDefenceMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 灵兽回血#客户端#C  灵兽回血属性出战回血/每3秒#合体护盾回血
function cfg_items:GetHsHpRecover()
    if self.hsHpRecover ~= nil then
        return self.hsHpRecover
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hsHpRecover
        else
            return nil
        end
    end
end

---@return number 暴击伤害#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetCriticalDamage()
    if self.criticalDamage ~= nil then
        return self.criticalDamage
    else
        if self:CsTABLE() ~= nil then
            self.criticalDamage = self:CsTABLE().criticalDamage
            return self.criticalDamage
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 血量#客户端#C  属性（1表示战士2表示法师3表示道士）1#100&2#200&3#300  &表示隔开 #代表对应职业血量
function cfg_items:GetMaxHp()
    if self.maxHp ~= nil then
        return self.maxHp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().maxHp
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 灯芯秒杀属性#客户端#C  攻击玩家血量一定数量以下会有概率秒杀玩家，攻击玩家血量万分比以下#秒杀概率万分比
function cfg_items:GetSeckill()
    if self.seckill ~= nil then
        return self.seckill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().seckill
        else
            return nil
        end
    end
end

---@return number 最小神圣攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetHolyAttackMin()
    if self.holyAttackMin ~= nil then
        return self.holyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMin = self:CsTABLE().holyAttackMin
            return self.holyAttackMin
        else
            return nil
        end
    end
end

---@return number 最大神圣攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetHolyAttackMax()
    if self.holyAttackMax ~= nil then
        return self.holyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMax = self:CsTABLE().holyAttackMax
            return self.holyAttackMax
        else
            return nil
        end
    end
end

---@return number 最小神圣防御#客户端#C#不存在共同参与合并的字段  属性
function cfg_items:GetHolyDefenceMin()
    if self.holyDefenceMin ~= nil then
        return self.holyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMin = self:CsTABLE().holyDefenceMin
            return self.holyDefenceMin
        else
            return nil
        end
    end
end

---@return string 技能说明#客户端#C  技能描述（文本+颜色）
function cfg_items:GetExtraSkillTips()
    if self.extraSkillTips ~= nil then
        return self.extraSkillTips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraSkillTips
        else
            return nil
        end
    end
end

---@return number 展示暴击#客户端#C  显示暴击数值（假数值万分比）
function cfg_items:GetShowCritical()
    if self.showCritical ~= nil then
        return self.showCritical
    else
        if self:CsTABLE() ~= nil then
            self.showCritical = self:CsTABLE().showCritical
            return self.showCritical
        else
            return nil
        end
    end
end

---@return number 装备最大持久#客户端#C  不填则没有持久
function cfg_items:GetMaxLasting()
    if self.maxLasting ~= nil then
        return self.maxLasting
    else
        if self:CsTABLE() ~= nil then
            self.maxLasting = self:CsTABLE().maxLasting
            return self.maxLasting
        else
            return nil
        end
    end
end

---@return number 是否耗损持久#客户端#C  0不耗损1耗损-1不显示耐久
function cfg_items:GetIsWastageLasting()
    if self.isWastageLasting ~= nil then
        return self.isWastageLasting
    else
        if self:CsTABLE() ~= nil then
            self.isWastageLasting = self:CsTABLE().isWastageLasting
            return self.isWastageLasting
        else
            return nil
        end
    end
end

---@return string 使用后打开界面#客户端#C  按钮id#jumpid&按钮id#jumpid
function cfg_items:GetOpenPanel()
    if self.openPanel ~= nil then
        return self.openPanel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openPanel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 是否限时道具#客户端#C  不是就不填1.获得道具一定时间后清除 2.获得装备后一定时间后清除 3.表示在每周星期几的0点清除 4.在指定日期清除 5.活动开启时：5#活动id
function cfg_items:GetLimitedType()
    if self.limitedType ~= nil then
        return self.limitedType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().limitedType
        else
            return nil
        end
    end
end

---@return number 限制时间道具#客户端#C  非限制时间道具填0对应limitedType 1/2.持续时间 3.1-7代表星期几 4.指定日期（填时间戳）5.
function cfg_items:GetLimitedTime()
    if self.limitedTime ~= nil then
        return self.limitedTime
    else
        if self:CsTABLE() ~= nil then
            self.limitedTime = self:CsTABLE().limitedTime
            return self.limitedTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 修理1点耐久需要的货币及数量#客户端#C  itemid#数值
function cfg_items:GetRepairCost()
    if self.repairCost ~= nil then
        return self.repairCost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().repairCost
        else
            return nil
        end
    end
end

---@return string 标签名#客户端#C  若不填，则根据道具type默认显示（1，资源 ；2 【装备tips格式特殊】 3， 药品 4 技能书 5  宝箱  6  材料  7 技能经验  8  辅助【灵兽tip格式特殊】9 元素 10 攻城 11【碎片格式特殊】  12  印记），填了的话，则显示相应名称
function cfg_items:GetTag()
    if self.tag ~= nil then
        return self.tag
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tag
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 可交易道具筛选条件#客户端#C  条件1#条件2 具体条件配置在item_tradetype表
function cfg_items:GetTradeType()
    if self.tradeType ~= nil then
        return self.tradeType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tradeType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 重复使用次数显示位置#客户端#C  1、显示在道具tips中；2、显示在背包icon上(显示位置#icon，icon为剩余使用次数为1时显示的icon)
function cfg_items:GetReuseType()
    if self.reuseType ~= nil then
        return self.reuseType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().reuseType
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 是否能够交易#客户端#C  2个一组 开服天数#开服天数
function cfg_items:GetCanDeal()
    if self.canDeal ~= nil then
        return self.canDeal
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().canDeal
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 物品交易初始价格控制#客户端#C  货币id#系统底价#市场上限初始价格
function cfg_items:GetDealPriceSection()
    if self.dealPriceSection ~= nil then
        return self.dealPriceSection
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dealPriceSection
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 物品价格上限，随开服天数变动#客户端#C  4个一组  开服天数#开服天数#货币id#上限值
function cfg_items:GetTopPrice()
    if self.topPrice ~= nil then
        return self.topPrice
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().topPrice
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 拍卖价格区间#客户端#C  货币id#起拍最低价#起拍最高价#竞价比例（万分数）#一口价倍数
function cfg_items:GetBidPriceSection()
    if self.bidPriceSection ~= nil then
        return self.bidPriceSection
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bidPriceSection
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 对应法宝满级后，修复一点耐久消耗资源#客户端#C  资源id#资源数量&资源id#资源量
function cfg_items:GetRepairCost2()
    if self.repairCost2 ~= nil then
        return self.repairCost2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().repairCost2
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 是否可交易#客户端#C  开服天数#开服天数#道具产出量#道具产出量#是否可元宝交易#是否可钻石竞拍#是否可钻石交易#是否可元宝竞拍（1可以 0不可以）
function cfg_items:GetCanDealLimit()
    if self.canDealLimit ~= nil then
        return self.canDealLimit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().canDealLimit
        else
            return nil
        end
    end
end

---@return number 战损价值#客户端#C  战损价值
function cfg_items:GetWarDamageValue()
    if self.WarDamageValue ~= nil then
        return self.WarDamageValue
    else
        if self:CsTABLE() ~= nil then
            self.WarDamageValue = self:CsTABLE().WarDamageValue
            return self.WarDamageValue
        else
            return nil
        end
    end
end

---@return number 重量#客户端#C  重量#客户端
function cfg_items:GetWeight()
    if self.weight ~= nil then
        return self.weight
    else
        if self:CsTABLE() ~= nil then
            self.weight = self:CsTABLE().weight
            return self.weight
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具价值#客户端#C  装备赎回时计算赎回价格用，道具id#num
function cfg_items:GetItemValue()
    if self.itemValue ~= nil then
        return self.itemValue
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemValue
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 收藏家出售固定转化#客户端#C  收藏家出售价格itemid#count&itemid#count
function cfg_items:GetHighRecycle()
    if self.highRecycle ~= nil then
        return self.highRecycle
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().highRecycle
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 熔炼必定获得#客户端#C  道具id#数量下限#数量上限&道具id#数量下限#数量上限
function cfg_items:GetSmelt()
    if self.smelt ~= nil then
        return self.smelt
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smelt
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 熔炼概率获得#客户端#C  道具id#道具数量#概率&道具id#道具数量#概率（十万分数）
function cfg_items:GetSmeltExtra()
    if self.smeltExtra ~= nil then
        return self.smeltExtra
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smeltExtra
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 熔炼回购价格#客户端#C  道具id#价格下限#价格上限
function cfg_items:GetSmeltBuyPrice()
    if self.smeltBuyPrice ~= nil then
        return self.smeltBuyPrice
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smeltBuyPrice
        else
            return nil
        end
    end
end

---@return number 是否可直接交易#客户端#C  是否可直接交易  不填或0可以 1则不可以
function cfg_items:GetFaceToFaceDeal()
    if self.faceToFaceDeal ~= nil then
        return self.faceToFaceDeal
    else
        if self:CsTABLE() ~= nil then
            self.faceToFaceDeal = self:CsTABLE().faceToFaceDeal
            return self.faceToFaceDeal
        else
            return nil
        end
    end
end

---@return number 神力装备类型#客户端#C  索引到divineSuit表id，以读取道具归属的神力类型及等级
function cfg_items:GetDivineId()
    if self.divineId ~= nil then
        return self.divineId
    else
        if self:CsTABLE() ~= nil then
            self.divineId = self:CsTABLE().divineId
            return self.divineId
        else
            return nil
        end
    end
end

---@return number 掉宝概率#客户端#C  掉宝概率 十万分比
function cfg_items:GetAddDropTreasure()
    if self.addDropTreasure ~= nil then
        return self.addDropTreasure
    else
        if self:CsTABLE() ~= nil then
            self.addDropTreasure = self:CsTABLE().addDropTreasure
            return self.addDropTreasure
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具光柱显示限制#客户端#C  光柱显示的condition限制 不满足不显示
function cfg_items:GetLightBeamCondition()
    if self.lightBeamCondition ~= nil then
        return self.lightBeamCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().lightBeamCondition
        else
            return nil
        end
    end
end

---@return number 外观id#客户端#C  该道具对应的外观id  索引appearance表  如果是限时外观 配置的是对应的永久外观的道具id
function cfg_items:GetAppearanceId()
    if self.appearanceId ~= nil then
        return self.appearanceId
    else
        if self:CsTABLE() ~= nil then
            self.appearanceId = self:CsTABLE().appearanceId
            return self.appearanceId
        else
            return nil
        end
    end
end

---@return number 拾取类型#客户端#C  拾取类型，索引到pickup 中id字段
function cfg_items:GetPickUpType()
    if self.pickUpType ~= nil then
        return self.pickUpType
    else
        if self:CsTABLE() ~= nil then
            self.pickUpType = self:CsTABLE().pickUpType
            return self.pickUpType
        else
            return nil
        end
    end
end

---@return number 道具类型_C
function cfg_items:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end
---@return number 子类型_C
function cfg_items:GetSubType()
    if self.subType ~= nil then
        return self.subType
    else
        if self:CsTABLE() ~= nil then
            self.subType = self:CsTABLE().subType
            return self.subType
        else
            return nil
        end
    end
end

---@return number 使用等级_C
function cfg_items:GetUseLv()
    if self.useLv ~= nil then
        return self.useLv
    else
        if self:CsTABLE() ~= nil then
            self.useLv = self:CsTABLE().useLv
            return self.useLv
        else
            return nil
        end
    end
end
---@return number 转生等级_C
function cfg_items:GetReinLv()
    if self.reinLv ~= nil then
        return self.reinLv
    else
        if self:CsTABLE() ~= nil then
            self.reinLv = self:CsTABLE().reinLv
            return self.reinLv
        else
            return nil
        end
    end
end
---@return number 道具使用限制_C
function cfg_items:GetUseCondition()
    if self.useCondition ~= nil then
        return self.useCondition
    else
        if self:CsTABLE() ~= nil then
            self.useCondition = self:CsTABLE().useCondition
            return self.useCondition
        else
            return nil
        end
    end
end
---@return number 道具使用职业限制_C
function cfg_items:GetCareer()
    if self.career ~= nil then
        return self.career
    else
        if self:CsTABLE() ~= nil then
            self.career = self:CsTABLE().career
            return self.career
        else
            return nil
        end
    end
end
---@return number 性别_C
function cfg_items:GetSex()
    if self.sex ~= nil then
        return self.sex
    else
        if self:CsTABLE() ~= nil then
            self.sex = self:CsTABLE().sex
            return self.sex
        else
            return nil
        end
    end
end
---@return number 道具品质_C
function cfg_items:GetQuality()
    if self.quality ~= nil then
        return self.quality
    else
        if self:CsTABLE() ~= nil then
            self.quality = self:CsTABLE().quality
            return self.quality
        else
            return nil
        end
    end
end
---@return number 是否绑定_C
function cfg_items:GetBind()
    if self.bind ~= nil then
        return self.bind
    else
        if self:CsTABLE() ~= nil then
            self.bind = self:CsTABLE().bind
            return self.bind
        else
            return nil
        end
    end
end

---@return number 物品冷却_C
function cfg_items:GetResetTime()
    if self.resetTime ~= nil then
        return self.resetTime
    else
        if self:CsTABLE() ~= nil then
            self.resetTime = self:CsTABLE().resetTime
            return self.resetTime
        else
            return nil
        end
    end
end
---@return number 使用次数限制_C
function cfg_items:GetUseLimit()
    if self.useLimit ~= nil then
        return self.useLimit
    else
        if self:CsTABLE() ~= nil then
            self.useLimit = self:CsTABLE().useLimit
            return self.useLimit
        else
            return nil
        end
    end
end
---@return number 是否可以摧毁_C
function cfg_items:GetIsDelete()
    if self.isDelete ~= nil then
        return self.isDelete
    else
        if self:CsTABLE() ~= nil then
            self.isDelete = self:CsTABLE().isDelete
            return self.isDelete
        else
            return nil
        end
    end
end

---@return number 是否批量使用_C
function cfg_items:GetBatchusage()
    if self.batchusage ~= nil then
        return self.batchusage
    else
        if self:CsTABLE() ~= nil then
            self.batchusage = self:CsTABLE().batchusage
            return self.batchusage
        else
            return nil
        end
    end
end
---@return number 排序_C
function cfg_items:GetIndex()
    if self.index ~= nil then
        return self.index
    else
        if self:CsTABLE() ~= nil then
            self.index = self:CsTABLE().index
            return self.index
        else
            return nil
        end
    end
end
---@return number 唯一性字段_C
function cfg_items:GetOnly()
    if self.only ~= nil then
        return self.only
    else
        if self:CsTABLE() ~= nil then
            self.only = self:CsTABLE().only
            return self.only
        else
            return nil
        end
    end
end

---@return number 战斗力/价值_C
function cfg_items:GetNbValue()
    if self.nbValue ~= nil then
        return self.nbValue
    else
        if self:CsTABLE() ~= nil then
            self.nbValue = self:CsTABLE().nbValue
            return self.nbValue
        else
            return nil
        end
    end
end
---@return number 是否可捐献_C
function cfg_items:GetIsDonate()
    if self.isDonate ~= nil then
        return self.isDonate
    else
        if self:CsTABLE() ~= nil then
            self.isDonate = self:CsTABLE().isDonate
            return self.isDonate
        else
            return nil
        end
    end
end

---@return number 公会捐装备获得元宝_C
function cfg_items:GetGongXian()
    if self.gongXian ~= nil then
        return self.gongXian
    else
        if self:CsTABLE() ~= nil then
            self.gongXian = self:CsTABLE().gongXian
            return self.gongXian
        else
            return nil
        end
    end
end
---@return number 活动过期后可以出售活动的道具_C
function cfg_items:GetActivitySell()
    if self.activitySell ~= nil then
        return self.activitySell
    else
        if self:CsTABLE() ~= nil then
            self.activitySell = self:CsTABLE().activitySell
            return self.activitySell
        else
            return nil
        end
    end
end
---@return number 活动配置，活动过期后可以出售_C
function cfg_items:GetActivityPast()
    if self.activityPast ~= nil then
        return self.activityPast
    else
        if self:CsTABLE() ~= nil then
            self.activityPast = self:CsTABLE().activityPast
            return self.activityPast
        else
            return nil
        end
    end
end

---@return number 最小魔法防御_C
function cfg_items:GetMagicDefenceMin()
    if self.magicDefenceMin ~= nil then
        return self.magicDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMin = self:CsTABLE().magicDefenceMin
            return self.magicDefenceMin
        else
            return nil
        end
    end
end
---@return number 精准_C
function cfg_items:GetAccurate()
    if self.accurate ~= nil then
        return self.accurate
    else
        if self:CsTABLE() ~= nil then
            self.accurate = self:CsTABLE().accurate
            return self.accurate
        else
            return nil
        end
    end
end
---@return number 闪避_C
function cfg_items:GetDodge()
    if self.dodge ~= nil then
        return self.dodge
    else
        if self:CsTABLE() ~= nil then
            self.dodge = self:CsTABLE().dodge
            return self.dodge
        else
            return nil
        end
    end
end

---@return number 切割伤害继承万分比_C
function cfg_items:GetCutDamage()
    if self.cutDamage ~= nil then
        return self.cutDamage
    else
        if self:CsTABLE() ~= nil then
            self.cutDamage = self:CsTABLE().cutDamage
            return self.cutDamage
        else
            return nil
        end
    end
end
---@return number 神圣防御继承万分比_C
function cfg_items:GetSacredDefense()
    if self.sacredDefense ~= nil then
        return self.sacredDefense
    else
        if self:CsTABLE() ~= nil then
            self.sacredDefense = self:CsTABLE().sacredDefense
            return self.sacredDefense
        else
            return nil
        end
    end
end

---@return number 灵兽最小魔法防御_C
function cfg_items:GetHsmagicDefenceMin()
    if self.hsmagicDefenceMin ~= nil then
        return self.hsmagicDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.hsmagicDefenceMin = self:CsTABLE().hsmagicDefenceMin
            return self.hsmagicDefenceMin
        else
            return nil
        end
    end
end
---@return number hp恢复_C
function cfg_items:GetHpRecover()
    if self.hpRecover ~= nil then
        return self.hpRecover
    else
        if self:CsTABLE() ~= nil then
            self.hpRecover = self:CsTABLE().hpRecover
            return self.hpRecover
        else
            return nil
        end
    end
end
---@return number 攻击速度_C
function cfg_items:GetAttackSpeed()
    if self.attackSpeed ~= nil then
        return self.attackSpeed
    else
        if self:CsTABLE() ~= nil then
            self.attackSpeed = self:CsTABLE().attackSpeed
            return self.attackSpeed
        else
            return nil
        end
    end
end
---@return number 魔法恢复_C
function cfg_items:GetMpRecover()
    if self.mpRecover ~= nil then
        return self.mpRecover
    else
        if self:CsTABLE() ~= nil then
            self.mpRecover = self:CsTABLE().mpRecover
            return self.mpRecover
        else
            return nil
        end
    end
end
---@return number 幸运_C
function cfg_items:GetLuck()
    if self.luck ~= nil then
        return self.luck
    else
        if self:CsTABLE() ~= nil then
            self.luck = self:CsTABLE().luck
            return self.luck
        else
            return nil
        end
    end
end

---@return number 暴击倍率_C
function cfg_items:GetCriticalHurtAdd()
    if self.criticalHurtAdd ~= nil then
        return self.criticalHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.criticalHurtAdd = self:CsTABLE().criticalHurtAdd
            return self.criticalHurtAdd
        else
            return nil
        end
    end
end
---@return number 内力_C
function cfg_items:GetInnerPowerMax()
    if self.innerPowerMax ~= nil then
        return self.innerPowerMax
    else
        if self:CsTABLE() ~= nil then
            self.innerPowerMax = self:CsTABLE().innerPowerMax
            return self.innerPowerMax
        else
            return nil
        end
    end
end

---@return number 魔法值_C
function cfg_items:GetMaxMp()
    if self.maxMp ~= nil then
        return self.maxMp
    else
        if self:CsTABLE() ~= nil then
            self.maxMp = self:CsTABLE().maxMp
            return self.maxMp
        else
            return nil
        end
    end
end
---@return number 暴击率_C
function cfg_items:GetCritical()
    if self.critical ~= nil then
        return self.critical
    else
        if self:CsTABLE() ~= nil then
            self.critical = self:CsTABLE().critical
            return self.critical
        else
            return nil
        end
    end
end

---@return number 最大神圣防御_C
function cfg_items:GetHolyDefenceMax()
    if self.holyDefenceMax ~= nil then
        return self.holyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMax = self:CsTABLE().holyDefenceMax
            return self.holyDefenceMax
        else
            return nil
        end
    end
end
---@return number 穿透属性_C
function cfg_items:GetPenetrationAttributes()
    if self.penetrationAttributes ~= nil then
        return self.penetrationAttributes
    else
        if self:CsTABLE() ~= nil then
            self.penetrationAttributes = self:CsTABLE().penetrationAttributes
            return self.penetrationAttributes
        else
            return nil
        end
    end
end
---@return number 抗暴百分比_C
function cfg_items:GetResistanceCrit()
    if self.resistanceCrit ~= nil then
        return self.resistanceCrit
    else
        if self:CsTABLE() ~= nil then
            self.resistanceCrit = self:CsTABLE().resistanceCrit
            return self.resistanceCrit
        else
            return nil
        end
    end
end

---@return number pk伤害加成_C
function cfg_items:GetPkAtt()
    if self.pkAtt ~= nil then
        return self.pkAtt
    else
        if self:CsTABLE() ~= nil then
            self.pkAtt = self:CsTABLE().pkAtt
            return self.pkAtt
        else
            return nil
        end
    end
end
---@return number pk伤害消减_C
function cfg_items:GetPkDef()
    if self.pkDef ~= nil then
        return self.pkDef
    else
        if self:CsTABLE() ~= nil then
            self.pkDef = self:CsTABLE().pkDef
            return self.pkDef
        else
            return nil
        end
    end
end
---@return number 抗性_C
function cfg_items:GetResistance()
    if self.resistance ~= nil then
        return self.resistance
    else
        if self:CsTABLE() ~= nil then
            self.resistance = self:CsTABLE().resistance
            return self.resistance
        else
            return nil
        end
    end
end
---@return number 红点_C
function cfg_items:GetBagSign()
    if self.bagSign ~= nil then
        return self.bagSign
    else
        if self:CsTABLE() ~= nil then
            self.bagSign = self:CsTABLE().bagSign
            return self.bagSign
        else
            return nil
        end
    end
end

---@return number 物品技能（装备）_C
function cfg_items:GetSkill()
    if self.skill ~= nil then
        return self.skill
    else
        if self:CsTABLE() ~= nil then
            self.skill = self:CsTABLE().skill
            return self.skill
        else
            return nil
        end
    end
end
---@return number 强化星级_C
function cfg_items:GetStar()
    if self.star ~= nil then
        return self.star
    else
        if self:CsTABLE() ~= nil then
            self.star = self:CsTABLE().star
            return self.star
        else
            return nil
        end
    end
end
---@return number 整理时自动使用_C
function cfg_items:GetArrangeUse()
    if self.arrangeUse ~= nil then
        return self.arrangeUse
    else
        if self:CsTABLE() ~= nil then
            self.arrangeUse = self:CsTABLE().arrangeUse
            return self.arrangeUse
        else
            return nil
        end
    end
end
---@return number 是否有模型预览_C
function cfg_items:GetIsModelPreview()
    if self.isModelPreview ~= nil then
        return self.isModelPreview
    else
        if self:CsTABLE() ~= nil then
            self.isModelPreview = self:CsTABLE().isModelPreview
            return self.isModelPreview
        else
            return nil
        end
    end
end

---@return number 背包排序_C
function cfg_items:GetOrder()
    if self.order ~= nil then
        return self.order
    else
        if self:CsTABLE() ~= nil then
            self.order = self:CsTABLE().order
            return self.order
        else
            return nil
        end
    end
end
---@return number 道具重复使用次数_C
function cfg_items:GetReuseAmount()
    if self.reuseAmount ~= nil then
        return self.reuseAmount
    else
        if self:CsTABLE() ~= nil then
            self.reuseAmount = self:CsTABLE().reuseAmount
            return self.reuseAmount
        else
            return nil
        end
    end
end
---@return number 是否能够拍卖_C
function cfg_items:GetCanAuction()
    if self.canAuction ~= nil then
        return self.canAuction
    else
        if self:CsTABLE() ~= nil then
            self.canAuction = self:CsTABLE().canAuction
            return self.canAuction
        else
            return nil
        end
    end
end
---@return number 属性加成职业偏向_C
function cfg_items:GetPropertyTendency()
    if self.propertyTendency ~= nil then
        return self.propertyTendency
    else
        if self:CsTABLE() ~= nil then
            self.propertyTendency = self:CsTABLE().propertyTendency
            return self.propertyTendency
        else
            return nil
        end
    end
end

---@return number 上架时，不可选择价格，直接以当前市场上限上架_C
function cfg_items:GetNotChoosePrice()
    if self.notChoosePrice ~= nil then
        return self.notChoosePrice
    else
        if self:CsTABLE() ~= nil then
            self.notChoosePrice = self:CsTABLE().notChoosePrice
            return self.notChoosePrice
        else
            return nil
        end
    end
end
---@return number 是否可存入仓库_C
function cfg_items:GetSave()
    if self.save ~= nil then
        return self.save
    else
        if self:CsTABLE() ~= nil then
            self.save = self:CsTABLE().save
            return self.save
        else
            return nil
        end
    end
end
---@return number 双倍经验效果_C
function cfg_items:GetMonsterDieAddExpBei()
    if self.MonsterDieAddExpBei ~= nil then
        return self.MonsterDieAddExpBei
    else
        if self:CsTABLE() ~= nil then
            self.MonsterDieAddExpBei = self:CsTABLE().MonsterDieAddExpBei
            return self.MonsterDieAddExpBei
        else
            return nil
        end
    end
end
---@return number 道具回收后放入哪些npc_C
function cfg_items:GetRecoverShop()
    if self.recoverShop ~= nil then
        return self.recoverShop
    else
        if self:CsTABLE() ~= nil then
            self.recoverShop = self:CsTABLE().recoverShop
            return self.recoverShop
        else
            return nil
        end
    end
end
---@return number 回收到npc商店后多久消失_C
function cfg_items:GetRecoverShopRemove()
    if self.recoverShopRemove ~= nil then
        return self.recoverShopRemove
    else
        if self:CsTABLE() ~= nil then
            self.recoverShopRemove = self:CsTABLE().recoverShopRemove
            return self.recoverShopRemove
        else
            return nil
        end
    end
end

---@return number 回收后的道具放入npc商店内的排序_由低到高排序_C
function cfg_items:GetRecoverShopOrder()
    if self.recoverShopOrder ~= nil then
        return self.recoverShopOrder
    else
        if self:CsTABLE() ~= nil then
            self.recoverShopOrder = self:CsTABLE().recoverShopOrder
            return self.recoverShopOrder
        else
            return nil
        end
    end
end
---@return number 道具等级_C
function cfg_items:GetItemLevel()
    if self.itemLevel ~= nil then
        return self.itemLevel
    else
        if self:CsTABLE() ~= nil then
            self.itemLevel = self:CsTABLE().itemLevel
            return self.itemLevel
        else
            return nil
        end
    end
end

---@return number 威慑伤害_C
function cfg_items:GetDelAtk()
    if self.delAtk ~= nil then
        return self.delAtk
    else
        if self:CsTABLE() ~= nil then
            self.delAtk = self:CsTABLE().delAtk
            return self.delAtk
        else
            return nil
        end
    end
end
---@return number 道具光柱显示_C
function cfg_items:GetLightBeam()
    if self.lightBeam ~= nil then
        return self.lightBeam
    else
        if self:CsTABLE() ~= nil then
            self.lightBeam = self:CsTABLE().lightBeam
            return self.lightBeam
        else
            return nil
        end
    end
end

---@return number 所属套装#客户端  关联suit表中的suitId字段，填相同id代表属于同一套套装，可用来激活套装属性
function cfg_items:GetSuitBelong()
    if self.suitBelong ~= nil then
        return self.suitBelong
    else
        if self:CsTABLE() ~= nil then
            self.suitBelong = self:CsTABLE().suitBelong
            return self.suitBelong
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 镶嵌所需目标等级#客户端  等级#转生等级#道具等级（itemlevel），不填表示不可用于镶嵌
function cfg_items:GetInsertLv()
    if self.insertLv ~= nil then
        return self.insertLv
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().insertLv
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao buffid#客户端  填buffid关联到buff表
function cfg_items:GetBuffers()
    if self.buffers ~= nil then
        return self.buffers
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buffers
        else
            return nil
        end
    end
end

---@return number 对BOSS伤害增加#客户端  对boss造成伤害增加，万分比
function cfg_items:GetBossDamage()
    if self.bossDamage ~= nil then
        return self.bossDamage
    else
        if self:CsTABLE() ~= nil then
            self.bossDamage = self:CsTABLE().bossDamage
            return self.bossDamage
        else
            return nil
        end
    end
end

---@return number 增伤属性#客户端  战斗中，造成的伤害增加，万分比
function cfg_items:GetLampHurtAdd()
    if self.lampHurtAdd ~= nil then
        return self.lampHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.lampHurtAdd = self:CsTABLE().lampHurtAdd
            return self.lampHurtAdd
        else
            return nil
        end
    end
end

---@return number 减伤属性#客户端  战斗中，受到的伤害降低，万分比
function cfg_items:GetSoulAttackReduce()
    if self.soulAttackReduce ~= nil then
        return self.soulAttackReduce
    else
        if self:CsTABLE() ~= nil then
            self.soulAttackReduce = self:CsTABLE().soulAttackReduce
            return self.soulAttackReduce
        else
            return nil
        end
    end
end

---@return number 神力经验#客户端  消耗此道具可增加的神力经验
function cfg_items:GetDivineExp()
    if self.divineExp ~= nil then
        return self.divineExp
    else
        if self:CsTABLE() ~= nil then
            self.divineExp = self:CsTABLE().divineExp
            return self.divineExp
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具使用限制#客户端  道具使用限制
function cfg_items:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditions
        else
            return nil
        end
    end
end

---@return number 获得道具时限类型#客户端  使用后获得的道具限时限制类型  1 限时外观
function cfg_items:GetGetLimitType()
    if self.getLimitType ~= nil then
        return self.getLimitType
    else
        if self:CsTABLE() ~= nil then
            self.getLimitType = self:CsTABLE().getLimitType
            return self.getLimitType
        else
            return nil
        end
    end
end

---@return number 获得道具时限#客户端  使用后获得的时限时间  单位 分钟
function cfg_items:GetGetLimitTime()
    if self.getLimitTime ~= nil then
        return self.getLimitTime
    else
        if self:CsTABLE() ~= nil then
            self.getLimitTime = self:CsTABLE().getLimitTime
            return self.getLimitTime
        else
            return nil
        end
    end
end

---@return number 道具额外属性#客户端  道具穿戴时额外属性，索引到extramoneffect表中id，穿戴时
function cfg_items:GetExtraMonEffect()
    if self.extraMonEffect ~= nil then
        return self.extraMonEffect
    else
        if self:CsTABLE() ~= nil then
            self.extraMonEffect = self:CsTABLE().extraMonEffect
            return self.extraMonEffect
        else
            return nil
        end
    end
end

---@return number 道具镶嵌效果#客户端  道具镶嵌时候额外效果，索引到cfg_inlay_effect
function cfg_items:GetExtraMonEffectInlay()
    if self.extraMonEffectInlay ~= nil then
        return self.extraMonEffectInlay
    else
        if self:CsTABLE() ~= nil then
            self.extraMonEffectInlay = self:CsTABLE().extraMonEffectInlay
            return self.extraMonEffectInlay
        else
            return nil
        end
    end
end

---@return number 回收类型#客户端
function cfg_items:GetRecoverType()
    if self.recoverType ~= nil then
        return self.recoverType
    else
        if self:CsTABLE() ~= nil then
            self.recoverType = self:CsTABLE().recoverType
            return self.recoverType
        else
            return nil
        end
    end
end

---@return number 会员功能#客户端  到达会员等级可自动使用
function cfg_items:GetVipMemberAutoUse()
    if self.vipMemberAutoUse ~= nil then
        return self.vipMemberAutoUse
    else
        if self:CsTABLE() ~= nil then
            self.vipMemberAutoUse = self:CsTABLE().vipMemberAutoUse
            return self.vipMemberAutoUse
        else
            return nil
        end
    end
end

---@return number 是否可鉴定#客户端  1为可鉴定装备
function cfg_items:GetJianDing()
    if self.jianDing ~= nil then
        return self.jianDing
    else
        if self:CsTABLE() ~= nil then
            self.jianDing = self:CsTABLE().jianDing
            return self.jianDing
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 仙装镶嵌不同槽位互斥#客户端  仙装镶嵌同部位里3孔槽不可镶嵌同种类仙装；比如A孔装备S，B孔不可再装SS
function cfg_items:GetDifferentInlay()
    if self.differentInlay ~= nil then
        return self.differentInlay
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().differentInlay
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 是否可投保#客户端  投保金额#弃保金额
function cfg_items:GetInsure()
    if self.insure ~= nil then
        return self.insure
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().insure
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ITEMS C#中的数据结构
function cfg_items:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_ItemsTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_items lua中的数据结构
function cfg_items:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.suitBelong = decodedData.suitBelong
    
    ---@private
    self.insertLv = decodedData.insertLv
    
    ---@private
    self.buffers = decodedData.buffers
    
    ---@private
    self.bossDamage = decodedData.bossDamage
    
    ---@private
    self.lampHurtAdd = decodedData.lampHurtAdd
    
    ---@private
    self.soulAttackReduce = decodedData.soulAttackReduce
    
    ---@private
    self.divineExp = decodedData.divineExp
    
    ---@private
    self.conditions = decodedData.conditions
    
    ---@private
    self.getLimitType = decodedData.getLimitType
    
    ---@private
    self.getLimitTime = decodedData.getLimitTime
    
    ---@private
    self.extraMonEffect = decodedData.extraMonEffect
    
    ---@private
    self.extraMonEffectInlay = decodedData.extraMonEffectInlay
    
    ---@private
    self.recoverType = decodedData.recoverType
    
    ---@private
    self.vipMemberAutoUse = decodedData.vipMemberAutoUse
    
    ---@private
    self.jianDing = decodedData.jianDing
    
    ---@private
    self.differentInlay = decodedData.differentInlay
    
    ---@private
    self.insure = decodedData.insure
end

return cfg_items