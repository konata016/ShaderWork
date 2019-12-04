Shader "Unlit/Sky"
{
    Properties
    {
        _MainTex ("Texture", CUBE) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                /*float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)*/
				float3 normal_w:TEXCOORD0;
				float3 eye_dir_w:TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            samplerCUBE _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.eye_dir_w = mul(unity_ObjectToWorld, v.vertex).xyz - _WorldSpaceCameraPos;
				o.normal_w = mul(UNITY_MATRIX_M, float4(v.normal, 0.0));

                /*o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);*/
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				float3 reflect = i.eye_dir_w - 2.0*dot(i.normal_w,i.eye_dir_w)*i.normal_w;
				reflect = float3(reflect.x, -reflect.z, reflect.y);
				fixed4 col = fixed4(texCUBE(_MainTex, reflect).rgb, 1.0);


                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                //// apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
