protobuf = nil;
protoc = nil;

---@class protobufMgr
local protobufMgr = {}
local localProtobuf

---消息反序列化ID缓存
---@type number
protobufMgr.mMsgDeserializedIDCache = 0
---消息反序列化内容的table缓存
---@type table
protobufMgr.mMsgDeserializedTblCache = nil

function protobufMgr.Init()
    CS.XLuaProtobuf.Init(preMainPath .. '/protobufLua/config')
    protobuf = require "pb";--pb.dll
    protoc = require "protoc";
    localProtobuf = protobuf

    if CS.XLuaEncrypt.IsXLuaEncryptOpened then
        protoc.isEncrypted = true
        protoc.decodeProtoFile = function(path)
            return CS.XLuaMgr.Instance:ReadAndDecodeProtoFile(path)
        end
    end
    --proto热更缓存路径（先加入先读）
    protoc:addpath(cachePath .. '/protobufLua/proto')
    protoc:addpath(cachePath .. '/table/clientProto')

    --proto包内缓存路径
    protoc:addpath(preMainPath .. '/protobufLua/proto')
    protoc:addpath(preMainPath .. '/table/clientProto')

    --加载所有相关proto文件
    local reloadAllProto = require 'luaRes.protobufLua.registerAllRelatedProto'
    reloadAllProto:LoadAll(protobufMgr)

    --加载网络消息请求
    require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize'
    --加载网络消息响应
    require 'luaRes.protobufLua.networkRequest.NetworkRequest'
    --加载网络消息解析
    require 'luaRes.protobufLua.networkRespond.NetworkRespond'
    --加载网络消息预处理
    require 'luaRes.netMsgPreprocessing.NetMsgPreprocessing'
    --加载网络消息预校验
    require 'luaRes.netMsgPreverifying.NetMsgPreverifying'

    tableLoader:Init(protobufMgr)
end

function protobufMgr.RegisterPb(pbFileName)
    --先读取热更下载出proto，没有的话再加载包内proto
    assert(protoc:loadfile(pbFileName))
end

---根据proto反序列化
---@param msgName string 消息名
---@param buffer string 待反序列化内容
---@return table 反序列化结果
function protobufMgr.Deserialize(msgName, buffer)
    local decodedData = localProtobuf.decode(msgName, buffer)
    return decodedData
end

---根据proto序列化
---@param msgName string 消息名
---@param content table 待序列化内容
---@return string 序列化结果
function protobufMgr.Serialize(msgName, content)
    return assert(localProtobuf.encode(msgName, content))
end

return protobufMgr