using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Windows;

public class SerializeList
{
    public static string ListToJson<T>(List<T> l) 
    {
        return JsonUtility.ToJson(new SerializationList<T>(l));
    }

    public static List<T> ListFromJson<T>(string str) 
    {
        return JsonUtility.FromJson<SerializationList<T>>(str).ToList();
    }
    
    public static void SaveObjectToPlayerPrefs<T>(List<T> list,string key)
    {
        string shortCutKeyInfoJson = SerializeList.ListToJson(list);
        Debug.Log(shortCutKeyInfoJson);
        //PlayerPrefs.SetString(key,shortCutKeyInfoJson);
        System.IO.File.WriteAllText(@"d:\Users\admin\Desktop\test.txt",shortCutKeyInfoJson);
    }

    public static List<T> GetObjectFormPlayerPrefs<T>(string key) 
    {
        //var json= PlayerPrefs.GetString(key);
        var json=  System.IO.File.ReadAllText(@"d:\Users\admin\Desktop\test.txt");
        if (string.IsNullOrEmpty(json))
        {
            return default;
        }

        var a= SerializeList.ListFromJson<T>(json);
        if (a == null)
        {
            return default;
        }
        return a;
    }
    
    
}
