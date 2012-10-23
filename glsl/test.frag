uniform float t;
#include "glsl/crt.frag"

// wrapper for actual stuff
vec4 effect( vec4 color, sampler2D texture, vec2 tc, vec2 sc ) {
	return crt( color, texture, tc, sc);
}
