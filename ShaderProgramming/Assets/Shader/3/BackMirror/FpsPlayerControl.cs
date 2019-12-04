using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FpsPlayerControl : MonoBehaviour
{

    public GameObject Camera;
    public GameObject PL;

    // Use this for initialization
    void Start()
    {


    }

    // Update is called once per frame
    void Update()
    {
        float X_Rotation = Input.GetAxis("Mouse X");
        float Y_Rotation = Input.GetAxis("Mouse Y");
        PL.transform.Rotate(0, X_Rotation, 0);
        Camera.transform.Rotate(-Y_Rotation, 0, 0);

    }
}