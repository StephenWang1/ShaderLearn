using System.IO;
using UnityEngine;
public class EditorPath
{
    #region Excel转换相关路径

    public static string NetVisibleToolFile
    {
        get
        {
            return GetBackDir(Application.dataPath, 4) + "/Tool/NetVisibleTool/NetVisibleTool.exe";
        }
    }

    public static string GenSingleInterfaceToolFile
    {
        get
        {
            return GetBackDir(Application.dataPath, 4) + "/Tool/GenSingleInterface/GenSingleInterface.exe";
        }
    }

    public static string BatchCleanUpToolFile
    {
        get
        {
            return GetBackDir(Application.dataPath, 4) + "/Tool/BatchCleanUpProject/BatchCleanUpProject.exe";
        }
    }


    #endregion

    public static string LocalProjectName
    {
        get
        {
            string s = Application.dataPath.Replace("/Assets", "");
            s = s.Substring(s.LastIndexOf("/") + 1);
            return s;
        }
    }

    public static string LastOpenFolderKey = "LastOpenFolder";
    private static string _LastOpenFolder;
    public static string LastOpenFolder
    {
        get
        {
            if (string.IsNullOrEmpty(_LastOpenFolder))
            {
                _LastOpenFolder = PlayerPrefs.GetString(LastOpenFolderKey);
            }

            if (string.IsNullOrEmpty(_LastOpenFolder))
            {
                _LastOpenFolder = string.Empty;
            }

            return _LastOpenFolder;
        }
        set
        {
            FileInfo file = new FileInfo(value);
            _LastOpenFolder = file.Directory.ToString();
            PlayerPrefs.SetString(LastOpenFolderKey, _LastOpenFolder);
        }
    }

    public static string LastGenSingleInterfaceOpenFolderKey = "LastOpenFolder";
    private static string _LastGenSingleInterfaceOpenFolder;
    public static string LastGenSingleInterfaceOpenFolder
    {
        get
        {
            if (string.IsNullOrEmpty(_LastOpenFolder))
            {
                _LastGenSingleInterfaceOpenFolder = PlayerPrefs.GetString(LastGenSingleInterfaceOpenFolderKey);
            }

            if (string.IsNullOrEmpty(_LastGenSingleInterfaceOpenFolder))
            {
                _LastGenSingleInterfaceOpenFolder = string.Empty;
            }

            return _LastGenSingleInterfaceOpenFolder;
        }
        set
        {
            FileInfo file = new FileInfo(value);
            _LastGenSingleInterfaceOpenFolder = file.Directory.ToString();
            PlayerPrefs.SetString(LastGenSingleInterfaceOpenFolderKey, _LastGenSingleInterfaceOpenFolder);
        }
    }


    public static string GetBackDir(string dir, int time)
    {
        dir = dir.Replace("\\", "/");
        for (int i = 0; i < time; i++)
        {
            int lastIndex = dir.LastIndexOf("/");
            if (lastIndex == dir.Length - 1)
            {
                dir = dir.Substring(0, dir.Length - 1);
            }
            lastIndex = dir.LastIndexOf("/");
            if (lastIndex == -1)
            {
                return string.Empty;
            }

            dir = dir.Substring(0, lastIndex);
        }
        return dir;
    }

    public static string GetDirectory(string path)
    {
        path = path.Replace("\\", "/");
        int lastIndex = path.LastIndexOf("/");
        if (lastIndex == -1)
        {
            return "";
        }

        path = path.Substring(0, lastIndex);
        return path;
    }

    /*public static string GetStreamingAssetsPath(string folderName)
    {
        string filePath =
#if UNITY_ANDROID && !UNITY_EDITOR
        "jar:file://" + Application.dataPath + "!/assets/" + flodername + "/";
#elif UNITY_IPHONE && !UNITY_EDITOR
        Application.dataPath + "/Raw/";
#elif UNITY_STANDALONE_WIN || UNITY_EDITOR
            "file://" + Application.dataPath + "/StreamingAssets" + "/" + folderName + "/";
#else
        string.Empty;
#endif
        return filePath;
    }*/
    
    public static string GetStreamingAssetsPath()
    {
        string filePath =
#if UNITY_ANDROID && !UNITY_EDITOR
        "jar:file://" + Application.dataPath + "!/assets";
#elif UNITY_IPHONE && !UNITY_EDITOR
        Application.dataPath + "/Raw";
#elif UNITY_STANDALONE_WIN || UNITY_EDITOR
            /*"file://+"*/  Application.dataPath + "/StreamingAssets";
#else
        string.Empty;
#endif
        return filePath;
    }

}