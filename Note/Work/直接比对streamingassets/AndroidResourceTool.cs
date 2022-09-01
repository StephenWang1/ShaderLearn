using ExtendEditor;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using UnityEditor;
using UnityEngine;

public class AndroidResourceTool : AssetPostprocessor, IEditorTool
{
    public static string RootPath;


    private static string projectPath;
    /// <summary>
    /// 版本文件跟路径
    /// </summary>
    private static string versionsPath;
    /// <summary>
    /// assets文件跟路径
    /// </summary>
    private static string assetsPath;
    /// <summary>
    /// assets文件跟路径
    /// </summary>
    private static string autoHotUpdate;
    /// <summary>
    /// 操作类型文件路径
    /// </summary>
    private static string hotOperationPath;
    /// <summary>
    /// 操作类型
    /// </summary>
    private static int hotOperation;
    /// <summary>
    /// 操作类型文件路径
    /// </summary>
    private static string lastGenTime;

    public static List<DataPathInfo> list = new List<DataPathInfo>();

    private string[] ControlList = new string[] { "热更资源处理", "首包资源获取", "处理所有", "只获取资源列表" };
    private int[] ControlListIndex = new int[] { 0, 1, 2, 3 };

    static CSAndroidResourceToolBuildData AndroidResourceToolBuildData = null;

    public AndroidResourceTool()
    {
        Init();
        if (AndroidResourceToolBuildData == null) AndroidResourceToolBuildData = new CSAndroidResourceToolBuildData();
    }

    [UnityEditor.Callbacks.DidReloadScripts]
    static void AllScriptsReloaded()
    {
        if (AndroidResourceToolBuildData == null) AndroidResourceToolBuildData = new CSAndroidResourceToolBuildData();
        AndroidResourceToolBuildData.AllScriptsReloaded();
    }

    public void Init()
    {
        list.Clear();
        RootPath = (Application.dataPath).Replace("/Assets", "/AutoHotUpdate");
        projectPath = RootPath + "\\data\\projectPath.txt";
        versionsPath = RootPath + "\\data\\versionsPath.txt";
        assetsPath = RootPath + "\\data\\assetsPath.txt";
        autoHotUpdate = RootPath + "\\run.exe";
        hotOperationPath = RootPath + "\\data\\operationPath.txt";

        //资源文件路径
        string projectPathInfo = GetPath(projectPath);
        //版本文件路径
        string versionsPathInfo = GetPath(versionsPath);
        //assets文件跟路径
        string assetsPathInfo = GetPath(assetsPath);
        lastGenTime = GetPathInPb("lastGenTime");
        list.Add(new DataPathInfo("工程资源文件路径:", projectPathInfo, projectPath));
        list.Add(new DataPathInfo("资源文件存档路径:", versionsPathInfo, versionsPath));
        //list.Add(new DataPathInfo("assets文件跟路径:", assetsPathInfo, assetsPath));
    }

    /// <summary>
    /// 自动生成代码
    /// </summary>
    public void AutoGenerateCode()
    {
        AndroidResourceToolBuildData.AutoBuildType = EAutoBuildType.AutoGenerateClassUpdateFile;
        //bool isUseSourceCode = false;
        //DirectoryInfo info = new DirectoryInfo(Application.dataPath + "/CB");
        //DirectoryInfo[] childs = info.GetDirectories();
        //if (childs != null && childs.Length > 1)
        //{
        //    isUseSourceCode = true;
        //}
        //UnityEngine.Debug.LogError("是否是使用DLL工程:" + isUseSourceCode);
        //UnityEngine.Debug.LogError("开始生成代码, 共4步,直至创建出APK为止,中途请勿操作");
        //if (!isUseSourceCode)
        //{
        //    AndroidResourceToolBuildData.ClassAutoStage1_NGUIReplace(true);
        //}
        AndroidResourceToolBuildData.ClassAutoStage2_ClearXlua(true);
    }

    public void OnGUI()
    {
        if (GUILayout.Button("保存配置", GUILayout.Width(200)))
        {
            SaveDataInfo();
        }

        DataOperation(list);

        GUIWindow.DrawSeparator();
        GUILayout.Space(20);

        GUILayout.BeginHorizontal();
        GUILayout.Label(lastGenTime, GUILayout.Width(300));
        GUILayout.EndHorizontal();

        GUILayout.BeginHorizontal();
        if (GUILayout.Button("1.Clear", GUILayout.Width(200)))
        {
            AndroidResourceToolBuildData.ClassAutoStage2_ClearXlua();
        }
        if (GUILayout.Button("2.Gen", GUILayout.Width(200)))
        {
            AndroidResourceToolBuildData.ClassAutoStage3_GenXlua();
        }
        if (GUILayout.Button("3.Build", GUILayout.Width(200)))
        {
            if (!CheckFontDependices()) return;
            if (!CheckXLuaGenCorrect()) return;
            OpenBuildSettingsPanel();
        }
        if (GUILayout.Button("4.将工程代码以及转移至资源存档目录", GUILayout.Width(300)))
        {
            //string client = Application.dataPath.Replace("/Assets", "");
            //string folder = client + "/AutoHotUpdate/ZipManager.exe";
            //Process.Start(folder, string.Format("{0} {1} {2}", "UnityAll", client, AndroidBuildPanel.GetToolResoutceOutPath()));
            AndroidResourceToolBuildData.ClassAutoStage4_TransferResource();
        }
        if (GUILayout.Button("5.拷贝IL2CPP代码到更新目录下", GUILayout.Width(200)))
        {
            CopyIL2Cpp();
        }
        GUILayout.EndHorizontal();
        GUILayout.Space(10);

        GUILayout.BeginHorizontal();
        {
            if (GUILayout.Button("AutoGenerateCode", GUILayout.Width(200)))
            {
                AutoGenerateCode();
            }
        }
        GUILayout.EndHorizontal();

        //GUILayout.Space(20);
        //GUILayout.Label("操作类型");

        //hotOperation = EditorGUILayout.IntPopup(hotOperation, ControlList, ControlListIndex, GUILayout.Width(200));
        GUIWindow.DrawSeparator();

        GUILayout.Space(20);

        GUILayout.BeginHorizontal();
        {
            if (GUILayout.Button("1.更新UI Assetbundle资源到资源目录", GUILayout.Width(250)))
            {
                GenerateAB();
            }

            if (GUILayout.Button("2.拷贝Lua 并加密", GUILayout.Width(200)))
            {
                CopyLuaToLocalResourcesLoadPath();
            }
            
            if (GUILayout.Button("2.拷贝Lua(streaming assets path) 并加密", GUILayout.Width(400)))
            {
                CopyLuaToStreamingAssetsPath();
            }

            if (GUILayout.Button("3.热更资源处理", GUILayout.Width(200)))
            {
                hotOperation = 0;
                if (!DetectionPath())
                {
                    return;
                }
                SaveDataInfo();
                Process.Start(autoHotUpdate);
            }
            if (GUILayout.Button("4.首包资源获取", GUILayout.Width(200)))
            {
                hotOperation = 1;
                if (!DetectionPath())
                {
                    return;
                }
                SaveDataInfo();
                Process.Start(autoHotUpdate);
            }

            if (GUILayout.Button("5.将首包资源转移至资源存档目录", GUILayout.Width(300)))
            {
                string folder = Application.dataPath.Replace("/Assets", "/AutoHotUpdate/data/FirstResource");
                FileUtility.CopyFolderToPath(folder, AndroidBuildPanel.GetToolResoutceOutPath());
            }
        }
        GUILayout.EndHorizontal();

        GUILayout.Space(20);

        GUILayout.BeginHorizontal();
        {
            if (GUILayout.Button("一键处理所有资源", GUILayout.Width(300)))
            {
                if (!DetectionPath())
                {
                    return;
                }
                //1.更新UI Assetbundle资源到资源目录
                GenerateAB();
                //2.拷贝Lua 并加密
                CopyLuaToLocalResourcesLoadPath();
                //3.热更资源处理
                hotOperation = 0;
                SaveDataInfo();
                Process pp1 = Process.Start(autoHotUpdate);
                pp1.WaitForExit();
                //4.首包资源获取
                hotOperation = 1;
                SaveDataInfo();
                Process pp2 = Process.Start(autoHotUpdate);
                pp2.WaitForExit();
                //5.将首包资源转移至资源存档目录
                string folder = Application.dataPath.Replace("/Assets", "/AutoHotUpdate/data/FirstResource");
                FileUtility.CopyFolderToPath(folder, AndroidBuildPanel.GetToolResoutceOutPath());
            }
            
            if (GUILayout.Button("一键处理所有资源(lua streaming Assets Path)", GUILayout.Width(500)))
            {
                if (!DetectionPath())
                {
                    return;
                }
                //1.更新UI Assetbundle资源到资源目录
                GenerateAB();
                //2.拷贝Lua 并加密
                CopyLuaToStreamingAssetsPath();
                //3.热更资源处理
                hotOperation = 0;
                SaveDataInfo();
                Process pp1 = Process.Start(autoHotUpdate);
                pp1.WaitForExit();
                //4.首包资源获取
                hotOperation = 1;
                SaveDataInfo();
                Process pp2 = Process.Start(autoHotUpdate);
                pp2.WaitForExit();
                //5.将首包资源转移至资源存档目录
                string folder = Application.dataPath.Replace("/Assets", "/AutoHotUpdate/data/FirstResource");
                FileUtility.CopyFolderToPath(folder, AndroidBuildPanel.GetToolResoutceOutPath());
            }
        }
        GUILayout.EndHorizontal();

        GUILayout.Space(20);

        GUIWindow.DrawSeparator();

        GUILayout.BeginHorizontal();
        {
            if (GUILayout.Button("一键提交所有", GUILayout.Width(300)))
            {
                string commitPath = "";
                commitPath += (string.IsNullOrEmpty(commitPath) ? "" : "*") + GetPath(versionsPath);
                commitPath += (string.IsNullOrEmpty(commitPath) ? "" : "*") + AndroidBuildPanel.GetToolResoutceOutPath();
                Process pp1 = Process.Start("TortoiseProc.exe", @"/command:commit" + " /path:" + commitPath + " /closeonend:0");
                pp1.WaitForExit();
            }
        }
        GUILayout.EndHorizontal();

        GUIWindow.DrawSeparator();

        GUILayout.Label("其他");

        GUILayout.BeginHorizontal();
        {
            if (GUILayout.Button("刷新", GUILayout.Width(100)))
            {
                Init();
            }
            if (GUILayout.Button("帮助文档", GUILayout.Width(100)))
            {
                OpenFolder(RootPath + "/help");
            }
        }
        GUILayout.EndHorizontal();

        GUIWindow.DrawSeparator();
        GUILayout.BeginHorizontal();
        {
            if (GUILayout.Button("protobuff dll替换源码", GUILayout.Width(200)))
            {
                DllToFolder();
            }
            if (GUILayout.Button("protobuff 源码替换dll", GUILayout.Width(200)))
            {
                FolderToDll();
            }
            //if (GUILayout.Button("1.NGUI dll替换(源码工程跳过)", GUILayout.Width(220)))
            //{
            //    AndroidResourceToolBuildData.ClassAutoStage1_NGUIReplace();
            //}
        }
        GUILayout.EndHorizontal();

        GUIWindow.DrawSeparator();
    }

    /// <summary>
    /// NGUI_No_UNITYEDITOR_Flag下保存的NGUI.dll是没有UNITY_EDITOR编译宏de
    /// </summary>
    public static void CopyNGUI(bool isCopyToProject = true)
    {
        if (!EditorUtil.IsBaseClient)
        {

            if (isCopyToProject)
            {
                string nguiNoUNITY_EDITOR_dllPath = FileUtilityEditor.GetBackDir(Application.dataPath, 4) + "/ClassLibrary_wzcq3D/DllOutput/NGUI_No_UNITYEDITOR_Flag/NGUI.dll";
                string targetPath = Application.dataPath + "/Plugins/Dll/NGUI.dll";
                if (File.Exists(nguiNoUNITY_EDITOR_dllPath))
                {
                    File.Copy(nguiNoUNITY_EDITOR_dllPath, targetPath, true);
                }
            }
            else
            {
                string ngui_dllPath = FileUtilityEditor.GetBackDir(Application.dataPath, 4) + "/ClassLibrary_wzcq3D/DllOutput/NGUI.dll";
                string targetPath = Application.dataPath + "/Plugins/Dll/NGUI.dll";
                if (File.Exists(ngui_dllPath))
                {
                    File.Copy(ngui_dllPath, targetPath, true);
                }
            }
            AssetDatabase.Refresh(ImportAssetOptions.ForceUpdate);
        }


        //EditorUtility.DisplayDialog("Finish", "发布版本前的准备（build前点击）完成","确定");
    }

    private void OpenBuildSettingsPanel()
    {
        EditorApplication.ExecuteMenuItem("File/Build Settings...");
    }

    private bool CheckFontDependices()
    {
        List<string> list = new List<string>();
        FileUtilityEditor.GetDeepAssetPaths(Application.dataPath + "/Resources", list, ".prefab");
        string errorInfo = "";
        for (int i = 0; i < list.Count; i++)
        {
            string path = list[i];
            //GameObject go = AssetDatabase.LoadAssetAtPath(list[i], typeof(GameObject)) as GameObject;
            //if (go == null) continue;
            string[] dependes = AssetDatabase.GetDependencies(path);
            foreach (var cur in dependes)
            {
                if (cur.EndsWith(".cs")) continue;
                if (cur.Contains("msyh"))
                {
                    errorInfo += path + " 字体msyh\n";
                }
                if (cur.Contains("SOURCEHANSANSCN-NORMAL"))
                {
                    errorInfo += path + " 字体SOURCEHANSANSCN-NORMAL\n";
                }
            }

        }

        if (!string.IsNullOrEmpty(errorInfo))
        {
            UnityEngine.Debug.LogError(errorInfo + " 资源有对字体的引用，请手动去除");
            EditorUtility.DisplayDialog("Error", errorInfo + " 资源有对字体的引用，请手动去除", "确定");
            return false;
        }

        return true;
    }

    private bool CheckXLuaGenCorrect()
    {
        List<string> list = new List<string>();
        FileUtilityEditor.GetDeepAssetPaths(Application.dataPath + "/XLua/Gen", list, ".cs");
        if (list.Count < 1000)
        {
            UnityEngine.Debug.LogError("Xlua Wrap没有正确生成代码,请重新生成");
            EditorUtility.DisplayDialog("Error", "Xlua Wrap没有正确生成代码,请重新生成", "确定");
            return false;
        }
        return true;
    }

    public static void CopyIL2Cpp()
    {
        string versionsPathInfo = GetPath(versionsPath);
        string airPath = versionsPathInfo + "\\";
        string folderPath = AndroidBuildPanel.GetToolResoutceOutPath() + "\\IL2CPP\\";
        if (Directory.Exists(folderPath))
        {
            CopyPtf(folderPath, airPath, false);
        }
        else
        {
            UnityEngine.Debug.LogError("不存在文件夹路径" + folderPath);
        }
    }
    private void CopyMono()
    {
        string versionsPathInfo = GetPath(versionsPath);
        string airPath = versionsPathInfo + "\\";
        string folderPath = AndroidBuildPanel.GetToolResoutceOutPath() + "/Mono/";
        if (Directory.Exists(folderPath))
        {
            CopyPtf(folderPath, airPath, false);
        }
        else
        {
            UnityEngine.Debug.LogError("不存在文件夹路径" + folderPath);
        }
    }

    private void GenerateAB()
    {
        string andoridPath = CSEditorPath.Get(EEditorPath.LocalResourcesLoadPath) + "Android";
        //FileUtilityEditor.DeleteDir(andoridPath);
        //DoAssetbundle.SetMainAssetBundleName();
        DoAssetbundle.CreateAllAssetBundles(false);
        string path = CSEditorPath.Get(EEditorPath.LocalResourcesLoadPath) + "Android/";
    }
    private void DllToFolder()
    {
        string dllPath = Application.dataPath + "/Plugins/protobuf-net.dll";
        string folderPath = Application.dataPath.Replace("/Assets", "/protobuf-net");
        string folderToPath = Application.dataPath + "/protobuf-net";
        if (Directory.Exists(folderPath))
        {
            CopyPtf(folderPath, folderToPath);
            if (File.Exists(dllPath))
                File.Delete(dllPath);
            else
                UnityEngine.Debug.LogError("不存在文件路径" + dllPath);
        }
        else
        {
            UnityEngine.Debug.LogError("不存在文件夹路径" + folderPath);
        }
    }
    private static void CopyPtf(string otherPaht, string airPath, bool creatrPath = true)
    {
        if (creatrPath)
        {
            if (Directory.Exists(airPath))
            {
                FileUtilityEditor.DeleteDir(airPath, "", true);
            }

            FileUtilityEditor.DetectCreateDirectory(airPath);
        }
        else
        {
            string[] path = Directory.GetFiles(otherPaht);
            for (int i = 0; i < path.Length; i++)
            {
                if (File.Exists(path[i].Replace(otherPaht, airPath)))
                    File.Delete(path[i].Replace(otherPaht, airPath));
            }
        }
        FileUtilityEditor.CopyDir(otherPaht, airPath);
    }
    private void FolderToDll()
    {
        string dllToPath = Application.dataPath + "/Plugins/protobuf-net.dll";
        string dllPath = Application.dataPath.Replace("/Assets", "/AutoHotUpdate/protobuf-net.dll");
        string folderPath = Application.dataPath + "/protobuf-net";
        if (File.Exists(dllPath))
        {
            if (File.Exists(dllToPath))
                File.Delete(dllToPath);
            File.Copy(dllPath, dllToPath);
            if (Directory.Exists(folderPath))
                FileUtilityEditor.DeleteDir(folderPath, "", true);
            else
                UnityEngine.Debug.LogError("不存在文件夹路径" + folderPath);
        }
        else
        {
            UnityEngine.Debug.LogError("不存在文件路径" + dllPath);
        }

    }
    private void CopyLuaRes(string targetDir)
    {
        string srcDir = FileUtilityEditor.GetBackDir(Application.dataPath, 1) + "/luaRes";
        //string targetDir = CSEditorPath.Get(EEditorPath.LocalResourcesLoadPath) + "luaRes";
       // string targetDir = CSEditorPath.Get(EEditorPath.StreamingAssetsPath) + "/luaRes";
        if (Directory.Exists(targetDir))
        {
            //Directory.Delete(targetDir, true);
            FileUtilityEditor.DeleteDir(targetDir, "", true);
        }
        FileUtilityEditor.DetectCreateDirectory(targetDir);
        FileUtilityEditor.CopyDir(srcDir, targetDir);
        string luaSetPath = targetDir + "/.idea";
        if (Directory.Exists(luaSetPath))
        {
            //Directory.Delete(luaSetPath, true);
            FileUtilityEditor.DeleteDir(luaSetPath, "", true);
        }
        if (CSInterfaceSingletonEditor.iEditorAssist.IsNeedEncryptLua)
        {
            CSInterfaceSingletonEditor.iEditorAssist.EncryptLua(targetDir);
        }
    }

    private void CopyLuaToLocalResourcesLoadPath()
    {
        string targetDir = CSEditorPath.Get(EEditorPath.LocalResourcesLoadPath) + "luaRes";
        CopyLuaRes(targetDir);
    }

    private void CopyLuaToStreamingAssetsPath()
    {
        string targetDir = Application.streamingAssetsPath + "/luaRes";
        CopyLuaRes(targetDir);
    }
    

    public static void FastBuildPlayerWindowProc2()
    {
        EditorWindow win = FastBuildPlayerWindow.GetWindow(typeof(FastBuildPlayerWindow));
        win.Show();
    }

    /// <summary>
    /// 检测路径
    /// </summary>
    private bool DetectionPath()
    {
        foreach (var item in list)
        {
            if (!Directory.Exists(item.Path))
            {
                EditorUtility.DisplayDialog("检测", item.Name + item.Path + "路径无法找到！！", "确定");
                return false;
            }
        }
        return true;

    }
    /// <summary>
    /// 打开文件路径
    /// </summary>
    /// <param name="path"></param>
    private static void OpenFolder(string path)
    {
        if (Directory.Exists(path))
        {
            Process.Start(path);
        }

    }
    #region Data
    private static string ProjectPath
    {
        get
        {
            return Application.dataPath.Replace("/Assets", "");
        }
    }
    /// <summary>
    /// 文件数据一键操作
    /// </summary>
    private void DataOperation(List<DataPathInfo> list)
    {
        foreach (var path in list)
        {
            GUILayout.BeginHorizontal();
            {
                GUILayout.Label(path.Name, GUILayout.Width(100));
                path.Path = GUIWindow.TextField(path.Path, GUILayout.Width(600));
                if (GUILayout.Button("打开目录", GUILayout.Width(100)))
                {
                    if (Directory.Exists(path.Path))
                    {
                        FileUtilityEditor.Open(path.Path);
                    }
                    else
                    {
                        UnityEngine.Debug.LogError(path.Path + " is not exist");
                    }
                }
            }

            if (GUILayout.Button("创建目录", GUILayout.Width(80)))
            {
                if (!Directory.Exists(path.Path))
                {
                    Directory.CreateDirectory(path.Path);
                }
            }
            if (GUILayout.Button("SVN 更新", GUILayout.Width(80)))
            {
                FileUtilityEditor.ProcSVNCmd(path.Path, "update");
            }
            if (GUILayout.Button("SVN 提交", GUILayout.Width(80)))
            {
                FileUtilityEditor.ProcSVNCmd(path.Path, "commit");
            }
            if (GUILayout.Button("SVN 还原", GUILayout.Width(80)))
            {
                FileUtilityEditor.ProcSVNCmd(path.Path, "revert");
            }
            if (GUILayout.Button("SVN 日志", GUILayout.Width(80)))
            {
                FileUtilityEditor.ProcSVNCmd(path.Path, "log");
            }
            GUILayout.EndHorizontal();
        }
    }



    /// <summary>
    /// 版本配置
    /// </summary>
    private void ConfigVersion()
    {
        GUILayout.BeginHorizontal();

        GUILayout.BeginHorizontal();

    }

    /// <summary>
    /// 保存数据
    /// </summary>
    private void SaveDataInfo()
    {
        foreach (var item in list)
        {
            WriterData(item.DataPath, item.Path);
            SetPath(item.DataPath, item.Path);
        }
        WriterData(hotOperationPath, hotOperation.ToString());
    }
    #endregion

    #region 工具
    private static string GetPathInPb(string path)
    {
        if (PlayerPrefs.HasKey(path))
        {
            return PlayerPrefs.GetString(path);
        }
        else
        {
            return "本地无Gen的时间记录";
        }
    }
    private static string GetPath(string path)
    {
        if (PlayerPrefs.HasKey(path))
        {
            return PlayerPrefs.GetString(path);
        }
        else
        {
            return ReaderData(path);
        }
    }

    private static void SetPath(string path, string data)
    {
        PlayerPrefs.SetString(path, data);
    }
    /// <summary>
    /// 读取文件
    /// </summary>
    /// <param name="path">去读路径</param>
    private static string ReaderData(string path)
    {
        using (StreamReader reader = new StreamReader(path))
        {
            return reader.ReadToEnd();
        }

    }
    /// <summary>
    /// 写入数据
    /// </summary>
    /// <returns></returns>
    private static void WriterData(string path, string data)
    {
        if (File.Exists(path))
        {
            File.Delete(path);
        }
        using (StreamWriter sw = new StreamWriter(path))
        {
            sw.Write(data);
            sw.Dispose();
            sw.Close();
        }
    }
    #endregion
}

//public class DataPathInfo
//{
//    private string name;

//    public string Name
//    {
//        get { return name; }
//        set { name = value; }
//    }
//    private string path;

//    public string Path
//    {
//        get { return path; }
//        set { path = value; }
//    }

//    private string dataPath;

//    public string DataPath
//    {
//        get { return dataPath; }
//        set { dataPath = value; }
//    }
//    public DataPathInfo(string name, string path, string dataPath)
//    {
//        this.name = name;
//        this.path = path;
//        this.dataPath = dataPath;
//    }


//}

//public enum HotOperation
//{
//    HotUpadte = 0,
//    FirstResource = 1,
//    HotAndFirst = 2,
//}
public class OutResourcePathItem
{
    public string name = "";
    public string path = "";

    public OutResourcePathItem(string name, string path)
    {
        this.name = name;
        this.path = path;
    }
}