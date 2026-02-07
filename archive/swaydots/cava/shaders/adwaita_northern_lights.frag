#version 330

in vec2 fragCoord;
out vec4 fragColor;

// bar values. defaults to left channels first (low to high), then right (high to low).
uniform float bars[512];

uniform int bars_count;    // number of bars (left + right) (configurable)

uniform vec3 u_resolution; // window resolution, not used here

//colors, configurable in cava config file
uniform vec3 bg_color; // background color(r,g,b) (0.0 - 1.0), not used here
uniform vec3 fg_color; // foreground color, not used here

uniform int gradient_count;
uniform vec3 gradient_colors[8]; // gradient colors

vec3 normalize_C(float y,vec3 col_1, vec3 col_2, float y_min, float y_max)
{
    //create color based on fraction of this color and next color
    float yr = (y - y_min) / (y_max - y_min);
    return col_1 * (1.0 - yr) + col_2 * yr;
}

void main()
{
    // find which bar to use based on where we are on the x axis
    int bar = int(bars_count * fragCoord.x);

    float bar_y = 1.0 - abs((fragCoord.y - 0.5)) * 2.0;
    float y = (bars[bar]) * bar_y;

    float bar_x = (fragCoord.x - float(bar) / float(bars_count)) * bars_count;
    float bar_r = 1.0 - abs((bar_x - 0.5)) * 2;

    bar_r = bar_r * bar_r * 2;

    vec3 color;
    if (gradient_count > 0) {
        // Use gradient colors based on y position
        int color_idx = int((gradient_count - 1) * fragCoord.y);
        if (color_idx >= gradient_count - 1) {
            color = gradient_colors[gradient_count - 1];
        } else {
            float y_min = float(color_idx) / float(gradient_count - 1);
            float y_max = float(color_idx + 1) / float(gradient_count - 1);
            color = normalize_C(fragCoord.y, gradient_colors[color_idx], 
                               gradient_colors[color_idx + 1], y_min, y_max);
        }
    } else {
        // Use foreground color if no gradient
        color = fg_color;
    }

    // set color
    fragColor.r = color.x * y * bar_r;
    fragColor.g = color.y * y * bar_r;
    fragColor.b = color.z * y * bar_r;
    fragColor.a = 1.0;
}