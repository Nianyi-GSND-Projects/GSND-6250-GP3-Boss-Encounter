using UnityEditor;
using UnityEngine;

public class CreateAtOriginTool
{

    [MenuItem("GameObject/Create Empty At Origin %#e")]
    private static void CreateEmptyAtOrigin()
    {

        GameObject go = new GameObject("GameObject");


        go.transform.position = Vector3.zero;

        Undo.RegisterCreatedObjectUndo(go, "Create " + go.name);

        Selection.activeObject = go;
    }
}
    