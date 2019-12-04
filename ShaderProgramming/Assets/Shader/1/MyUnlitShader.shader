Shader "Unlit/MyUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}	//インスペクター上で操作ができるやつらしい
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }	//表示順を決めるやつらしい
        LOD 100

        Pass	//一度の描画時に出るもの　Passはいくつでも作れる
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;	//位置座標	float4はfloatが4つあるやつ
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)				//フォグのやつ
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;		// インスペクター上で操作ができるやつらしいの宣言
            float4 _MainTex_ST;

            v2f vert (appdata v)	//頂点シェーダー
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target	//フラグメントシェーダー
            {
                //// sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);		//テキストを読み込む
                //// apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);
                //return col;

				return float4(1,0,0,1);
            }
            ENDCG
        }
    }
}
