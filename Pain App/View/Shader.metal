#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct myPlaneNodeBuffer {
    float4x4 modelTransform;
    float4x4 modelViewTransform;
    float4x4 normalTransform;
    float4x4 modelViewProjectionTransform;
    float2x3 boundingBox;
};

typedef struct {
    float3 position [[ attribute(SCNVertexSemanticPosition) ]];
//    float2 texCoords [[ attribute(SCNVertexSemanticTexcoord0) ]];
    float4 color    [[ attribute(SCNVertexSemanticColor) ]];
} VertexInput;

static float rand(float2 uv)
{
    return fract(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}

static float2 uv2tri(float2 uv)
{
    float sx = uv.x - uv.y / 2;
    float sxf = fract(sx);
    float offs = step(fract(1 - uv.y), sxf);
    return float2(floor(sx) * 2 + sxf + offs, uv.y);
}
struct SimpleVertexWithUV
{
    float4 position [[ position ]];
    float2 uv;
    float4 color;
};

float plot(float2 st) {
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

struct Size {
    int size;
};

struct Touches {
    uint touches;
};

vertex SimpleVertexWithUV outline_vertex(VertexInput in [[ stage_in ]],
                                        constant SCNSceneBuffer& scn_frame [[buffer(0)]],
                                        constant myPlaneNodeBuffer& scn_node [[buffer(1)]],
                                         uint v_id [[vertex_id]])
{
    SimpleVertexWithUV vert;
    vert.position = scn_node.modelViewProjectionTransform * float4(in.position, 1.0);
//    vert.uv = in.texCoords;
//    vert.position = float4(in.position, 1.0);
//    float random = clamp(rand(in.position.xy), 0.0, 1.0);
    vert.color = in.color;
    return vert;
}

extern constant uint ids[256];

fragment float4 outline_fragment(SimpleVertexWithUV in [[stage_in]],
                                constant SCNSceneBuffer& scn_frame [[buffer(0)]],
                                constant myPlaneNodeBuffer& scn_node [[buffer(1)]],
                                device float4 *vertices [[buffer(2)]],
                                device float4 *triangles [[buffer(3)]],
//                                constant Touches& touches [[buffer(2)]],
//                                device uint* touches2 [[buffer(3)]],
//                                constant Size& size [[buffer(4)]],
                                float3 coord [[barycentric_coord]],
                                uint primitive_id [[primitive_id]]
                                )
{
    float4 fragColor;
    float2 uv = in.uv*50;
    //    float timer = scn_frame.time;
    //    uv.y += timer;
    //    float t = timer * 0.8;
    //    float tc = floor(t);
    //    float tp = smoothstep(0, 0.8, fract(t));
    //    float2 r1 = float2(floor(uv.y), tc);
    //    float2 r2 = float2(floor(uv.y), tc + 1);
    //    float offs = mix(rand(r1), rand(r2), tp);
    //    uv.x += offs * 8;
    float2 p = uv2tri(uv);
    float ph = rand(floor(p)) * 0.15 + p.y * 0.001;
    //    float c = abs(sin(ph + timer));
    float c = ph;
    fragColor = float4(c, c, c, 1);
    
    //    float3 color = float3(0.0);
    //    float2 bl = step(float2(0.1), in.uv);
    //    float2 tr = step(float2(0.1), 1.0 - in.uv);
    //    float pct = bl.x * bl.y * tr.x * tr.y;
    //
    //    color = float3(pct);
    //float4(clamp(in.color.rgb - cos(scn_frame.time / 500.0), 0.0, 1.0), 1.0)
    
    //    float4 color = float4(1.0);
    //    color = float4(min(color.rgb, 0.0 + abs(touches[20] - primitive_id)), 1.0);
    //    color = float4(min(color.rgb, 0.0 + abs(touches[2] - primitive_id)), 1.0);
    //
    //    color = float4(min(color.rgb, 0.0 + abs(touches[5] - primitive_id)), 1.0);
    //    color = float4(min(color.rgb, 0.0 + abs(touches[10] - primitive_id)), 1.0);
    //    color = float4(min(color.rgb, 0.0 + abs(touches.touches - primitive_id)), 1.0);
    
    //    color.rgb = min(color.rgb, 0.0 + abs(20 - primitive_id));
    //    for (int i = 0; i < size.size; i++) {
    //        color.rgb = min(color.rgb, 0.0 + abs(touches2[i] - primitive_id));
    //        if(touches2[i] == primitive_id) {
    //            break;
    //        }
    //        color.rgb = float3(0.7);
    //    }
    
    float4 color = in.color;
    
    if (primitive_id == 6476) {
        color.rgb = float3(0.75, 0.75, 0.75);
    }
    
    float3 d = fwidth(coord);
    float3 a3 = step(d * 0.5,coord);
    float edgeFactor = min(min(a3.x,a3.y),a3.z);
    color = float4(min(float3(edgeFactor), in.color.rgb), 1.0);
//    return float4(min(step(0.01, in.color.rgb), in.color.rgb), 1.0);
    return color;
}
