#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 normal;

varying vec4 vertex_view;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	normal = gl_NormalMatrix * gl_Normal;
	vertex_view = gl_ModelViewMatrix * gl_Vertex;
}