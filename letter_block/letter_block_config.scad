use <letter_block.scad>

characters = "ABCD";
cube_size = 35;
border_margin = 2;
border_thickness = 0.8;
border_padding = 1.5;
font="Liberation Mono:style=Bold";

assert(!is_undef(characters), "Must provide `characters` argument");
assert(is_string(characters), "`characters` must be a string");
assert(len(characters) == 4, "`characters` must contain exactly 4 values");

assert(!is_undef(cube_size), "Must provide `cube_size` argument");
assert(is_num(cube_size), "`cube_size` must be a number");
assert(cube_size > 0, "`cube_size` must be non-zero");

assert(!is_undef(border_margin), "Must provide `border_margin` argument");
assert(is_num(border_margin), "`border_margin` must be a number");
assert(border_margin > 0, "`border_margin` must be non-zero");

assert(!is_undef(border_thickness), "Must provide `border_thickness` argument");
assert(is_num(border_thickness), "`border_thickness` must be a number");
assert(border_thickness > 0, "`border_thickness` must be non-zero");

assert(!is_undef(border_padding), "Must provide `border_padding` argument");
assert(is_num(border_padding), "`border_padding` must be a number");
assert(border_padding > 0, "`border_padding` must be non-zero");

assert(border_margin + border_thickness + border_padding < cube_size, "The sum of `border_margin`, `border_thickness`, and `border_padding` must be less than `cube_size`");


letter_cube(characters, cube_size, border_margin, border_thickness, border_padding, font=font);

/* Good looking font options:
 *
 * "Liberation Mono:style=Bold" (default)
 * "Comic Sans MS:style=Bold"
 * "Courier New:style=Bold"
 * "Trebuchet MS:style=Bold"
 */
