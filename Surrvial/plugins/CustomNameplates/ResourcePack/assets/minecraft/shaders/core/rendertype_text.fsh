#version 150
#moj_import<fog.glsl>

uniform sampler2D Sampler0;
uniform vec4 ColorModulator;
uniform float FogStart,FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in float depthLevel;

in vec2 pos1;
in vec2 pos2;
in vec2 coord;
flat in int posID;

out vec4 fragColor;

void main() {
    vec4 texColor = texture(Sampler0, texCoord0);
    vec4 color = texColor * vertexColor * ColorModulator;
    vec2 p1 = round(pos1 / (posID == 0 ? 1 - coord.x : 1 - coord.y));
    vec2 p2 = round(pos2 / (posID == 0 ? coord.y : coord.x));
    ivec2 resolution = ivec2(abs(p1 - p2));
    ivec2 corner = ivec2(min(p1, p2));
    vec4 pixel = texture(Sampler0, corner / 256.0) * 255;
    if (pixel.a == 1) {
        ivec2 frames = ivec2(resolution / pixel.gb);
        vec2 uv = (texCoord0 * 256 - corner) / frames.x;
        if (uv.x > pixel.y || uv.y > pixel.z)
            discard;
        int time = int(GameTime * 1200 * pixel.x) % int(frames.x * frames.y);
        uv = corner + mod(uv, pixel.yz) + vec2(time % frames.x, time / frames.x % frames.y) * pixel.yz;
        color = texture(Sampler0, uv / 256.0) * vertexColor * ColorModulator;
    }
    if (color.a < 0.1) {
        discard;
    }
    if (texColor.a == 254.0/255.0) {
        if (depthLevel == 0.00) {
            discard;
        } else {
            color = vec4(texColor.rgb, 1.0) * vertexColor * ColorModulator;
        }
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
