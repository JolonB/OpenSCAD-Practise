use <letter_block.scad>

characters = "ABCD";
cube_size = 45;
border_margin = 6;  // outer
border_padding = 4; // inner
font="Liberation Mono:style=Bold";

// Camera
rotation = 45;
$vpr=[70,0,rotation];
$vpt=[0,0,cube_size/2];
$vpd=5*cube_size;

assert(!is_undef(characters), "Must provide `characters` argument");
assert(is_string(characters), "`characters` must be a string");
assert(len(characters) == 4, "`characters` must contain exactly 4 values");

assert(!is_undef(cube_size), "Must provide `cube_size` argument");
assert(is_num(cube_size), "`cube_size` must be a number");
assert(cube_size > 0, "`cube_size` must be non-zero");

assert(!is_undef(border_margin), "Must provide `border_margin` argument");
assert(is_num(border_margin), "`border_margin` must be a number");
assert(border_margin > 0, "`border_margin` must be non-zero");

assert(!is_undef(border_padding), "Must provide `border_padding` argument");
assert(is_num(border_padding), "`border_padding` must be a number");
assert(border_padding > 0, "`border_padding` must be non-zero");

assert(border_margin + border_padding < cube_size, "The sum of `border_margin`, `border_thickness`, and `border_padding` must be less than `cube_size`");

letter_cube(characters, cube_size, border_margin, border_padding, font=font);

/* Good looking font options:
 *
 * "Liberation Mono:style=Bold" (default)
 * "Comic Sans MS:style=Bold"
 * "Courier New:style=Bold"
 * "Trebuchet MS:style=Bold"
 */
