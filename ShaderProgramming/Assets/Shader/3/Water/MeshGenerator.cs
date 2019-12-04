using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshGenerator : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        GetComponent<MeshFilter>().mesh = generateFineMesh(100, 100, 10.0f, 10.0f);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    Mesh generateFineMesh(int nX,int nZ,float sizX, float sizZ)
    {
        int numVerticies = (nX + 1) * (nZ + 1);
        Vector3[] aVertex = new Vector3[numVerticies];
        Vector3[] aNormal = new Vector3[numVerticies];
        Vector2[] aUv = new Vector2[numVerticies];

        float dX = sizX / (float)nX;
        float dZ = sizX / (float)nZ;
        int idx = 0;
        float fz = -0.05f * sizZ;

        for (int z = 0; z <= nZ; z++)
        {
            float v = (float)z / (float)nX;
            float fx = -0.05f * sizX;

            for (int x = 0; x <= nX; x++)
            {
                float u = (float)x / (float)nX;
                aVertex[idx] = new Vector3(fx, 0f, fz);
                aNormal[idx] = new Vector3(0f, 1f, 0f);
                aUv[idx] = new Vector2(u, v);
                idx++;
                fx += dX;
            }
            fz += dZ;
        }

        idx = 0;

        int[] indecies = new int[nX * nZ * 6];

        for(int z = 0; z < nZ; z++)
        {
            int index = z * (nX + 1);

            for(int x = 0; x < nX; x++)
            {
                indecies[idx + 0] = index;
                indecies[idx + 1] = index+nX+1;
                indecies[idx + 2] = index+1;
                indecies[idx + 3] = index+1;
                indecies[idx + 4] = index+nX+1;
                indecies[idx + 5] = index+nX+2;
                index++;
                idx += 6;
            }
        }

        Mesh mesh = new Mesh
        {
            vertices = aVertex,
            normals = aNormal,
            uv = aUv
        };

        mesh.SetIndices(indecies, MeshTopology.Triangles, 0);

        return mesh;
    }
}
