/*
 * Tencent is pleased to support the open source community by making xLua available.
 * Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using XLua;
using System;
using System.IO;
using System.Text;

[LuaCallCSharp]
public class LuaBehaviour : MonoBehaviour
{
    private static List<List<IOnDestroy>> onDestroyListList = new List<List<IOnDestroy>>();

    private static List<IOnDestroy> PopList()
    {
        int count = onDestroyListList.Count;
        if (count > 0)
        {
            var list = onDestroyListList[count - 1];
            onDestroyListList.RemoveAt(count - 1);
            return list;
        }
        return new List<IOnDestroy>();
    }

    private static void PushList(List<IOnDestroy> list)
    {
        list.Clear();
        onDestroyListList.Add(list);
    }

    public LuaTable chunkTable;

    private Action luaStart;
    private Action luaUpdate;
    private Action luaOnDestroy;

    private LuaTable scriptEnv;

    [Header("Lua文件名")]
    public string luaName;
    [Header("销毁时是否需要调用所有子物体组件的OnDestroy方法")]
    public bool isNeedInvokeOnDestoryToAllChildren = true;

    public void InitWithFilePath(string filePath, string luaName)
    {
        string fullPath;
        if (CSInterfaceSingleton.Unity_Editor.Is_UNITY_EDITOR)
        {
            fullPath = Application.dataPath.Substring(0, Application.dataPath.Length - 6) + filePath;
        }
        else
        {
            CSStringBuilder.Clear();
            CSStringBuilder.Append(Application.persistentDataPath);
            CSStringBuilder.Append("/");
            CSStringBuilder.Append(filePath);
            fullPath = CSStringBuilder.ToString();
        }
        //UnityEngine.Debug.Log(fullPath);
        if (!File.Exists(fullPath))
        {
            //没有新的lua文件读取streaming assets下的lua
            CSStringBuilder.Clear();
            CSStringBuilder.Append(EditorPath.GetStreamingAssetsPath());
            CSStringBuilder.Append("/");
            CSStringBuilder.Append(filePath);
            fullPath = CSStringBuilder.ToString();

            if (!File.Exists(fullPath))
            {
                return;
            }
            
        }
        string content;
        if (XLuaMgr.Instance.ScriptContentCache.TryGetCache(luaName, out content))
        {
            Init(content, luaName);
            XLuaMgr.Instance.ScriptContentCache.OnPanelOpened(luaName, content);
        }
        else
        {
            if (XLuaEncrypt.IsXLuaEncryptOpened)
            {
                var fileContent = File.ReadAllBytes(fullPath);
                XLuaEncrypt.Decode(fileContent);
                //规避带bom头的UTF8文件
                if (fileContent.Length > 3 && fileContent[0] == 239 && fileContent[1] == 187 && fileContent[2] == 191)
                {
                    fileContent[0] = 32;
                    fileContent[1] = 32;
                    fileContent[2] = 32;
                }
                content = Encoding.UTF8.GetString(fileContent);
                Init(content, luaName);
                XLuaMgr.Instance.ScriptContentCache.OnPanelOpened(luaName, content);
            }
            else
            {
                content = File.ReadAllText(fullPath);
                Init(content, luaName);
                XLuaMgr.Instance.ScriptContentCache.OnPanelOpened(luaName, content);
            }
        }
    }

    public void Init(string luaScript)
    {
        Init(luaScript, "");
    }

    public void Init(string luaScript, string luaName)
    {
        //UnityEngine.Debug.Log("luaName = " + luaName);
        this.luaName = luaName;
        LuaEnv luaEnv = XLuaMgr.Instance.Luaenv;
        scriptEnv = luaEnv.NewTable();

        LuaTable meta = luaEnv.NewTable();
        meta.Set("__index", luaEnv.Global);
        scriptEnv.SetMetaTable(meta);
        meta.Dispose();

        scriptEnv.Set("self", this);
        object[] objs;
        if (string.IsNullOrEmpty(luaName))
        {
            objs = luaEnv.DoString(luaScript, "LuaBehaviour", scriptEnv);
        }
        else
        {
#if UNITY_EDITOR
            string chunkname = FileUtility.GetBackDir(Application.dataPath, 1) + "/luaRes/ui/panels/" + luaName + ".lua";
            objs = luaEnv.DoString(luaScript, chunkname, scriptEnv);
#else
            objs = luaEnv.DoString(luaScript, luaName, scriptEnv);
#endif

        }
        if (objs != null && objs.Length > 0)
        {
            chunkTable = objs[0] as LuaTable;
        }
        else
        {
            chunkTable = null;
        }

        Action luaAwake = scriptEnv.Get<Action>("awake");
        scriptEnv.Get("start", out luaStart);
        scriptEnv.Get("update", out luaUpdate);
        scriptEnv.Get("ondestroy", out luaOnDestroy);

        if (luaAwake != null)
        {
            luaAwake();
        }
    }

    // Use this for initialization
    void Start()
    {
        if (luaStart != null)
        {
            luaStart();
        }
    }

    // Update is called once per frame
    bool isUpdateError = false;
    void Update()
    {
        if (isUpdateError) return;
        if (luaUpdate != null)
        {
            try
            {

                luaUpdate();

            }
            catch (System.Exception ex)
            {
                isUpdateError = true;
                UnityEngine.Debug.LogError("luaName = " + luaName + " update 异常 = " + ex.ToString());
            }
        }
        //if (Time.time - LuaBehaviour.lastGCTime > GCInterval)
        //{
        //    luaEnv.Tick();
        //    LuaBehaviour.lastGCTime = Time.time;
        //}
    }

    void OnDestroy()
    {
        //UnityEngine.Debug.Log("OnDestroy");
        if (luaOnDestroy != null)
        {
            luaOnDestroy();
        }
        luaOnDestroy = null;
        luaUpdate = null;
        luaStart = null;
        if (scriptEnv != null)
        {
            scriptEnv.Dispose();
        }
        scriptEnv = null;
        if (chunkTable != null)
        {
            chunkTable.Dispose();
        }
        chunkTable = null;
        //injections = null;
        //在lua中释放界面引用
        //if (XLuaMgr.Instance != null)
        //{
        //    XLuaMgr.Instance.ReleaseUITableInLua(chunkTable);
        //}
        if (isNeedInvokeOnDestoryToAllChildren)
        {
            var onDestroyListTemp = PopList();
            onDestroyListTemp.Clear();
            GetComponentsInChildren(true, onDestroyListTemp);
            for (int i = 0; i < onDestroyListTemp.Count; i++)
            {
                onDestroyListTemp[i].OnDestroy();
            }
            //UnityEngine.Debug.LogFormat("{0}销毁时执行了{1}个子物体组件的OnDestroy方法", luaName, onDestroyListTemp.Count);
            PushList(onDestroyListTemp);
        }
    }

    //public void Show()
    //{
    //    if (scriptEnv != null)
    //    {
    //        Action luaAwake = scriptEnv.Get<Action>("awake");
    //        scriptEnv.Get("start", out luaStart);
    //        scriptEnv.Get("update", out luaUpdate);
    //        scriptEnv.Get("ondestroy", out luaOnDestroy);

    //        if (luaAwake != null)
    //        {
    //            if (Debug.isProfilingSampleOn)
    //            {
    //                Debug.BeginProfileSample("LuaBehaviour Awake Callback Function  " + (transform.parent == null ? name : (transform.parent.name + "/" + name)));
    //            }
    //            luaAwake();
    //            if (Debug.isProfilingSampleOn)
    //            {
    //                Debug.EndProfileSample();
    //            }
    //        }
    //    }
    //    else
    //    {
    //        UnityEngine.Debug.Log("scriptEnv is null");
    //    }
    //}

    public void Dispose()
    {
        //if (luaOnDestroy != null)
        //{
        //    if (Debug.isProfilingSampleOn)
        //    {
        //        Debug.BeginProfileSample("LuaBehaviour OnDestroy Callback Function  " + (transform.parent == null ? name : (transform.parent.name + "/" + name)));
        //    }
        //    luaOnDestroy();
        //    if (Debug.isProfilingSampleOn)
        //    {
        //        Debug.EndProfileSample();
        //    }
        //}

        //luaOnDestroy = null;
        //luaUpdate = null;
        //luaStart = null;

        OnDestroy();
    }
}
