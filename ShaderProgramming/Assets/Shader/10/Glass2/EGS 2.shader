Shader "Unlit/EGS"
{
    Properties
    {
        _GlassTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
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
                o.uv = v.uv;
                return o;
            }

			[maxvertexcount(30)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> stream) {
				
				g2f o;
				float dy = 1.0 / 4.0 / 2.0;
				for (int i = 0; i < 10; i++) {
					o.pos = UnityObjectToClipPos(IN[0].pos + float4(0, sin(dy), cos(dy), 0));
					o.uv = IN[0].uv;
					stream.Append(o);

					o.pos = UnityObjectToClipPos(IN[1].pos + float4(0, 0, 0, 0));
					o.uv = IN[1].uv;
					stream.Append(o);

					o.pos = UnityObjectToClipPos(IN[2].pos + float4(0, sin(dy), cos(dy), 0));
					o.uv = IN[2].uv;
					stream.Append(o);

					stream.RestartStrip();

					dy += 1.0 / 4.0;	
				}

			}

			fixed4 frag(g2f i) :SV_Target{
				fixed4 col = tex2D(_GlassTex,i.uv);
				if (col.a <= 0.5)discard;
				col.a = 0.3;
				return col;
			}

            ENDCG
        }
    }
}
