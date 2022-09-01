using System;
using System.Collections;
using System.Collections.Generic;
using MiniJSON;
using UnityEngine;

public class ShortCutKeyMgr : MonoBehaviour
{
    private static string ShortCutKeySaveKey = "ShortCutKey";
    
    /// <summary>
    /// 如果没有存储的快捷键信息，就用这里的当作默认的信息
    /// </summary>
    private List<ShortCutKeyInfo> _defaultShortCutKeyInfos = new List<ShortCutKeyInfo>()
    {
        #region 示例
        //键盘按键示例
        new ShortCutKeyInfo(new [] {new ShortCutKeyItem(KeyCode.Escape)},"Close","关闭快捷键"),
        new ShortCutKeyInfo(new [] {new ShortCutKeyItem(KeyCode.LeftControl),new ShortCutKeyItem(KeyCode.C)},"Copy","复制"),
        //鼠标点击示例
        new ShortCutKeyInfo(new [] {new ShortCutKeyItem(0)},"ClickMouseLeft","点击鼠标左键")
        #endregion
    };
    
    private readonly Dictionary<string,ShortCutKeyInfo> _shortCutKeyDic= new Dictionary<string, ShortCutKeyInfo>();
  
    // Start is called before the first frame update
    void Start()
    {
        InitShortCutKey();

        var info = new ShortCutKeyInfo(new[] {new ShortCutKeyItem(0)}, "ClickMouseLeft", "点击鼠标左键");
        AddShortCutKey(info, () =>
        {
            Debug.Log(info.ShowName);
        });
        
        var info1= new ShortCutKeyInfo(new[] {new ShortCutKeyItem(KeyCode.Escape)}, "ClickMouseLeft", "点击鼠标左键");
        AddShortCutKey(info1, () =>
        {
            Debug.Log(info1.ShowName);
        });
        
        var info2= new ShortCutKeyInfo(new[] {new ShortCutKeyItem(KeyCode.LeftControl),new ShortCutKeyItem(KeyCode.LeftShift),new ShortCutKeyItem(KeyCode.G)}, "1234234", "Ctr+Shift+G");
        AddShortCutKey(info2, () =>
        {
            Debug.Log(info2.ShowName);
        });
        AddShortCutKey(info2, () =>
        {
            Debug.Log(info2.ShowName+": add");
        });
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.anyKeyDown)
        {
            for (int i = 0; i < _defaultShortCutKeyInfos.Count; i++)
            {
                if (_defaultShortCutKeyInfos[i].IsMatchShortCut())
                {
                    Broadcast(_defaultShortCutKeyInfos[i].Name);
                }
            }
        }
        
    }

    /// <summary>
    /// 初始化快捷键信息，如果没有存储的快捷键信息，用默认的信息
    /// </summary>
    private void InitShortCutKey()
    {
        var infos = ReadShortCutKeyInfo();
        if (infos != null)
        {
            _defaultShortCutKeyInfos = infos;
        }

        for (int i = 0; i < _defaultShortCutKeyInfos.Count; i++)
        {
            var info = _defaultShortCutKeyInfos[i];
            _shortCutKeyDic[info.Name] = info;
        }
    }
    
   /// <summary>
   /// 添加或修改快捷键信息
   /// </summary>
   /// <param name="info"></param>
   /// <param name="action"></param>
    public AddShortResult AddShortCutKey(ShortCutKeyInfo info,Action action)
    {
        if (info == null || !info.IsValid())
        {
            return new AddShortResult()
            {
                IsSuccess = false,
                Result = "添加的快捷键无效"
            };
        }
        if (_shortCutKeyDic.TryGetValue(info.Name, out _))
        {
            Debug.Log("按键已存在");
            var result =new AddShortResult()
            {
                IsSuccess = false,
                Result = "按键已存在"
            };
            return result;
        }
        
        var index = _defaultShortCutKeyInfos.FindIndex((a) => a.Name == info.Name);
        if (index == -1)
        {
            _defaultShortCutKeyInfos.Add(info); 
        }
        else
        {
            for (int i = 0; i < _defaultShortCutKeyInfos.Count; i++)
            {
                if (_defaultShortCutKeyInfos[i].IsMatchKey(info))
                {
                    Debug.Log("快捷键冲突");
                    var result =new AddShortResult()
                    {
                        IsSuccess = false,
                        Result = "快捷键冲突"
                    };
                    return result;
                }
            }
            _defaultShortCutKeyInfos.Add(info);
        }
        SaveShortCutKeyInfo();
        
        _shortCutKeyDic[info.Name] = info;
        //todo；绑定有问题只能绑定一次待处理，消息单独处理，自由绑定和快捷键信息解耦
        _shortCutKeyDic[info.Name].OnShortCut += action;
        
        var successResult =new AddShortResult()
        {
            IsSuccess = true,
        };
        return successResult;
    }

   public void ModifyShortCut(ShortCutKeyInfo info)
   {
       if (_shortCutKeyDic.TryGetValue(info.Name, value: out _))
       {
           _shortCutKeyDic[info.Name] = info;
       }
       else
       {
           Debug.Log("想要修改的快捷键不存在");
       }
   }

    /// <summary>
    /// 用快捷键名字删除快捷键
    /// </summary>
    /// <param name="key">快捷键名字</param>
    public void RemoveShortCutKey(string key)
    {
        var index = _defaultShortCutKeyInfos.FindIndex((a) => a.Name == key);
        if (index != -1)
        {
            _defaultShortCutKeyInfos.RemoveAt(index);
        }

        if (_shortCutKeyDic.ContainsKey(key))
        {
            _shortCutKeyDic.Remove(key);
        }
    }
    
    /// <summary>
    /// 用快捷键名字删除快捷键
    /// </summary>
    /// <param name="info"></param>
    public void RemoveShortCutKey(ShortCutKeyInfo info)
    {
        if (_defaultShortCutKeyInfos.Contains(info))
        {
            _defaultShortCutKeyInfos.Remove(info);
        }

        if (_shortCutKeyDic.ContainsKey(info.Name))
        {
            _shortCutKeyDic.Remove(info.Name);
        }
    }

    private void Broadcast(string key)
    {
        ShortCutKeyInfo info;
        if (_shortCutKeyDic.TryGetValue(key, out info))
        {
            info.BroadCaste();
        }
    }

    #region 读取储存快捷键信息

    private void SaveShortCutKeyInfo()
    {
        //todo: 目前存储客户端有需求在传server
        /*string shortCutKeyInfoJson = Json.Serialize(_shortCutKeyInfos);
        PlayerPrefs.SetString(ShortCutKeySaveKey,shortCutKeyInfoJson);*/
        SerializeList.SaveObjectToPlayerPrefs(_defaultShortCutKeyInfos, ShortCutKeySaveKey);
    }

    private List<ShortCutKeyInfo> ReadShortCutKeyInfo()
    {
        /*var shortCutKeyInfoJson= PlayerPrefs.GetString(ShortCutKeySaveKey);
        List<ShortCutKeyInfo> shortCutKeyInfos = Json.Deserialize(shortCutKeyInfoJson) as List<ShortCutKeyInfo>;
        return shortCutKeyInfos;*/
        return SerializeList.GetObjectFormPlayerPrefs<ShortCutKeyInfo>(ShortCutKeySaveKey);
    }
    #endregion
    
    public class  AddShortResult
    {
        public bool IsSuccess;
        public string Result;
    }
}
