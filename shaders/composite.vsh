#version 120

varying vec2 texcoord;

// Unused varying
//varying vec3 sunVec;

uniform vec3 sunPosition;
uniform vec3 upPosition;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;

    //sunVec = normalize((gl_ModelViewMatrix * vec4(sunPosition, 1.0)).xyz);
}
