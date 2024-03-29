﻿Shader "Unlit/EGS"
{
    Properties
    {
        _GlassTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
			#pragma geometry geom
            #pragma fragment frag
            // make fog work

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2g
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

			struct g2f
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

            sampler2D _GlassTex;
            float4 _MainTex_ST;

            v2g vert (appdata v)
            {
                v2g o;
				o.pos = v.vertex;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

			[maxvertexcount(12)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> stream) {
				
				float4 pos = float4(UnityObjectToViewPos((IN[0].pos.xyz + IN[1].pos.xyz + IN[2].pos.xyz) / 3.0), 1.0);
				float w = 1;
				float h = 1;
				g2f o;

				o.pos = mul(UNITY_MATRIX_P,pos + float4(-w, 0, 0, 0));
				o.uv = float2(0.0, 0.0);
				stream.Append(o);

				o.pos = mul(UNITY_MATRIX_P, pos + float4(-w, h, 0, 0));
				o.uv = float2(0.0, 1.0);
				stream.Append(o);

				o.pos = mul(UNITY_MATRIX_P, pos + float4(+w, 0, 0, 0));
				o.uv = float2(1.0, 0.0);
				stream.Append(o);

				o.pos = mul(UNITY_MATRIX_P, pos + float4(+w, h, 0, 0));
				o.uv = float2(1.0, 1.0);
				stream.Append(o);

			}

			fixed4 frag(g2f i) :SV_Target{
				fixed4 col = tex2D(_GlassTex,i.uv);
				if (col.a <= 0.5)discard;
				return col;
			}

            ENDCG
        }
    }
}
