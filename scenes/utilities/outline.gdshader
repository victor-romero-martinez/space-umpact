shader_type canvas_item;

uniform vec4 outline_color: source_color;
uniform float outline_size = 1.0;
uniform vec4 sprite_tint: source_color;

void fragment() {
	float zise_x = outline_size/float(textureSize(TEXTURE, 0).x);
	float zise_y = outline_size/float(textureSize(TEXTURE, 0).y);
	vec4 sprite_color = texture(TEXTURE, UV);
	sprite_color.rgb *= sprite_tint.rgb;
	float alpha = -4.0 * sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(zise_x, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(-zise_x, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(0, zise_y)).a;
	alpha += texture(TEXTURE, UV + vec2(0, -zise_y)).a;
	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
}