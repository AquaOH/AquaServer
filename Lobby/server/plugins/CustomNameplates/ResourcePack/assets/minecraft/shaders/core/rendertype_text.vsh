#version 150
#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform float GameTime;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out float depthLevel;

void main() {
    vec4 vertex = vec4(Position, 1.0);
    vertexDistance = fog_distance(Position, FogShape);
    depthLevel = Position.z;
    texCoord0 = UV0;
    if (Color.xyz == vec3(255., 254., 253.) / 255. && (Position.z == 50.03 || Position.z == 200.03 || Position.z == 400.03 || Position.z == 1000.03 || Position.z == 2000 || Position.z == 2200.03 || Position.z == 2400.06 || Position.z == 2400.12 || Position.z == 2650.03 || Position.z == 2800.03)) {
        vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
        vertex.y += 1;
        vertex.x += 1;
        gl_Position = ProjMat * ModelViewMat * vertex;
    } else if (Color.xyz == vec3(240., 240., 240.) / 255.) {
        vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
        vertexColor.rgb = texelFetch(Sampler2, UV2 / 16, 0).rgb;
        gl_Position = ProjMat * ModelViewMat * vertex;
    } else if (Color.xyz == vec3(60., 60., 60.) / 255.) {
        vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
        depthLevel = 114514.0;
        gl_Position = ProjMat * ModelViewMat * vertex;
    } else {
        vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
        gl_Position = ProjMat * ModelViewMat * vertex;
    }
}
