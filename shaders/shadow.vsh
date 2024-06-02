#version 120

#include "library.glsl"

void main() {

    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    gl_Position.xy = distortPosition(gl_Position.xy);

}
