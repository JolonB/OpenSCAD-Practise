use <fontmetrics.scad>;

_MIN_MAX_SCALING = 1.2;

TEXT_DEPTH = 0.4;
LETTER_FONT="Liberation Mono:style=Bold";

module letter (character, size, font, depth, center=[0,0,0], rotation=[0,0,0]) {
    char_len = len(character);
    assert(char_len == 1, str("A letter cannot contain more than one character. '", character, "' contains ", char_len));
    character = uppercaseChar(character);

    dimensions = measureTextBounds(character, font=font, size=size)[1];
    scale_factor = size / max(dimensions);

    let (
    size = scale_factor >= _MIN_MAX_SCALING ? size * _MIN_MAX_SCALING : scale_factor < 1 ? size * scale_factor : size,
    char_bounds = measureTextBounds(character, font=font, size=size),
    corner_pos = char_bounds[0],
    dimensions = char_bounds[1]
    ) {
    translate(center)
    rotate(rotation)
    translate([0, 0, -depth])
    linear_extrude(depth)
    translate(-corner_pos - dimensions/2)
    text(character, font=font, size=size);
    }
}

function rotated_center(angle, center_offset) = [
        [
            cos(angle) * center_offset,
            sin(angle) * center_offset,
            center_offset
        ], [
            0, 90, angle
        ]
];

function rotated_centers(center_offset) = [
    for (i=[0:3])
    rotated_center(i*90, center_offset)
];

module bordered_cube(size, border_thickness, indent_depth) {
    difference() {
        translate([0, 0, cube_size/2])
        cube(cube_size, center=true);

        for (center_rotation = rotated_centers(size/2)) {
            center = center_rotation[0];
            rotation = center_rotation[1];
            inner_size = size - 2*border_thickness;
            translate(center)
            rotate(rotation)
            translate([0, 0, -indent_depth/2])
            cube([inner_size, inner_size, indent_depth], center=true);
        }
    }
}


module letter_cube(
        characters, cube_size, border_thickness, border_padding, depth=TEXT_DEPTH, font=LETTER_FONT
) {
    assert(border_thickness + border_padding < cube_size);
    assert(len(characters) == 4);

    color("white")
    bordered_cube(cube_size, border_thickness, depth);

    let (
            letter_size = cube_size-2*(border_padding + border_thickness),
            letter_centering = cube_size/2
    ) {
        color("black")
        for (i = [0:3]) {
            center_rotation = rotated_center(i*90, letter_centering);
            center = center_rotation[0];
            rotation = center_rotation[1];
            letter(characters[i], letter_size, font, depth, center=center, rotation=rotation);
        }
    }
}

// TEST //

characters = "AMOG";
cube_size = 45;
text_border_margin = 6;  // outer
text_border_padding = 4; // inner

letter_cube(characters, cube_size, text_border_margin, text_border_padding);
