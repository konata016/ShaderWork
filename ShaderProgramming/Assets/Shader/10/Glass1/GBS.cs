using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions;

public class GBS : MonoBehaviour
{
    public IBS prefab;
    public int INSTANCE_NUM = 1000;
    int last_Instance_num = 1000;

    public List<Color> colorList = new List<Color>();

    // Start is called before the first frame update
    void Start()
    {

        Generate();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnValidate()
    {
        if (last_Instance_num != INSTANCE_NUM)
        {
            last_Instance_num = INSTANCE_NUM;

            for (int i = 0; i < gameObject.transform.childCount; i++)
            {
                Destroy(gameObject.transform.GetChild(i).gameObject);
            }
            Generate();
        }
    }

    void Generate()
    {
        for(int i = 0; i < INSTANCE_NUM; i++)
        {
            var inst = Instantiate(prefab);

            inst.transform.parent = gameObject.transform;

            float y = Random.Range(0.3f, 1.5f);
            inst.transform.localScale = new Vector3(0.1f, y, 0.1f);

            inst.transform.position = new Vector3(Random.Range(-5f, 5f), y, Random.Range(-5f, 5f));

            int count = Random.Range(0, colorList.Count);
            inst.color = colorList[count];

            //inst.color.r = Random.Range(0f, 1f);
            //inst.color.g = Random.Range(0f, 1f);
            //inst.color.b = Random.Range(0f, 1f);
        }
    }
}
