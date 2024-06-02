#version 120

varying vec2 texcoord;

uniform sampler2D gcolor;
uniform float viewWidth;
uniform float viewHeight;

void main() {
    vec3 color = texture2D(gcolor, texcoord).rgb;
    gl_FragColor = vec4(color, 1.0);
}