--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_map
local cfg_map = {}

cfg_map.__index = cfg_map

function cfg_map:UUID()
    return self.id
end

---@return number 地图ID#客户端#C#不存在共同参与合并的字段  1位（1主城地图、中转地图，野外公共地图，3单人副本地图）；23地图位置；4地图编号 10室内地图
function cfg_map:GetId()
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

---@return number 地图切换目录#客户端#C#不存在共同参与合并的字段  关联ScenesRes
function cfg_map:GetMap()
    if self.map ~= nil then
        return self.map
    else
        if self:CsTABLE() ~= nil then
            self.map = self:CsTABLE().map
            return self.map
        else
            return nil
        end
    end
end

---@return number 小地图#客户端#C#不存在共同参与合并的字段  关联MiniMap
function cfg_map:GetMiniMap()
    if self.miniMap ~= nil then
        return self.miniMap
    else
        if self:CsTABLE() ~= nil then
            self.miniMap = self:CsTABLE().miniMap
            return self.miniMap
        else
            return nil
        end
    end
end

---@return number 阻挡配置（可共用）#客户端#C#不存在共同参与合并的字段  关联SceneEditorCacheMapByte
function cfg_map:GetData()
    if self.data ~= nil then
        return self.data
    else
        if self:CsTABLE() ~= nil then
            self.data = self:CsTABLE().data
            return self.data
        else
            return nil
        end
    end
end

---@return string 复古地图数据名#客户端#C  复古地图的数据名，用于复古地图绘制替换，不填则不替换为复古地图
function cfg_map:GetFgmap()
    if self.fgmap ~= nil then
        return self.fgmap
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().fgmap
        else
            return nil
        end
    end
end

---@return string 地图名称(服务端之前就是用这个公告的)#客户端#C
function cfg_map:GetName()
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

---@return number 地图宽度#客户端#C#不存在共同参与合并的字段
function cfg_map:GetWidth()
    if self.width ~= nil then
        return self.width
    else
        if self:CsTABLE() ~= nil then
            self.width = self:CsTABLE().width
            return self.width
        else
            return nil
        end
    end
end

---@return number 地图高度#客户端#C#不存在共同参与合并的字段
function cfg_map:GetHeight()
    if self.height ~= nil then
        return self.height
    else
        if self:CsTABLE() ~= nil then
            self.height = self:CsTABLE().height
            return self.height
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 小地图尺寸#客户端#C  小地图尺寸x#小地图尺寸y#原地图缩放对照尺寸x#原地图缩放对照尺寸y#原地图缩放对照中心偏移量x#原地图缩放对照中心偏移量y
function cfg_map:GetMiniscaling()
    if self.miniscaling ~= nil then
        return self.miniscaling
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().miniscaling
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 地图进入等级限制#客户端#C  关联cfg_conditions
function cfg_map:GetConditionId()
    if self.conditionId ~= nil then
        return self.conditionId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionId
        else
            return nil
        end
    end
end

---@return string 开启自动寻路#客户端#C  是否开启自动寻路 默认开启 1不开启
function cfg_map:GetFinding()
    if self.finding ~= nil then
        return self.finding
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().finding
        else
            return nil
        end
    end
end

---@return string 是否有出口#客户端#C  不填为有出口 填1为没出口 无出口的地图 寻路未发现路线后，会提示是否直接离开
function cfg_map:GetExit()
    if self.exit ~= nil then
        return self.exit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().exit
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 买活消耗道具#客户端#C  道具id#基础消耗数量#每次复活增加消耗数量#最高消耗数量
function cfg_map:GetHereReliveCost()
    if self.hereReliveCost ~= nil then
        return self.hereReliveCost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hereReliveCost
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 自动复活的类型和时间#客户端#C  配置方式：类型#时间（秒）1、回城复活，2、原地复活，3、出生点复活；4、随机坐标复活；5、回到挂机；6、退出地图
function cfg_map:GetAutoRelive()
    if self.autoRelive ~= nil then
        return self.autoRelive
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().autoRelive
        else
            return nil
        end
    end
end

---@return number 从地图回城回的地方#客户端#C#不存在共同参与合并的字段  从地图回城回的地方
function cfg_map:GetHomeMapId()
    if self.homeMapId ~= nil then
        return self.homeMapId
    else
        if self:CsTABLE() ~= nil then
            self.homeMapId = self:CsTABLE().homeMapId
            return self.homeMapId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 灵兽出战等级限制#客户端#C  等级#转生等级
function cfg_map:GetInnerCondition()
    if self.innerCondition ~= nil then
        return self.innerCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().innerCondition
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 当前地图怪点#客户端#C  怪物点
function cfg_map:GetMonster()
    if self.monster ~= nil then
        return self.monster
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().monster
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 巡逻怪点#客户端#C  自动战斗
function cfg_map:GetPatrol()
    if self.patrol ~= nil then
        return self.patrol
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().patrol
        else
            return nil
        end
    end
end

---@return number 音效#客户端#C#不存在共同参与合并的字段  bgm
function cfg_map:GetSoundID()
    if self.soundID ~= nil then
        return self.soundID
    else
        if self:CsTABLE() ~= nil then
            self.soundID = self:CsTABLE().soundID
            return self.soundID
        else
            return nil
        end
    end
end

---@return number 同一区域deliverid#客户端#C#不存在共同参与合并的字段  相同的deliverid表示同一区域，寻路用，如果目标地图与目前地图为同一区域则不寻路且提示
function cfg_map:GetAnnounceDeliver()
    if self.announceDeliver ~= nil then
        return self.announceDeliver
    else
        if self:CsTABLE() ~= nil then
            self.announceDeliver = self:CsTABLE().announceDeliver
            return self.announceDeliver
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 走路音效#客户端#C  默认音效#特殊格子
function cfg_map:GetWalkingSounds()
    if self.walkingSounds ~= nil then
        return self.walkingSounds
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().walkingSounds
        else
            return nil
        end
    end
end

---@return number 是否开启精英和boss距离方位显示功能#客户端#C  1开启0不开启
function cfg_map:GetDirectionShow()
    if self.directionShow ~= nil then
        return self.directionShow
    else
        if self:CsTABLE() ~= nil then
            self.directionShow = self:CsTABLE().directionShow
            return self.directionShow
        else
            return nil
        end
    end
end

---@return number 是否叠加#客户端#C  0不可叠加，1可叠加（不配默认0，客户端用，不可叠加时，出现重叠后客户端自动移开位置）
function cfg_map:GetCancrossClient()
    if self.cancrossClient ~= nil then
        return self.cancrossClient
    else
        if self:CsTABLE() ~= nil then
            self.cancrossClient = self:CsTABLE().cancrossClient
            return self.cancrossClient
        else
            return nil
        end
    end
end

---@return number 死亡后是否掉落#客户端#C#不存在共同参与合并的字段  0掉落1不掉落
function cfg_map:GetCanNoDropOfDie()
    if self.canNoDropOfDie ~= nil then
        return self.canNoDropOfDie
    else
        if self:CsTABLE() ~= nil then
            self.canNoDropOfDie = self:CsTABLE().canNoDropOfDie
            return self.canNoDropOfDie
        else
            return nil
        end
    end
end

---@return number 是否穿人#客户端#C  0不可穿人，1可穿人（不配默认0，客户端用，不可穿人时，客户端会绕开玩家）
function cfg_map:GetIsCancross()
    if self.isCancross ~= nil then
        return self.isCancross
    else
        if self:CsTABLE() ~= nil then
            self.isCancross = self:CsTABLE().isCancross
            return self.isCancross
        else
            return nil
        end
    end
end

---@return number 是否直接传送#客户端#C  是否可以通过小飞鞋传送到分享坐标（聊天坐标分享）：1、传坐标；2、传deliver
function cfg_map:GetIsTransmit()
    if self.isTransmit ~= nil then
        return self.isTransmit
    else
        if self:CsTABLE() ~= nil then
            self.isTransmit = self:CsTABLE().isTransmit
            return self.isTransmit
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 进入地图消耗条件#客户端#C  关联condition   conditionid#conditionid
function cfg_map:GetCostCondition()
    if self.costCondition ~= nil then
        return self.costCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costCondition
        else
            return nil
        end
    end
end

---@return number 真实地图id#客户端#C#不存在共同参与合并的字段  分线地图对应真实地图id，无分线填原来id，用于地图寻路
function cfg_map:GetRealMapId()
    if self.realMapId ~= nil then
        return self.realMapId
    else
        if self:CsTABLE() ~= nil then
            self.realMapId = self:CsTABLE().realMapId
            return self.realMapId
        else
            return nil
        end
    end
end

---@return number 小地图标识模式#客户端#C  用于判断当前地图是否需要小地图标识切换模式的选项，填0或不填则不显示选项（按照视野范围显示），填1则显示选项
function cfg_map:GetSmallMapIconMode()
    if self.smallMapIconMode ~= nil then
        return self.smallMapIconMode
    else
        if self:CsTABLE() ~= nil then
            self.smallMapIconMode = self:CsTABLE().smallMapIconMode
            return self.smallMapIconMode
        else
            return nil
        end
    end
end

---@return string 小地图标识显示#客户端#C  仅在小地图模式填1的时候触发，在选择小地图BOSS出生点模式下的BOSS位置（也可以用于其他特殊点的显示，但仅限BOSS出生点模式），格式：[FF0000]点名字#点图片#x#y&[FF0000] 点名字#点图片#x#y&[FF0000]点名字#点图片#x#y
function cfg_map:GetSmallMapPoint()
    if self.smallMapPoint ~= nil then
        return self.smallMapPoint
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smallMapPoint
        else
            return nil
        end
    end
end

---@return number 复活倒计时_C
function cfg_map:GetFuhuo()
    if self.fuhuo ~= nil then
        return self.fuhuo
    else
        if self:CsTABLE() ~= nil then
            self.fuhuo = self:CsTABLE().fuhuo
            return self.fuhuo
        else
            return nil
        end
    end
end
---@return number 类型_C
function cfg_map:GetCls()
    if self.cls ~= nil then
        return self.cls
    else
        if self:CsTABLE() ~= nil then
            self.cls = self:CsTABLE().cls
            return self.cls
        else
            return nil
        end
    end
end
---@return number 是否是即时战斗地图_C
function cfg_map:GetRpg()
    if self.rpg ~= nil then
        return self.rpg
    else
        if self:CsTABLE() ~= nil then
            self.rpg = self:CsTABLE().rpg
            return self.rpg
        else
            return nil
        end
    end
end
---@return number 是否是副本_C
function cfg_map:GetDuplicate()
    if self.duplicate ~= nil then
        return self.duplicate
    else
        if self:CsTABLE() ~= nil then
            self.duplicate = self:CsTABLE().duplicate
            return self.duplicate
        else
            return nil
        end
    end
end
---@return number 是否可以无条件穿人_C
function cfg_map:GetCancross()
    if self.cancross ~= nil then
        return self.cancross
    else
        if self:CsTABLE() ~= nil then
            self.cancross = self:CsTABLE().cancross
            return self.cancross
        else
            return nil
        end
    end
end
---@return number 是否是安全地图_C
function cfg_map:GetSafe()
    if self.safe ~= nil then
        return self.safe
    else
        if self:CsTABLE() ~= nil then
            self.safe = self:CsTABLE().safe
            return self.safe
        else
            return nil
        end
    end
end
---@return number 玩家ai配置表_C
function cfg_map:GetPlayerAI()
    if self.playerAI ~= nil then
        return self.playerAI
    else
        if self:CsTABLE() ~= nil then
            self.playerAI = self:CsTABLE().playerAI
            return self.playerAI
        else
            return nil
        end
    end
end

---@return number 地图类型_C
function cfg_map:GetMapType()
    if self.mapType ~= nil then
        return self.mapType
    else
        if self:CsTABLE() ~= nil then
            self.mapType = self:CsTABLE().mapType
            return self.mapType
        else
            return nil
        end
    end
end
---@return number 买活类型_C
function cfg_map:GetCanHereRelive()
    if self.canHereRelive ~= nil then
        return self.canHereRelive
    else
        if self:CsTABLE() ~= nil then
            self.canHereRelive = self:CsTABLE().canHereRelive
            return self.canHereRelive
        else
            return nil
        end
    end
end
---@return number 进入地图默认的攻击模式_C
function cfg_map:GetFightModel()
    if self.fightModel ~= nil then
        return self.fightModel
    else
        if self:CsTABLE() ~= nil then
            self.fightModel = self:CsTABLE().fightModel
            return self.fightModel
        else
            return nil
        end
    end
end
---@return number 视野范围_C
function cfg_map:GetViewRange()
    if self.viewRange ~= nil then
        return self.viewRange
    else
        if self:CsTABLE() ~= nil then
            self.viewRange = self:CsTABLE().viewRange
            return self.viewRange
        else
            return nil
        end
    end
end
---@return number 服务器类型_C
function cfg_map:GetServerType()
    if self.serverType ~= nil then
        return self.serverType
    else
        if self:CsTABLE() ~= nil then
            self.serverType = self:CsTABLE().serverType
            return self.serverType
        else
            return nil
        end
    end
end

---@return number 坐标点x_C
function cfg_map:GetHomeX()
    if self.homeX ~= nil then
        return self.homeX
    else
        if self:CsTABLE() ~= nil then
            self.homeX = self:CsTABLE().homeX
            return self.homeX
        else
            return nil
        end
    end
end
---@return number 坐标点y_C
function cfg_map:GetHomeY()
    if self.homeY ~= nil then
        return self.homeY
    else
        if self:CsTABLE() ~= nil then
            self.homeY = self:CsTABLE().homeY
            return self.homeY
        else
            return nil
        end
    end
end
---@return number 幻兽出战_C
function cfg_map:GetHuanshou()
    if self.huanshou ~= nil then
        return self.huanshou
    else
        if self:CsTABLE() ~= nil then
            self.huanshou = self:CsTABLE().huanshou
            return self.huanshou
        else
            return nil
        end
    end
end
---@return number 自动战斗_C
function cfg_map:GetAutomatic()
    if self.automatic ~= nil then
        return self.automatic
    else
        if self:CsTABLE() ~= nil then
            self.automatic = self:CsTABLE().automatic
            return self.automatic
        else
            return nil
        end
    end
end
---@return number 是否禁止随机传送石_C
function cfg_map:GetBanRandomTransfer()
    if self.banRandomTransfer ~= nil then
        return self.banRandomTransfer
    else
        if self:CsTABLE() ~= nil then
            self.banRandomTransfer = self:CsTABLE().banRandomTransfer
            return self.banRandomTransfer
        else
            return nil
        end
    end
end

---@return number 是否禁止回城相关功能_C
function cfg_map:GetBanHomeTransfer()
    if self.banHomeTransfer ~= nil then
        return self.banHomeTransfer
    else
        if self:CsTABLE() ~= nil then
            self.banHomeTransfer = self:CsTABLE().banHomeTransfer
            return self.banHomeTransfer
        else
            return nil
        end
    end
end
---@return number 地图人数限制_C
function cfg_map:GetOnlineLimit()
    if self.onlineLimit ~= nil then
        return self.onlineLimit
    else
        if self:CsTABLE() ~= nil then
            self.onlineLimit = self:CsTABLE().onlineLimit
            return self.onlineLimit
        else
            return nil
        end
    end
end

---@return number 联服开启#客户端  第几次联服开启的联服地图，开启后，下次联服会继续开启
function cfg_map:GetShareNum()
    if self.shareNum ~= nil then
        return self.shareNum
    else
        if self:CsTABLE() ~= nil then
            self.shareNum = self:CsTABLE().shareNum
            return self.shareNum
        else
            return nil
        end
    end
end

---@return number 小地图右侧按钮显示类型#客户端  与map_npc表的deliverType自动对应：0上次到达的主城；1比奇；2盟重；3分线比奇；4白日门
function cfg_map:GetMinMapDeliverType()
    if self.minMapDeliverType ~= nil then
        return self.minMapDeliverType
    else
        if self:CsTABLE() ~= nil then
            self.minMapDeliverType = self:CsTABLE().minMapDeliverType
            return self.minMapDeliverType
        else
            return nil
        end
    end
end

---@return number 小地图回城优先显示#客户端  0上次到达的主城；1比奇；2盟重；3白日门
function cfg_map:GetMinMapBackFirst()
    if self.minMapBackFirst ~= nil then
        return self.minMapBackFirst
    else
        if self:CsTABLE() ~= nil then
            self.minMapBackFirst = self:CsTABLE().minMapBackFirst
            return self.minMapBackFirst
        else
            return nil
        end
    end
end

---@return number XP技能#客户端  填0或不填为可用，1为不可用
function cfg_map:GetXp()
    if self.xp ~= nil then
        return self.xp
    else
        if self:CsTABLE() ~= nil then
            self.xp = self:CsTABLE().xp
            return self.xp
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MAP C#中的数据结构
function cfg_map:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_MapTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_map lua中的数据结构
function cfg_map:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.shareNum = decodedData.shareNum
    
    ---@private
    self.minMapDeliverType = decodedData.minMapDeliverType
    
    ---@private
    self.minMapBackFirst = decodedData.minMapBackFirst
    
    ---@private
    self.xp = decodedData.xp
end

return cfg_map