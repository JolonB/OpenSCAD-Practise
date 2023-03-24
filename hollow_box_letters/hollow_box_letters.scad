use <fontmetrics.scad>;

cube_size = 45;
cube_wall_thickness = 3;
text_border_margin = 3;  // outer
text_border_padding = 4; // inner
text_border_thickness = 1.5;
text_depth = 0.2;
min_max_scaling = 1.2;
characters = "ABCD";
letter_font="Liberation Mono:style=Bold"; // TODO change to Nimbus Mono or similar

assert(cube_size > 2 * cube_wall_thickness);
assert(len(characters) == 4);

module letter (character, size, center=[0,0,0], rotation=[0,0,0]) {
    char_len = len(character);
    assert(char_len == 1, str("A letter cannot contain more than one character. '", character, "' contains ", char_len));
    character = uppercaseChar(character);

    dimensions = measureTextBounds(character, font=letter_font, size=size)[1];
    scale_factor = size / max(dimensions);

    let (
    size = scale_factor >= min_max_scaling ? size * min_max_scaling : size,
    char_bounds = measureTextBounds(character, font=letter_font, size=size),
    corner_pos = char_bounds[0],
    dimensions = char_bounds[1]
    ) {
    translate(center)
    rotate(rotation)
    linear_extrude(text_depth)
    translate(-corner_pos - dimensions/2)
    text(character, font=letter_font, size=size);
    }
}

module border (inner_size, thickness, center=[0,0,0], rotation=[0,0,0]) {
    translate(center)
    rotate(rotation)
    linear_extrude(text_depth)
    difference() {
        square(inner_size + thickness, center=true);
        square(inner_size, center=true);
    }
}

module hollow_cube (size, wall_thickness) {
    difference() {
        cube(size);
        let (inner_size = size - 2*wall_thickness) {
            translate([wall_thickness, wall_thickness, wall_thickness])
            cube([inner_size, inner_size, size-wall_thickness]);
        }
    }
}

module letter_cube (size, wall_thickness) {
    color("white")
    translate([-size/2, -size/2, 0])
    hollow_cube(size, wall_thickness);
}

module bordered_letter(character, letter_size, border_padding, center=[0,0,0], rotation=[0,0,0]) {
    union() {
        letter(character, letter_size, center=center, rotation=rotation);
        border(letter_size + 2*border_padding, text_border_thickness, center=center, rotation=rotation);
    }
}


let (
        outline_size = text_border_margin + text_border_padding + text_border_thickness,
        letter_size = cube_size-2*outline_size,
        letter_shift = cube_size/2
    ) {
        for (i = [0:3]) {
            angle = i * 90;
            x_shift = cos(angle) * letter_shift;
            y_shift = sin(angle) * letter_shift;
            center = [x_shift, y_shift, letter_shift];
            rotation = [0, 90, angle];
            bordered_letter(characters[i], letter_size, text_border_padding, center=center, rotation=rotation);
        }
}

letter_cube(cube_size, cube_wall_thickness);
