#version 120

#include "library.glsl"

varying vec2 texcoord;
varying vec4 color;

void main() {

    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    gl_Position.xy = distortPosition(gl_Position.xy);
    texcoord = gl_MultiTexCoord0.xy;
    color = gl_Color;
}
