using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PL : MonoBehaviour
{
    Rigidbody rb;
    Vector3 move;
    Vector3 posSave;

    bool isObject;

    public float speed=3;
    public float jumpPower = 5;
    public float jumpMaxPosY;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        //プレイヤーが回転した時、動きもそれに合わせるための式
        float angleDir = transform.eulerAngles.y * (Mathf.PI / 180.0f);
        Vector3 dirVertical = new Vector3(Mathf.Sin(angleDir), 0, Mathf.Cos(angleDir));
        Vector3 dirHorizontal = new Vector3(-Mathf.Cos(angleDir), 0, Mathf.Sin(angleDir));

        //入力したときにカメラの向きを基準とした動き
        if (Input.GetAxis("Horizontal") != 0) move = -dirHorizontal * Input.GetAxis("Horizontal") * speed;
        if (Input.GetAxis("Vertical") != 0) move = dirVertical * Input.GetAxis("Vertical") * speed;

        //ジャンプ
        if (Input.GetButtonDown("Jump"))
        {
            move.y = jumpPower;
        }
        else
        {
            //オブジェクトに触れ居ている時にポジションをSaveする
            if (isObject)
            {
                posSave = transform.position;
            }
        }

        //一定の高さに高さに成ったら下向きの力を加える
        if (transform.position.y > jumpMaxPosY)
        {
            move.y = -3;
        }

        //移動
        rb.AddForce(speed * (move - rb.velocity));
    }

    private void OnCollisionEnter(Collision collision)
    {
        isObject = true;
        move.y = 0;
    }

    private void OnCollisionExit(Collision collision)
    {
        isObject = false;
    }
}
