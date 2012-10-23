// horizontal lines for CRT monitor stuffs
// float t is time in seconds, please define somewhere
vec4 crt( vec4 color, sampler2D texture, vec2 tc, vec2 sc ) {
	color = vec4 ( Texel( texture, tc ) );
	float it = 0 - t;
	vec4 distort = vec4 (
		// red
		( 10.5 + abs( cos( color.r + sc.y ) + cos( it ) ) ) / 12.5,
		// green
		( 10.1 + abs( cos( color.g + sc.y ) + cos( t ) ) ) / 12.1,
		// blue
		( 10.2 + abs( cos( color.b + sc.y ) + cos( it ) ) ) / 12.2,
		// alpha
		1.0
	);
	color.rgb = distort.rgb * ( color.rgb * 1.1 );
	return color;
}
